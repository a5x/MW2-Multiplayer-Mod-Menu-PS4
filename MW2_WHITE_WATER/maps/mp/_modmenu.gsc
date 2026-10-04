// ============================================================================
//  Mod Menu for MW2 (2009) on the PS4 port -- WhiteWaterV6.5, ModMenu v8.
//
//  Menus, option names, order, access levels and the look are those of the
//  WhiteWaterV6.5 patch (xRobertDavisx and JokerRey, ported by BravSoldat):
//  "hudbig" font, menu title at the top centre with the neighbouring menus
//  120 units left and right, one option every 17 units, the selected one
//  bigger in a random glowing colour with the water sound, the blue tiger
//  camo behind it, the two bars at the bottom of the screen. The options run
//  the patch's own functions, which are in maps/mp/_modmenu_ww1..9.gsc
//  (renamed ww_*).
//
//  This file is the frame around them: who has which access, the menu lists,
//  drawing and buttons. Different from the patch on purpose (as in the
//  EliteMossy v9.6 port):
//    - open / close with R1 + Square (the patch: D-pad up), back with Circle
//      (the patch: Square), menu left / right with the D-pad
//    - Map Menu keeps the players connected and counts down
//    - access is level.p[name]["permission"] (0 User, 1 Verified, 2 VIP,
//      3 Admin, 4 Co-Host, 5 Host) instead of flags set on the player only;
//      the patch's flags (IsVerified, IsVIP, IsAdmin, Is666ch) follow it,
//      the patch's functions read them. Nobody changes the access of a
//      player at or above his own level.
//    - not in here: Derank (player, all players), Freeze PS3, Fuck up
//      Classes (player, all players), Give Bad Dvars, Reset Stats of another
//      player, Lock menu, Scare Player, Disable Quit (they wreck another
//      player's stats, console or classes, or lock him into the lobby), and
//      the Sex Doll model and bullets (model the game has not loaded)
//
//  v8 (against freezes on the Xbox 360 based port):
//    - no new text per scroll (the game's text slots ran out: freeze)
//    - every option takes exactly the one argument the menu passes
//    - pad commands registered once per connect, not again on every spawn
//      or every time an option is chosen
//    - no calls into functions the platform does not have
//      (gamesendservercmd, vecscale, ClearAllTextAfterHudElem)
//    - no effects or models the game has not loaded
//
//  Started from maps/mp/gametypes/_rank.gsc:  level thread maps\mp\_modmenu::init();
// ============================================================================

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init()
{
	// The patch's init().
	level.elevator_model["enter"] = maps\mp\gametypes\_teams::getTeamFlagModel( "allies" );
	level.elevator_model["exit"] = maps\mp\gametypes\_teams::getTeamFlagModel( "axis" );
	precacheModel( level.elevator_model["enter"] );
	precacheModel( level.elevator_model["exit"] );
	level.Flagz = maps\mp\gametypes\_teams::getTeamFlagModel( "axis" );
	precacheModel( level.Flagz );

	precacheShader( "cardtitle_bloodsplat" );
	precacheModel( "test_sphere_silver" );
	precacheShader( "cardicon_weed" );
	precacheShader( "cardicon_redhand" );
	precacheItem( "lightstick_mp" );
	precacheItem( "throwingknife_rhand_mp" );

	ents = getEntArray();
	for ( index = 0; index < ents.size; index++ )
		if ( isSubStr( ents[index].classname, "trigger_hurt" ) )
			ents[index].origin = ( 0, 0, 9999999 );

	precacheShader( "cardtitle_weed_3" );
	precacheShader( "cardicon_skull_black" );
	precacheShader( "cardicon_prestige10_02" );
	precacheShader( "cardicon_girlskull" );
	precacheShader( "cardicon_sniper" );
	precacheShader( "ui_camoskin_blue_tiger" );
	precacheShader( "mw2_main_cloud_overlay" );
	precacheShader( "minimap_scanlines" );
	precacheShader( "minimap_background" );
	precacheShader( "black" );
	precacheShader( "map_artillery_selector" );
	precacheModel( "vehicle_stryker_config2_static" );
	precacheModel( "vehicle_t72_tank_d_body_static" );
	precacheModel( "vehicle_zodiac" );

	level.icontest = "rank_prestige10";

	level.shakeFX["laser"] = loadFX( "misc/aircraft_light_wingtip_blue" );
	level.shakeFX["impact"] = loadFX( "explosions/grenadeExp_dirt_1" );   // FX Gun plays it, the patch never loaded it
	level._effect["FNGun"] = loadfx( "explosions/player_death_nuke_flash" );
	level._effect["SBGun"] = loadfx( "explosions/stealth_bomb_mp" );
	level._effect["ADGun"] = loadfx( "explosions/artilleryExp_dirt_brown" );
	level._effect["NGun"] = loadfx( "explosions/player_death_nuke" );
	level._effect["blood"] = loadfx( "impacts/flesh_hit_body_fatal_exit" );

	level.fx[0] = loadfx( "fire/fire_smoke_trail_m" );
	level.fx[1] = loadfx( "fire/tank_fire_engine" );
	level.fx[2] = loadfx( "smoke/smoke_trail_black_heli" );
	level.fx[3] = loadfx( "explosions/grenadeExp_water" );
	level.fx[4] = loadfx( "explosions/grenadeExp_snow" );
	level.fx[5] = loadfx( "explosions/grenadeExp_dirt_1" );
	level.pistol = "coltanaconda_fmj_mp";
	setDvar( "player_sprintSpeedScale", 1.5 );

	// Values the patch compares before it ever sets them.
	level.Speed = 0;
	level.SuperJump = 0;
	level.FX_count = 0;

	level.mmLines = 18;                         // options shown at once; longer menus scroll
	level.mmCoHosts = strTok( "BravSoldat", "," );   // the patch's isCoHost(): Co-Host on connect
	level.p = [];
	maps\mp\_modmenu_br::br_init();             // Battle Royale (Patches Menu)
	level thread mm_onPlayerConnect();
}

mm_onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );
		player thread mm_onPlayerConnected();
	}
}

// Access is kept in level.p under the player's name, without a clan tag. The
// name is made unique here, so a second player with the same name does not
// share the first one's access.
mm_initName()
{
	name = self.name;
	for ( i = 0; i < name.size; i++ )
	{
		if ( name[i] == "]" )
		{
			name = getSubStr( name, i + 1, name.size );
			break;
		}
	}
	key = name;
	foreach ( player in level.players )
	{
		if ( player != self && isDefined( player.myName ) && player.myName == key )
			key = name + "#" + self getEntityNumber();
	}
	self.myName = key;
	level.p[key] = [];
	level.p[key]["permission"] = 0;
	level.p[key]["MenuOpen"] = 0;
}

mm_isNamedCoHost()
{
	foreach ( name in level.mmCoHosts )
	{
		if ( self.name == name || self.myName == name )
			return true;
	}
	return false;
}

// What the patch's toggles compare with 0 or test with "!" before they set it.
mm_initVars()
{
	self.IsVerified = false;
	self.IsVIP = false;
	self.IsAdmin = false;
	self.Is666ch = false;
	self.HasMenuAccess = false;
	self.HasGodModeOn = false;
	self.infAmmoOn = false;
	self.RBox = false;
	self.thirdp = false;
	self.VIPSet = false;
	self.IsUFO = false;
	self.IsHidden = false;
	self.IsRain = false;
	self.IsFrozen = 0;
	self.SBV = false;
	self.Forge = 0;
	self.ugp = 30;          // crates Forge Mode may spawn; the patch never set it, so it spawned none
	self.gmd = 0;
	self.fmd = 0;
	self.gsd = 0;
	self.lgv = 0;
	self.ufo = 0;
	self.demi = 0;
	self.wall = 0;
	self.visi = 0;
	self.aimbot = 0;
	self.aimtog = 0;
	self.tog = false;
	self.unf = false;
	self.godl = false;
	self.frzz = false;
	self.spdz = false;
	self.norc = false;
	self.ebullp = 0;
	self.FUCK = 0;
	self.hidz = 0;
	self.hasRadar = 0;
}

mm_onPlayerConnected()
{
	self endon( "disconnect" );

	self.mmOpen = false;
	self.MenuIsOpen = false;
	self.menuOpen = false;
	self.mmShownAccess = 0;
	self mm_initName();
	self mm_initVars();
	if ( self isHost() )
	{
		level.p[self.myName]["permission"] = 5;
		level.hostis = self.name;
		level.hostname = self.name;
		level.colorScheme = ( 0, 0, 1 );
		level.colors = [];
		level.CCo = 0;
		setDvar( "testClients_doAttack", 0 );
		setDvar( "testClients_doMove", 0 );
		setDvar( "testClients_watchKillcam", 0 );
		setDvar( "g_password", "" );
	}
	else if ( self mm_isNamedCoHost() )
		level.p[self.myName]["permission"] = 4;
	self mm_syncFlags();

	// The pad commands, registered once per connect: every notifyOnPlayerCommand
	// adds another registration, and two for the same command send the notify
	// twice (one press moved the cursor two lines). The patch's menu notifies,
	// its button monitor's (helicopter controls) and the ones its options
	// wait for; the menu listens to the patch's ones.
	self maps\mp\_modmenu_ww1::ww_menuCMDS();
	self maps\mp\_modmenu_ww1::ww_registerButts();
	self maps\mp\_modmenu_ww1::ww_registerOptionCommands();
	self thread mm_forward( "dpad_up", "up" );
	self thread mm_forward( "dpad_down", "down" );
	self thread mm_forward( "dpad_left", "left" );
	self thread mm_forward( "dpad_right", "right" );
	self thread mm_forward( "button_cross", "select" );
	self thread mm_forward( "button_circle", "back" );

	// On-screen menu controls.
	self thread maps\mp\_modmenu_ww1::ww_M_controls();

	if ( self mm_allowed( 4 ) )
	{
		if ( getDvarFloat( "sys_cpughz" ) > 3 )
			setDvar( "sv_network_fps", 900 );
		else if ( getDvarFloat( "sys_cpughz" ) > 2.5 )
			setDvar( "sv_network_fps", 650 );
		else if ( getDvarFloat( "sys_cpughz" ) > 2 )
			setDvar( "sv_network_fps", 400 );
	}

	self thread mm_watchOpenClose();

	for(;;)
	{
		self waittill( "spawned_player" );
		self mm_onSpawned();
	}
}

// What the patch does on every spawn (its onPlayerSpawned loop).
mm_onSpawned()
{
	self setClientDvar( "motd", "^1 Hello ! Thanks for Using This PS4 Port, we made it with love, have a good day brother! Made by ^4ZERTY ^7& ^1@UrBaZz" );
	self setClientDvar( "ui_playerPartyColor", "1 0 0 1" );
	self setClientDvar( "lobby_searchingPartyColor", "0 1 0 1" );
	self setClientDvar( "party_lobbyPlayerCount", "0 1 0 1" );
	// Only the host moves during the countdown at the start of the match; the
	// others stay frozen until it ends, as in the stock game.
	if ( !gameFlag( "prematch_done" ) && self isHost() )
		self freezeControls( false );
	self mm_updateStartMenu();
	self.menuOpen = false;
	self.HasGodModeOn = false;
	self.infAmmoOn = false;
	self.RBox = false;
	self.thirdp = false;
	if ( self mm_allowed( 4 ) )
		self thread maps\mp\_modmenu_ww1::ww_clearAir();
	self mm_activate();
	self thread maps\mp\_modmenu_br::br_onSpawned();
}

