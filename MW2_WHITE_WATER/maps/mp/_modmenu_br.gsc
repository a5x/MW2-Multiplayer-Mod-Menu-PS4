// ============================================================================
//  Battle Royale for WhiteWater (MW2 2009, PS4 port).
//
//  Started by a Co-Host or the Host from the Patches Menu, on the map being
//  played (no map load). Everybody playing at the start is in it:
//    - 10 s countdown, everybody is redeployed (killed once, the death does
//      not count) and spawns frozen with a USP .45 only
//    - GO: everybody falls from the sky over a spawn inside the zone (no fall
//      damage while it runs)
//    - loot crates on the map (walk over them): Common SMGs, Rare rifles and
//      shotguns, Epic snipers and LMGs; an airdrop of 2 Epic / Legendary
//      crates falls into the new zone after each shrink. Legendary also
//      gives 150 health for that life.
//    - the zone: 5 phases, each a wait then a shrink towards a random end
//      point, the next circle always inside the last one. Flags on the edge
//      show it, they slide inwards while it shrinks. Outside it the player
//      loses health every second, more each phase; the last circle is 0.
//    - dead = out: spectator until the end. Free-for-all: the last one alive
//      wins. Team modes: the last team with players alive wins.
//    - the menu stays closed for everybody below Co-Host while it runs.
//  At the end the eliminated players go back to their team and spawn again.
//
//  For the port, as the rest of the menu: the HUD shows its numbers with
//  setValue after a precached label (no new text per update: the game's text
//  slots run out), only models and effects the game or the menu has loaded,
//  only built-in functions the menu already calls.
//
//  maps\mp\_modmenu.gsc calls br_init() from init(), br_onSpawned() on every
//  spawn, and has "Battle Royale" / "Stop Battle Royale" in the Patches Menu.
// ============================================================================

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

br_init()
{
	// The HUD labels, set before the numbers (setValue).
	precacheString( &"ALIVE: " );
	precacheString( &"BATTLE ROYALE IN: " );
	precacheString( &"ZONE SHRINKS IN: " );
	precacheString( &"ZONE CLOSING: " );
	precacheString( &"^1OUTSIDE THE ZONE ^7- METERS: " );
	precacheModel( "com_plasticcase_friendly" );
}

// ---------------------------------------------------------------------------
//  Menu options (Patches Menu)
// ---------------------------------------------------------------------------

br_start( unused )
{
	if ( isDefined( level.br ) )
	{
		self iPrintln( "^3Battle Royale is running already" );
		return;
	}
	if ( isDefined( level.mmMapChange ) )
	{
		self iPrintln( "^3Map change is running" );
		return;
	}
	if ( getGametypeNumLives() )
	{
		self iPrintln( "^3Battle Royale: play it in Free-for-all or Team Deathmatch" );
		return;
	}
	points = br_spawnPoints();
	if ( points.size < 2 )
	{
		self iPrintln( "^3Battle Royale: no spawn points found on this map" );
		return;
	}

	level.br = spawnStruct();
	level.br.state = "countdown";
	level.br.points = br_shuffle( points );
	level.br.dropIndex = 0;
	level.br.crates = [];
	level.br.markers = [];
	level.br.aliveCount = 0;
	level.br.damage = 1;
	level.br.labels = [];
	level.br.labels[0] = &"BATTLE ROYALE IN: ";
	level.br.labels[1] = &"ZONE SHRINKS IN: ";
	level.br.labels[2] = &"ZONE CLOSING: ";
	level.br.timerKind = 0;
	level.br.timerEnd = getTime() + 10000;
	level.br.loot = br_lootTable();
	br_setupZone();

	level thread br_run();
}

br_stop( unused )
{
	if ( !isDefined( level.br ) || level.br.state == "ended" )
	{
		self iPrintln( "^3No Battle Royale is running" );
		return;
	}
	level thread br_end( "^3Battle Royale stopped by " + self.name, undefined );
}

