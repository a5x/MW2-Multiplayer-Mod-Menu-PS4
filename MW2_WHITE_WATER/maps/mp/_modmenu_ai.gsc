// ============================================================================
//  AI Zombies eXtreme V1.8 ([115]Death) for MW2 (2009) on the PS4 port, as
//  the WhiteWaterV6.5 patch_mp runs it: picked in WhiteWater's Patches Menu
//  ("AI Zombies Extreme", matchGameType "AI"), the map is loaded again and
//  WhiteWater starts this instead of its own menu.
//
//      maps\mp\gametypes\_rank.gsc:  level thread maps\mp\_modmenu_ai::init();
//      (instead of maps\mp\_modmenu::init() when matchGameType is "AI")
//
//  The mode's own functions are in maps/mp/_modmenu_ai1..N.gsc (renamed ai_*):
//  AImod/*.gsc and the patch_mp scripts it uses (MapEdit, coolweapons,
//  Upgrade, _sniper, _overwatch, ...). Functions the stock game has are the
//  stock game's.
//
//  As in the patch: the host goes back to WhiteWater lying down (prone),
//  holding knife (R3) and pressing D-pad right (the patch's knifeandup()).
//
//  For the port (as EliteMossy's): pad commands registered once per connect,
//  numbers on the HUD as numbers (setValue), no text made on every change.
// ============================================================================

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
// The mode's modules: included, so the core calls them by name (a path::func
// call is a precache entry of the script loader each time).
#include maps\mp\_modmenu_ai1;
#include maps\mp\_modmenu_ai2;
#include maps\mp\_modmenu_ai3;
#include maps\mp\_modmenu_ai4;
#include maps\mp\_modmenu_ai5;

init()
{
	// The labels the mode shows a number after (wave, boss health, nuke timer).
	precacheString( &"Wave " );
	precacheString( &"Hell Zombie Wave " );
	precacheString( &"Hell Boss Wave " );
	precacheString( &"Boss Health " );
	precacheString( &"^1Boss Health: " );
	precacheString( &"Survived Wave " );
	precacheString( &"Survived Hell Wave " );
	precacheString( &"Nuke Incoming In: " );

	level thread mm_onPlayerConnect();
	level thread ai_ModLoad();
	level thread mm_noForfeit();
}

// Online (not a private match) the game ends the match when a team has
// nobody for 20 s: "enemy team forfeits in 0:20". Here every player is on
// allies and the zombies are not players, so axis is always empty: the
// forfeit is stopped (its message cleared) and kept from starting again.
mm_noForfeit()
{
	level endon( "game_ended" );

	for(;;)
	{
		level notify( "abort_forfeit" );
		level.forfeitInProgress = true;
		wait 0.5;
	}
}

mm_onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );
		player thread mm_onPlayerConnected();
	}
}

mm_onPlayerConnected()
{
	self endon( "disconnect" );

	// The pad commands the mode's functions wait for, once per connect.
	self ai_registerOptionCommands();
	self notifyOnPlayerCommand( "dpad_right", "+actionslot 4" );
	if ( self isHost() )
		self thread mm_backToWhiteWater();

	// Start opens the menu named by g_scriptMainMenu, sent by the game when a
	// player picks a team; after a map change that keeps the players
	// (map( n, true )) they keep their team without picking it, so it is sent again on every spawn.
	for(;;)
	{
		self waittill( "spawned_player" );
		if ( isDefined( self.pers["team"] ) && ( self.pers["team"] == "allies" || self.pers["team"] == "axis" || self.pers["team"] == "spectator" ) )
			self updateMainMenu();
	}
}

// The patch's knifeandup(): prone + knife + D-pad right, host only.
mm_backToWhiteWater()
{
	self endon( "disconnect" );

	for(;;)
	{
		self waittill( "dpad_right" );
		if ( self getStance() == "prone" && self meleeButtonPressed() )
			break;
	}
	self iPrintln( "^7Changing Game Mode" );
	wait 1;
	// The mode turned these on for the whole lobby (ModLoad); WhiteWater is played without.
	setDvar( "g_hardcore", 0 );
	setDvar( "scr_diehard", 0 );
	setDvar( "matchGameType", 0 );
	setDvar( "g_password", "" );
	map( getDvar( "mapname" ) );
}

// The module calls this when a function of the mode closes "the menu"; the
// mode has none.
mm_closeMenu()
{
}