// Start opens the menu named by the client dvar g_scriptMainMenu, which the
// game sends when a player picks a team. After a map change that keeps the
// players (map( n, true ), not used any more) they come back on their team without picking it,
// the dvar is never sent and Start opens nothing: sent again on every spawn.
mm_updateStartMenu()
{
	if ( !isDefined( self.pers["team"] ) )
		return;
	if ( self.pers["team"] == "allies" || self.pers["team"] == "axis" || self.pers["team"] == "spectator" )
		self updateMainMenu();
}

// ---------------------------------------------------------------------------
//  Access: 0 User, 1 Verified, 2 VIP, 3 Admin, 4 Co-Host, 5 Host
// ---------------------------------------------------------------------------

mm_access( p )
{
	return level.p[p.myName]["permission"];
}

mm_allowed( access )
{
	return ( level.p[self.myName]["permission"] >= access );
}

mm_syncFlags()
{
	access = level.p[self.myName]["permission"];
	self.IsVerified = ( access >= 1 );
	self.IsVIP = ( access >= 2 );
	self.IsAdmin = ( access >= 3 );
	self.Is666ch = ( access >= 4 );
	self.HasMenuAccess = ( access >= 1 );
}

// The patch's Verified(): on every spawn and when the access is changed. The
// threads of one life end on death, and on "MenuChangePerms" when the access
// changes in the middle of it.
mm_activate()
{
	self notify( "MenuChangePerms" );
	if ( self.mmOpen )
		self mm_closeMenu();
	self mm_syncFlags();
	self maps\mp\_modmenu_ww1::ww_M_controls();   // shown or hidden with the access

	if ( !self mm_allowed( 1 ) )
	{
		self.mmShownAccess = 0;
		return;
	}

	self setClientDvar( "password", "GrimReaper" );
	if ( getDvarInt( "Big_XP" ) == 1 )
		self.xpScaler = 1000;
	if ( isAlive( self ) )
	{
		self thread maps\mp\_modmenu_ww1::ww_iWalkAC();
		self thread maps\mp\_modmenu_ww1::ww_iButts();
		if ( isDefined( self.newufo ) )
			self.newufo delete();
		self.newufo = spawn( "script_origin", self.origin );
		self thread maps\mp\_modmenu_ww1::ww_NewUFO();
	}
	self setClientDvar( "ui_gametype", "[{+stance}]Port by ^4@ZERTY ^7& ^1@UrBaZz[{+gostand}] ^4III^7III^1III" );

	access = level.p[self.myName]["permission"];
	if ( access == self.mmShownAccess )
		return;
	self.mmShownAccess = access;
	self thread mm_welcome();
}

// The patch's menu(status): its message, once per access level.
mm_welcome()
{
	self endon( "disconnect" );

	wait ( 0.3 );
	if ( self.IsAdmin )
		status = "Admin";
	else if ( self.IsVIP )
		status = "VIP";
	else
		status = "Verified";
	notifyData = spawnstruct();
	notifyData.titleText = "Hello " + self.name + "^4 !";
	notifyData.notifyText = "Access Level: " + status;
	notifyData.notifyText2 = "WhiteWaterV6.5";
	notifyData.glowColor = ( 0.0, 0.0, 1.0 );
	notifyData.duration = 11;
	notifyData.iconName = level.icontest;
	self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
	self iPrintln( "^3PS4 Port by ^1@ZERTY ^2& ^1@UrBaZz, Thanks for Using WhiteWaterV6.5 - ^4Base & Creators ^3xRobertDavisx ^4& ^3JokerRey - ^4X360 Port By: ^3BravSoldat");
}

// p's access may be changed by self: not self, and below self.
mm_canChange( p )
{
	if ( !isDefined( p ) || p == self || !isDefined( p.myName ) )
		return false;
	return ( mm_access( p ) < mm_access( self ) );
}

// Gives at least that access (the patch never lowered it by giving).
mm_grant( p, access, text )
{
	if ( !self mm_canChange( p ) )
		return false;
	if ( access >= mm_access( self ) )
		return false;
	if ( mm_access( p ) < access )
	{
		level.p[p.myName]["permission"] = access;
		p mm_activate();
	}
	self thread maps\mp\_modmenu_ww1::ww_ccTXT( text + p.name );
	return true;
}

// The patch's plVE(), plV(), plAdmin(), plCoHost666(), plRA().
mm_plVerify( p )
{
	self mm_grant( p, 1, "^5Verified: " );
}

mm_plVip( p )
{
	self mm_grant( p, 2, "^2VIP: " );
}

mm_plAdmin( p )
{
	self mm_grant( p, 3, "^3ADMIN: " );
}

mm_plCoHost( p )
{
	if ( !self mm_grant( p, 4, "^4Co-Host^7:^2 " ) )
		return;
	wait 1;
	if ( isDefined( p ) )
		p thread maps\mp\_modmenu_ww2::ww_doMyMsg666420( "^0" + level.hostis + " Gave You Co-Host!", "Be Fair, Dont Be A Cunt.", "Enjoy!" );
}

mm_plRemove( p )
{
	if ( !self mm_canChange( p ) )
		return;
	self thread maps\mp\_modmenu_ww1::ww_ccTXT( "Removed Access: " + p.name );
	level.p[p.myName]["permission"] = 0;
	p setClientDvar( "password", "" );
	p mm_activate();
	p suicide();
}

mm_plKick( p )
{
	if ( self mm_canChange( p ) )
		self maps\mp\_modmenu_ww2::ww_plK( p );
}

// The patch's vfAll(), VIPAll(), AdminAll(), raAll().
mm_verifyAll( unused )
{
	self iprintln( "^3Everyone ^7Is ^3Now ^7Verified" );
	foreach ( p in level.players )
		self mm_plVerify( p );
}

mm_vipAll( unused )
{
	self iprintln( "Everyone ^2VIP" );
	foreach ( p in level.players )
		self mm_plVip( p );
}

mm_adminAll( unused )
{
	self iprintln( "Everyone ^3ADMIN" );
	foreach ( p in level.players )
		self mm_plAdmin( p );
}

mm_removeAll( unused )
{
	foreach ( p in level.players )
		self mm_plRemove( p );
}

mm_watchOpenClose()
{
	self endon( "disconnect" );

	for(;;)
	{
		if ( self FragButtonPressed() && self useButtonPressed() && self mm_allowed( 1 ) )
		{
			if ( self.mmOpen )
				self mm_closeMenu();
			else if ( isDefined( level.br ) && !self mm_allowed( 4 ) )
				self iPrintln( "^3Menu locked during the Battle Royale" );
			else if ( self.sessionstate == "playing" )
				self mm_openRoot();
			wait ( 0.4 );
		}
		wait ( 0.05 );
	}
}

// ---------------------------------------------------------------------------
//  Menu lists -- the patch's getMenu(), menuMaster() and its sub menus, in
//  its order and with its names. A view is a row of menus to cycle through:
//  the top level is one (WhiteWater, Players [1], Players [2]), a sub menu
//  and a picked player are views on top of it. mm_addClosed is for options
//  that need the pad themselves (map selector, own buttons, class choice):
//  the menu closes first.
// ---------------------------------------------------------------------------

mm_addMenu( id, title )
{
	self.mm[id] = spawnStruct();
	self.mm[id].title = title;
	self.mm[id].text = [];
	self.mm[id].func = [];
	self.mm[id].arg = [];
	self.mm[id].closed = [];
}

mm_addRoot( id, title )
{
	self mm_addMenu( id, title );
	self.mmRoot[self.mmRoot.size] = id;
}

mm_addOption( id, text, func, arg )
{
	i = self.mm[id].text.size;
	self.mm[id].text[i] = text;
	self.mm[id].func[i] = func;
	self.mm[id].arg[i] = arg;
	self.mm[id].closed[i] = false;
}

mm_addClosed( id, text, func, arg )
{
	self mm_addOption( id, text, func, arg );
	self.mm[id].closed[self.mm[id].text.size - 1] = true;
}

mm_playerTag( p )
{
	if ( p.IsAdmin )
		return "[ADM]";
	if ( p.IsVIP )
		return "[VIP]";
	if ( p.IsVerified )
		return "[VER]";
	return "[^1UN-VER]^7";
}