// ---------------------------------------------------------------------------
//  Map: spawn points, zone, ground
// ---------------------------------------------------------------------------

br_spawnPoints()
{
	points = [];
	names = strTok( "mp_dm_spawn,mp_tdm_spawn", "," );
	foreach ( name in names )
	{
		ents = getEntArray( name, "classname" );
		foreach ( ent in ents )
			points[points.size] = ent.origin;
	}
	if ( !points.size )
	{
		foreach ( player in level.players )
		{
			if ( isAlive( player ) )
				points[points.size] = player.origin;
		}
	}
	return points;
}

br_shuffle( a )
{
	for ( i = a.size - 1; i > 0; i-- )
	{
		j = randomInt( i + 1 );
		t = a[i];
		a[i] = a[j];
		a[j] = t;
	}
	return a;
}

br_dist2D( a, b )
{
	return distance( ( a[0], a[1], 0 ), ( b[0], b[1], 0 ) );
}

// First circle: around every spawn point. Last circle: a spawn point near the
// middle, so the fight ends somewhere players can stand.
br_setupZone()
{
	points = level.br.points;
	sum = ( 0, 0, 0 );
	zMin = points[0][2];
	zMax = points[0][2];
	foreach ( p in points )
	{
		sum = sum + p;
		if ( p[2] < zMin )
			zMin = p[2];
		if ( p[2] > zMax )
			zMax = p[2];
	}
	center = ( sum[0] / points.size, sum[1] / points.size, sum[2] / points.size );

	radius = 0;
	foreach ( p in points )
	{
		d = br_dist2D( p, center );
		if ( d > radius )
			radius = d;
	}
	radius += 400;

	near = [];
	foreach ( p in points )
	{
		if ( br_dist2D( p, center ) < radius * 0.45 )
			near[near.size] = p;
	}
	last = center;
	if ( near.size )
		last = near[randomInt( near.size )];

	level.br.zMid = center[2];
	level.br.zTop = zMax + 400;
	level.br.zBottom = zMin - 1500;
	level.br.startCenter = center;
	level.br.startRadius = radius;
	level.br.lastCenter = last;

	level.br.fromC = center;
	level.br.toC = center;
	level.br.fromR = radius;
	level.br.toR = radius;
	level.br.shrinkStart = 0;
	level.br.shrinkTime = 0;
}

// Wait (s), shrink (s), part of the first radius, damage per second.
br_phases()
{
	p = [];
	p[0] = br_phase( 45, 30, 0.65, 2 );
	p[1] = br_phase( 35, 25, 0.40, 4 );
	p[2] = br_phase( 25, 20, 0.22, 6 );
	p[3] = br_phase( 20, 15, 0.10, 9 );
	p[4] = br_phase( 15, 15, 0.0, 12 );
	return p;
}

br_phase( hold, shrink, part, damage )
{
	ph = spawnStruct();
	ph.hold = hold;
	ph.shrink = shrink;
	ph.part = part;
	ph.damage = damage;
	return ph;
}

br_zoneFrac()
{
	if ( level.br.shrinkTime <= 0 )
		return 1;
	f = ( getTime() - level.br.shrinkStart ) * 1.0 / level.br.shrinkTime;
	if ( f < 0 )
		return 0;
	if ( f > 1 )
		return 1;
	return f;
}

br_zoneCenter()
{
	return level.br.fromC + ( level.br.toC - level.br.fromC ) * br_zoneFrac();
}

br_zoneRadius()
{
	return level.br.fromR + ( level.br.toR - level.br.fromR ) * br_zoneFrac();
}

// How far outside the zone (0 inside).
br_outsideBy( origin )
{
	d = br_dist2D( origin, br_zoneCenter() ) - br_zoneRadius();
	if ( d < 0 )
		return 0;
	return d;
}

br_ground( x, y )
{
	trace = bulletTrace( ( x, y, level.br.zTop ), ( x, y, level.br.zBottom ), false, undefined );
	pos = trace["position"];
	if ( pos[2] <= level.br.zBottom + 1 )
		return ( x, y, level.br.zMid );
	return pos;
}

