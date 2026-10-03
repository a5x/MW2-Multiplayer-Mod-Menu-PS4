
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\_modmenu_ai1;
#include maps\mp\_modmenu_ai2;
#include maps\mp\_modmenu_ai3;
#include maps\mp\_modmenu_ai4;
#include maps\mp\_modmenu_ai5;

init()
{
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

	self ai_registerOptionCommands();
	self notifyOnPlayerCommand( "dpad_right", "+actionslot 4" );
	if ( self isHost() )
		self thread mm_backToWhiteWater();
}

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
	setDvar( "g_hardcore", 0 );
	setDvar( "scr_diehard", 0 );
	setDvar( "matchGameType", 0 );
	setDvar( "g_password", "" );
	map( getDvar( "mapname" ), true );
}

mm_closeMenu()
{
}