mm_buildMenus()
{
	self.mm = [];
	self.mmRoot = [];

	self mm_addRoot( "master", " [ WhiteWater ] " );
	self mm_addOption( "master", "^7Player Options", ::mm_openSub, "player_options" );
	self mm_addOption( "master", "^7Account Options", ::mm_openSub, "account" );
	self mm_addOption( "master", "^7Infection Options", ::mm_openSub, "infections" );
	self mm_addOption( "master", "^7Fun Options", ::mm_openSub, "fun" );
	if ( self mm_allowed( 2 ) )
	{
		self mm_addOption( "master", "^7Weapons Options", ::mm_openSub, "weapons" );
		self mm_addOption( "master", "^7Model Options", ::mm_openSub, "models" );
		self mm_addOption( "master", "^7Vip Options", ::mm_openSub, "vip" );
	}
	if ( self mm_allowed( 3 ) )
	{
		self mm_addOption( "master", "^7Admin Options", ::mm_openSub, "admin" );
		self mm_addOption( "master", "^7Message Menu", ::mm_openSub, "messages" );
	}
	if ( self mm_allowed( 4 ) )
	{
		self mm_addOption( "master", "^7Host Options", ::mm_openSub, "host" );
		self mm_addOption( "master", "^7Map Options", ::mm_openSub, "maps" );
		self mm_addOption( "master", "^7Settings & Forge", ::mm_openSub, "settings" );
		self mm_addOption( "master", "^7Patches Menu", ::mm_openSub, "patches" );
		self mm_addOption( "master", "^7All Players", ::mm_openSub, "all" );

		self mm_addRoot( "players1", "^7Players List" );
		foreach ( p in level.players )
		{
			if ( !isDefined( p.myName ) )
				continue;
			self mm_addOption( "players1", mm_playerTag( p ) + p.name, ::mm_openPlayer, p );
		}
	}

	self mm_addMenu( "player_options", "^1   Player Options   " );
	if ( self mm_allowed( 3 ) )
	{
		self mm_addOption( "player_options", "God Mode", maps\mp\_modmenu_ww1::ww_MGodToggle, undefined );
		self mm_addOption( "player_options", "Invisible", maps\mp\_modmenu_ww7::ww_INV, undefined );
	}
	self mm_addOption( "player_options", "Infinite Ammo", maps\mp\_modmenu_ww1::ww_InfAmmoToggle, undefined );
	self mm_addOption( "player_options", "Speed x2", maps\mp\_modmenu_ww1::ww_Speed2, undefined );
	self mm_addOption( "player_options", "Multi Jumps", maps\mp\_modmenu_ww1::ww_onPlayerMultiJump, undefined );
	self mm_addOption( "player_options", "Third Person", maps\mp\_modmenu_ww1::ww_TPN, undefined );
	self mm_addOption( "player_options", "Toggle FOV", maps\mp\_modmenu_ww1::ww_FOV, undefined );
	self mm_addOption( "player_options", "UFO Mode", maps\mp\_modmenu_ww7::ww_tUFO, undefined );
	self mm_addOption( "player_options", "No Recoil", maps\mp\_modmenu_ww1::ww_NRC, undefined );
	self mm_addClosed( "player_options", "Change Class", maps\mp\_modmenu_ww1::ww_ChaCla, undefined );
	self mm_addClosed( "player_options", "Suicide", maps\mp\_modmenu_ww1::ww_Suicides, undefined );

	self mm_addMenu( "account", "^1   Account Options   " );
	self mm_addOption( "account", "Choose Accolades Stats", ::mm_openSub, "accolades" );
	self mm_addOption( "account", "Mod My Class Names", ::mm_openSub, "class_names" );
	self mm_addOption( "account", "Clantag Menu", ::mm_openSub, "clantag" );
	// self mm_addOption( "account", "Request Infectable ModMenu", maps\mp\_modmenu_ww1::ww_DPtt, undefined );
	// self mm_addClosed( "account", "Patch Info", maps\mp\_modmenu_ww1::ww_doCred, undefined );
	self mm_addOption( "account", "Level 70", maps\mp\_modmenu_ww1::ww_I70, undefined );
	self mm_addClosed( "account", "Unlock All", maps\mp\_modmenu_ww1::ww_Challenges, undefined );
	// self mm_addClosed( "account", "Toggle Prestige", maps\mp\_modmenu_ww1::ww_togglePerrrStige, undefined );
	if ( self mm_allowed( 2 ) )
	{
		self mm_addOption( "account", "Select Prestige", ::mm_openSub, "select_prestige" );
		self mm_addOption( "account", "Preset Stats Account", ::mm_openSub, "preset_stats_account" );
	}

	self mm_addMenu( "class_names", "^1---Mod My Class Names---" );
	self mm_addOption( "class_names", "Modded Class Names (keybinds)", maps\mp\_modmenu_ww7::ww_doClasses, undefined );
	self mm_addOption( "class_names", "Colored Classes (tag + username)", maps\mp\_modmenu_ww1::ww_CCs, undefined );

	self mm_addMenu( "accolades", "^1---Choose Accolades Stats---" );
	self mm_addOption( "accolades", "1,000 Accolades", maps\mp\_modmenu_ww1::ww_Acco, 1000 );
	self mm_addOption( "accolades", "10,000 Accolades", maps\mp\_modmenu_ww1::ww_Acco, 10000 );
	self mm_addOption( "accolades", "100,000 Accolades", maps\mp\_modmenu_ww1::ww_Acco, 100000 );
	self mm_addOption( "accolades", "1,000,000 Accolades", maps\mp\_modmenu_ww1::ww_Acco, 1000000 );
	self mm_addOption( "accolades", "100,000,000 Accolades", maps\mp\_modmenu_ww1::ww_Acco, 100000000 );
	self mm_addOption( "accolades", "1 Billion Accolades", maps\mp\_modmenu_ww1::ww_Acco, 1000000000 );

	self mm_addMenu( "clantag", "^1---Clantag Menu---" );
	self mm_addOption( "clantag", "ClanTag - Unbound", maps\mp\_modmenu_ww1::ww_CTG, undefined );
	self mm_addOption( "clantag", "ClanTag - niga", maps\mp\_modmenu_ww1::ww_CTG, "niga" );
	self mm_addOption( "clantag", "ClanTag - {IL}", maps\mp\_modmenu_ww1::ww_CTG, "{IL}" );
	self mm_addOption( "clantag", "ClanTag - FUCK", maps\mp\_modmenu_ww1::ww_CTG, "FUCK" );
	self mm_addOption( "clantag", "ClanTag - {{}}", maps\mp\_modmenu_ww1::ww_CTG, "{{}}" );
	self mm_addOption( "clantag", "ClanTag - {@@}", maps\mp\_modmenu_ww1::ww_CTG, "{@@}" );
	self mm_addOption( "clantag", "ClanTag - {EZ}", maps\mp\_modmenu_ww1::ww_CTG, "{EZ}" );
	self mm_addOption( "clantag", "ClanTag - FUCK", maps\mp\_modmenu_ww1::ww_CTG, "FUCK" );
	self mm_addOption( "clantag", "ClanTag - @  @", maps\mp\_modmenu_ww1::ww_CTG, "@  @" );

	self mm_addMenu( "infections", "^1   Infections Menu   " );
	self mm_addOption( "infections", "Standard", maps\mp\_modmenu_ww8::ww_DVs, undefined );
	self mm_addOption( "infections", "Nuke Time", maps\mp\_modmenu_ww8::ww_NTs, undefined );
	self mm_addOption( "infections", "KillCam Time", maps\mp\_modmenu_ww8::ww_CTs, undefined );
	self mm_addOption( "infections", "Super SoH", maps\mp\_modmenu_ww8::ww_SHs, undefined );
	self mm_addOption( "infections", "Super Stopping Power", maps\mp\_modmenu_ww8::ww_SSs, undefined );
	self mm_addOption( "infections", "Super Danger Close", maps\mp\_modmenu_ww8::ww_SDs, undefined );
	self mm_addOption( "infections", "Knock Back", maps\mp\_modmenu_ww8::ww_KBs, undefined );
	self mm_addOption( "infections", "L33T Hacks", maps\mp\_modmenu_ww8::ww_LHs, undefined );
	self mm_addOption( "infections", "Sherbert Vision", maps\mp\_modmenu_ww8::ww_SVs, undefined );
	self mm_addOption( "infections", "Javi Macross", maps\mp\_modmenu_ww8::ww_JMs, undefined );
	self mm_addOption( "infections", "Nuke in Care Package", maps\mp\_modmenu_ww8::ww_nkcp, undefined );
	self mm_addOption( "infections", "Infectable XP", maps\mp\_modmenu_ww8::ww_BoostXP, undefined );
	self mm_addOption( "infections", "Gold Eagle Classes", maps\mp\_modmenu_ww8::ww_GoldDeagleClasses, undefined );
	self mm_addOption( "infections", "Shotgun Camos", maps\mp\_modmenu_ww8::ww_shotguncl, undefined );

	self mm_addMenu( "fun", "^1   Fun Menu   " );
	self mm_addOption( "fun", "Juggernaunt", maps\mp\_modmenu_ww7::ww_doJug, undefined );
	self mm_addOption( "fun", "Human Caterpiller", maps\mp\_modmenu_ww7::ww_HumanPed, undefined );
	self mm_addOption( "fun", "Spec Nade", maps\mp\_modmenu_ww7::ww_specnadefuck, undefined );
	self mm_addOption( "fun", "Snake Mode", maps\mp\_modmenu_ww7::ww_WhatTheFuckLol666, undefined );
	self mm_addOption( "fun", "Change Appearance", maps\mp\_modmenu_ww7::ww_RandomApper, undefined );
	self mm_addOption( "fun", "Right Throw Knife", maps\mp\_modmenu_ww7::ww_rightthrow, undefined );
	self mm_addOption( "fun", "Blood Fountain", maps\mp\_modmenu_ww7::ww_ToggleFountain, undefined );
	self mm_addOption( "fun", "Get Wasted", maps\mp\_modmenu_ww1::ww_PissedUpBad, undefined );
	self mm_addOption( "fun", "TBAG", maps\mp\_modmenu_ww1::ww_doTbag, undefined );
	self mm_addOption( "fun", "Bouncing Betty", maps\mp\_modmenu_ww1::ww_bounceBetty, undefined );
	self mm_addOption( "fun", "Mega Perks", maps\mp\_modmenu_ww1::ww_MegaPerks, undefined );
	self mm_addOption( "fun", "M40A3", maps\mp\_modmenu_ww1::ww_doSM, undefined );
	self mm_addOption( "fun", "High Mode", maps\mp\_modmenu_ww1::ww_HighMode, undefined );
	self mm_addOption( "fun", "Ghost Rider", maps\mp\_modmenu_ww6::ww_upinSmoke, undefined );

	if ( self mm_allowed( 2 ) )
	{
		self mm_addMenu( "select_prestige", "^1---Select Prestige---" );
		self mm_addOption( "select_prestige", "Zero", maps\mp\_modmenu_ww1::ww_SetPrestige, 0 );
		self mm_addOption( "select_prestige", "1st", maps\mp\_modmenu_ww1::ww_SetPrestige, 1 );
		self mm_addOption( "select_prestige", "2nd", maps\mp\_modmenu_ww1::ww_SetPrestige, 2 );
		self mm_addOption( "select_prestige", "3rd", maps\mp\_modmenu_ww1::ww_SetPrestige, 3 );
		self mm_addOption( "select_prestige", "4th", maps\mp\_modmenu_ww1::ww_SetPrestige, 4 );
		self mm_addOption( "select_prestige", "5th", maps\mp\_modmenu_ww1::ww_SetPrestige, 5 );
		self mm_addOption( "select_prestige", "6th", maps\mp\_modmenu_ww1::ww_SetPrestige, 6 );
		self mm_addOption( "select_prestige", "7th", maps\mp\_modmenu_ww1::ww_SetPrestige, 7 );
		self mm_addOption( "select_prestige", "8th", maps\mp\_modmenu_ww1::ww_SetPrestige, 8 );
		self mm_addOption( "select_prestige", "9th", maps\mp\_modmenu_ww1::ww_SetPrestige, 9 );
		self mm_addOption( "select_prestige", "10th", maps\mp\_modmenu_ww1::ww_SetPrestige, 10 );
		self mm_addOption( "select_prestige", "11th", maps\mp\_modmenu_ww1::ww_SetPrestige, 11 );
		self mm_addOption( "select_prestige", "Derank", maps\mp\_modmenu_ww8::ww_I702, undefined );
		self mm_addOption( "select_prestige", "300th", maps\mp\_modmenu_ww8::ww_doPrestige300, undefined );
		self mm_addMenu( "preset_stats_account", "^1---Preset Stats Account---" );
		self mm_addOption( "preset_stats_account", "Reset Stats", maps\mp\_modmenu_ww8::ww_doStats, "Reset Stats" );
		self mm_addOption( "preset_stats_account", "Legit Stats", maps\mp\_modmenu_ww8::ww_doStats, "Legit Stats" );
		self mm_addOption( "preset_stats_account", "Moderate Stats", maps\mp\_modmenu_ww8::ww_doStats, "Moderate Stats" );
		self mm_addOption( "preset_stats_account", "Insane Stats", maps\mp\_modmenu_ww8::ww_doStats, "Insane Stats" );

		self mm_addMenu( "weapons", "^1   Weapons Menu   " );
		self mm_addOption( "weapons", "Gold Desert Eagle", maps\mp\_modmenu_ww6::ww_weapons12, "GOL" );
		self mm_addOption( "weapons", "Default Weapon", maps\mp\_modmenu_ww6::ww_weapons12, "DEF" );
		// self mm_addOption( "weapons", "RPG", maps\mp\_modmenu_ww6::ww_weapons12, "RPG" );
		self mm_addOption( "weapons", "Spas-12", maps\mp\_modmenu_ww6::ww_weapons12, "SPA" );
		self mm_addOption( "weapons", "Intervention", maps\mp\_modmenu_ww6::ww_weapons12, "INT" );
		// self mm_addOption( "weapons", "AT-4", maps\mp\_modmenu_ww6::ww_weapons12, "AT4" );
		self mm_addOption( "weapons", "Give Weapons", ::mm_openSub, "give_weapons" );
		self mm_addOption( "weapons", "Modded Weapons", ::mm_openSub, "modded_weapons" );
		self mm_addOption( "weapons", "Random Weapon Box", maps\mp\_modmenu_ww6::ww_WepBox, undefined );
		self mm_addOption( "weapons", "Rapid Fire Guns", maps\mp\_modmenu_ww6::ww_dorapid, undefined );
		self mm_addOption( "weapons", "Move Gun ON/OFF", maps\mp\_modmenu_ww6::ww_MGun, undefined );
		self mm_addOption( "weapons", "Rainbow Camo ON/OFF", ::mm_rainbowCamo, undefined );

		self mm_addMenu( "modded_weapons", "^1---Modded Weapons---" );
		self mm_addOption( "modded_weapons", "Akimbo Thumpers", maps\mp\_modmenu_ww6::ww_weapons12, "AKK" );
		self mm_addOption( "modded_weapons", "Akimbo Default Weapon", maps\mp\_modmenu_ww6::ww_akiT, undefined );
		self mm_addOption( "modded_weapons", "Death Machine", maps\mp\_modmenu_ww6::ww_Dmac, undefined );
		self mm_addOption( "modded_weapons", "Crossbow", maps\mp\_modmenu_ww6::ww_giveCB, undefined );
		self mm_addOption( "modded_weapons", "Spawn a Turret", maps\mp\_modmenu_ww6::ww_tuT, undefined );
		self mm_addOption( "modded_weapons", "Akimbo OMA", maps\mp\_modmenu_ww6::ww_OneManArmyFTW, undefined );
		self mm_addOption( "modded_weapons", "Walking AC-130", maps\mp\_modmenu_ww6::ww_tAC130, undefined );
		self mm_addOption( "modded_weapons", "Red Blinking Lights", maps\mp\_modmenu_ww6::ww_flashingplayerz, undefined );
		self mm_addOption( "modded_weapons", "GlowStick", maps\mp\_modmenu_ww6::ww_lightsticktestwtf, undefined );
		self mm_addOption( "modded_weapons", "Flyable AC-130", maps\mp\_modmenu_ww1::ww_test, undefined );
		self mm_addClosed( "modded_weapons", "Remote Drone", maps\mp\_modmenu_ww6::ww_Hepticdrone, undefined );
		if ( self mm_allowed( 3 ) )
			self mm_addOption( "modded_weapons", "Modded Weapons Page 2", ::mm_openSub, "weapons2" );

		self mm_addMenu( "give_weapons", "^1---Give Weapons---" );
		self mm_addOption( "give_weapons", "Assault Rifles", ::mm_openSub, "give_assault_rifles" );
		self mm_addOption( "give_weapons", "Submachine Guns", ::mm_openSub, "give_smg" );
		self mm_addOption( "give_weapons", "Light Machine Guns", ::mm_openSub, "give_lmg" );
		self mm_addOption( "give_weapons", "Sniper Rifles", ::mm_openSub, "give_snipers" );
		self mm_addOption( "give_weapons", "Shotguns", ::mm_openSub, "give_shotguns" );
		self mm_addOption( "give_weapons", "Handguns", ::mm_openSub, "give_handguns" );
		self mm_addOption( "give_weapons", "Machine Pistols", ::mm_openSub, "give_machine_pistols" );
		self mm_addOption( "give_weapons", "Launchers", ::mm_openSub, "give_launchers" );
		self mm_addOption( "give_weapons", "Special Weapons", ::mm_openSub, "give_special_weapons" );

		self mm_addMenu( "give_assault_rifles", "^1---Assault Rifles---" );
		self mm_addOption( "give_assault_rifles", "AK-47", ::mm_giveWeapon, "ak47_mp" );
		self mm_addOption( "give_assault_rifles", "FAMAS", ::mm_giveWeapon, "famas_mp" );
		self mm_addOption( "give_assault_rifles", "FAL", ::mm_giveWeapon, "fal_mp" );
		self mm_addOption( "give_assault_rifles", "M16A4", ::mm_giveWeapon, "m16_reflex_mp" );
		self mm_addOption( "give_assault_rifles", "M4A1", ::mm_giveWeapon, "m4_reflex_mp" );
		self mm_addOption( "give_assault_rifles", "ACR", ::mm_giveWeapon, "masada_mp" );
		self mm_addOption( "give_assault_rifles", "F2000", ::mm_giveWeapon, "fn2000_mp" );
		self mm_addOption( "give_assault_rifles", "SCAR-H", ::mm_giveWeapon, "scar_mp" );
		self mm_addOption( "give_assault_rifles", "TAR-21", ::mm_giveWeapon, "tavor_mp" );

		self mm_addMenu( "give_smg", "^1---Submachine Guns---" );
		self mm_addOption( "give_smg", "MP5K", ::mm_giveWeapon, "mp5k_mp" );
		self mm_addOption( "give_smg", "Mini-Uzi", ::mm_giveWeapon, "uzi_mp" );
		self mm_addOption( "give_smg", "P90", ::mm_giveWeapon, "p90_mp" );
		self mm_addOption( "give_smg", "Vector", ::mm_giveWeapon, "kriss_mp" );
		self mm_addOption( "give_smg", "UMP45", ::mm_giveWeapon, "ump45_mp" );

		self mm_addMenu( "give_lmg", "^1---Light Machine Guns---" );
		self mm_addOption( "give_lmg", "L86 LSW", ::mm_giveWeapon, "sa80_mp" );
		self mm_addOption( "give_lmg", "RPD", ::mm_giveWeapon, "rpd_mp" );
		self mm_addOption( "give_lmg", "MG4", ::mm_giveWeapon, "mg4_mp" );
		self mm_addOption( "give_lmg", "AUG HBAR", ::mm_giveWeapon, "aug_mp" );
		self mm_addOption( "give_lmg", "M240", ::mm_giveWeapon, "m240_grip_mp" );

		self mm_addMenu( "give_snipers", "^1---Sniper Rifles---" );
		self mm_addOption( "give_snipers", "Intervention", ::mm_giveWeapon, "cheytac_mp" );
		self mm_addOption( "give_snipers", "Barrett .50cal", ::mm_giveWeapon, "barrett_mp" );
		self mm_addOption( "give_snipers", "WA2000", ::mm_giveWeapon, "wa2000_acog_mp" );
		self mm_addOption( "give_snipers", "M21 EBR", ::mm_giveWeapon, "m21_acog_mp" );

		self mm_addMenu( "give_shotguns", "^1---Shotguns---" );
		self mm_addOption( "give_shotguns", "SPAS-12", ::mm_giveWeapon, "spas12_mp" );
		self mm_addOption( "give_shotguns", "AA-12", ::mm_giveWeapon, "aa12_mp" );
		self mm_addOption( "give_shotguns", "Striker", ::mm_giveWeapon, "striker_mp" );
		self mm_addOption( "give_shotguns", "Ranger", ::mm_giveWeapon, "ranger_mp" );
		self mm_addOption( "give_shotguns", "Model 1887", ::mm_giveWeapon, "model1887_mp" );

		self mm_addMenu( "give_handguns", "^1---Handguns---" );
		self mm_addOption( "give_handguns", "USP .45", ::mm_giveWeapon, "usp_mp" );
		self mm_addOption( "give_handguns", "M9", ::mm_giveWeapon, "beretta_mp" );
		self mm_addOption( "give_handguns", ".44 Magnum", ::mm_giveWeapon, "coltanaconda_mp" );
		self mm_addOption( "give_handguns", "Desert Eagle", ::mm_giveWeapon, "deserteagle_mp" );
		self mm_addOption( "give_handguns", "Gold Desert Eagle", ::mm_giveWeapon, "deserteaglegold_mp" );

		self mm_addMenu( "give_machine_pistols", "^1---Machine Pistols---" );
		self mm_addOption( "give_machine_pistols", "PP2000", ::mm_giveWeapon, "pp2000_mp" );
		self mm_addOption( "give_machine_pistols", "G18", ::mm_giveWeapon, "glock_mp" );
		self mm_addOption( "give_machine_pistols", "M93 Raffica", ::mm_giveWeapon, "beretta393_mp" );
		self mm_addOption( "give_machine_pistols", "TMP", ::mm_giveWeapon, "tmp_mp" );

		self mm_addMenu( "give_launchers", "^1---Launchers---" );
		self mm_addOption( "give_launchers", "Thumper", ::mm_giveWeapon, "m79_mp" );
		self mm_addOption( "give_launchers", "RPG-7", ::mm_giveWeapon, "rpg_mp" );
		self mm_addOption( "give_launchers", "AT4-HS", ::mm_giveWeapon, "at4_mp" );
		self mm_addOption( "give_launchers", "Javelin", ::mm_giveWeapon, "javelin_mp" );
		self mm_addOption( "give_launchers", "Stinger", ::mm_giveWeapon, "stinger_mp" );

		self mm_addMenu( "give_special_weapons", "^1---Special Weapons---" );
		self mm_addOption( "give_special_weapons", "Riot Shield", ::mm_giveWeapon, "riotshield_mp" );

		self mm_addMenu( "models", "^1   Models Menu   " );
		self mm_addOption( "models", "Normal", maps\mp\_modmenu_ww7::ww_SetSelfNormal, undefined );
		self mm_addOption( "models", "Sentry Gun", maps\mp\_modmenu_ww7::ww_qwqe321, "bgt2" );
		self mm_addOption( "models", "UAV Plane", maps\mp\_modmenu_ww7::ww_qwqe321, "bgt3" );
		self mm_addOption( "models", "AC-130", maps\mp\_modmenu_ww7::ww_qwqe321, "bgt14" );
		self mm_addOption( "models", "Green Bush", maps\mp\_modmenu_ww7::ww_qwqe321, "bgt8" );
		self mm_addOption( "models", "Little Bird", maps\mp\_modmenu_ww7::ww_qwqe321, "bgt4" );
		self mm_addOption( "models", "Benzin Barrel", maps\mp\_modmenu_ww7::ww_qwqe321, "bgt9" );
		self mm_addOption( "models", "Ammo Crate", maps\mp\_modmenu_ww7::ww_qwqe321, "bgt10" );
		self mm_addOption( "models", "Palm Tree", maps\mp\_modmenu_ww7::ww_qwqe321, "bgt11" );
		self mm_addOption( "models", "Chicken", maps\mp\_modmenu_ww7::ww_qwqe321, "bgt7" );
		self mm_addOption( "models", "Blue Car", maps\mp\_modmenu_ww7::ww_qwqe321, "bgt12" );
		self mm_addOption( "models", "Police Car", maps\mp\_modmenu_ww7::ww_qwqe321, "bgt13" );
		self mm_addOption( "models", "Care Package", maps\mp\_modmenu_ww7::ww_qwqe321, "bgt1" );
		self mm_addOption( "models", "Dev Sphere", maps\mp\_modmenu_ww7::ww_qwqe321, "bgt6" );

		self mm_addMenu( "vip", "^1   VIP   " );
		self mm_addOption( "vip", "UFO Bind", maps\mp\_modmenu_ww7::ww_tgHepUFO, undefined );
		self mm_addOption( "vip", "Wallhack", maps\mp\_modmenu_ww7::ww_WHK, undefined );
		self mm_addOption( "vip", "Select Bullet", maps\mp\_modmenu_ww7::ww_EBullO, undefined );
		self mm_addClosed( "vip", "Teleporter", maps\mp\_modmenu_ww7::ww_TPo, undefined );
		self mm_addOption( "vip", "Create Clone", maps\mp\_modmenu_ww7::ww_Clne, undefined );
		self mm_addOption( "vip", "Orgasm", maps\mp\_modmenu_ww7::ww_orgasm, undefined );
		self mm_addOption( "vip", "Save & Load Position", maps\mp\_modmenu_ww7::ww_savepsis, undefined );
		self mm_addOption( "vip", "JetPack", maps\mp\_modmenu_ww7::ww_JPK, undefined );
		self mm_addOption( "vip", "Human Torch", maps\mp\_modmenu_ww7::ww_fireOn, undefined );
		self mm_addOption( "vip", "Kill Text", maps\mp\_modmenu_ww7::ww_m99, undefined );
		self mm_addOption( "vip", "Modded Bullets", maps\mp\_modmenu_ww7::ww_EBull, undefined );
		self mm_addClosed( "vip", "Bomberman", maps\mp\_modmenu_ww7::ww_BM, undefined );
		self mm_addClosed( "vip", "RCXD Car", maps\mp\_modmenu_ww7::ww_doRC, undefined );
		self mm_addOption( "vip", "Stalker Pro", maps\mp\_modmenu_ww7::ww_bigassheads, undefined );
		self mm_addOption( "vip", "Auto Drop Shot", maps\mp\_modmenu_ww7::ww_HardMode, undefined );
		self mm_addClosed( "vip", "Change Team", maps\mp\_modmenu_ww7::ww_ChaTea, undefined );
	}

	if ( self mm_allowed( 3 ) )
	{
		self mm_addMenu( "admin", "^1   Admin Options   " );
		self mm_addOption( "admin", "Stealth Aimbot", maps\mp\_modmenu_ww9::ww_toggleAim, undefined );
		self mm_addOption( "admin", "Penis In The Sky", maps\mp\_modmenu_ww9::ww_penis, undefined );
		self mm_addOption( "admin", "Tits In The Sky", maps\mp\_modmenu_ww9::ww_TitsInTheSky, undefined );
		self mm_addOption( "admin", "Teleport Everyone to me", maps\mp\_modmenu_ww9::ww_TEE, undefined );
		self mm_addOption( "admin", "Bots Play", maps\mp\_modmenu_ww9::ww_BPLY, undefined );
		self mm_addOption( "admin", "Spawn a Littlebird", maps\mp\_modmenu_ww9::ww_SpawnSmallHelicopter, undefined );
		self mm_addOption( "admin", "Attack Littlebird", maps\mp\_modmenu_ww9::ww_AttackLittlebird, undefined );
		self mm_addClosed( "admin", "Flyable Harrier", maps\mp\_modmenu_ww9::ww_initJet, undefined );
		self mm_addClosed( "admin", "Suicide Harrier", maps\mp\_modmenu_ww5::ww_SHarr, undefined );
		self mm_addClosed( "admin", "Napalm Strike", maps\mp\_modmenu_ww5::ww_Nlpm, undefined );
		self mm_addOption( "admin", "JaviRain", maps\mp\_modmenu_ww5::ww_javirain, undefined );
		self mm_addOption( "admin", "Super AC-130", maps\mp\_modmenu_ww5::ww_SuperAC130, undefined );
		self mm_addOption( "admin", "Pet Pavelow", maps\mp\_modmenu_ww5::ww_SSH, undefined );
		self mm_addClosed( "admin", "Gersh Device", maps\mp\_modmenu_ww5::ww_gersh, undefined );
		self mm_addClosed( "admin", "Ka Boom", maps\mp\_modmenu_ww5::ww_doKaBoom, undefined );
		self mm_addOption( "admin", "Spinning Ball Force Field", maps\mp\_modmenu_ww5::ww_ballThing, undefined );
		self mm_addOption( "admin", "MW3 IMS", maps\mp\_modmenu_ww5::ww_IMSMW3, undefined );
		self mm_addClosed( "admin", "TRAP BALL", maps\mp\_modmenu_ww5::ww_startBigBall, undefined );
		self mm_addOption( "admin", "Spawn 1 Bot", maps\mp\_modmenu_ww5::ww_InitBotBot, undefined );
		self mm_addOption( "admin", "Kick All Bots", maps\mp\_modmenu_ww5::ww_kickbots, undefined );

		self mm_addMenu( "weapons2", "^1---Weapon Menu [2]---" );
		self mm_addOption( "weapons2", "Atomic Gun", maps\mp\_modmenu_ww6::ww_superF2000lol, undefined );
		self mm_addOption( "weapons2", "Snow Gun", maps\mp\_modmenu_ww6::ww_BloodGun, undefined );
		self mm_addOption( "weapons2", "Water Gun", maps\mp\_modmenu_ww6::ww_BloodyTampon, undefined );
		self mm_addOption( "weapons2", "Blizzard Gun", maps\mp\_modmenu_ww6::ww_effecttest666420, undefined );
		self mm_addOption( "weapons2", "Sonic Boom Gun", maps\mp\_modmenu_ww6::ww_SonicBoom666, undefined );
		self mm_addOption( "weapons2", "Lightning Gun", maps\mp\_modmenu_ww6::ww_TazerMadeByCmdX, undefined );
		self mm_addOption( "weapons2", "Explosion/Smoke Gun", maps\mp\_modmenu_ww6::ww_NukeGUN, undefined );
		self mm_addOption( "weapons2", "Mustang and Sally", maps\mp\_modmenu_ww6::ww_MustandSal, undefined );
		self mm_addOption( "weapons2", "Air Gun", maps\mp\_modmenu_ww6::ww_airgun, undefined );
		self mm_addOption( "weapons2", "FX Gun", maps\mp\_modmenu_ww6::ww_bubblegun, undefined );
		self mm_addOption( "weapons2", "Death Ball Gun", maps\mp\_modmenu_ww6::ww_dobullet, undefined );
		self mm_addClosed( "weapons2", "Care Package Gun", maps\mp\_modmenu_ww6::ww_CPgun, undefined );
		self mm_addOption( "weapons2", "AT-4 Nuke Gun", maps\mp\_modmenu_ww6::ww_nukeAT4, undefined );
		self mm_addOption( "weapons2", "Flamethrower Gun", maps\mp\_modmenu_ww6::ww_FTH, undefined );
		self mm_addOption( "weapons2", "Teleport Gun", maps\mp\_modmenu_ww6::ww_giveTT, undefined );
		self mm_addOption( "weapons2", "Nuke Gun", maps\mp\_modmenu_ww6::ww_nkGun, undefined );
		self mm_addOption( "weapons2", "Flash Nuke Gun", maps\mp\_modmenu_ww6::ww_FlashNukeGUN, undefined );
		self mm_addOption( "weapons2", "Stealth Bomb Gun", maps\mp\_modmenu_ww6::ww_StealthBomberGUN, undefined );
		self mm_addOption( "weapons2", "Artillery Gun", maps\mp\_modmenu_ww6::ww_ArtilleryDirtGUN, undefined );

		self mm_addMenu( "messages", "^1   Message Options   " );
		self mm_addOption( "messages", "Thanks 01cedric for this port !", maps\mp\_modmenu_ww8::ww_cxm27, undefined );
		self mm_addOption( "messages", "Fuck Israel", maps\mp\_modmenu_ww8::ww_cxm28, undefined );
		self mm_addOption( "messages", "Free Palestine", maps\mp\_modmenu_ww8::ww_cxm29, undefined );
		self mm_addOption( "messages", "PS4 Port Menu By @ZERTY & @UrBaZz", maps\mp\_modmenu_ww8::ww_cxm30, undefined );
		self mm_addOption( "messages", "Yes", maps\mp\_modmenu_ww8::ww_cxm2, undefined );
		self mm_addOption( "messages", "No", maps\mp\_modmenu_ww8::ww_cxm3, undefined );
		self mm_addOption( "messages", "Maybe", maps\mp\_modmenu_ww8::ww_cxm4, undefined );
		self mm_addOption( "messages", "Okay", maps\mp\_modmenu_ww8::ww_cxm8, undefined );
		self mm_addOption( "messages", "Who's Hacking?", maps\mp\_modmenu_ww8::ww_cxm13, undefined );
		self mm_addOption( "messages", "No Problem", maps\mp\_modmenu_ww8::ww_cxm5, undefined );
		self mm_addOption( "messages", "Wanna Get Deranked?", maps\mp\_modmenu_ww8::ww_cxm7, undefined );
		self mm_addOption( "messages", "Are You Gay?", maps\mp\_modmenu_ww8::ww_cxm6, undefined );
		self mm_addOption( "messages", "STFU", maps\mp\_modmenu_ww8::ww_cxm14, undefined );
	//	self mm_addOption( "messages", "Stop Asking For Admin!", maps\mp\_modmenu_ww8::ww_cxm9, undefined );
	//	self mm_addOption( "messages", "Host Is God", maps\mp\_modmenu_ww8::ww_cxm10, undefined );
	//	self mm_addOption( "messages", "Patch Name", maps\mp\_modmenu_ww8::ww_cxm1, undefined );
		self mm_addOption( "messages", "Back Out!", maps\mp\_modmenu_ww8::ww_cxm12, undefined );
		self mm_addOption( "messages", "WhiteWaterV6.5", maps\mp\_modmenu_ww8::ww_cxm15, undefined );
		self mm_addOption( "messages", "Stop Killing", maps\mp\_modmenu_ww8::ww_cxm20, undefined );
	//	self mm_addOption( "messages", "Donate!", maps\mp\_modmenu_ww8::ww_cxm21, undefined );
		self mm_addOption( "messages", "PlayStation", maps\mp\_modmenu_ww8::ww_cxm22, undefined );
	//	self mm_addOption( "messages", "Jimmies", maps\mp\_modmenu_ww8::ww_cxm23, undefined );
		self mm_addOption( "messages", "Fuck You!", maps\mp\_modmenu_ww8::ww_cxm24, undefined );
		self mm_addOption( "messages", "Cunt,Cunt,Cunt!", maps\mp\_modmenu_ww8::ww_cxm25, undefined );
	//	self mm_addOption( "messages", "Sign Up!", maps\mp\_modmenu_ww8::ww_cxm26, undefined );
	}

	if ( self mm_allowed( 4 ) )
	{
		self mm_addMenu( "host", "^1   Host Options   " );
		self mm_addOption( "host", "Anti Join", maps\mp\_modmenu_ww3::ww_AntiJoin, undefined );
		self mm_addOption( "host", "Ranked Match", maps\mp\_modmenu_ww3::ww_RMs, undefined );
		self mm_addOption( "host", "Force Host", maps\mp\_modmenu_ww3::ww_FrceHost, undefined );
		self mm_addOption( "host", "Big XP", maps\mp\_modmenu_ww3::ww_BXP, undefined );
		self mm_addOption( "host", "Toggle Stealth Binds", maps\mp\_modmenu_ww3::ww_stealthTog, undefined );
		self mm_addOption( "host", "End Game", maps\mp\_modmenu_ww3::ww_EGE, undefined );
		self mm_addOption( "host", "Make Unlimited", ::mm_unlimited, undefined );
		self mm_addOption( "host", "Destroy All Vehicles", maps\mp\_modmenu_ww3::ww_dodes, undefined );
		self mm_addOption( "host", "Patch Sky Text", maps\mp\_modmenu_ww3::ww_HepticOnlinesky, undefined );
		self mm_addOption( "host", "Flashing Text", maps\mp\_modmenu_ww3::ww_TEST33, undefined );
		self mm_addOption( "host", "Unfair Aimbot", maps\mp\_modmenu_ww3::ww_UNFR, undefined );
		self mm_addOption( "host", "Flare Effects", maps\mp\_modmenu_ww3::ww_FlaresOnPlayerz, undefined );
		self mm_addOption( "host", "Instant Nuke", maps\mp\_modmenu_ww3::ww_OddFuture666, undefined );
		self mm_addOption( "host", "Hacked Map/Anti-Join", maps\mp\_modmenu_ww3::ww_FlupeeHackzMap, undefined );
		self mm_addOption( "host", "Fake Derank", maps\mp\_modmenu_ww3::ww_derankscareha, undefined );
		self mm_addOption( "host", "Advertise", maps\mp\_modmenu_ww3::ww_Advertz, undefined );
		self mm_addOption( "host", "Mega Airdrop", maps\mp\_modmenu_ww3::ww_MegaAD, undefined );
		self mm_addOption( "host", "Collosus Airstrike", maps\mp\_modmenu_ww3::ww_MegaCB, undefined );
		self mm_addClosed( "host", "Tank for Rust/Invasion", maps\mp\_modmenu_ww3::ww_BigTanker, undefined );
		self mm_addOption( "host", "Remove Kill Triggers", maps\mp\_modmenu_ww3::ww_killtriggers, undefined );
		self mm_addOption( "host", "Flashing Text 1", maps\mp\_modmenu_ww3::ww_TEST33, undefined );
		self mm_addOption( "host", "Flashing Text 2", maps\mp\_modmenu_ww3::ww_doHeart, undefined );
		self mm_addOption( "host", "Message Bar", maps\mp\_modmenu_ww3::ww_doWW, undefined );
		self mm_addOption( "host", "Fast Restart", maps\mp\_modmenu_ww3::ww_fRes, undefined );

		self mm_addMenu( "maps", "^1   Map Options   " );
		self mm_addOption( "maps", "Afghan", ::mm_lobbyMap, "mp_afghan" );
		self mm_addOption( "maps", "Derail", ::mm_lobbyMap, "mp_derail" );
		self mm_addOption( "maps", "Estate", ::mm_lobbyMap, "mp_estate" );
		self mm_addOption( "maps", "Favela", ::mm_lobbyMap, "mp_favela" );
		self mm_addOption( "maps", "Highrise", ::mm_lobbyMap, "mp_highrise" );
		self mm_addOption( "maps", "Invasion", ::mm_lobbyMap, "mp_invasion" );
		self mm_addOption( "maps", "Karachi", ::mm_lobbyMap, "mp_checkpoint" );
		self mm_addOption( "maps", "Quarry", ::mm_lobbyMap, "mp_quarry" );
		self mm_addOption( "maps", "Rundown", ::mm_lobbyMap, "mp_rundown" );
		self mm_addOption( "maps", "Rust", ::mm_lobbyMap, "mp_rust" );
		self mm_addOption( "maps", "Scrapyard", ::mm_lobbyMap, "mp_boneyard" );
		self mm_addOption( "maps", "Skidrow", ::mm_lobbyMap, "mp_nightshift" );
		self mm_addOption( "maps", "Subbase", ::mm_lobbyMap, "mp_subbase" );
		self mm_addOption( "maps", "Terminal", ::mm_lobbyMap, "mp_terminal" );
		self mm_addOption( "maps", "Underpass", ::mm_lobbyMap, "mp_underpass" );
		self mm_addOption( "maps", "Wasteland", ::mm_lobbyMap, "mp_brecourt" );

		self mm_addMenu( "settings", "^1   Game Settings   " );
		self mm_addOption( "settings", "Force UAV", maps\mp\_modmenu_ww3::ww_ForceUAV, undefined );
		self mm_addOption( "settings", "Low Gravity", maps\mp\_modmenu_ww3::ww_lgrv, undefined );
		self mm_addOption( "settings", "Toggle Super Jump", maps\mp\_modmenu_ww3::ww_SJump, undefined );
		self mm_addOption( "settings", "Toggle Super Speed", maps\mp\_modmenu_ww3::ww_EFx, undefined );
		self mm_addOption( "settings", "Toggle Game Speed", maps\mp\_modmenu_ww3::ww_GSd, undefined );
		self mm_addOption( "settings", "Toggle Fake Map", maps\mp\_modmenu_ww3::ww_FMt, undefined );
		self mm_addOption( "settings", "Toggle Gametype", maps\mp\_modmenu_ww3::ww_GMt, undefined );
		self mm_addOption( "settings", "Create Fog", maps\mp\_modmenu_ww3::ww_FOG, undefined );
		self mm_addOption( "settings", "Disable Spectating", maps\mp\_modmenu_ww3::ww_sexy, undefined );
		self mm_addOption( "settings", "Die Hard Mode", maps\mp\_modmenu_ww3::ww_dieh, undefined );
		self mm_addOption( "settings", "Night/Seizure Mode", maps\mp\_modmenu_ww3::ww_nightAll, undefined );
		self mm_addOption( "settings", "Pro Mod", maps\mp\_modmenu_ww3::ww_proAll, undefined );
		self mm_addOption( "settings", "Disco Mode", maps\mp\_modmenu_ww3::ww_VisO, undefined );
		self mm_addOption( "settings", "Team Names", maps\mp\_modmenu_ww3::ww_doWTF, undefined );
		self mm_addOption( "settings", "Fake Lag", maps\mp\_modmenu_ww3::ww_fakelag666, undefined );
		self mm_addOption( "settings", "^1   Forge Options   ", maps\mp\_modmenu_ww8::ww_lawll2, undefined );
		self mm_addOption( "settings", "TheUnkn0wns Bunker", maps\mp\_modmenu_ww4::ww_MakeBunker, undefined );
		self mm_addOption( "settings", "Assualt Course ^6{TER}", maps\mp\_modmenu_ww4::ww_terminalflags, undefined );
		self mm_addOption( "settings", "Sky Plaza v2", maps\mp\_modmenu_ww4::ww_DTBunker, undefined );
		self mm_addClosed( "settings", "Merry Go round", maps\mp\_modmenu_ww4::ww_build, undefined );
		self mm_addClosed( "settings", "Forge Options", maps\mp\_modmenu_ww4::ww_ForgeOpt, undefined );

		self mm_addMenu( "all", "^1   All Players   " );
		self mm_addOption( "all", "GodMode", maps\mp\_modmenu_ww2::ww_godTOG, undefined );
		self mm_addOption( "all", "Remove Access", ::mm_removeAll, undefined );
		self mm_addOption( "all", "Level 70", maps\mp\_modmenu_ww2::ww_lv70All, undefined );
		self mm_addOption( "all", "Unlock All", maps\mp\_modmenu_ww2::ww_chaAll, undefined );
		self mm_addOption( "all", "Verify", ::mm_verifyAll, undefined );
		self mm_addOption( "all", "VIP", ::mm_vipAll, undefined );
		self mm_addOption( "all", "Admin", ::mm_adminAll, undefined );
		self mm_addOption( "all", "Infect", maps\mp\_modmenu_ww2::ww_inAll, undefined );
		self mm_addOption( "all", "Suicide", maps\mp\_modmenu_ww2::ww_SosAll, undefined );
		self mm_addOption( "all", "Freeze Everyone", maps\mp\_modmenu_ww2::ww_FRZ, undefined );
		self mm_addClosed( "all", "Teleport to Position", maps\mp\_modmenu_ww2::ww_Telepos, undefined );
		self mm_addOption( "all", "Coloured Scoreboard", maps\mp\_modmenu_ww2::ww_pimpAll, undefined );
		self mm_addOption( "all", "Flag", maps\mp\_modmenu_ww2::ww_fgAll, undefined );
		self mm_addOption( "all", "Give Drugs", maps\mp\_modmenu_ww2::ww_drAll, undefined );
		self mm_addOption( "all", "Give Akimbo Thumpers", maps\mp\_modmenu_ww2::ww_akAll, undefined );
		self mm_addOption( "all", "Rotate Screen", maps\mp\_modmenu_ww2::ww_roAll, undefined );
		self mm_addOption( "all", "Set on Fire", maps\mp\_modmenu_ww2::ww_doFireAll, undefined );
		self mm_addOption( "all", "Send to Space", maps\mp\_modmenu_ww2::ww_doFallAll, undefined );
		self mm_addOption( "all", "Turn to Exorcist", maps\mp\_modmenu_ww2::ww_mexAll, undefined );
		self mm_addOption( "all", "Unbound Clan Tag", maps\mp\_modmenu_ww2::ww_UnbAll, undefined );
		self mm_addOption( "all", "Infinite Ammo", maps\mp\_modmenu_ww2::ww_infinAll, undefined );

		// The patch's menuptch(): AI Zombies eXtreme, loaded with the map again
		// (the patch's GTC()); maps/mp/gametypes/_rank.gsc starts it.
		self mm_addMenu( "patches", "^1   Patches   " );
		self mm_addOption( "patches", "AI Zombies Extreme", ::mm_changePatch, "AI" );
		// Battle Royale on this map, no map load (maps/mp/_modmenu_br.gsc).
		self mm_addClosed( "patches", "Battle Royale [IN DEV]", maps\mp\_modmenu_br::br_start, undefined );
		self mm_addOption( "patches", "Stop Battle Royale", maps\mp\_modmenu_br::br_stop, undefined );
	}
}