br_ringPoint( center, radius, k )
{
	dir = anglesToForward( ( 0, k * 22.5, 0 ) );
	return br_ground( center[0] + dir[0] * radius, center[1] + dir[1] * radius );
}

// A spawn point inside the zone, a different one each call while there are.
br_pickPoint( center, radius )
{
	points = level.br.points;
	for ( i = 0; i < points.size; i++ )
	{
		p = points[( level.br.dropIndex + i ) % points.size];
		if ( br_dist2D( p, center ) < radius )
		{
			level.br.dropIndex = ( level.br.dropIndex + i + 1 ) % points.size;
			return p;
		}
	}
	return br_ground( center[0], center[1] );
}

// Up to height above p, under any roof.
br_skyAbove( p, height, ignore )
{
	top = bulletTrace( p + ( 0, 0, 40 ), p + ( 0, 0, height ), false, ignore )["position"];
	pos = top - ( 0, 0, 90 );
	if ( pos[2] < p[2] + 40 )
		return p + ( 0, 0, 10 );
	return pos;
}

// ---------------------------------------------------------------------------
//  The round
// ---------------------------------------------------------------------------

br_run()
{
	level endon( "br_end" );

	maps\mp\_modmenu::mm_limitOff( "timelimit" );
	maps\mp\_modmenu::mm_limitOff( "scorelimit" );
	level.br.oldFallMin = getDvar( "bg_fallDamageMinHeight" );
	level.br.oldFallMax = getDvar( "bg_fallDamageMaxHeight" );
	level.br.oldForceRespawn = getDvar( "scr_player_forcerespawn" );
	setDvar( "bg_fallDamageMaxHeight", 9999 );
	setDvar( "bg_fallDamageMinHeight", 9998 );
	setDvar( "scr_player_forcerespawn", 1 );

	count = 0;
	foreach ( player in level.players )
	{
		player.brMoved = undefined;
		player.brTeam = player.pers["team"];
		if ( isDefined( player.pers["team"] ) && ( player.pers["team"] == "allies" || player.pers["team"] == "axis" ) )
		{
			player.brState = "in";
			count++;
			player thread br_watchDeath();
		}
		else
			player.brState = "out";
		if ( !player maps\mp\_modmenu::mm_allowed( 4 ) )
			player maps\mp\_modmenu::mm_closeMenu();
		player thread br_hud();
	}
	level.br.solo = ( count < 2 );
	level.br.aliveCount = count;

	br_spawnMarkers();
	crates = 6 + count * 2;
	if ( crates > 18 )
		crates = 18;
	for ( i = 0; i < crates; i++ )
		br_spawnCrate( level.br.points[i % level.br.points.size], br_crateTier(), false );

	if ( level.teamBased )
		br_announce( "^5BATTLE ROYALE ^7- last team standing wins" );
	else
		br_announce( "^5BATTLE ROYALE ^7- last one standing wins" );
	wait 2;
	// Redeployed: everybody alive dies once (not counted, the state is still
	// "countdown") and spawns again with the Battle Royale loadout.
	foreach ( player in level.players )
	{
		if ( br_isIn( player ) && isAlive( player ) )
			player suicide();
	}
	wait 8;

	level.br.state = "fight";
	level.br.goTime = getTime();
	level notify( "br_go" );
	br_announce( "^2GO! ^7Loot the crates, stay in the zone" );

	level thread br_damageLoop();
	level thread br_watchEnd();
	br_zoneLoop();
}

br_zoneLoop()
{
	level endon( "br_end" );

	phases = br_phases();
	for ( i = 0; i < phases.size; i++ )
	{
		ph = phases[i];
		level.br.timerKind = 1;
		level.br.timerEnd = getTime() + ph.hold * 1000;
		wait ( ph.hold );

		newR = level.br.startRadius * ph.part;
		newC = level.br.lastCenter + ( level.br.startCenter - level.br.lastCenter ) * ph.part;
		level.br.fromC = level.br.toC;
		level.br.fromR = level.br.toR;
		level.br.toC = newC;
		level.br.toR = newR;
		level.br.shrinkStart = getTime();
		level.br.shrinkTime = ph.shrink * 1000;
		level.br.damage = ph.damage;
		level.br.timerKind = 2;
		level.br.timerEnd = getTime() + ph.shrink * 1000;
		br_moveMarkers( newC, newR, ph.shrink );
		br_announce( "^1The zone is closing! ^7(" + ( i + 1 ) + "/" + phases.size + ")" );
		wait ( ph.shrink );

		if ( i < phases.size - 1 )
			br_airdrop( 2 );
	}
	level.br.timerKind = 3;
}

// Outside the zone: damage every second, through the game's own damage
// (hit marker, red screen, no health regeneration, a normal death).
br_damageLoop()
{
	level endon( "br_end" );

	for ( ;; )
	{
		wait 1;
		foreach ( player in level.players )
		{
			if ( br_isIn( player ) && isAlive( player ) && br_outsideBy( player.origin ) > 0 )
				player thread [[ level.callbackPlayerDamage ]]( player, player, level.br.damage, 0, "MOD_TRIGGER_HURT", "none", player.origin, ( 0, 0, 0 ), "none", 0 );
		}
	}
}

br_isIn( player )
{
	if ( !isDefined( player.brState ) )
		return false;
	return ( player.brState == "in" );
}

br_countIn()
{
	count = 0;
	foreach ( player in level.players )
	{
		if ( br_isIn( player ) )
			count++;
	}
	return count;
}

br_watchEnd()
{
	level endon( "br_end" );

	for ( ;; )
	{
		wait 0.25;

		// Did not spawn 20 s after GO: out.
		if ( getTime() - level.br.goTime > 20000 )
		{
			foreach ( player in level.players )
			{
				if ( br_isIn( player ) && !isAlive( player ) )
					player thread br_eliminate( "did not spawn" );
			}
		}

		level.br.aliveCount = br_countIn();

		allies = false;
		axis = false;
		winners = [];
		names = "";
		foreach ( player in level.players )
		{
			if ( !br_isIn( player ) )
				continue;
			winners[winners.size] = player;
			if ( names != "" )
				names += "^7, ^2";
			names += player.name;
			if ( player.pers["team"] == "allies" )
				allies = true;
			else
				axis = true;
		}

		// One player at the start (a test): it ends when he is out.
		over = false;
		if ( level.br.solo )
			over = ( winners.size == 0 );
		else if ( level.teamBased )
		{
			if ( !allies || !axis )
				over = true;
		}
		else
			over = ( winners.size <= 1 );
		if ( !over )
			continue;

		if ( winners.size )
			level thread br_end( "^2" + names + " ^7won the Battle Royale!", winners );
		else
			level thread br_end( "^3Nobody survived the Battle Royale", undefined );
		return;
	}
}

br_watchDeath()
{
	self endon( "disconnect" );
	level endon( "br_end" );

	for ( ;; )
	{
		self waittill( "death" );
		if ( level.br.state != "fight" || !br_isIn( self ) )
			continue;
		self thread br_eliminate( undefined );
	}
}

// Out: spectator until the end (as AI Zombies does with its dead).
br_eliminate( reason )
{
	if ( !br_isIn( self ) )
		return;
	self.brState = "out";
	left = br_countIn();
	level.br.aliveCount = left;
	text = "^1" + self.name + " ^7eliminated";
	if ( isDefined( reason ) )
		text = text + " (" + reason + ")";
	foreach ( player in level.players )
		player iPrintln( text + " - ^2" + left + " ^7left" );

	self br_toSpectator( "^1Eliminated! ^7Watch the end of the Battle Royale" );
}

br_toSpectator( text )
{
	self.brMoved = true;
	self notify( "menuresponse", game["menu_team"], "spectator" );
	self allowSpectateTeam( "freelook", true );
	self iPrintLnBold( text );
	if ( !isDefined( self.brHud ) )
		self thread br_hud();
}