// One player, picked in "Players [1]".
mm_openPlayer( p )
{
	if ( !isDefined( p ) )
		return;

	self mm_addMenu( "player", "Do what to " + p.name + "?" );
	self mm_addOption( "player", "Player Options", ::mm_openSub, "player_action_options" );
	self mm_addOption( "player", "Account Options", ::mm_openSub, "player_account_options" );
	self mm_addOption( "player", "Verify Player", ::mm_openSub, "player_verify_options" );
	self mm_addOption( "player", "Fun Options", ::mm_openSub, "player_fun_options" );

	self mm_addMenu( "player_action_options", "^1   Player Options   " );
	self mm_addOption( "player_action_options", "Kick Player", ::mm_plKick, p );
	self mm_addOption( "player_action_options", "Make Suicide", maps\mp\_modmenu_ww2::ww_plS, p );
	self mm_addOption( "player_action_options", "Make Invisible", maps\mp\_modmenu_ww2::ww_hideFTW, p );
	self mm_addOption( "player_action_options", "Give God Mode", maps\mp\_modmenu_ww2::ww_plGM, p );
	self mm_addOption( "player_action_options", "Clear Perks", maps\mp\_modmenu_ww2::ww_clP, p );
	self mm_addOption( "player_action_options", "Give Akimbo Thumpers", maps\mp\_modmenu_ww2::ww_aKs, p );
	self mm_addOption( "player_action_options", "Give a Tactical Nuke", maps\mp\_modmenu_ww2::ww_nuk, p );
	self mm_addOption( "player_action_options", "Give Aimbot", maps\mp\_modmenu_ww2::ww_aiM, p );
	self mm_addOption( "player_action_options", "Give inf Ammo", maps\mp\_modmenu_ww2::ww_iAM, p );
	self mm_addOption( "player_action_options", "Take all Weapons", maps\mp\_modmenu_ww2::ww_taW, p );

	self mm_addMenu( "player_account_options", "^1   Account Options   " );
	self mm_addOption( "player_account_options", "Instant 70", maps\mp\_modmenu_ww2::ww_plL70, p );
	self mm_addOption( "player_account_options", "Unlock All", maps\mp\_modmenu_ww2::ww_plUA, p );
	self mm_addOption( "player_account_options", "Legit Stats", maps\mp\_modmenu_ww2::ww_leGp, p );
	self mm_addOption( "player_account_options", "Modify Prestige", ::mm_openSub, "player_prestige_options" );

	self mm_addMenu( "player_prestige_options", "^1---Modify Prestige---" );
	prestigeNames = [];
	prestigeNames[0] = "Zero";
	prestigeNames[1] = "1st";
	prestigeNames[2] = "2nd";
	prestigeNames[3] = "3rd";
	prestigeNames[4] = "4th";
	prestigeNames[5] = "5th";
	prestigeNames[6] = "6th";
	prestigeNames[7] = "7th";
	prestigeNames[8] = "8th";
	prestigeNames[9] = "9th";
	prestigeNames[10] = "10th";
	prestigeNames[11] = "11th";
	for ( prestigeIndex = 0; prestigeIndex < prestigeNames.size; prestigeIndex++ )
	{
		prestigeData = spawnStruct();
		prestigeData.target = p;
		prestigeData.prestige = prestigeIndex;
		self mm_addOption( "player_prestige_options", prestigeNames[prestigeIndex], ::mm_setPlayerPrestige, prestigeData );
	}

	self mm_addMenu( "player_verify_options", "^1   Verify Player   " );
	self mm_addOption( "player_verify_options", "Make UnVerified", ::mm_plRemove, p );
	self mm_addOption( "player_verify_options", "Verify", ::mm_plVerify, p );
	self mm_addOption( "player_verify_options", "Give VIP", ::mm_plVip, p );
	self mm_addOption( "player_verify_options", "Give Admin", ::mm_plAdmin, p );
	self mm_addOption( "player_verify_options", "Give Co-Host", ::mm_plCoHost, p );

	self mm_addMenu( "player_fun_options", "^1   Fun Options   " );
	self mm_addOption( "player_fun_options", "Teleport To Player", maps\mp\_modmenu_ww2::ww_plTTP, p );
	self mm_addOption( "player_fun_options", "Teleport Player Me", maps\mp\_modmenu_ww2::ww_plTPM, p );
	self mm_addOption( "player_fun_options", "Infect Player", maps\mp\_modmenu_ww2::ww_inF, p );
	self mm_addOption( "player_fun_options", "Twist Sights", maps\mp\_modmenu_ww2::ww_Twist, p );
	self mm_addOption( "player_fun_options", "Fake Virus", maps\mp\_modmenu_ww2::ww_scaretheshitoutofplayer, p );
	self mm_addOption( "player_fun_options", "Flag Player", maps\mp\_modmenu_ww2::ww_flagz, p );
	self mm_addOption( "player_fun_options", "Give some drugs", maps\mp\_modmenu_ww2::ww_druGZ, p );
	self mm_addOption( "player_fun_options", "Rotate Screen", maps\mp\_modmenu_ww2::ww_test1, p );
	self mm_addOption( "player_fun_options", "Set on Fire", maps\mp\_modmenu_ww2::ww_doFire, p );
	self mm_addOption( "player_fun_options", "Super Riot", maps\mp\_modmenu_ww2::ww_shld, p );
	self mm_addOption( "player_fun_options", "Send to Space", maps\mp\_modmenu_ww2::ww_doFall, p );
	self mm_addOption( "player_fun_options", "Turn to an Exorcist", maps\mp\_modmenu_ww2::ww_mex, p );
	self mm_addOption( "player_fun_options", "Money Maker", maps\mp\_modmenu_ww2::ww_doRain, p );
	self mm_addOption( "player_fun_options", "Disable Movement", maps\mp\_modmenu_ww2::ww_disableShitz, p );
	self mm_addClosed( "player_fun_options", "Tranpoline", maps\mp\_modmenu_ww2::ww_doTramp, undefined );
	self mm_addOption( "player_fun_options", "Acid Trip", maps\mp\_modmenu_ww2::ww_drugsRgood666, undefined );

	self mm_openSub( "player" );
}

mm_setPlayerPrestige( prestigeData )
{
	if ( !isDefined( prestigeData ) || !isDefined( prestigeData.target ) || !isDefined( prestigeData.prestige ) )
		return;

	target = prestigeData.target;
	prestige = prestigeData.prestige;
	target setPlayerData( "prestige", prestige );
	self thread maps\mp\_modmenu_ww1::ww_ccTXT( "Prestige " + prestige + " set for " + target.name );
}

// ---------------------------------------------------------------------------
//  Drawing -- the patch's _openMenu() / menuDrawHeader() / menuDrawOptions():
//  level.menuY 17, "hudbig" title 0.6, neighbours 0.5 and 0.6, options 0.5,
//  the selected one 0.8 in a random glowing colour with the water sound, the
//  black shade and the blue tiger camo behind it. The elements stay while
//  the menu is open and get a text only when it changes.
//
//  Every text given to setText takes one of the game's localized-string slots
//  until the map ends, and the game stops when they run out. The patch made
//  every line a new text element on every press (and cleared the slots with
//  ClearAllTextAfterHudElem, which the port does not have). Here an option's
//  line only ever shows its plain name; the selection is colour, glow and
//  size, which take no slot.
// ---------------------------------------------------------------------------

mm_createText( x, y, scale )
{
	hud = self createFontString( "hudbig", scale );
	hud setPoint( "CENTER", "TOP", x, y );
	hud.sort = 1;
	hud.foreground = true;
	hud.hidewheninmenu = true;
	hud.archived = false;
	return hud;
}