// Called by maps\mp\_modmenu.gsc on every spawn.
br_onSpawned()
{
	if ( !isDefined( level.br ) || level.br.state == "ended" )
		return;
	if ( !br_isIn( self ) )
	{
		// Joined while it runs.
		self.brState = "out";
		self br_toSpectator( "^3Battle Royale in progress ^7- you play the next one" );
		return;
	}
	self thread br_equip();
}

br_equip()
{
	self endon( "disconnect" );
	self endon( "death" );
	level endon( "br_end" );

	wait 0.05;   // after the game's class
	self takeAllWeapons();
	self giveWeapon( "usp_mp", 0, false );
	self giveMaxAmmo( "usp_mp" );
	self switchToWeapon( "usp_mp" );
	self.brLoot = undefined;
	self.maxhealth = 100;
	self.health = self.maxhealth;
	if ( !isDefined( self.brHud ) )
		self thread br_hud();

	if ( level.br.state == "countdown" )
	{
		self freezeControls( true );
		level waittill( "br_go" );
		self freezeControls( false );
	}
	self br_drop();
}

br_drop()
{
	p = br_pickPoint( br_zoneCenter(), br_zoneRadius() * 0.85 );
	self setOrigin( br_skyAbove( p, 1400, self ) );
	self setPlayerAngles( ( 0, randomInt( 360 ), 0 ) );
}

br_end( text, winners )
{
	if ( !isDefined( level.br ) || level.br.state == "ended" )
		return;
	level.br.state = "ended";
	level notify( "br_end" );

	br_announce( text );
	if ( isDefined( winners ) )
	{
		foreach ( player in winners )
		{
			notifyData = spawnstruct();
			notifyData.titleText = "^2#1 - WINNER!";
			notifyData.notifyText = "Last one standing";
			notifyData.glowColor = ( 0.0, 1.0, 0.0 );
			notifyData.duration = 6;
			notifyData.iconName = level.icontest;
			player thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
		}
	}
	foreach ( player in level.players )
		player freezeControls( false );

	wait 6;

	foreach ( crate in level.br.crates )
	{
		if ( isDefined( crate ) )
			crate delete();
	}
	foreach ( marker in level.br.markers )
	{
		if ( isDefined( marker ) )
			marker delete();
	}
	setDvar( "bg_fallDamageMinHeight", level.br.oldFallMin );
	setDvar( "bg_fallDamageMaxHeight", level.br.oldFallMax );
	setDvar( "scr_player_forcerespawn", level.br.oldForceRespawn );

	foreach ( player in level.players )
	{
		player br_destroyHud();
		player.brState = undefined;
		if ( isDefined( player.brMoved ) && player.pers["team"] == "spectator" )
		{
			team = "autoassign";
			if ( isDefined( player.brTeam ) && ( player.brTeam == "allies" || player.brTeam == "axis" ) )
				team = player.brTeam;
			player notify( "menuresponse", game["menu_team"], team );
			wait 0.05;
			if ( isDefined( player ) )
				player notify( "menuresponse", "changeclass", "class1" );
		}
		if ( isDefined( player ) )
			player.brMoved = undefined;
	}
	level.br = undefined;
}

br_announce( text )
{
	foreach ( player in level.players )
		player iPrintLnBold( text );
}

// ---------------------------------------------------------------------------
//  Zone edge: flags on the circle, sliding with it, a blue light on top
// ---------------------------------------------------------------------------

br_spawnMarkers()
{
	for ( k = 0; k < 16; k++ )
	{
		m = spawn( "script_model", br_ringPoint( level.br.toC, level.br.toR, k ) );
		m setModel( level.Flagz );
		level.br.markers[k] = m;
	}
	level thread br_markerLights();
}

br_moveMarkers( center, radius, time )
{
	for ( k = 0; k < level.br.markers.size; k++ )
		level.br.markers[k] moveTo( br_ringPoint( center, radius, k ), time );
}