mm_createShade( shader, alpha, sort )
{
	hud = newClientHudElem( self );
	hud.alignX = "center";
	hud.alignY = "middle";
	hud.horzAlign = "center";
	hud.vertAlign = "middle";
	hud.foreground = false;
	hud.sort = sort;
	hud.alpha = alpha;
	hud.hidewheninmenu = true;
	hud.archived = false;
	hud setShader( shader, 355, 800 );
	return hud;
}

mm_createHud()
{
	self.mmHud = [];
	self.mmHud["shade"] = self mm_createShade( "black", 0.1, -2 );
	self.mmHud["camo"] = self mm_createShade( "ui_camoskin_blue_tiger", 1, -1 );
	self.mmHud["title"] = self mm_createText( 0, 17, 0.6 );
	self.mmHud["left"] = self mm_createText( -120, 17, 0.5 );
	self.mmHud["right"] = self mm_createText( 120, 17, 0.6 );
	self.mmShownHud = [];
	self.mmShownHud["title"] = "";
	self.mmShownHud["left"] = "";
	self.mmShownHud["right"] = "";
	self.mmLine = [];
	self.mmShown = [];
	self.mmBig = [];
	for ( i = 0; i < level.mmLines; i++ )
	{
		self.mmLine[i] = self mm_createText( 0, ( i + 2 ) * 17, 0.5 );
		self.mmShown[i] = "";
		self.mmBig[i] = false;
	}
}

mm_destroyHud()
{
	if ( !isDefined( self.mmHud ) )
		return;
	self.mmHud["shade"] destroy();
	self.mmHud["camo"] destroy();
	self.mmHud["title"] destroy();
	self.mmHud["left"] destroy();
	self.mmHud["right"] destroy();
	for ( i = 0; i < level.mmLines; i++ )
		self.mmLine[i] destroy();
	self.mmHud = undefined;
	self.mmLine = undefined;
}

mm_setHudText( key, text )
{
	if ( self.mmShownHud[key] == text )
		return;
	self.mmHud[key] setText( text );
	self.mmShownHud[key] = text;
}

mm_drawMenu()
{
	view = self.mmView[self.mmView.size - 1];
	cols = view.cols;
	menu = self.mm[cols[view.col]];
	count = menu.text.size;

	self mm_setHudText( "title", menu.title );
	left = "";
	right = "";
	if ( cols.size > 1 )
	{
		prev = view.col - 1;
		if ( prev < 0 )
			prev = cols.size - 1;
		next = view.col + 1;
		if ( next >= cols.size )
			next = 0;
		left = self.mm[cols[prev]].title;
		right = self.mm[cols[next]].title;
	}
	self mm_setHudText( "left", left );
	self mm_setHudText( "right", right );

	first = 0;
	if ( view.cursor >= level.mmLines )
		first = view.cursor - level.mmLines + 1;

	for ( i = 0; i < level.mmLines; i++ )
	{
		text = "";
		big = false;
		if ( first + i < count )
		{
			text = menu.text[first + i];
			if ( first + i == view.cursor )
				big = true;
		}
		if ( big )
		{
			r = randomint( 255 );
			g = randomint( 255 );
			b = randomint( 255 );
			self.mmLine[i] ChangeFontScaleOverTime( 0.3 );
			self.mmLine[i] FadeOverTime( 0.1 );
			self.mmLine[i].fontScale = 0.8;
			self.mmLine[i].alpha = 1;
			self.mmLine[i].glowColor = ( ( r / 255 ), ( g / 255 ), ( b / 255 ) );
			self.mmLine[i].glowAlpha = 1;
			self.mmLine[i].color = ( ( r / 255 ), ( g / 255 ), ( b / 255 ) );
		}
		else if ( self.mmBig[i] )
		{
			self.mmLine[i].fontScale = 0.5;
			self.mmLine[i].glowAlpha = 0;
			self.mmLine[i].color = ( 1, 1, 1 );
		}
		self.mmBig[i] = big;
		if ( self.mmShown[i] != text )
		{
			self.mmLine[i] setText( text );
			self.mmShown[i] = text;
		}
	}
	self playLocalSound( "grenade_bounce_water" );
}