br_markerLights()
{
	level endon( "br_end" );

	for ( ;; )
	{
		foreach ( m in level.br.markers )
			playFX( level.shakeFX["laser"], m.origin + ( 0, 0, 100 ) );
		wait 1;
	}
}

// ---------------------------------------------------------------------------
//  Loot
// ---------------------------------------------------------------------------

// weapon:name, the weapons of the Give Weapons menu.
br_lootTable()
{
	t = [];
	t[0] = strTok( "mp5k_mp:MP5K,uzi_mp:Mini-Uzi,ump45_mp:UMP45,kriss_mp:Vector,p90_mp:P90,pp2000_mp:PP2000,glock_mp:G18,tmp_mp:TMP", "," );
	t[1] = strTok( "ak47_mp:AK-47,famas_mp:FAMAS,fal_mp:FAL,m16_reflex_mp:M16A4,m4_reflex_mp:M4A1,masada_mp:ACR,fn2000_mp:F2000,scar_mp:SCAR-H,tavor_mp:TAR-21,model1887_mp:Model 1887,spas12_mp:SPAS-12,striker_mp:Striker", "," );
	t[2] = strTok( "cheytac_mp:Intervention,wa2000_acog_mp:WA2000,m21_acog_mp:M21 EBR,aa12_mp:AA-12,rpd_mp:RPD,mg4_mp:MG4,m240_grip_mp:M240,sa80_mp:L86 LSW,aug_mp:AUG HBAR", "," );
	t[3] = strTok( "deserteaglegold_mp:Gold Desert Eagle,rpg_mp:RPG-7,m79_mp:Thumper,barrett_mp:Barrett .50cal,aa12_mp:AA-12", "," );
	return t;
}

br_tierName( tier )
{
	switch ( tier )
	{
		case 0: return "^7Common";
		case 1: return "^5Rare";
		case 2: return "^6Epic";
	}
	return "^3LEGENDARY";
}

br_crateTier()
{
	r = randomInt( 100 );
	if ( r < 50 )
		return 0;
	if ( r < 85 )
		return 1;
	return 2;
}

br_airdrop( count )
{
	br_announce( "^3AIRDROP ^7incoming in the zone!" );
	for ( i = 0; i < count; i++ )
		br_spawnCrate( br_pickPoint( level.br.toC, level.br.toR * 0.8 ), 2 + randomInt( 2 ), true );
}

br_spawnCrate( ground, tier, fromSky )
{
	rest = ground + ( 0, 0, 8 );
	start = rest;
	if ( fromSky )
		start = br_skyAbove( ground, 1500, undefined );
	crate = spawn( "script_model", start );
	crate setModel( "com_plasticcase_friendly" );
	crate.angles = ( 0, randomInt( 360 ), 0 );
	level.br.crates[level.br.crates.size] = crate;
	crate thread br_crateThink( rest, tier, fromSky );
}

br_crateThink( rest, tier, fromSky )
{
	self endon( "death" );
	level endon( "br_end" );

	if ( fromSky && distance( self.origin, rest ) > 20 )
	{
		self moveTo( rest, 3, 1, 0 );
		wait 3;
		playFX( level.fx[5], rest );
	}
	self thread br_crateSpin();

	tick = 0;
	for ( ;; )
	{
		foreach ( player in level.players )
		{
			if ( br_isIn( player ) && isAlive( player ) && distance( player.origin, self.origin ) < 64 )
			{
				player br_giveLoot( tier );
				self delete();
				return;
			}
		}
		// Epic and Legendary crates blink.
		tick++;
		if ( tier >= 2 && tick >= 10 )
		{
			tick = 0;
			playFX( level.shakeFX["laser"], self.origin + ( 0, 0, 40 ) );
		}
		wait 0.1;
	}
}

br_crateSpin()
{
	self endon( "death" );
	level endon( "br_end" );

	for ( ;; )
	{
		if ( !isDefined( self ) )
			return;
		self rotateYaw( 360, 4 );
		wait 4;
	}
}