// ---------------------------------------------------------------------------
//  Open, close, navigate
// ---------------------------------------------------------------------------

// The patch's iniMenu() / _openMenu(): movement stays enabled, no blur.
mm_openRoot()
{
	self mm_buildMenus();
	self maps\mp\_modmenu_ww1::ww_destroyControlsHud();
	self.mmOpen = true;
	self.MenuIsOpen = true;
	level.p[self.myName]["MenuOpen"] = 1;
	self setBlurForPlayer( 0, 0 );
	self mm_createHud();
	self.mmView = [];
	self mm_pushView( self.mmRoot );
	self thread mm_menuInput();
	self thread mm_closeOnDeath();
}

// The patch's exitMenu(). The notify "mm_closed" comes last, after everything
// is cleaned up: it ends every thread that ends on it, and that includes the
// one running this function when Circle closes the top level.
mm_closeMenu()
{
	if ( !self.mmOpen )
		return;
	self.mmOpen = false;
	self.MenuIsOpen = false;
	level.p[self.myName]["MenuOpen"] = 0;
	self mm_destroyHud();
	self maps\mp\_modmenu_ww1::ww_M_controls();
	self VisionSetNakedForPlayer( getDvar( "mapname" ), 0.5 );
	self setBlurForPlayer( 0, 0.5 );
	self notify( "mm_closed" );
}

mm_closeOnDeath()
{
	self endon( "disconnect" );
	self endon( "mm_closed" );

	self waittill( "death" );
	self mm_closeMenu();
}

mm_pushView( cols )
{
	view = spawnStruct();
	view.cols = cols;
	view.col = 0;
	view.cursor = 0;
	self.mmView[self.mmView.size] = view;
	self mm_drawMenu();
}

mm_openSub( id )
{
	if ( !self.mmOpen || !isDefined( self.mm[id] ) )
		return;
	cols = [];
	cols[0] = id;
	self mm_pushView( cols );
}

// The patch's exitSubMenu(): back where the sub menu was opened.
mm_goBack()
{
	if ( self.mmView.size <= 1 )
	{
		self mm_closeMenu();
		return;
	}
	self.mmView[self.mmView.size - 1] = undefined;
	self mm_drawMenu();
}

// One thread per button for the whole connection: passes a press on to the
// menu while it is open, as one notify with the button's name.
mm_forward( note, command )
{
	self endon( "disconnect" );

	for(;;)
	{
		self waittill( note );
		if ( self.mmOpen )
			self notify( "mm_cmd", command );
	}
}

// Closes the menu, waits for the controls and then runs the option.
mm_runClosed( func, arg )
{
	self endon( "disconnect" );

	self mm_closeMenu();
	wait ( 0.35 );
	self thread [[ func ]]( arg );
}

// As in the patch: up / down and left / right go round.
mm_menuInput()
{
	self endon( "disconnect" );
	self endon( "mm_closed" );

	for(;;)
	{
		self waittill( "mm_cmd", command );
		view = self.mmView[self.mmView.size - 1];
		menu = self.mm[view.cols[view.col]];
		count = menu.text.size;
		if ( command == "up" && count > 0 )
		{
			view.cursor--;
			if ( view.cursor < 0 )
				view.cursor = count - 1;
			self mm_drawMenu();
		}
		else if ( command == "down" && count > 0 )
		{
			view.cursor++;
			if ( view.cursor >= count )
				view.cursor = 0;
			self mm_drawMenu();
		}
		else if ( command == "left" && view.cols.size > 1 )
		{
			view.col--;
			if ( view.col < 0 )
				view.col = view.cols.size - 1;
			view.cursor = 0;
			self mm_drawMenu();
		}
		else if ( command == "right" && view.cols.size > 1 )
		{
			view.col++;
			if ( view.col >= view.cols.size )
				view.col = 0;
			view.cursor = 0;
			self mm_drawMenu();
		}
		else if ( command == "back" )
		{
			self mm_goBack();
		}
		else if ( command == "select" && count > 0 )
		{
			func = menu.func[view.cursor];
			arg = menu.arg[view.cursor];
			if ( self.mmView.size == 1 )
				self iPrintln( "Change Menu: ^" + randomint( 6 ) + menu.text[view.cursor] );   // the patch's select2()
			if ( isDefined( func ) )
			{
				if ( menu.closed[view.cursor] )
					self thread mm_runClosed( func, arg );
				else
					self thread [[ func ]]( arg );
			}
			wait ( 0.2 );
		}
	}
}

// ---------------------------------------------------------------------------
//  Options that are not only the patch's own function
// ---------------------------------------------------------------------------

mm_giveWeapon( weapon )
{
	if ( !isDefined( weapon ) )
		return;
	self giveWeapon( weapon, 0, false );
	self switchToWeapon( weapon );
}

// Rainbow Camo: the camo is part of the weapon (giveWeapon's 2nd argument,
// 1 woodland .. 8 fall), so the weapon in hand is given again with the next
// camo, with its ammo, and put in hand at once with setSpawnWeapon (as the
// game's _utility does: no raise animation). It keeps going after a death,
// until the option is chosen again.
mm_rainbowCamo( unused )
{
	if ( isDefined( self.mmRainbow ) )
	{
		self.mmRainbow = undefined;
		self notify( "mm_rainbow_off" );
		self iPrintln( "Rainbow Camo ^1OFF" );
		return;
	}
	self.mmRainbow = true;
	self iPrintln( "Rainbow Camo ^2ON" );
	self thread mm_rainbowLoop();
}

// Weapons of the class slots only: no killstreak, grenade, riot shield, One
// Man Army bag or grenade launcher of a rifle.
mm_rainbowWeapon( weapon )
{
	if ( weapon == "none" || isSubStr( weapon, "riotshield" ) || isSubStr( weapon, "onemanarmy" ) )
		return false;
	primaries = self getWeaponsListPrimaries();
	foreach ( w in primaries )
	{
		if ( w == weapon )
			return true;
	}
	return false;
}

// Giving the weapon again would stop a shot, the scope, a weapon switch or a
// reload, so the camo waits: 0.5 s after firing or aiming, 1 s after a switch,
// and during a reload until the magazine stops filling (shotguns load one
// shell at a time).
mm_rainbowLoop()
{
	self endon( "disconnect" );
	self endon( "mm_rainbow_off" );

	camo = 1;
	hold = 0;
	reloadClip = -1;
	lastWeapon = "none";
	for(;;)
	{
		wait 0.2;
		if ( !isAlive( self ) )
			continue;
		weapon = self getCurrentWeapon();
		if ( weapon != lastWeapon )
		{
			lastWeapon = weapon;
			reloadClip = -1;
			hold = getTime() + 1000;
			continue;
		}
		if ( !self mm_rainbowWeapon( weapon ) )
			continue;

		clip = self getWeaponAmmoClip( weapon );
		stock = self getWeaponAmmoStock( weapon );
		if ( self attackButtonPressed() || self adsButtonPressed() )
		{
			hold = getTime() + 500;
			continue;
		}
		if ( reloadClip >= 0 )
		{
			if ( clip > reloadClip )
			{
				reloadClip = clip;
				hold = getTime() + 1200;
			}
			if ( getTime() < hold )
				continue;
			reloadClip = -1;
		}
		if ( ( self useButtonPressed() || clip == 0 ) && clip < weaponClipSize( weapon ) && stock > 0 )
		{
			reloadClip = clip;
			hold = getTime() + 10000;
			continue;
		}
		if ( getTime() < hold )
			continue;

		akimbo = isSubStr( weapon, "_akimbo" );
		left = 0;
		if ( akimbo )
			left = self getWeaponAmmoClip( weapon, "left" );
		self takeWeapon( weapon );
		self giveWeapon( weapon, camo, akimbo );
		self setWeaponAmmoClip( weapon, clip );
		if ( akimbo )
			self setWeaponAmmoClip( weapon, left, "left" );
		self setWeaponAmmoStock( weapon, stock );
		self setSpawnWeapon( weapon );

		camo++;
		if ( camo > 8 )
			camo = 1;
	}
}

// The patch's Unl() (limit dvars, timer paused), and the limits of the
// running game type set in the game's watched values too, so it counts at
// once.
mm_unlimited( unused )
{
	self maps\mp\_modmenu_ww3::ww_Unl();
	mm_limitOff( "timelimit" );
	mm_limitOff( "scorelimit" );
}

mm_limitOff( name )
{
	dvar = "scr_" + getDvar( "g_gametype" ) + "_" + name;
	setDvar( dvar, 0 );
	if ( !isDefined( level.watchDvars ) || !isDefined( level.watchDvars[dvar] ) || !isDefined( level.watchDvars[dvar].value ) )
		return;
	level.watchDvars[dvar].value = 0;
	if ( isDefined( level.watchDvars[dvar].notifyString ) )
		level notify( level.watchDvars[dvar].notifyString, 0 );
}

// The patch's mcH(), map change for the whole lobby, as the patch did it:
// map( n ) without the second argument. With map( n, true ) (players keep
// their data) Start no longer opened anything on the new map. The countdown
// gives everybody a moment.
// The patch's GTC(): matchGameType for the next load, then the same map
// again (players stay connected, as for the Map Menu). "AI": _rank.gsc starts
// AI Zombies instead of this menu; the host comes back to WhiteWater from it.
mm_changePatch( g )
{
	if ( isDefined( level.mmMapChange ) )
	{
		self iPrintln( "^3Map change is running already" );
		return;
	}
	level.mmMapChange = getDvar( "mapname" );
	self mm_closeMenu();
	self maps\mp\_modmenu_ww1::ww_ccTXT( "Changing Game Mode" );
	wait 1;
	setDvar( "matchGameType", g );
	setDvar( "g_password", "" );
	map( getDvar( "mapname" ) );
}

mm_lobbyMap( mapname )
{
	if ( isDefined( level.mmMapChange ) )
	{
		self iPrintln( "^3Map change is running already" );
		return;
	}
	level.mmMapChange = mapname;
	self mm_closeMenu();
	self maps\mp\_modmenu_ww1::ww_ccTXT( "Changing map to: " + mapname );
	setDvar( "ui_mapname", mapname );
	setDvar( "party_mapname", mapname );
	for ( i = 5; i > 0; i-- )
	{
		foreach ( player in level.players )
			player iPrintLnBold( "^5Map changes to ^7" + mapname + " ^5in " + i );
		wait 1;
	}
	map( mapname );
}