br_giveLoot( tier )
{
	list = level.br.loot[tier];
	entry = strTok( list[randomInt( list.size )], ":" );
	weapon = entry[0];

	if ( isDefined( self.brLoot ) && self.brLoot != weapon )
		self takeWeapon( self.brLoot );
	self giveWeapon( weapon, 0, false );
	self giveMaxAmmo( weapon );
	self giveMaxAmmo( "usp_mp" );
	self switchToWeapon( weapon );
	self.brLoot = weapon;

	if ( tier == 3 )
		self.maxhealth = 150;
	self.health = self.maxhealth;

	text = br_tierName( tier ) + " ^7- " + entry[1];
	if ( tier == 3 )
		text = text + " ^3+ ARMOR";
	self iPrintLnBold( text );
}

// ---------------------------------------------------------------------------
//  HUD: players alive, zone timer, outside warning, red screen outside
// ---------------------------------------------------------------------------

br_text( x, y, scale )
{
	hud = self createFontString( "objective", scale );
	hud setPoint( "TOPRIGHT", "TOPRIGHT", x, y );
	hud.hidewheninmenu = true;
	hud.archived = false;
	hud.foreground = true;
	return hud;
}

br_hud()
{
	self endon( "disconnect" );
	level endon( "br_end" );

	self br_destroyHud();
	self.brHud = [];

	self.brHud["alive"] = self br_text( -15, 20, 1.5 );
	self.brHud["alive"].label = &"ALIVE: ";
	self.brHud["alive"].color = ( 0.4, 1, 0.4 );

	self.brHud["timer"] = self br_text( -15, 40, 1.3 );
	self.brHud["timer"].label = level.br.labels[0];
	shownKind = 0;

	self.brHud["warn"] = self createFontString( "objective", 1.6 );
	self.brHud["warn"] setPoint( "CENTER", "CENTER", 0, -90 );
	self.brHud["warn"].label = &"^1OUTSIDE THE ZONE ^7- METERS: ";
	self.brHud["warn"].hidewheninmenu = true;
	self.brHud["warn"].archived = false;
	self.brHud["warn"].alpha = 0;

	red = newClientHudElem( self );
	red.x = 0;
	red.y = 0;
	red.alignX = "left";
	red.alignY = "top";
	red.horzAlign = "fullscreen";
	red.vertAlign = "fullscreen";
	red.sort = -10;
	red.foreground = false;
	red.hidewheninmenu = true;
	red.archived = false;
	red setShader( "white", 640, 480 );
	red.color = ( 1, 0, 0 );
	red.alpha = 0;
	self.brHud["red"] = red;

	for ( ;; )
	{
		self.brHud["alive"] setValue( level.br.aliveCount );

		kind = level.br.timerKind;
		if ( kind == 3 )
			self.brHud["timer"].alpha = 0;
		else
		{
			if ( kind != shownKind )
			{
				self.brHud["timer"].label = level.br.labels[kind];
				shownKind = kind;
			}
			left = int( ( level.br.timerEnd - getTime() ) / 1000 ) + 1;
			if ( left < 0 )
				left = 0;
			self.brHud["timer"] setValue( left );
		}

		outside = 0;
		if ( level.br.state == "fight" && br_isIn( self ) && isAlive( self ) )
			outside = br_outsideBy( self.origin );
		if ( outside > 0 )
		{
			self.brHud["warn"].alpha = 1;
			self.brHud["warn"] setValue( int( outside * 0.0254 ) + 1 );
			self.brHud["red"].alpha = 0.15;
		}
		else
		{
			self.brHud["warn"].alpha = 0;
			self.brHud["red"].alpha = 0;
		}
		wait 0.25;
	}
}

br_destroyHud()
{
	if ( !isDefined( self.brHud ) )
		return;
	foreach ( hud in self.brHud )
		hud destroy();
	self.brHud = undefined;
}
