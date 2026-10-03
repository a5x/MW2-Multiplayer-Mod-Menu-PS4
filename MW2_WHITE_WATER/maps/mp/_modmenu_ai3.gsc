
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ai_DisableAimOnSomeWeapons()
{
	self endon("disconnect");
	for(;;)
    {
        if(self getCurrentWeapon() == "tmp_silencer_mp" || self getCurrentWeapon() == "tmp_silencer_xmags_mp")
        {
		    self allowADS(false);
        }
		if(self getCurrentWeapon() != "tmp_silencer_mp" || self getCurrentWeapon() != "tmp_silencer_xmags_mp")
        {
		    self allowADS(true);
        }
	    self waittill( "weapon_change" );
	}
}

ai_TextPopup( text )
{
	self endon( "disconnect" );
	wait ( 0.05 );
	self.textPopup destroy();
	self notify( "textPopup" );
	self endon( "textPopup" );
	self.textPopup = newClientHudElem( self );
	self.textPopup.horzAlign = "center";
	self.textPopup.vertAlign = "middle";
	self.textPopup.alignX = "center";
	self.textPopup.alignY = "middle";
	self.textPopup.x = 40;
	self.textPopup.y = -30;
	self.textPopup.font = "hudbig";
	self.textPopup.fontscale = 0.69;
	self.textPopup.color = (25.5, 25.5, 3.6);
	self.textPopup setText(text);
	self.textPopup.alpha = 0.85;
	self.textPopup.glowColor = (0.3, 0.3, 0.9);
	self.textPopup.glowAlpha = 0.55;
	self.textPopup ChangeFontScaleOverTime( 0.1 );
	self.textPopup.fontScale = 0.75;	
    wait 0.1;
	self.textPopup ChangeFontScaleOverTime( 0.1 );
	self.textPopup.fontScale = 0.69;	
	switch(randomInt(2))
	{
	    case 0:
		self.textPopup moveOverTime( 2.00 );
		self.textPopup.x = 100;
		self.textPopup.y = -30;
		break;
		case 1:
		self.textPopup moveOverTime( 2.00 );
		self.textPopup.x = -100;
		self.textPopup.y = -30;
		break;
	}
	wait 1;
	self.textPopup fadeOverTime( 1.00 );
	self.textPopup.alpha = 0;
}

ai_TextPopup2( text )
{
	self endon( "disconnect" );
	wait ( 0.05 );
	self.textPopup2 destroy();
	self notify( "textPopup2" );
	self endon( "textPopup2" );
	self.textPopup2 = newClientHudElem( self );
	self.textPopup2.horzAlign = "center";
	self.textPopup2.vertAlign = "middle";
	self.textPopup2.alignX = "center";
	self.textPopup2.alignY = "middle";
	self.textPopup2.x = 0;
	self.textPopup2.y = 0;
	self.textPopup2.font = "hudbig";
	self.textPopup2.fontscale = 0.69;
	self.textPopup2.color = (25.5, 25.5, 3.6);
	self.textPopup2 setText(text);
	self.textPopup2.alpha = 0.85;
	self.textPopup2.glowColor = (0.3, 0.9, 0.3);
	self.textPopup2.glowAlpha = 0.55;
	self.textPopup2 ChangeFontScaleOverTime( 0.1 );
	self.textPopup2.fontScale = 0.75;	
    wait 0.1;
	self.textPopup2 ChangeFontScaleOverTime( 0.1 );
	self.textPopup2.fontScale = 0.69;	
	switch(randomInt(2))
	{
	    case 0:
		self.textPopup2 moveOverTime( 2.00 );
		self.textPopup2.x = 60;
		self.textPopup2.y = 0;
		break;
		case 1:
		self.textPopup2 moveOverTime( 2.00 );
		self.textPopup2.x = -60;
		self.textPopup2.y = 0;
		break;
	}
	wait 1;
	self.textPopup2 fadeOverTime( 1.00 );
	self.textPopup2.alpha = 0;
}

ai_onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );
		player thread ai_CustomMapnames();
		player [[level.allies]]();
		player thread ai_ForceInitialSpawn();
		player.bonus = 0;
		setDvar("didyouknow","^7White ^5Water ^1Patch ^6| ^3Sub HepticOnline");
		player.money = getdvarInt("z_money");
		player.standpro = 0;
		player.autorevive = 0;
		player.moving = 0;
		player.isup = 0;
		player thread ai_SetVision();
		player setClientDvar("ui_drawCrosshair", 0);
		player thread maps\mp\_modmenu_ai5::ai_Javlin();
		player thread maps\mp\_modmenu_ai2::ai_IntermissionHud();
		player thread maps\mp\_modmenu_ai2::ai_Live();
		player thread maps\mp\_modmenu_ai2::ai_Death();
		player thread maps\mp\_modmenu_ai2::ai_Shaders();
		player thread ai_DisableAimOnSomeWeapons();
		player thread maps\mp\_modmenu_ai2::ai_ShowHost(player);
		player thread ai_onPlayerSpawned();
	}
}

ai_ForceInitialSpawn()
{
	self endon( "disconnect" );
	wait 2;
	if ( self.sessionstate == "playing" )
		return;

	self notify( "menuresponse", game["menu_team"], "allies" );
	wait 0.1;
	self notify( "menuresponse", "changeclass", "class1" );
	wait 0.25;
	if ( self.sessionstate != "playing" )
	{
		self notify( "respawn" );
		self thread [[level.SpawnClient]]();
	}
}

ai_onPlayerSpawned()
{
	self endon( "disconnect" );
	for(;;)
	{
		self waittill( "spawned_player" );
		wait 0.001;
	self.MenuIsOpen = true;
		currentWeapon = self getCurrentWeapon();
		self thread maps\mp\_modmenu_ai2::ai_WeaponIcon();
		self thread maps\mp\_modmenu_ai2::ai_WeaponText();
		self thread maps\mp\_modmenu_ai2::ai_AmmoHud();
		self thread maps\mp\_modmenu_ai2::ai_Money();
		self thread maps\mp\_modmenu_ai2::ai_BonusPoints();
		self thread maps\mp\_modmenu_ai2::ai_GrenadeHud();
		self thread maps\mp\_modmenu_ai4::ai_PowerHud();
		self notify("menuresponse", game["menu_team"], "allies");
		wait 0.001;
		self notify("menuresponse", "changeclass", "class1");
		wait 0.001;
		self.needsToSpawn = false;
		self player_recoilScaleOn(100);
		self.upgrade = 0;
		self.nobuyhealth = 0;
		self.gambler = 0;
		self.speedy = 0;
		self.stoppingpower = 0;
		self.steadyaim = 0;
		self.speedreload = 0;
		self.ammomatic = 0;
		self.zombieperks = 0;
		self.bonusdrophud = 0;
		self.weapons = 0;
		self.inLastStand = false;
		self.inFinalStand = false;
		self.notusebox = 0;
		self.usingairstrike = "false";
		self notify("revive");
		self.moveSpeedScaler = 1.0;
		self maps\mp\gametypes\_weapons::updateMoveSpeedScale( "primary" );
		self thread ai_TakeWeaponsAfghan();
		self thread ai_TakeWeaponsScrapyard();
		self thread ai_TakeWeaponsSkidrow();
		self thread ai_TakeWeaponsUnderpass();
		self thread ai_TakeWeaponsTrailerPark();
		self thread ai_TakeWeaponsQaurry();
		self thread ai_TakeWeaponsRust();
		self thread ai_TakeWeaponsSalvage();
		self thread ai_TakeWeaponsStrike();
		self thread ai_TakeWeaponsHighrise();
		self thread ai_TakeWeaponsDerail();
		self thread ai_TakeWeaponsTerminal();
		self thread ai_TakeWeaponsWasteland();
		self thread ai_TakeWeaponsSubBase();
		self thread ai_TakeWeaponsKarachi();
		self thread ai_TakeWeaponsFavela();
		self thread ai_TakeWeaponsRundown();
		self thread ai_TakeWeaponsBailout();
		self thread ai_TakeWeaponsInvasion();
		self thread ai_TakeWeaponsEstate();
		self thread ai_TakeWeaponsCarnival();
		self thread ai_TakeWeaponsVacant();
		self thread ai_TakeWeaponsStorm();
		self thread ai_KillIfUnderMap();
		if ( self _hasPerk( "specialty_finalstand" ) )
		{
		}
		else
		{
			self.autorevive = 0;
		}
		if(level.zState != "intermission")
		{
			self notify("menuresponse", game["menu_team"], "spectator");
		}
		else
		{
			self thread ai_pMain();
		}
	}
}

ai_pMain()
{
	self endon("respawn");
	self endon("death");
	self endon("disconnect");
	{
		for(;;)
		if(level.IntermissionTime <= 0)
		{
			if(getDvarInt("z_dedicated") == 0)
			{
				self playLocalSound("mp_killstreak_jet");
			}
			else
			{
				self playLocalSound( game["music"]["winning_allies"] );
			}
			self freezeControls(false);
			break;
		}
		else 
		{
			self freezeControls(true);
			wait 0.05;
		}
	}
}

ai_MonitorKillstreaks()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		if(self.kills == getdvarInt("z_airstrike") && self.pers["lastKillstreak"] != "uav")
		{
		    self thread ai_TextPopup2(getdvarInt("z_airstrike") + " Kills");
			self.pers["lastKillstreak"] = "uav";
			self playlocalsound("mp_level_up");
			self iPrintlnBold(self.name + " ^3" + getdvarInt("z_airstrike") + " Killstreak You have earned the an Airstrike");
			self fx_ai3_10( "uav", true );
			wait 3.0;
			self fx_ai3_6( "airstrike", getdvarInt("z_airstrike"));
			Announcement(self.name + " ^3Has got the Airstrike");
		}
		if(self.kills == getdvarInt("z_25"))
		{
			self thread ai_TextPopup2(getdvarInt("z_25") + " Kills");
		}
		if(self.kills == getdvarInt("z_predator_missile") && self.pers["lastKillstreak"] != "predator_missile")
		{
		    self thread ai_TextPopup2(getdvarInt("z_predator_missile") + " Kills");
			self.pers["lastKillstreak"] = "predator_missile";
			self playlocalsound("mp_level_up");
			self iPrintlnBold(self.name + " ^3" + getdvarInt("z_predator_missile") + " Killstreak You have earned the Predator Missile");
			self fx_ai3_10( "predator_missile", true );
			wait 3.0;
			self fx_ai3_6( "predator_missile", getdvarInt("z_predator_missile"));
			Announcement(self.name + " ^3Has got the Predator Missile");
		}
		if(self.kills == getdvarInt("z_random_1") && self.pers["lastKillstreak"] != "random1")
		{
		    self thread ai_TextPopup2(getdvarInt("z_random_1") + " Kills");
			self.pers["lastKillstreak"] = "random1";
			self playlocalsound("mp_level_up");
			self iPrintlnBold(self.name + " ^3" + getdvarInt("z_random_1") + " Killstreak You have earned a random killstreak");
			wait 2.0;
			self thread ai_KillStreakRandom();
			wait 3.0;
			Announcement(self.name + " ^3Has got a random killstreak");
			self thread fx_ai3_7( 100, 0, (0,1,2), 1 );
			self.money += 100;
			self notify("MONEY");
		}
		if(self.kills == getdvarInt("z_sentry") && self.pers["lastKillstreak"] != "sentry")
		{
		    self thread ai_TextPopup2(getdvarInt("z_sentry") + " Kills");
			self.pers["lastKillstreak"] = "sentry";
			self playlocalsound("mp_level_up");
			self iPrintlnBold(self.name + " ^3" + getdvarInt("z_sentry") + " Killstreak You have earned a Sentry Gun");
			self fx_ai3_10("sentry",true);
			wait 3.0;
			self fx_ai3_6( "sentry", getdvarInt("z_sentry"));
			Announcement(self.name + " ^3Has got a Sentry Gun");
			self thread fx_ai3_7( 500, 0, (0,1,2), 1 );
			self.money += 500;
			self notify("MONEY");
		}
		if(self.kills == getdvarInt("z_random_4") && self.pers["lastKillstreak"] != "random4")
		{
			self.pers["lastKillstreak"] = "random4";
			self playlocalsound("mp_level_up");
			self thread ai_TextPopup2(getdvarInt("z_random_4") + " Kills");
			self iPrintlnBold(self.name + " ^3" + getdvarInt("z_random_4") + " Killstreak you have earned 4 random killstreaks");
			wait 3.0;
			self thread ai_KillStreakRandom();
			wait 3.0;
			self thread ai_KillStreakRandom();
			wait 3.0;
			self thread ai_KillStreakRandom();
			wait 3.0;
			self thread ai_KillStreakRandom();
			wait 3.0;
			Announcement(self.name + " ^3Has got 4 random killstreaks!");
			self thread fx_ai3_7( 1000, 0, (0,1,2), 1 );
			self.money += 1000;
			self notify("MONEY");
		}
		if(self.kills == getdvarInt("z_sub") && self.pers["lastKillstreak"] != "sub")
		{
		    self thread ai_TextPopup2(getdvarInt("z_sub") + " Kills");
			self.pers["lastKillstreak"] = "sub";
			self playlocalsound("mp_level_up");
			self iPrintlnBold(self.name + " ^3" + getdvarInt("z_sub") + " Killstreak Sub Team Ready For Deployment");
			self thread maps\mp\_modmenu_ai5::ai_SniperStreak();
			wait 3.0;
			self thread ai_TextPopup2("Press [{+actionslot 2}] to use Sub Team");
			Announcement(self.name + " ^3Has got the Sub Team");
		}
		if(self.kills == getdvarInt("z_lmg") && self.pers["lastKillstreak"] != "lmg")
		{
		    self thread ai_TextPopup2(getdvarInt("z_lmg") + " Kills");
			self.pers["lastKillstreak"] = "lmg";
			self playlocalsound("mp_level_up");
			self iPrintlnBold(self.name + " ^3" + getdvarInt("z_lmg") + " Killstreak LMG Team Ready For Deployment");
			self thread maps\mp\_modmenu_ai5::ai_MachineGunStreak();
			wait 3.0;
			self thread ai_TextPopup2("Press [{+actionslot 2}] to use LMG Team");
			Announcement(self.name + " ^3Has got the LMG Team");
		}
		if(self.kills == getdvarInt("z_overwatch") && self.pers["lastKillstreak"] != "overwatch")
		{
		    self thread ai_TextPopup2(getdvarInt("z_overwatch") + " Kills");
			self.pers["lastKillstreak"] = "overwatch";
			self playlocalsound("mp_level_up");
			self iPrintlnBold(self.name + " ^3" + getdvarInt("z_overwatch") + " Killstreak Overwatch For Deployment");
			self thread maps\mp\_modmenu_ai5::ai_OverwatchStreak();
			wait 3.0;
			self fx_ai3_6( "littlebird_support", getdvarInt("z_overwatch"));
			self thread ai_TextPopup2("Press [{+actionslot 2}] to use Overwatch");
			Announcement(self.name + " ^3Has got an Overwatch");
		}
		if(self.kills == getdvarInt("z_super") && self.pers["lastKillstreak"] != "super")
		{
		    self thread ai_TextPopup2(getdvarInt("z_super") + " Kills");
			self.pers["lastKillstreak"] = "super";
			self playlocalsound("mp_level_up");
			self iPrintlnBold(self.name + " ^3" + getdvarInt("z_super") + " Killstreak You have earned the Super Airstrike");
			self fx_ai3_10( "counter_uav", true );
			wait 3.0;
			self fx_ai3_6( "ac130", getdvarInt("z_super"));
			Announcement(self.name + " ^3Has got the Super Airstrike");
		}
		if(self.kills == getdvarInt("z_vision") && self.pers["lastKillstreak"] != "emp" && getdvar("mapname") == "mp_boneyard" || self.pers["botKillstreak"] == 250 && self.pers["lastKillstreak"] != "emp" && getdvar("mapname") == "mp_quarry" || self.pers["botKillstreak"] == 250 && self.pers["lastKillstreak"] != "emp" && getdvar("mapname") == "mp_nightshift" && level.edit == 2 || self.pers["botKillstreak"] == 250 && self.pers["lastKillstreak"] != "emp" && getdvar("mapname") == "mp_highrise" && level.edit == 1)
		{
		    self thread ai_TextPopup2(getdvarInt("z_emp") + " Kills");
			self.pers["lastKillstreak"] = "emp";
			self playlocalsound("mp_level_up");
			self iPrintlnBold(self.name + " ^3" + getdvarInt("z_emp") + " Killstreak You have earned the Vision Restorer");
			self fx_ai3_10( "emp", true );
			wait 3.0;
			self fx_ai3_6( "emp", getdvarInt("z_emp"));
			Announcement(self.name + " ^3Has got the Vision Restorer");
		}
		if(self.kills == getdvarInt("z_nuke") && self.pers["lastKillstreak"] != "nuke")
		{
		    self thread ai_TextPopup2(getdvarInt("z_nuke") + " Kills");
			self.pers["lastKillstreak"] = "nuke";
			self playlocalsound("mp_bomb_plant");
			self iPrintlnBold(self.name + " ^3" + getdvarInt("z_nuke") + " Killstreak You have earned the Tactical Nuke");
			self fx_ai3_10( "nuke", true );
			wait 3.0;
			self fx_ai3_6( "nuke", getdvarInt("z_nuke"));
			Announcement(self.name + " ^3Has earned the Tactical Nuke");
		}
		self waittill("zombie_killed");
	}
}

ai_KillStreakRandom()
{
	self endon("disconnect");
	switch(randomInt(2))
	{
		case 0: self iPrintlnBold(self.name + " ^3Predator Missile!");
		self fx_ai3_10( "predator_missile", true );
		self fx_ai3_6( "predator_missile_pickup");
		break;
		case 1: self iPrintlnBold(self.name + " ^3Airstrike");
		self fx_ai3_10( "uav", true );
		wait 3.0;
		self fx_ai3_6( "airstrike");
		break;
	}
}

ai_KillIfUnderMap()
{
	self endon("death");
	while(1)
	{
		if(getdvar("mapname") == "mp_rust" && self.origin[2] <= -429 && level.edit == 0 || getdvar("mapname") == "mp_rust" && self.origin[2] <= -306 && level.edit == 1)
		{
			self suicide();
		}
		if(getdvar("mapname") == "mp_estate" && self.origin[2] <= -713)
		{
			self suicide();
		}
		if(getdvar("mapname") == "mp_afghan" && self.origin[2] <= -1585)
		{
			self suicide();
		}
		if(getdvar("mapname") == "mp_vacant" && self.origin[2] <= -350)
		{
			self suicide();
		}
		wait 0.1;
	}
}

ai_multikill()
{
	if(!isDefined(self.multi)) self.multi = 0;
	self.multi++;
	wait 1;
	if(self.multi == 2)
	{
		self thread ai_TextPopup( "Double Kill!" );
		self.bonus += 1;
		self notify("BONUS");
	}
	if(self.multi == 3)
	{
		self thread ai_TextPopup( "Triple Kill!" );
		self.bonus += 2;
		self notify("BONUS");
	}
	if(self.multi == 4)
	{
	    iPrintLn(self.name + " ^2has got a multikill with ^1" + self.multi + " ^2zombies!");
	    iPrintLn(" ^2LOL?? ^5is that ^1ALL ^5you've ^1Got!? ^6You must do BETTER!!");
		self thread ai_TextPopup2( "Take that!!!" );
		self thread ai_TextPopup( "Multi Kill!" );
		self.bonus += 2;
		self notify("BONUS");
	}
	if(self.multi == 5)
	{
	    iPrintLn(self.name + " ^4is on a killing spree with ^1" + self.multi + " ^4zombies!");
		self thread ai_TextPopup2( "OMG!!!" );
		self thread ai_TextPopup( "Multi Kill!" );
		self.bonus += 2;
		self notify("BONUS");
	}
	if(self.multi == 6)
	{
	    iPrintLn(self.name + " ^6is on a raping streak with ^2" + self.multi + " ^6zombies!");
		self thread ai_TextPopup2( "Thats gotta hurt!!!" );
		self thread ai_TextPopup( "RAPE KILL!!" );
		self.bonus += 2;
		self notify("BONUS");
	}
	if(self.multi >= 7)
	{
		iPrintLn(self.name + " ^1YOUR RAPING SO MUCH U HAVE KILLED ^4" + self.multi + " ^1ZOMBIES!!");
		iPrintLn(" ^2The Creators Of ^7White^5Water ^4APPROVE THAT YOU ^1ROCK!");
		self thread ai_TextPopup2( "Killing Spree!!!" );
		self thread ai_TextPopup( "JIZZTASTIC KILL!!" );
		self.bonus += 2;
		self notify("BONUS");
	}
	self.multi = 0;
}

ai_precacheItems()
{
game["strings"]["MP_HORDE_BEGINS_IN"] = "Zombie Round Starts In";
game["strings"]["MONEYTEXT"] = "^7Money :";
game["strings"]["MONEYTEXT2"] = "^1Money $";
game["strings"]["MONEYTEXT3"] = "^3Money $";
game["strings"]["BONUSTEXT"] = "^7Bonus Points :";

precacheString(game["strings"]["MP_HORDE_BEGINS_IN"]);
precacheString(game["strings"]["MONEYTEXT"]);
precacheString(game["strings"]["MONEYTEXT2"]);
precacheString(game["strings"]["MONEYTEXT3"]);
precacheString(game["strings"]["BONUSTEXT"]);
}

ai_FuncsMain()
{
level.SpawnTrigger = maps\mp\_modmenu_ai1::ai_SpawnTrigger;
level.SpawnWeapon = maps\mp\_modmenu_ai2::ai_SpawnWeapon;
level.SpawnClient = maps\mp\gametypes\_playerlogic::spawnPlayer;
}

ai_GetHost( )
{

	foreach( player in level.players )
	{
		if(player isHost())
			return player;
	}
	
	return 0;
}

ai_BotDestroyOnDeath( icon )
{
	self waittill("bot_death");
	icon destroy();
}

ai_SetVision()
{
	if(getdvar("mapname") == "mp_boneyard")
	{
		self VisionSetNakedForPlayer( "cobra_sunset3", 0 );
		self.brightness = -0.07;
		self setClientDvar("r_brightness", self.brightness);
	}
	if(getdvar("mapname") == "mp_nightshift" && level.edit == 0)
	{
		self VisionSetNakedForPlayer( "icbm_sunrise2", 0 );
		self.brightness = -0.05;
		self setClientDvar("r_brightness", self.brightness);
	}
	if(getdvar("mapname") == "mp_nightshift" && level.edit == 1)
	{
		self VisionSetNakedForPlayer( "cobra_sunset1", 0 );
		self.brightness = -0.05;
		self setClientDvar("r_brightness", self.brightness);
	}
	if(getdvar("mapname") == "mp_nightshift" && level.edit == 2)
	{
		self VisionSetNakedForPlayer( "cobra_sunset3", 0 );
		self.brightness = -0.08;
		self setClientDvar("r_brightness", self.brightness);
	}
	if(getdvar("mapname") == "mp_afghan")
	{
		self VisionSetNakedForPlayer( "default", 0 );
	}
	if(getdvar("mapname") == "mp_underpass")
	{
		self VisionSetNakedForPlayer( "cobra_sunset1", 0 );
		self.brightness = -0.08;
		self setClientDvar("r_brightness", self.brightness);
	}
	if(getdvar("mapname") == "mp_trailerpark")
	{
		self VisionSetNakedForPlayer( "cobra_sunset2", 0 );
		self.brightness = -0.06;
		self setClientDvar("r_brightness", self.brightness);
	}
	if(getdvar("mapname") == "mp_quarry")
	{
		self VisionSetNakedForPlayer( "cobra_sunset3", 0 );
		self.brightness = -0.06;
		self setClientDvar("r_brightness", self.brightness);
	}
	if(getdvar("mapname") == "mp_rust" && level.edit == 0)
	{
		self VisionSetNakedForPlayer( "cobra_sunset1", 0 );
		self.brightness = -0.02;
		self setClientDvar("r_brightness", self.brightness);
	}
	if(getdvar("mapname") == "mp_rust" && level.edit == 1)
	{
		self VisionSetNakedForPlayer( "mp_rust", 0 );
	}
	if(getdvar("mapname") == "mp_compact")
	{
		self VisionSetNakedForPlayer( "cobra_sunset3", 0 );
		self.brightness = -0.04;
		self setClientDvar("r_brightness", self.brightness);
	}
	if(getdvar("mapname") == "mp_strike")
	{
		self VisionSetNakedForPlayer( "cobra_sunset2", 0 );
		self.brightness = -0.05;
		self setClientDvar("r_brightness", self.brightness);
	}
	if(getdvar("mapname") == "mp_highrise" && level.edit == 0)
	{
		self VisionSetNakedForPlayer( "mp_highrise", 0 );
	}
	if(getdvar("mapname") == "mp_highrise" && level.edit == 1)
	{
		self VisionSetNakedForPlayer( "cobra_sunset3", 0 );
		self.brightness = -0.07;
		self setClientDvar("r_brightness", self.brightness);
	}
	if(getdvar("mapname") == "mp_derail")
	{
		self VisionSetNakedForPlayer( "mp_derail", 0 );
		self.brightness = -0.07;
		self setClientDvar("r_brightness", self.brightness);
	}
	if(getdvar("mapname") == "mp_terminal")
	{
		self VisionSetNakedForPlayer( "oilrig_exterior_deck0", 0 );
	}
	if(getdvar("mapname") == "mp_brecourt")
	{
		self VisionSetNakedForPlayer( "mp_brecourt", 0 );
	}
	if(getdvar("mapname") == "mp_subbase")
	{
		self VisionSetNakedForPlayer( "cobra_sunset1", 0 );
		self.brightness = -0.03;
		self setClientDvar("r_brightness", self.brightness);
	}
	if(getdvar("mapname") == "mp_favela")
	{
		self VisionSetNakedForPlayer( "mp_favela", 0 );
	}
	if(getdvar("mapname") == "mp_checkpoint")
	{
		self VisionSetNakedForPlayer( "cobra_sunset2", 0 );
	}
	if(getdvar("mapname") == "mp_rundown")
	{
		self VisionSetNakedForPlayer( "mp_downtown_la", 0 );
	}
	if(getdvar("mapname") == "mp_complex")
	{
		self VisionSetNakedForPlayer( "mp_complex", 0 );
	}
	if(getdvar("mapname") == "mp_invasion")
	{
		self VisionSetNakedForPlayer( "mp_invasion", 0 );
	}
	if(getdvar("mapname") == "mp_estate")
	{
		self VisionSetNakedForPlayer( "mp_estate", 0 );
	}
	if(getdvar("mapname") == "mp_abandon")
	{
		self VisionSetNakedForPlayer( "mp_abandon", 0 );
	}
	if(getdvar("mapname") == "mp_vacant")
	{
		self VisionSetNakedForPlayer( "mp_vacant", 0 );
	}
	if(getdvar("mapname") == "mp_storm")
	{
		self VisionSetNakedForPlayer( "mp_storm", 0 );
	}
	if(level.day == 1)
	{
		self VisionSetNakedForPlayer( getDvar( "mapname" ), 0 );
	}
	if(level.nuked == 1)
	{
		self VisionSetNakedForPlayer("mpnuke_aftermath", 1);
	}
}

ai_SetVisionPain()
{
	if(getdvar("mapname") == "mp_boneyard")
	{
		VisionSetPain("cobra_sunset3");
	}
	if(getdvar("mapname") == "mp_nightshift" && level.edit == 0)
	{
		VisionSetPain("icbm_sunrise2");
	}
	if(getdvar("mapname") == "mp_nightshift" && level.edit == 1)
	{
		VisionSetPain("cobra_sunset1");
	}
	if(getdvar("mapname") == "mp_nightshift" && level.edit == 2)
	{
		VisionSetPain("cobra_sunset3");
	}
	if(getdvar("mapname") == "mp_afghan")
	{
		VisionSetPain("default");
	}
	if(getdvar("mapname") == "mp_underpass")
	{
		VisionSetPain("cobra_sunset1");
	}
	if(getdvar("mapname") == "mp_trailerpark")
	{
		VisionSetPain("cobra_sunset2");
	}
	if(getdvar("mapname") == "mp_quarry")
	{
		VisionSetPain("cobra_sunset3");
	}
	if(getdvar("mapname") == "mp_rust" && level.edit == 0)
	{
		VisionSetPain("cobra_sunset1");
	}
	if(getdvar("mapname") == "mp_rust" && level.edit == 1)
	{
		VisionSetPain("mp_rust");
	}
	if(getdvar("mapname") == "mp_compact")
	{
		VisionSetPain("cobra_sunset3");
	}
	if(getdvar("mapname") == "mp_strike")
	{
		VisionSetPain("cobra_sunset2");
	}
	if(getdvar("mapname") == "mp_highrise" && level.edit == 0)
	{
		VisionSetPain("mp_highrise");
	}
	if(getdvar("mapname") == "mp_highrise" && level.edit == 1)
	{
		VisionSetPain("cobra_sunset3");
	}
	if(getdvar("mapname") == "mp_derail")
	{
		VisionSetPain("mp_derail");
	}
	if(getdvar("mapname") == "mp_terminal")
	{
		VisionSetPain("oilrig_exterior_deck0");
	}
	if(getdvar("mapname") == "mp_brecourt")
	{
		VisionSetPain("mp_brecourt");
	}
	if(getdvar("mapname") == "mp_subbase")
	{
		VisionSetPain("cobra_sunset1");
	}
	if(getdvar("mapname") == "mp_favela")
	{
		VisionSetPain("mp_favela");
	}
	if(getdvar("mapname") == "mp_checkpoint")
	{
		VisionSetPain("cobra_sunset2");
	}
	if(getdvar("mapname") == "mp_rundown")
	{
		VisionSetPain("mp_downtown_la");
	}
	if(getdvar("mapname") == "mp_complex")
	{
		VisionSetPain("mp_complex");
	}
	if(getdvar("mapname") == "mp_invasion")
	{
		VisionSetPain("mp_invasion");
	}
	if(getdvar("mapname") == "mp_estate")
	{
		VisionSetPain("mp_estate");
	}
	if(getdvar("mapname") == "mp_abandon")
	{
		VisionSetPain("mp_abandon");
	}
	if(getdvar("mapname") == "mp_vacant")
	{
		VisionSetPain("mp_vacant");
	}
	if(getdvar("mapname") == "mp_storm")
	{
		VisionSetPain("mp_storm");
	}
}

ai_KillEnt( ent, time )
{
    wait time;
	ent hide();
    ent delete();
	ent destroy();
}

ai_UpdateTimePlayed()
{
    while(1)
	{
	    if(level.timeplayed >= 60)
		{
			level.timeplayedminutes += 1;
			level.timeplayed = 0;
		}
		else
		{
			level.timeplayed += 1;
			wait 0.1;
		}
	    wait 1;
	}
}

ai_CustomMapnames()
{
	if(getdvar("mapname") == "mp_afghan")
	{
		self setClientDvar("ui_mapname", "^1Desert Bunker");
	}
	else if(getdvar("mapname") == "mp_nightshift" && level.edit == 0)
	{
		self setClientDvar("ui_mapname", "^1Sunrise Apartments");
	}
	else if(getdvar("mapname") == "mp_nightshift" && level.edit == 1)
	{
		self setClientDvar("ui_mapname", "^1Doomed Canal");
	}
	else if(getdvar("mapname") == "mp_nightshift" && level.edit == 2)
	{
		self setClientDvar("ui_mapname", "^1River Rumble");
	}
	else if(getdvar("mapname") == "mp_rust" && level.edit == 0)
	{
		self setClientDvar("ui_mapname", "^1River Rapids");
	}
	else if(getdvar("mapname") == "mp_rust" && level.edit == 1)
	{
		self setClientDvar("ui_mapname", "^1River Pad");
	}
	else if(getdvar("mapname") == "mp_trailerpark")
	{
		self setClientDvar("ui_mapname", "^1Old West");
	}
	else if(getdvar("mapname") == "mp_boneyard")
	{
		self setClientDvar("ui_mapname", "^1Dark Dead Airbase");
	}
	else if(getdvar("mapname") == "mp_quarry")
	{
		self setClientDvar("ui_mapname", "^1Dark Construction");
	}
	else if(getdvar("mapname") == "mp_compact")
	{
		self setClientDvar("ui_mapname", "^1Snowy Death");
	}
	else if(getdvar("mapname") == "mp_underpass")
	{
		self setClientDvar("ui_mapname", "^1Rainy Dead Red");
	}
	else if(getdvar("mapname") == "mp_strike")
	{
		self setClientDvar("ui_mapname", "^3Ally");
	}
	else if(getdvar("mapname") == "mp_highrise" && level.edit == 0)
	{
		self setClientDvar("ui_mapname", "^1Sunset ^5Infestation");
	}
	else if(getdvar("mapname") == "mp_highrise" && level.edit == 1)
	{
		self setClientDvar("ui_mapname", "^1Infestation");
	}
	else if(getdvar("mapname") == "mp_derail")
	{
		self setClientDvar("ui_mapname", "^1Pine Creek");
	}
	else if(getdvar("mapname") == "mp_terminal")
	{
		self setClientDvar("ui_mapname", "^2Aircrafts Lair");
	}
	else if(getdvar("mapname") == "mp_brecourt")
	{
		self setClientDvar("ui_mapname", "^1Wasteland");
	}
	else if(getdvar("mapname") == "mp_subbase")
	{
		self setClientDvar("ui_mapname", "^1HELL!!!");
	}
	else if(getdvar("mapname") == "mp_checkpoint")
	{
		self setClientDvar("ui_mapname", "^1Surrounded");
	}
	else if(getdvar("mapname") == "mp_favela")
	{
		self setClientDvar("ui_mapname", "^1Rundown Town");
	}
	else if(getdvar("mapname") == "mp_estate")
	{
		self setClientDvar("ui_mapname", "^5Falls of Fortune");
	}
	else if(getdvar("mapname") == "mp_rundown")
	{
		self setClientDvar("ui_mapname", "The Holdout");
	}
	else if(getdvar("mapname") == "mp_complex")
	{
		self setClientDvar("ui_mapname", "The Complex");
	}
	else if(getdvar("mapname") == "mp_invasion")
	{
		self setClientDvar("ui_mapname", "^5Sea Side");
	}
	else if(getdvar("mapname") == "mp_abandon")
	{
		self setClientDvar("ui_mapname", "Parking Lot");
	}
	else if(getdvar("mapname") == "mp_vacant")
	{
		self setClientDvar("ui_mapname", "Evening Side");
	}
	else if(getdvar("mapname") == "mp_storm")
	{
		self setClientDvar("ui_mapname", "^5Rainy Gourge");
	}
}

ai_HideGunParts(weapon)
{
	if(!IsSubStr( weapon, "silencer"))
		self HidePart("tag_silencer");
	if(!IsSubStr( weapon, "reflex" ))
	{
		self HidePart("tag_red_dot");
		self HidePart("tag_tavor_scope");
	}
	if(!IsSubStr( weapon, "thermal" ))
	{
		self HidePart("tag_thermal_scope");
	}
	if(!IsSubStr( weapon, "eotech" ))
	{
		self HidePart("tag_eotech");
		self HidePart("tag_fn2000_scope");
		self HidePArt("tag_rail");
	}
	if(IsSubStr( weapon, "eotech" ) || IsSubStr( weapon, "reflex" ) || IsSubStr( weapon, "thermal" ))
	{
		self HidePart("tag_rear_sight");
		self HidePart("tag_iron_sight");
		self HidePart("tag_sight_on");
	}
	if(!IsSubStr( weapon, "gl" ))
	{
		self HidePart("tag_m203");
		self HidePart("tag_gp25");		
	}
	if(!IsSubStr( weapon, "shotgun" ))
		self HidePart("tag_shotgun");
	if(!IsSubStr( weapon, "acog" ))
	{
		self HidePart("tag_acog_2");
		self HidePart("tag_sa80_scope");
		self HidePart("tag_acog");
		self HidePart("tag_steyr_scope");
		self HidePart("tag_scope");
	}
	if(IsSubStr( weapon, "acog" ) || IsSubStr( weapon, "thermal" ))
	{
		self HidePart("tag_m14ebr_scope");
		self HidePart("tag_m82_scope");
		self HidePart("tag_wa2000_scope");
		self HidePart("tag_cheytac_scope");
	}
	if(!IsSubStr( weapon, "heartbeat" ))
		self HidePart("tag_heartbeat");
	if(!IsSubStr( weapon, "grip" ))
		self HidePart("tag_foregrip");
}

ai_SetNormalRound()
{
	if(level.BotsForWave >= 350)
	{
	    level.BotsForWave = 350;
	}
	if(level.Wave == 6)
	{
		level.BotsForWave = 60;
		level.ZombieHealth = 160;
	}
	else if(level.Wave == 11)
	{
		level.BotsForWave = 110;
		level.ZombieHealth = 210;
	}
	else if(level.Wave == 16)
	{
		level.BotsForWave = 160;
		level.ZombieHealth = 260;
	}
	else if(level.Wave == 21)
	{
		level.BotsForWave = 210;
		level.ZombieHealth = 310;
	}
	else if(level.Wave == 26)
	{
		level.BotsForWave = 260;
		level.ZombieHealth = 360;
	}
}

ai_TextWithIcon2( text, text2, icon, sound )
{
	notifyData = spawnstruct();
	notifyData.iconName = icon;
	notifyData.titleText = text;
	notifyData.notifyText = text2;
	notifyData.glowColor = (0.3, 0.6, 0.3);
	notifyData.sound = sound;
	self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}

ai_BonusDropText( text, intensity, color, glow, glowintensity )
{
	self endon( "disconnect" );
	wait ( 0.05 );
	self.bonusdroptext destroy();
	self notify( "bonus_drop_text" );
	self endon( "bonus_drop_text" );
	self.bonusdroptext = newClientHudElem( self );
	self.bonusdroptext.horzAlign = "center";
	self.bonusdroptext.vertAlign = "middle";
	self.bonusdroptext.alignX = "center";
	self.bonusdroptext.alignY = "middle";
	self.bonusdroptext.font = "objective";
	self.bonusdroptext.fontscale = 2;
	self.bonusdroptext.color = color;
	self.bonusdroptext setText(text);
	self.bonusdroptext.alpha = intensity;
	self.bonusdroptext.glowColor = glow;
	self.bonusdroptext.glowAlpha = glowintensity;
	self.bonusdroptext.x = 0;
	self.bonusdroptext.y = 140;
	self.bonusdroptext moveOverTime( 2.00 );
	self.bonusdroptext fadeOverTime( 2.00 );
	self.bonusdroptext.x = 0;
	self.bonusdroptext.y = 80;
	self.bonusdroptext.alpha = 0;
	wait 2;
	self.bonusdroptext destroy();
}

ai_BonusDropIcon(shader, color)
{
    self endon( "disconnect" );
	wait ( 0.05 );
	self.bonusdropicon destroy();
	self notify( "bonus_drop_icon" );
	self endon( "bonus_drop_icon" );
	self.bonusdropicon = NewClientHudElem( self );
	self.bonusdropicon.alignX = "center";
	self.bonusdropicon.alignY = "middle";
	self.bonusdropicon.horzAlign = "center";
	self.bonusdropicon.vertAlign = "middle";
	self.bonusdropicon.x = 0;
	self.bonusdropicon.y = 125;
	self.bonusdropicon.color = color;
	self.bonusdropicon.foreground = true;
	self.bonusdropicon setIconShader( shader );
	self.bonusdropicon setIconSize( 30, 30 );
	self.bonusdropicon.alpha = 1;
	self.bonusdropicon moveOverTime( 2.00 );
	self.bonusdropicon fadeOverTime( 2.00 );
	self.bonusdropicon.x = 0;
	self.bonusdropicon.y = 65;
	self.bonusdropicon.alpha = 0;
	wait 2;
	self.bonusdropicon destroy();
}

ai_RoundStartText( text, intensity, color, glow, glowintensity, value )
{
	self endon( "disconnect" );
	wait ( 0.05 );
	self.startext destroy();
	self notify( "round_start_text" );
	self endon( "round_start_text" );
	self.startext = newClientHudElem( self );
	self.startext.horzAlign = "center";
	self.startext.vertAlign = "middle";
	self.startext.alignX = "center";
	self.startext.alignY = "middle";
	self.startext.font = "hudbig";
	self.startext.fontscale = 6;
	self.startext.color = color;
	if(isDefined(value))
	{
		self.startext.label = text;
		self.startext setValue(value);
	}
	else
		self.startext setText(text);
	self.startext.alpha = 0;
	self.startext.glowColor = glow;
	self.startext.glowAlpha = glowintensity;
	self.startext.x = 0;
	self.startext.y = -160;
	self.startext ChangeFontScaleOverTime( 0.2 );
	self.startext fadeOverTime( 0.2 );
	self.startext moveOverTime( 0.2 );
	self.startext.alpha = intensity;
	self.startext.fontScale = 1;
	self.startext.x = 0;
	self.startext.y = -220;
	wait 2.5;
	self.startext ChangeFontScaleOverTime( 0.2 );
	self.startext fadeOverTime( 0.2 );
	self.startext moveOverTime( 0.2 );
	self.startext.alpha = 0;
	self.startext.fontScale = 4.5;
	self.startext.x = 0;
	self.startext.y = -160;
	wait 0.4;
	self.startext destroy();
}

ai_RoundEndText( text, intensity, color, glow, glowintensity, value )
{
	self endon( "disconnect" );
	wait ( 0.05 );
	self.endtext destroy();
	self notify( "round_end_text" );
	self endon( "round_end_text" );
	self.endtext = newClientHudElem( self );
	self.endtext.horzAlign = "center";
	self.endtext.vertAlign = "middle";
	self.endtext.alignX = "center";
	self.endtext.alignY = "middle";
	self.endtext.font = "hudbig";
	self.endtext.fontscale = 0.150;
	self.endtext.color = color;
	if(isDefined(value))
	{
		self.endtext.label = text;
		self.endtext setValue(value);
	}
	else
		self.endtext setText(text);
	self.endtext.alpha = 0;
	self.endtext.glowColor = glow;
	self.endtext.glowAlpha = glowintensity;
	self.endtext.x = 0;
	self.endtext.y = -220;
	self.endtext ChangeFontScaleOverTime( 0.2 );
	self.endtext fadeOverTime( 0.2 );
	self.endtext.fontscale = 1;
	self.endtext.alpha = intensity;
	wait 2.5;
	self.endtext ChangeFontScaleOverTime( 0.2 );
	self.endtext fadeOverTime( 0.2 );
	self.endtext.alpha = 0;
	self.endtext.fontScale = 0.150;
	wait 0.4;
	self.endtext destroy();
}

ai_IntermissionText( text, intensity, color, glow, glowintensity )
{
	self endon( "disconnect" );
	wait ( 0.05 );
	self.intermissiontext destroy();
	self notify( "intermission_end_text" );
	self endon( "intermission_end_text" );
	self.intermissiontext = newClientHudElem( self );
	self.intermissiontext.horzAlign = "center";
	self.intermissiontext.vertAlign = "middle";
	self.intermissiontext.alignX = "center";
	self.intermissiontext.alignY = "middle";
	self.intermissiontext.font = "hudbig";
	self.intermissiontext.fontscale = 0.001;
	self.intermissiontext.color = color;
	self.intermissiontext setText(text);
	self.intermissiontext.alpha = 0;
	self.intermissiontext.glowColor = glow;
	self.intermissiontext.glowAlpha = glowintensity;
	self.intermissiontext.x = 0;
	self.intermissiontext.y = -195;
	self.intermissiontext ChangeFontScaleOverTime( 0.2 );
	self.intermissiontext fadeOverTime( 0.2 );
	self.intermissiontext.fontscale = 1;
	self.intermissiontext.alpha = intensity;
	wait 2.5;
	self.intermissiontext ChangeFontScaleOverTime( 0.2 );
	self.intermissiontext fadeOverTime( 0.2 );
	self.intermissiontext.alpha = 0;
	self.intermissiontext.fontScale = 0.001;
	wait 0.4;
	self.intermissiontext destroy();
}

ai_TakeWeaponsAfghan()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_afghan")
	{
		self thread ai_StopBarriers();
		self ai_change_spawnsAfghan();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if ( self _hasPerk( "specialty_finalstand" ) )
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroAfghan();
	}
}

ai_TakeWeaponsScrapyard()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_boneyard")
	{
		self ai_change_spawnsScrapyard();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if ( self _hasPerk( "specialty_finalstand" ) )
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		wait 0.05;
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroScrapyard();
	}
}

ai_TakeWeaponsSkidrow()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_nightshift" && level.edit == 0)
	{
		self ai_change_spawnsSkidrow();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if ( self _hasPerk( "specialty_finalstand" ) )
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self fx_ai3_3();
	}
	else if(getdvar("mapname") == "mp_nightshift" && level.edit == 1)
	{
		self ai_change_spawnsSkidrow();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self fx_ai3_3();
	}
	else if(getdvar("mapname") == "mp_nightshift" && level.edit == 2)
	{
		self ai_change_spawnsSkidrow();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self fx_ai3_3();
	}
}

ai_TakeWeaponsUnderpass()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_underpass")
	{
		self ai_change_spawnsUnderpass();
		self setPlayerAngles((0,90,0));
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self giveWeapon("coltanaconda_akimbo_mp",10,false);
		self fx_ai3_11( "frag_grenade_mp" );
		wait 0.05;
		self switchToWeapon("coltanaconda_akimbo_mp",10,false);
		self giveMaxAmmo("coltanaconda_akimbo_mp",10,false);
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroUnderpass();
	}
}

ai_TakeWeaponsTrailerPark()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_trailerpark")
	{
		self ai_change_spawnsTrailerpark();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		wait 0.05;
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroTrailerpark();
	}
}

ai_TakeWeaponsSubBase()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_subbase")
	{
		self ai_change_spawnsSubBase();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		wait 0.05;
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroSubBase();
	}
}

ai_TakeWeaponsQaurry()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_quarry")
	{
		self ai_change_spawnsQuarry();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroQuarry();
	}
}

ai_TakeWeaponsStrike()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_strike")
	{
		self ai_change_spawnsStrike();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroStrike();
	}
}

ai_TakeWeaponsRust()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_rust")
	{
		self ai_change_spawnsRust();
		self.score = 0;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroRust();
	}
}

ai_TakeWeaponsDerail()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_derail")
	{
		self ai_change_spawnsDerail();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroDerail();
	}
}

ai_TakeWeaponsTerminal()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_terminal")
	{
		ai_change_spawnsTerminal();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroTerminal();
	}
}

ai_TakeWeaponsSalvage()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_compact")
	{
		self ai_change_spawnsSalvage();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroSalvage();
	}
}

ai_TakeWeaponsWasteland()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_brecourt")
	{
		self ai_change_spawnsWasteland();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroWasteland();
	}
}

ai_TakeWeaponsHighrise()
{
	if(getdvar("mapname") == "mp_highrise" && level.edit == 0)
	{
		self ai_change_spawnsHighrise();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self fx_ai3_2();
	}
	else if(getdvar("mapname") == "mp_highrise" && level.edit == 1)
	{
		self ai_change_spawnsHighrise();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self fx_ai3_2();
	}
}

ai_TakeWeaponsKarachi()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_checkpoint")
	{
		self ai_change_spawnsKarachi();
		self setPlayerAngles((0,90,0));
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroKarachi();
	}
}

ai_TakeWeaponsFavela()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_favela")
	{
		self ai_change_spawnsFavela();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroFavela();
	}
}

ai_TakeWeaponsRundown()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_rundown")
	{
		self ai_change_spawnsRundown();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroRundown();
	}
}

ai_TakeWeaponsBailout()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_complex")
	{
	    self ai_change_spawnsBailout();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self fx_ai3_1();
	}
}

ai_TakeWeaponsInvasion()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_invasion")
	{
	    self ai_change_spawnsInvasion();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self fx_ai3_1();
	}
}

ai_TakeWeaponsEstate()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_estate")
	{
		self thread ai_StopBarriers();
	    self ai_change_spawnsEstate();
		self.score = 0;
		self.health = 100;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroEstate();
	}
}

ai_TakeWeaponsCarnival()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_abandon")
	{
	    self ai_change_spawnsCarnival();
		self.score = 0;
		self.maxhealth = 100;
		self.health = self.maxhealth;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroCarnival();
	}
}

ai_TakeWeaponsVacant()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_vacant")
	{
	    self ai_change_spawnsVacant();
		self.score = 0;
		self.maxhealth = 100;
		self.health = self.maxhealth;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroVacant();
	}
}

ai_TakeWeaponsStorm()
{
	self endon("disconnect");
	if(getdvar("mapname") == "mp_storm")
	{
	    self ai_change_spawnsStorm();
		self.score = 0;
		self.maxhealth = 100;
		self.health = self.maxhealth;
		self.kills = 0;
		self.pers["botKillstreak"] = 0;
		self.pers["lastKillstreak"] = "";
		self thread ai_MonitorKillstreaks();
		self TakeAllWeapons();
		if(self.autorevive >= 1)
		{
			self _ClearPerks();
			self fx_ai3_11( "specialty_finalstand" );
		}
		else
		{
			self _ClearPerks();
		}
		self thread ai_Pistols();
		self fx_ai3_11( "frag_grenade_mp" );
		self fx_ai3_11("specialty_pistoldeath");
		self maps\mp\_modmenu_ai2::ai_IntroStorm();
	}
}

ai_Pistols()
{
	switch(randomInt(4))
	{
		case 0: self giveWeapon("beretta_mp",10,false);
		self giveMaxAmmo("beretta_mp",10,false);
		wait 0.1;
		self switchToWeapon("beretta_mp",10,false);
		break;
		case 1: self giveWeapon("usp_mp",10,false);
		self giveMaxAmmo("usp_mp",10,false);
		wait 0.1;
		self switchToWeapon("usp_mp",10,false);
		break;
		case 2: self giveWeapon("coltanaconda_mp",10,false);
		self giveMaxAmmo("coltanaconda_mp",10,false);
		wait 0.1;
		self switchToWeapon("coltanaconda_mp",10,false);
		break;
		case 3: self giveWeapon("deserteagle_mp",10,false);
		self giveMaxAmmo("deserteagle_mp",10,false);
		wait 0.1;
		self switchToWeapon("deserteagle_mp",10,false);
		break;
	}
}

ai_InitCountableWeapons()
{
	level.countableweapons[0] = "beretta_mp";
	level.countableweapons[1] = "usp_mp";
	level.countableweapons[2] = "deserteagle_mp";
	level.countableweapons[3] = "coltanaconda_mp";
	level.countableweapons[4] = "glock_mp";
	level.countableweapons[5] = "beretta393_mp";
	level.countableweapons[6] = "mp5k_mp";
	level.countableweapons[7] = "pp2000_mp";
	level.countableweapons[8] = "pp2000_eotech_mp";
	level.countableweapons[9] = "uzi_mp";
	level.countableweapons[10] = "p90_mp";
	level.countableweapons[11] = "kriss_mp";
	level.countableweapons[12] = "ump45_mp";
	level.countableweapons[13] = "tmp_mp";
	level.countableweapons[14] = "ak47_mp";
	level.countableweapons[15] = "m16_reflex_mp";
	level.countableweapons[16] = "m4_reflex_mp";
	level.countableweapons[17] = "fn2000_mp";
	level.countableweapons[18] = "masada_mp";
	level.countableweapons[19] = "famas_mp";
	level.countableweapons[20] = "fal_mp";
	level.countableweapons[21] = "scar_mp";
	level.countableweapons[22] = "tavor_mp";
	level.countableweapons[23] = "m79_mp";
	level.countableweapons[24] = "rpg_mp";
	level.countableweapons[25] = "at4_mp";
	level.countableweapons[26] = "javelin_mp";
	level.countableweapons[27] = "barrett_mp";
	level.countableweapons[28] = "wa2000_acog_mp";
	level.countableweapons[29] = "m21_acog_mp";
	level.countableweapons[30] = "cheytac_mp";
	level.countableweapons[31] = "ranger_mp";
	level.countableweapons[32] = "model1887_mp";
	level.countableweapons[33] = "model1887_fmj_mp";
	level.countableweapons[34] = "striker_mp";
	level.countableweapons[35] = "aa12_mp";
	level.countableweapons[36] = "m1014_mp";
	level.countableweapons[37] = "spas12_mp";
	level.countableweapons[38] = "rpd_mp";
	level.countableweapons[39] = "sa80_mp";
	level.countableweapons[40] = "mg4_mp";
	level.countableweapons[41] = "m240_grip_mp";
	level.countableweapons[42] = "aug_mp";
	level.countableweapons[43] = "onemanarmy_mp";
	level.countableweapons[44] = "m4_silencer_mp";
	level.countableweapons[45] = "tmp_silencer_mp";
	level.countableweapons[46] = "ump45_eotech_xmags_mp";
	level.countableweapons[47] = "usp_akimbo_xmags_mp";
	level.countableweapons[48] = "deserteagle_akimbo_mp";
	level.countableweapons[49] = "beretta_akimbo_xmags_mp";
	level.countableweapons[50] = "wa2000_acog_xmags_mp";
	level.countableweapons[51] = "m16_eotech_xmags_mp";
	level.countableweapons[52] = "famas_acog_fmj_mp";
	level.countableweapons[52] = "beretta393_akimbo_xmags_mp";
	level.countableweapons[53] = "ak47_fmj_xmags_mp";
	level.countableweapons[54] = "aa12_grip_xmags_mp";
	level.countableweapons[55] = "striker_xmags_mp";
	level.countableweapons[56] = "cheytac_fmj_mp";
	level.countableweapons[57] = "glock_akimbo_xmags_mp";
	level.countableweapons[58] = "rpd_eotech_grip_mp";
	level.countableweapons[59] = "ac130_25mm_mp";
	level.countableweapons[60] = "coltanaconda_akimbo_fmj_mp";
	level.countableweapons[61] = "m4_eotech_shotgun_mp";
	level.countableweapons[62] = "mp5k_fmj_xmags_mp";
	level.countableweapons[63] = "ak47_gl_thermal_mp";
	level.countableweapons[64] = "barrett_acog_xmags_mp";
	level.countableweapons[65] = "sa80_grip_xmags_mp";
	level.countableweapons[66] = "m21_acog_xmags_mp";
	level.countableweapons[67] = "spas12_grip_xmags_mp";
	level.countableweapons[68] = "tmp_akimbo_xmags_mp";
	level.countableweapons[69] = "mg4_eotech_xmags_mp";
	level.countableweapons[70] = "pp2000_fmj_reflex_mp";
	level.countableweapons[71] = "aug_eotech_xmags_mp";
	level.countableweapons[72] = "m240_eotech_xmags_mp";
	level.countableweapons[73] = "tavor_fmj_reflex_mp";
	level.countableweapons[74] = "kriss_reflex_rof_mp";
	level.countableweapons[75] = "scar_eotech_xmags_mp";
	level.countableweapons[76] = "ranger_akimbo_fmj_mp";
	level.countableweapons[77] = "p90_akimbo_xmags_mp";
	level.countableweapons[78] = "masada_reflex_xmags_mp";
	level.countableweapons[79] = "uzi_acog_silencer_mp";
	level.countableweapons[80] = "model1887_akimbo_fmj_mp";
	level.countableweapons[81] = "fn2000_reflex_mp";
	level.countableweapons[82] = "fal_reflex_xmags_mp";
	level.countableweapons[83] = "m1014_xmags_mp";
	level.countableweapons[84] = "tmp_silencer_xmags_mp";
	level.countableweapons[85] = "pp2000_eotech_xmags_mp";
	level.countableweapons[86] = "coltanaconda_akimbo_fmj_mp";
	level.countableweapons[87] = "deserteaglegold_mp";
	level.countableweapons[88] = "m4_acog_silencer_mp";
	level.countableweapons[89] = "ranger_fmj_mp";
	level.countableweapons[90] = "stinger_mp";
}

ai_getAllWeapons(whatWeapon)//What weapon to get
{
	foundWeapon = 0;
	weaponList = self GetWeaponsListAll();
	{
		foreach(weaponName in weaponList)
		{
			if(weaponName != whatWeapon)
			{
				continue;
			}	
			else if(weaponName == whatWeapon)
			{
				foundWeapon = 1;
			}
		}
	}
	if(foundWeapon == 1)
	{
		return true;
	}
	else
	{
		return false;
	}
}

ai_switchtoRandomWeapon()//What weapon to get
{
	pWeapon = undefined;
	weaponList = self GetWeaponsListAll();
	{
		foreach(weaponName in weaponList)
		{
			foreach(countablegun in level.countableweapons)
			{
				if(weaponName != countablegun)
					continue;
				
				if(weaponName == countablegun)
					pWeapon = weaponName;
			}
		}
		self switchToWeapon(pWeapon);
	}
}

ai_IfCanSetOnFire(sWeapon)
{
	setFire = 0;
	switch(sWeapon)
	{
		case "tmp_silencer_mp":
		setFire = 1;
		break;
		case "tmp_silencer_xmags_mp":
		setFire = 1;
		break;
		case "cheytac_mp":
		setFire = 1;
		break;
		case "cheytac_fmj_mp":
		setFire = 1;
		break;
		case "model1887_akimbo_fmj_mp":
		setFire = 1;
		break;
	}
	if(setFire == 0)
		return false;
		
	if(setFire == 1)
		return true;
}

ai_IfCanBlowUp(sWeapon)
{
	setBlow = 0;
	switch(sWeapon)
	{
		case "rpg_mp":
		setBlow = 1;
		break;
		case "frag_grenade_mp":
		setBlow = 1;
		break;
		case "semtex_mp":
		setBlow = 1;
		break;
		case "c4_mp":
		setBlow = 1;
		break;
		case "gl_ak47_mp":
		setBlow = 1;
		break;
		case "gl_m16_mp":
		setBlow = 1;
		break;
		case "gl_m4_mp":
		setBlow = 1;
		break;
		case "gl_fn2000_mp":
		setBlow = 1;
		break;
		case "gl_masada_mp":
		setBlow = 1;
		break;
		case "gl_famas_mp":
		setBlow = 1;
		break;
		case "gl_fal_mp":
		setBlow = 1;
		break;
		case "gl_scar_mp":
		setBlow = 1;
		break;
		case "gl_tavor_mp":
		setBlow = 1;
		break;
		case "gl_mp":
		setBlow = 1;
		break;
		case "at4_mp":
		setBlow = 1;
		break;
		case "ac130_40mm_mp":
		setBlow = 1;
		break;
		case "ac130_105mm_mp":
		setBlow = 1;
		break;
	}
	if(setBlow == 0)
		return false;
		
	if(setBlow == 1)
		return true;
}

ai_blowBackGrenade(vPoint)
{
	self startRagDoll(1);
	PhysicsExplosionSphere( vPoint, 30, 30, 6 );
}

ai_AmmoMaticAdd(sWeapon)
{
	AmmoMatic = 0;
	switch(sWeapon)
	{
		case "beretta_mp":
		AmmoMatic = 4;
		break;
		case "usp_mp":
		AmmoMatic = 4;
		break;
		case "deserteagle_mp":
		AmmoMatic = 2;
		break;
		case "coltanaconda_mp":
		AmmoMatic = 2;
		break;
		case "glock_mp":
		AmmoMatic = 4;
		break;
		case "beretta393_mp":
		AmmoMatic = 4;
		break;
		case "mp5k_mp":
		AmmoMatic = 3;
		break;
		case "pp2000_mp":
		AmmoMatic = 2;
		break;
		case "pp2000_eotech_mp":
		AmmoMatic = 1;
		break;
		case "uzi_mp":
		AmmoMatic = 2;
		break;
		case "p90_mp":
		AmmoMatic = 3;
		break;
		case "kriss_mp":
		AmmoMatic = 3;
		break;
		case "ump45_mp":
		AmmoMatic = 2;
		break;
		case "tmp_mp":
		AmmoMatic = 3;
		break;
		case "ak47_mp":
		AmmoMatic = 2;
		break;
		case "m16_reflex_mp":
		AmmoMatic = 2;
		break;
		case "m4_reflex_mp":
		AmmoMatic = 3;
		break;
		case "fn2000_mp":
		AmmoMatic = 3;
		break;
		case "masada_mp":
		AmmoMatic = 3;
		break;
		case "famas_mp":
		AmmoMatic = 2;
		break;
		case "fal_mp":
		AmmoMatic = 1;
		break;
		case "scar_mp":
		AmmoMatic = 2;
		break;
		case "tavor_mp":
		AmmoMatic = 3;
		break;
		case "m79_mp":
		AmmoMatic = 1;
		break;
		case "rpg_mp":
		AmmoMatic = 1;
		break;
		case "at4_mp":
		AmmoMatic = 1;
		break;
		case "javelin_mp":
		AmmoMatic = 1;
		break;
		case "barrett_mp":
		AmmoMatic = 1;
		break;
		case "wa2000_acog_mp":
		AmmoMatic = 1;
		break;
		case "m21_acog_mp":
		AmmoMatic = 1;
		break;
		case "cheytac_mp":
		AmmoMatic = 1;
		break;
		case "ranger_mp":
		AmmoMatic = 1;
		break;
		case "model1887_mp":
		AmmoMatic = 1;
		break;
		case "model1887_fmj_mp":
		AmmoMatic = 1;
		break;
		case "striker_mp":
		AmmoMatic = 1;
		break;
		case "aa12_mp":
		AmmoMatic = 1;
		break;
		case "m1014_mp":
		AmmoMatic = 1;
		break;
		case "spas12_mp":
		AmmoMatic = 1;
		break;
		case "rpd_mp":
		AmmoMatic = 2;
		break;
		case "sa80_mp":
		AmmoMatic = 2;
		break;
		case "mg4_mp":
		AmmoMatic = 2;
		break;
		case "m240_grip_mp":
		AmmoMatic = 2;
		break;
		case "aug_mp":
		AmmoMatic = 2;
		break;
		case "m4_silencer_mp":
		AmmoMatic = 2;
		break;
		case "tmp_silencer_mp":
		AmmoMatic = 1;
		break;
		case "ump45_eotech_xmags_mp":
		AmmoMatic = 3;
		break;
		case "usp_akimbo_xmags_mp":
		AmmoMatic = 4;
		break;
		case "deserteagle_akimbo_mp":
		AmmoMatic = 4;
		break;
		case "beretta_akimbo_xmags_mp":
		AmmoMatic = 0;
		break;
		case "wa2000_acog_xmags_mp":
		AmmoMatic = 2;
		break;
		case "m16_eotech_xmags_mp":
		AmmoMatic = 3;
		break;
		case "famas_acog_fmj_mp":
		AmmoMatic = 3;
		break;
		case "beretta393_akimbo_xmags_mp":
		AmmoMatic = 4;
		break;
		case "ak47_fmj_xmags_mp":
		AmmoMatic = 4;
		break;
		case "aa12_grip_xmags_mp":
		AmmoMatic = 2;
		break;
		case "striker_xmags_mp":
		AmmoMatic = 2;
		break;
		case "cheytac_fmj_mp":
		AmmoMatic = 2;
		break;
		case "glock_akimbo_xmags_mp":
		AmmoMatic = 4;
		break;
		case "rpd_eotech_grip_mp":
		AmmoMatic = 3;
		break;
		case "coltanaconda_akimbo_fmj_mp":
		AmmoMatic = 4;
		break;
		case "m4_eotech_shotgun_mp":
		AmmoMatic = 3;
		break;
		case "mp5k_fmj_xmags_mp":
		AmmoMatic = 3;
		break;
		case "ak47_gl_thermal_mp":
		AmmoMatic = 4;
		break;
		case "sa80_grip_xmags_mp":
		AmmoMatic = 3;
		break;
		case "m21_acog_xmags_mp":
		AmmoMatic = 2;
		break;
		case "spas12_grip_xmags_mp":
		AmmoMatic = 2;
		break;
		case "tmp_akimbo_xmags_mp":
		AmmoMatic = 4;
		break;
		case "mg4_eotech_xmags_mp":
		AmmoMatic = 3;
		break;
		case "pp2000_fmj_reflex_mp":
		AmmoMatic = 3;
		break;
		case "aug_eotech_xmags_mp":
		AmmoMatic = 3;
		break;
		case "m240_eotech_xmags_mp":
		AmmoMatic = 3;
		break;
		case "tavor_fmj_reflex_mp":
		AmmoMatic = 3;
		break;
		case "kriss_reflex_rof_mp":
		AmmoMatic = 3;
		break;
		case "scar_eotech_xmags_mp":
		AmmoMatic = 3;
		break;
		case "ranger_akimbo_fmj_mp":
		AmmoMatic = 2;
		break;
		case "p90_akimbo_xmags_mp":
		AmmoMatic = 4;
		break;
		case "masada_reflex_xmags_mp":
		AmmoMatic = 4;
		break;
		case "uzi_acog_silencer_mp":
		AmmoMatic = 3;
		break;
		case "model1887_akimbo_fmj_mp":
		AmmoMatic = 2;
		break;
		case "fn2000_reflex_mp":
		AmmoMatic = 3;
		break;
		case "fal_reflex_xmags_mp":
		AmmoMatic = 2;
		break;
		case "m1014_xmags_mp":
		AmmoMatic = 2;
		break;
		case "tmp_silencer_xmags_mp":
		AmmoMatic = 2;
		break;
		case "pp2000_eotech_xmags_mp":
		AmmoMatic = 1;
		break;
		case "deserteaglegold_mp":
		AmmoMatic = 4;
		break;
		case "m4_acog_silencer_mp":
		AmmoMatic = 3;
		break;
		case "ranger_fmj_mp":
		AmmoMatic = 1;
		break;
		case "stinger_mp":
		AmmoMatic = 1;
		break;
	}
	return AmmoMatic;
}

ai_IncreaseDamage(sWeapon, type)
{
	switch(sWeapon)
	{
		case "ac130_105mm_mp":
		self.crate1.health -= 2000;
		break;
		case "ac130_40mm_mp":
		self.crate1.health -= 2000;
		break;
		case "ac130_25mm_mp":
		self.crate1.health -= 0;
		break;
		case "m240_xmags_mp":
		self.crate1.health -= 30;
		break;
		case "m240_fmj_xmags_mp":
		self.crate1.health -= 15;
		break;
	}
}

ai_ZombieAirstrikeSound(sWeapon)
{
	switch(randomInt(12))
	{
		case 0:
		self PlayLocalSound(fx_ai3_9( "allies" ) + "ac130_fco_rightontarget" );
		break;
		case 1:
		self PlayLocalSound(fx_ai3_9( "allies" ) + "ac130_fco_goodkill" );
		break;
		case 2:
		self PlayLocalSound(fx_ai3_9( "allies" ) + "ac130_fco_yougothim" );
		break;
		case 3:
		self PlayLocalSound(fx_ai3_9( "allies" ) + "ac130_fco_yougothim2" );
		break;
		case 4:
		self PlayLocalSound(fx_ai3_9( "allies" ) + "ac130_fco_thatsahit" );
		break;
		case 5:
		self PlayLocalSound(fx_ai3_9( "allies" ) + "ac130_fco_directhit" );
		break;
		case 6:
		self PlayLocalSound(fx_ai3_9( "allies" ) + "ac130_fco_within2feet" );
		break;
		case 7:
		self PlayLocalSound(fx_ai3_9( "allies" ) + "ac130_plt_gottahurt" );
		break;
		case 8:
		self PlayLocalSound(fx_ai3_9( "allies" ) + "ac130_fco_oopsiedaisy" );
		break;
		case 9:
		self PlayLocalSound(fx_ai3_9( "allies" ) + "ac130_fco_iseepieces" );
		break;
		case 10:
		self PlayLocalSound(fx_ai3_9( "allies" ) + "ac130_fco_nice" );
		break;
		case 11:
		self PlayLocalSound(fx_ai3_9( "allies" ) + "ac130_fco_directhits" );
		break;
	}
}

ai_RegularAnim()
{
	if(level.power == 0)
	{
		switch(randomInt(8))
		{
			case 0: self scriptModelPlayAnim("pb_sprint_gundown");
			self.animation = "pb_sprint_gundown";
			self.speed = 150;
			self.speed2 = 150;
			break;
			case 1: self scriptModelPlayAnim("pb_sprint_mg");
			self.animation = "pb_sprint_mg";
			self.speed = 170;
			self.speed2 = 170;
			break;
			case 2: self scriptModelPlayAnim("pb_sprint_akimbo");
			self.animation = "pb_sprint_akimbo";
			self.speed = 220;
			self.speed2 = 220;
			break;
			case 3: self scriptModelPlayAnim("pb_sprint_shield");
			self.animation = "pb_sprint_shield";
			self.speed = 170;
			self.speed2 = 170;
			break;
			case 4: self scriptModelPlayAnim("pb_pistol_run_fast");
			self.animation = "pb_pistol_run_fast";
			self.speed = 250;
			self.speed2 = 250;
			break;
			case 5: self scriptModelPlayAnim("pb_sprint_pistol");
			self.animation = "pb_sprint_pistol";
			self.speed = 200;
			self.speed2 = 200;
			break;
			case 6: self scriptModelPlayAnim("pb_walk_forward_shield");
			self.animation = "pb_walk_forward_shield";
			self.speed = 70;
			self.speed2 = 70;
			self.ZombieHealth += 50;
			break;
			case 7: self scriptModelPlayAnim("pb_combatwalk_forward_loop_pistol");
			self.animation = "pb_combatwalk_forward_loop_pistol";
			self.speed = 90;
			self.speed2 = 90;
			self.ZombieHealth += 100;
			break;
		}
		self.idleanimation = 0;
		self.freezed = 0;
		self.automove = 0;
	}
	if(level.power == 1)
	{
		switch(randomInt(9))
		{
			case 0: self scriptModelPlayAnim("pb_sprint_gundown");
			self.animation = "pb_sprint_gundown";
			self.speed = 150;
			self.speed2 = 150;
			break;
			case 1: self scriptModelPlayAnim("pb_sprint_mg");
			self.animation = "pb_sprint_mg";
			self.speed = 170;
			self.speed2 = 170;
			break;
			case 2: self scriptModelPlayAnim("pb_sprint_akimbo");
			self.animation = "pb_sprint_akimbo";
			self.speed = 220;
			self.speed2 = 220;
			break;
			case 3: self scriptModelPlayAnim("pb_sprint_shield");
			self.animation = "pb_sprint_shield";
			self.speed = 170;
			self.speed2 = 170;
			break;
			case 4: self scriptModelPlayAnim("pb_pistol_run_fast");
			self.animation = "pb_pistol_run_fast";
			self.speed = 250;
			self.speed2 = 250;
			break;
			case 5: self scriptModelPlayAnim("pb_sprint_pistol");
			self.animation = "pb_sprint_pistol";
			self.speed = 200;
			self.speed2 = 200;
			break;
			case 6: self scriptModelPlayAnim("pb_combatrun_forward_loop_stickgrenade");
			self.animation = "pb_combatrun_forward_loop_stickgrenade";
			self.c4 = spawn("script_model", self getTagOrigin("tag_inhand"));
			self.c4 setModel("weapon_c4");
			self.c4 linkto(self,"tag_inhand", ( 0,0,0 ), ( 0,0,0));
			self.speed = 160;
			self.speed2 = 160;
			break;
			case 7: self scriptModelPlayAnim("pb_walk_forward_shield");
			self.animation = "pb_walk_forward_shield";
			self.speed = 70;
			self.speed2 = 70;
			self.ZombieHealth += 50;
			self.shield = spawn("script_model",self getTagOrigin("tag_stowed_back")); 
			self.shield setModel(GetWeaponModel("riotshield_mp", 0));
			self.shield.angles = (0,180,0);
			self.shield linkto( self, "tag_stowed_back" );
			break;
			case 8: self scriptModelPlayAnim("pb_combatwalk_forward_loop_pistol");
			self.animation = "pb_combatwalk_forward_loop_pistol";
			self.speed = 90;
			self.speed2 = 90;
			self.ZombieHealth += 100;
			break;
		}
		self.idleanimation = 0;
		self.freezed = 0;
		self.automove = 0;
	}
}

ai_HellAnim()
{
	switch(randomInt(7))
	{
		case 0: self scriptModelPlayAnim("pb_sprint_gundown");
		self.animation = "pb_sprint_gundown";
		self.speed = 250;
		self.speed2 = 250;
		break;
		case 1: self scriptModelPlayAnim("pb_sprint_mg");
		self.animation = "pb_sprint_mg";
		self.speed = 250;
		self.speed2 = 250;
		break;
		case 2: self scriptModelPlayAnim("pb_sprint_akimbo");
		self.animation = "pb_sprint_akimbo";
		self.speed = 270;
		self.speed2 = 270;
		break;
		case 3: self scriptModelPlayAnim("pb_sprint_shield");
		self.animation = "pb_sprint_shield";
		self.speed = 300;
		self.speed2 = 300;
		self.shield = spawn("script_model",self getTagOrigin("tag_stowed_back")); 
		self.shield setModel(GetWeaponModel("riotshield_mp", 0));
		self.shield.angles = (0,180,0);
		self.shield linkto( self, "tag_stowed_back" );
		break;
		case 4: self scriptModelPlayAnim("pb_pistol_run_fast");
		self.animation = "pb_pistol_run_fast";
		self.speed = 230;
		self.speed2 = 230;
		break;
		case 5: self scriptModelPlayAnim("pb_sprint_pistol");
		self.animation = "pb_sprint_pistol";
		self.speed = 200;
		self.speed2 = 200;
		break;
		case 6: self scriptModelPlayAnim("pb_combatrun_forward_loop_stickgrenade");
		self.animation = "pb_combatrun_forward_loop_stickgrenade";
		self.speed = 270;
		self.speed2 = 270;
		break;
	}
	self.idleanimation = 0;
	self.freezed = 0;
	self.automove = 0;
}

ai_BossAnim()
{
	self scriptModelPlayAnim("pb_sprint_mg");
	self.animation = "pb_sprint_mg";
	self.speed = 330;
	self.speed2 = 330;
	self.idleanimation = 0;
	self.freezed = 0;
	self.automove = 0;
}

ai_BossAnim2()
{
	self scriptModelPlayAnim("pb_sprint_mg");
	self.animation = "pb_sprint_mg";
	self.speed = 300;
	self.speed2 = 300;
	self.idleanimation = 0;
	self.freezed = 0;
	self.automove = 0;
}

ai_CrawlerAnim()
{
	self scriptModelPlayAnim("pb_prone_crawl_akimbo");
	self.animation = "pb_prone_crawl_akimbo";
	self.speed = RandomIntRange( 70, 260 );
	self.speed2 = self.speed;
	self.idleanimation = 0;
	self.freezed = 0;
	self.automove = 0;
}

ai_ExplosionDeath()
{
	switch(randomInt(1))
	{
		case 0: self scriptModelPlayAnim("pb_stand_death_leg_kickup");
		break;
	}
}

ai_HitPainAnim()
{
	self endon("bot_death");
	self endon("hit");
	self scriptModelPlayAnim("pb_stumble_forward");
	wait 0.4;
	if(self.idleanimation == 1)
		self scriptModelPlayAnim("pb_stand_alert");
	else
		self scriptModelPlayAnim(self.animation);
}

ai_DeathSound()
{
	switch(randomInt(4))
	{
		case 0:
		self playSound("generic_death_russian_1");
		break;
		case 1:
		self playSound("generic_death_american_1");
		break;
		case 2:
		self playSound("generic_death_russian_2");
		break;
		case 3:
		self playSound("generic_death_american_2");
		break;
	}
}

ai_DeathReguler()
{
	if(getDvar("mapname") == "mp_afghan" || getDvar("mapname") == "mp_trailerpark" || getDvar("mapname") == "mp_estate")
	{
		switch(randomInt(9))
		{
			case 0: self scriptModelPlayAnim("pb_death_run_stumble");
			break;
			case 1: self scriptModelPlayAnim("pb_stand_death_leg_kickup");
			break;
			case 2: self scriptModelPlayAnim("pb_stand_death_shoulderback");
			break;
			case 3: self scriptModelPlayAnim("pb_shotgun_death_front");
			break;
			case 4: self scriptModelPlayAnim("pb_crouch_death_falltohands");
			break;
			case 5: self scriptModelPlayAnim("pb_crouchrun_death_drop");
			break;
			case 6: self scriptModelPlayAnim("pb_death_run_onfront");
			break;
			case 7: self scriptModelPlayAnim("pb_stand_death_head_straight_back");
			break;
			case 8: self scriptModelPlayAnim("pb_crouchrun_death_drop");
			break;
		}
	}
	else
	{
		switch(randomInt(3))
		{
			case 0: self scriptModelPlayAnim("pb_death_run_stumble");
			break;
			case 1: self scriptModelPlayAnim("pb_stand_death_leg_kickup");
			break;
			case 2: self scriptModelPlayAnim("pb_stand_death_shoulderback");
			break;
		}
	}
}

ai_PlayFireDeath()
{
	playFXonTag(loadFx("fire/fire_smoke_trail_L_emitter"), self, "j_spinelower");
	playFXonTag(loadFx("smoke/smoke_trail_black_heli_emitter"), self, "j_spine4");
	wait 0.2;
}

ai_MoniterPosition()
{	
	self endon("bot_death");
	while(1)
	{
		level.zombieorigin = self.origin;
		level.zombieangles = self.angles;
		wait 0.1;
	}
}

ai_change_spawnsAfghan()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_afghan")
		{
            spawn[spawn.size] = (-2084,-708,-1439);
			spawn[spawn.size] = (-1941,-886,-1440);
			spawn[spawn.size] = (-2157,-371,-1440);
			spawn[spawn.size] = (-2347,-748,-1440);
			self setorigin(spawn[randomint(spawn.size)]);
			self setplayerangles(RandomIntRange(136,212));
		}	
	}
}

ai_change_spawnsScrapyard()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_boneyard")
		{
            spawn[spawn.size] = (124,-810,-124);
			spawn[spawn.size] = (71,-810,-124);
			spawn[spawn.size] = (7,-813,-124);
			spawn[spawn.size] = (-42,-811,-123);
			self setorigin(spawn[randomint(spawn.size)]);
			self setplayerangles((0,270,0));
		}	
	}
}

ai_change_spawnsRundown()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_rundown")
		{
            spawn[spawn.size] = (1432, 2922, 82);
			spawn[spawn.size] = (1238, 2876, 82);
			spawn[spawn.size] = (1327, 3112, 82);
			spawn[spawn.size] = (1425, 3098, 82);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsSkidrow()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_nightshift" && level.edit == 0)
		{
            spawn[spawn.size] = (-2387.2, -350.7, 144.1);
			spawn[spawn.size] = (-2349.1, -793.4, 144.1);
			spawn[spawn.size] = (-2215.3, 203.2, 32.1);
			spawn[spawn.size] = (-1596.6, -17.4, 8.1);
			spawn[spawn.size] = (-1728.4, -533.1, 8.1);
			spawn[spawn.size] = (-1202.0, -1668.5, 16.1);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
		else if(getdvar("mapname") == "mp_nightshift" && level.edit == 1)
		{
            spawn[spawn.size] = (793.4,-1855.6,192.1);
			spawn[spawn.size] = (887.7,-1855.2,192.1);
			spawn[spawn.size] = (1006.8,-1854.7,192.1);
			spawn[spawn.size] = (1068.2,-1851.8,192.1);
			spawn[spawn.size] = (1045,-2027.6,192.1);
			spawn[spawn.size] = (1029.6,-2112.3,192.1);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
		else if(getdvar("mapname") == "mp_nightshift" && level.edit == 2)
		{
            spawn[spawn.size] = (1602,-847,16);
			spawn[spawn.size] = (1653,-851,16);
			spawn[spawn.size] = (1724,-855,16);
			spawn[spawn.size] = (1816,-861,16);
			spawn[spawn.size] = (1889,-862,16);
			spawn[spawn.size] = (1952,-862,16);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsUnderpass()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_underpass")
		{
            spawn[spawn.size] = (3949,1062,400);
			spawn[spawn.size] = (3843,1059,400);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsTrailerpark()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_trailerpark")
		{
            spawn[spawn.size] = (1887.5, -2864.0, 24.1);
			spawn[spawn.size] = (1762.5, -2953.4, 24.1);
			spawn[spawn.size] = (1649.6, -2695.0, 24.1);
			spawn[spawn.size] = (1798.7, -2614.4, 24.1);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsQuarry()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_quarry")
		{
            spawn[spawn.size] = (-1711.1, 2146.8, 176.1);
			spawn[spawn.size] = (-1662.3, 2143.8, 176.1);
			spawn[spawn.size] = (-1621.4, 1213.7, 40.1);
			spawn[spawn.size] = (-1625.4, 1099.8, 40.1);
			spawn[spawn.size] = (-1620.0, 906.2, 40.1);
			spawn[spawn.size] = (-2564.1, 942.0, 40.1);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsRust()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_rust" && level.edit == 0)
		{
            spawn[spawn.size] = (3024.5, -10978.9, -162.1);
			spawn[spawn.size] = (3028.6, -10879.9, -163.5);
			spawn[spawn.size] = (2658.2, -10886.8, -197.9);
			spawn[spawn.size] = (2551.0, -10848.2, -208.7);
			spawn[spawn.size] = (2408.1, -10792.0, -212.0);
			spawn[spawn.size] = (2683.5, -10662.4, -201.8);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
		if(getdvar("mapname") == "mp_rust" && level.edit == 1)
		{
            spawn[spawn.size] = (1444,-4791,-139);
			spawn[spawn.size] = (1595,-4899,-172);
			spawn[spawn.size] = (1239,-4898,-196);
			spawn[spawn.size] = (1479,-4565,-160);
			spawn[spawn.size] = (1712,-4699,-163);
			spawn[spawn.size] = (1279,-5597,-255);
			spawn[spawn.size] = (986,-5643,-255);
			spawn[spawn.size] = (1152,-5514,-255);
			spawn[spawn.size] = (1178,-5915,-255);
			spawn[spawn.size] = (1004,-6355,-255);
			spawn[spawn.size] = (998,-6475,-255);
			spawn[spawn.size] = (1154,-6598,-255);
			spawn[spawn.size] = (1195,-6393,-255);
			self setorigin(spawn[randomint(spawn.size)]);
			self setplayerangles((0,270,0));
		}	
	}
}

ai_change_spawnsSalvage()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_compact")
		{
            spawn[spawn.size] = (1870.9,2029.6,152.1);
			spawn[spawn.size] = (1876.9,2082.3,152.1);
			spawn[spawn.size] = (1833.3,2271.0,152.1);
			spawn[spawn.size] = (1791.4,2029.6,152.1);
			spawn[spawn.size] = (1718.6,2289.2,152.1);
			spawn[spawn.size] = (1863.5,2302.9,152.1);
			self setPlayerAngles((0,90,0));
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsSubBase()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_subbase")
		{
            spawn[spawn.size] = (-254,-3903,16);
			spawn[spawn.size] = (-326,-3906,16);
			spawn[spawn.size] = (-408,-3905,16);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsWasteland()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_brecourt")
		{
            spawn[spawn.size] = (10943,7200,1486);
			spawn[spawn.size] = (9958,7285,358);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsStrike()
{
	self endon("disconnect");
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_strike")
		{
			switch(randomInt(3))
			{
			    case 0:
				self setorigin(-1786,1574,24);
				self.angles = (0,180,0);
				break;
				case 1:
				self setorigin((-1743,1467,26));
				self.angles = (0,180,0);
				break;
				case 2:
				self setorigin((-1878,1487,17));
				self.angles = (0,180,0);
				break;
			}
		}	
	}
}

ai_change_spawnsTerminal()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_terminal")
		{
            spawn[spawn.size] = (1503,4095,184);
			spawn[spawn.size] = (1586,4094,184);
			spawn[spawn.size] = (1700,4084,184);
			spawn[spawn.size] = (1773,4079,184);
			spawn[spawn.size] = (1693,4231,184);
			spawn[spawn.size] = (1582,4237,184);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsKarachi()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_checkpoint")
		{
            spawn[spawn.size] = (2367,1941,47);
			spawn[spawn.size] = (2485,1943,47);
			spawn[spawn.size] = (2435,2052,21);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsFavela()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_favela")
		{
            spawn[spawn.size] = (1505,2348,298);
			spawn[spawn.size] = (1492,2397,298);
			spawn[spawn.size] = (1474,2453,298);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsBailout()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_complex")
		{
            spawn[spawn.size] = (2864,-2001,1056);
			spawn[spawn.size] = (2974,-1992,1056);
			spawn[spawn.size] = (3068,-1981,1056);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsDerail()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_derail")
		{
            spawn[spawn.size] = (1759,3281,158);
			spawn[spawn.size] = (1748,3223,158);
			spawn[spawn.size] = (1753,3150,158);
			spawn[spawn.size] = (1826,3156,158);
			spawn[spawn.size] = (1828,3198,158);
			spawn[spawn.size] = (1832,3249,158);
			spawn[spawn.size] = (1974,3267,158);
			spawn[spawn.size] = (1973,3137,158);
			self setPlayerAngles((0,90,0));
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsHighrise()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_highrise" && level.edit == 0)
		{
            spawn[spawn.size] = (-7981,5599,2331);
			spawn[spawn.size] = (-7976,5762,2331);
			spawn[spawn.size] = (-7977,5979,2331);
			spawn[spawn.size] = (-7980,6285,2331);
			spawn[spawn.size] = (-7950,6566,2331);
			spawn[spawn.size] = (-7962,6746,2331);
			spawn[spawn.size] = (-8206,5374,2331);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
		else if(getdvar("mapname") == "mp_highrise" && level.edit == 1)
		{
            spawn[spawn.size] = (-14749.7,3934,5439.1);
			spawn[spawn.size] = (-14530.5,3917,5439.1);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsInvasion()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_invasion")
		{
            spawn[spawn.size] = (2411,12662,11);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsEstate()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_estate")
		{
            spawn[spawn.size] = (-2586,-243,-312);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsCarnival()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_abandon")
		{
            spawn[spawn.size] = (-2186,2961,3);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsVacant()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_vacant")
		{
            spawn[spawn.size] = (-53,796,-31);
			spawn[spawn.size] = (-39,949,-31);
			spawn[spawn.size] = (-11,1186,-31);
			spawn[spawn.size] = (-135,1278,-31);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_change_spawnsStorm()
{
	self endon("disconnect");
	spawn = [];
	if(self.team == "allies")
	{
		if(getdvar("mapname") == "mp_storm")
		{
            spawn[spawn.size] = (2598,-1279,-47);
			spawn[spawn.size] = (2607,-1148,-47);
			spawn[spawn.size] = (2612,-1023,-48);
			spawn[spawn.size] = (2787,-1132,-48);
			self setorigin(spawn[randomint(spawn.size)]);
		}	
	}
}

ai_StopBarriers()
{
	ents = getEntArray();
		for(i = 0;i < ents.size;i++)
			if(isSubStr(ents[i].classname,"trigger_hurt"))
				ents[i].origin = (0,0,9999999);
}

ai__explosiveintervention_Init()
{
	level.InterventionWeapon = "cheytac_mp";

	level.InterventionFX["impact"] = loadFX( "props/barrel_fire" );

	level.FX_count = 0;

	level thread ai_onPlayerConnected();
}

ai_onPlayerConnected()
{
	for( ;; )
	{
		level waittill( "connected", player );

		player thread ai_doExplosiveInterventiongun();
	}
}

ai_doExplosiveInterventiongun()
{
	for( ;; )
	{
		self waittill( "weapon_fired", weaponName );

		if( self getCurrentWeapon() != level.InterventionWeapon )
			continue;


		start = self getTagOrigin( "tag_eye" );
		end = self getTagOrigin( "tag_eye" ) + ai_vecscale( anglestoforward( self getPlayerAngles() ), 100000 );
		trace = bulletTrace( start, end, true, self );
 

		thread ai_InterventionFX( self getTagOrigin( "tag_flash" ), anglestoforward( self getPlayerAngles() ), trace["position"] );
	}	
}

ai_InterventionFX( startPos, direction, endPos )
{
	doDamage = 1;

	for( i = 1; ; i ++ ) 
	{
		pos = startPos + ai_vecscale( direction, i * 300 ); 

		if( distance( startPos, pos ) > 100000 ) 
		{
			doDamage = 0;
			break;
		}

		trace = bulletTrace( startPos, pos, true, self );

		if( !bulletTracePassed( startPos, pos, true, self ) )
		{
			impactFX = spawnFX( level.InterventionFX["impact"], bulletTrace( startPos, pos, true, self )["position"] );
			level.FX_count ++;
			triggerFX( impactFX );
			self playsound("explo_mine");

			wait( 0.2 );

			impactFX delete();
			level.FX_count --;
			
			break;
		}

		fireFX = spawnFX( level.InterventionFX["fire"], pos ); 
		level.FX_count ++;
		triggerFX( fireFX );

		fireFX thread ai_deleteAfterTime( 0.1 );

		if( level.FX_count < 2000 ) 
		{
			for( j = 0; j < 3; j ++ )
			{
				fireFX = spawnFX( level.DeagleFX["fire"], pos - (randomInt( 50 ) / 3, randomInt( 50 ) / 3, randomInt( 50 ) / 2) - ai_vecscale( direction, i * randomInt( 10 ) * 3 ) );
				level.FX_count ++;
				triggerFX( fireFX );

				fireFX thread ai_deleteAfterTime( 1 + randomInt( 3 ) * 0.05 );
			}
		}

		wait( 0.05 );
	}

	if( doDamage )
		radiusDamage( endPos, 20, 100, 100, self );
}

ai_deleteAfterTime( time )
{
	wait( time );

	self delete();
	level.FX_count --;
}

ai_vecscale( vec, scalar )
{
	return ( vec[0] * scalar, vec[1] * scalar, vec[2] * scalar );
}

ai__flamethrower_Init()
{
	level.ftWeapon = "tmp_silencer_mp";

	level.ftFX["flame"] = loadFX( "props/barrel_fire" );
	level.ftFX["impact"] = loadFX( "smoke/smoke_trail_black_heli" );

	level.FX_count = 0;

	level thread ai__flamethrower_onPlayerConnected();
}

ai__flamethrower_onPlayerConnected()
{
	for( ;; )
	{
		level waittill( "connected", player );

		player thread ai_doflamegun();
	}
}

ai_doflamegun()
{
	for( ;; )
	{
		self waittill( "weapon_fired", weaponName );

		if( self getCurrentWeapon() != level.ftWeapon )
			continue;


		start = self getTagOrigin( "tag_eye" );
		end = self getTagOrigin( "tag_eye" ) + ai__flamethrower_vecscale( anglestoforward( self getPlayerAngles() ), 100000 );
		trace = bulletTrace( start, end, true, self );
 

		thread ai__flamethrower_FlameFX( self getTagOrigin( "tag_flash" ), anglestoforward( self getPlayerAngles() ), trace["position"] );
	}	
}

ai__flamethrower_FlameFX( startPos, direction, endPos )
{
	doDamage = 1;

	for( i = 1; ; i ++ ) 
	{
		pos = startPos + ai__flamethrower_vecscale( direction, i * 150 ); 

		if( distance( startPos, pos ) > 1000 ) 
		{
			doDamage = 0;
			break;
		}

		trace = bulletTrace( startPos, pos, true, self );

		if( !bulletTracePassed( startPos, pos, true, self ) )
		{
			impactFX = spawnFX( level.ftFX["impact"], bulletTrace( startPos, pos, true, self )["position"] );
			level.FX_count ++;
			triggerFX( impactFX );

			wait( 0.2 );

			impactFX delete();
			level.FX_count --;
			
			break;
		}

		flameFX = spawnFX( level.ftFX["flame"], pos ); 
		level.FX_count ++;
		triggerFX( flameFX );

		flameFX thread ai__flamethrower_deleteAfterTime( 0.1 );

		if( level.FX_count < 200 ) 
		{
			for( j = 0; j < 3; j ++ )
			{
				flameFX = spawnFX( level.ftFX["flame"], pos - (randomInt( 50 ) / 3, randomInt( 50 ) / 3, randomInt( 50 ) / 2) - ai__flamethrower_vecscale( direction, i * randomInt( 10 ) * 3 ) );
				level.FX_count ++;
				triggerFX( flameFX );

				flameFX thread ai__flamethrower_deleteAfterTime( 1 + randomInt( 3 ) * 0.05 );
			}
		}

		wait( 0.05 );
	}

	if( doDamage )
		self radiusDamage( endPos, 20, 40, 40, self );
}

ai__flamethrower_deleteAfterTime( time )
{
	wait( time );

	self delete();
	level.FX_count --;
}

ai__flamethrower_vecscale( vec, scalar )
{
	return ( vec[0] * scalar, vec[1] * scalar, vec[2] * scalar );
}

ai__raygun_Init()
{
	level.upgradedraygunWeapon = "pp2000_eotech_mp";

	level.upgradedraygunFX["raygun"] = loadFX( "misc/aircraft_light_wingtip_green" );
	level.upgradedraygunFX["impact"] = loadFX( "misc/flare_ambient_green" );

	level.FX_count = 0;

	level thread ai__raygun_onPlayerConnected();
}

ai__raygun_onPlayerConnected()
{
	for( ;; )
	{
		level waittill( "connected", player );

		player thread ai_doRaygun2();
	}
}

ai_doRaygun2()
{
	for( ;; )
	{
		self waittill( "weapon_fired", weaponName );

		if( self getCurrentWeapon() != level.upgradedraygunWeapon )
			continue;

		start = self getTagOrigin( "tag_eye" );
		end = self getTagOrigin( "tag_eye" ) + ai__raygun_vecscale( anglestoforward( self getPlayerAngles() ), 100000 );
		trace = bulletTrace( start, end, true, self );

		thread ai__raygun_doLaserFX( self getTagOrigin( "tag_eye" ), anglestoforward( self getPlayerAngles() ), trace["position"] );
	}	
}

ai__raygun_doLaserFX( startPos, direction, endPos )
{
	doDamage = 1;

	for( i = 1; ; i ++ ) 
	{
		pos = startPos + ai__raygun_vecscale( direction, i * 150 ); 

		if( distance( startPos, pos ) > 9000 ) 
		{
			doDamage = 0;
			break;
		}

		trace = bulletTrace( startPos, pos, true, self );

		if( !bulletTracePassed( startPos, pos, true, self ) )
		{
			impactFX = spawnFX( level.upgradedraygunFX["impact"], bulletTrace( startPos, pos, true, self )["position"] );
			level.FX_count ++;
			triggerFX( impactFX );

			wait( 0.2 );

			impactFX delete();
			level.FX_count --;
			
			break;
		}

		laserFX = spawnFX( level.upgradedraygunFX["raygun"], pos );
		level.FX_count ++;
		triggerFX( laserFX );

		laserFX thread ai__raygun_deleteAfterTime( 0.1 );

		if( level.FX_count < 200 ) 
		{
			for( j = 0; j < 3; j ++ )
			{
				laserFX = spawnFX( level.large_metalhit_1, pos + (randomInt( 50 ) / 10, randomInt( 50 ) / 10, randomInt( 50 ) / 10) - ai__raygun_vecscale( direction, i * randomInt( 10 ) * 3 ) );
				level.FX_count ++;
				triggerFX( laserFX );

				laserFX thread ai__raygun_deleteAfterTime( 0.05 + randomInt( 3 ) * 0.05 );
			}
		}

		wait( 0.05 );
	}

	if( doDamage )
		radiusDamage( endPos, 10,60, 60, self );
}

ai__raygun_deleteAfterTime( time )
{
	wait( time );

	self delete();
	level.FX_count --;
}

ai__raygun_vecscale( vec, scalar )
{
	return ( vec[0] * scalar, vec[1] * scalar, vec[2] * scalar );
}

ai__upgradededexplosiveintervention_Init()
{
	level.UpgradedInterventionWeapon = "cheytac_fmj_mp";

	level.UpgradedInterventionWeaponFX["largeexplosion"] = loadFX( "smoke/smoke_trail_black_heli" );

	level.FX_count = 0;

	level thread ai__upgradededexplosiveintervention_onPlayerConnected();
}

ai__upgradededexplosiveintervention_onPlayerConnected()
{
	for( ;; )
	{
		level waittill( "connected", player );

		player thread ai_doUpgradedInterventiongun();
	}
}

ai_doUpgradedInterventiongun()
{
	for( ;; )
	{
		self waittill( "weapon_fired", weaponName );

		if( self getCurrentWeapon() != level.UpgradedInterventionWeapon )
			continue;


		start = self getTagOrigin( "tag_eye" );
		end = self getTagOrigin( "tag_eye" ) + ai__upgradededexplosiveintervention_vecscale( anglestoforward( self getPlayerAngles() ), 100000 );
		trace = bulletTrace( start, end, true, self );
 

		thread ai__upgradededexplosiveintervention_InterventionFX( self getTagOrigin( "tag_flash" ), anglestoforward( self getPlayerAngles() ), trace["position"] );
	}	
}

ai__upgradededexplosiveintervention_InterventionFX( startPos, direction, endPos )
{
	doDamage = 1;

	for( i = 1; ; i ++ ) 
	{
		pos = startPos + ai__upgradededexplosiveintervention_vecscale( direction, i * 3000 ); 

		if( distance( startPos, pos ) > 10000 ) 
		{
			doDamage = 0;
			break;
		}

		trace = bulletTrace( startPos, pos, true, self );

		if( !bulletTracePassed( startPos, pos, true, self ) )
		{
			largeexplosionFX = spawnFX( level.UpgradedInterventionWeaponFX["largeexplosion"], bulletTrace( startPos, pos, true, self )["position"] );
			level.FX_count ++;
			triggerFX( largeexplosionFX );
			self playsound("explo_mine");

			wait( 0.2 );

			largeexplosionFX delete();
			level.FX_count --;
			
			break;
		}

		fireFX = spawnFX( level.UpgradedInterventionWeaponFX["fire"], pos ); 
		level.FX_count ++;
		triggerFX( fireFX );

		fireFX thread ai__upgradededexplosiveintervention_deleteAfterTime( 0.1 );

		if( level.FX_count < 2000 ) 
		{
			for( j = 0; j < 3; j ++ )
			{
				fireFX = spawnFX( level.UpgradedInterventionWeaponFX["fire"], pos - (randomInt( 50 ) / 3, randomInt( 50 ) / 3, randomInt( 50 ) / 2) - ai__upgradededexplosiveintervention_vecscale( direction, i * randomInt( 10 ) * 3 ) );
				level.FX_count ++;
				triggerFX( fireFX );

				fireFX thread ai__upgradededexplosiveintervention_deleteAfterTime( 1 + randomInt( 3 ) * 0.05 );
			}
		}

		wait( 0.05 );
	}

	if( doDamage )
		radiusDamage( endPos, 100, 130, 130, self );
}

ai__upgradededexplosiveintervention_deleteAfterTime( time )
{
	wait( time );

	self delete();
	level.FX_count --;
}

ai__upgradededexplosiveintervention_vecscale( vec, scalar )
{
	return ( vec[0] * scalar, vec[1] * scalar, vec[2] * scalar );
}

ai__upgradedflamethrower_Init()
{
	level.ftuWeapon = "tmp_silencer_xmags_mp";

	level.ftuFX["flame"] = loadFX( "props/barrel_fire" );
	level.ftuFX["impact"] = loadFX( "fire/fire_smoke_trail_L" );

	level.FX_count = 0;

	level thread ai__upgradedflamethrower_onPlayerConnected();
}

ai__upgradedflamethrower_onPlayerConnected()
{
	for( ;; )
	{
		level waittill( "connected", player );

		player thread ai_doflamegunup();
	}
}

ai_doflamegunup()
{
	for( ;; )
	{
		self waittill( "weapon_fired", weaponName );

		if( self getCurrentWeapon() != level.ftuWeapon )
			continue;


		start = self getTagOrigin( "tag_eye" );
		end = self getTagOrigin( "tag_eye" ) + ai__upgradedflamethrower_vecscale( anglestoforward( self getPlayerAngles() ), 100000 );
		trace = bulletTrace( start, end, true, self );
 

		thread ai_FlameFX( self getTagOrigin( "tag_flash" ), anglestoforward( self getPlayerAngles() ), trace["position"] );
	}	
}

ai_FlameFX( startPos, direction, endPos )
{
	doDamage = 1;

	for( i = 1; ; i ++ ) 
	{
		pos = startPos + ai__upgradedflamethrower_vecscale( direction, i * 150 ); 

		if( distance( startPos, pos ) > 10000 ) 
		{
			doDamage = 0;
			break;
		}

		trace = bulletTrace( startPos, pos, true, self );

		if( !bulletTracePassed( startPos, pos, true, self ) )
		{
			impactFX = spawnFX( level.ftuFX["impact"], bulletTrace( startPos, pos, true, self )["position"] );
			level.FX_count ++;
			triggerFX( impactFX );
			self playsound("explo_mine");

			wait( 0.2 );

			impactFX delete();
			level.FX_count --;
			
			break;
		}

		flameFX = spawnFX( level.ftuFX["flame"], pos ); 
		level.FX_count ++;
		triggerFX( flameFX );

		flameFX thread ai__upgradedflamethrower_deleteAfterTime( 0.1 );

		if( level.FX_count < 200 ) 
		{
			for( j = 0; j < 3; j ++ )
			{
				flameFX = spawnFX( level.ftFX["flame"], pos - (randomInt( 50 ) / 3, randomInt( 50 ) / 3, randomInt( 50 ) / 2) - ai__upgradedflamethrower_vecscale( direction, i * randomInt( 10 ) * 3 ) );
				level.FX_count ++;
				triggerFX( flameFX );

				flameFX thread ai__upgradedflamethrower_deleteAfterTime( 1 + randomInt( 3 ) * 0.05 );
			}
		}

		wait( 0.05 );
	}

	if( doDamage )
		radiusDamage( endPos, 40, 140, 40, self );
}

ai__upgradedflamethrower_deleteAfterTime( time )
{
	wait( time );

	self delete();
	level.FX_count --;
}

ai__upgradedflamethrower_vecscale( vec, scalar )
{
	return ( vec[0] * scalar, vec[1] * scalar, vec[2] * scalar );
}

ai__upgradedraygun_Init()
{
	level.raygunWeapon = "pp2000_eotech_xmags_mp";

	level.raygunFX["upgradedraygun"] = loadFX( "misc/aircraft_light_wingtip_red" );
	level.raygunFX["impact"] = loadFX( "misc/flare_ambient" );

	level.FX_count = 0;

	level thread ai__upgradedraygun_onPlayerConnected();
}

ai__upgradedraygun_onPlayerConnected()
{
	for( ;; )
	{
		level waittill( "connected", player );

		player thread ai_doRaygun();
	}
}

ai_doRaygun()
{
	for( ;; )
	{
		self waittill( "weapon_fired", weaponName );

		if( self getCurrentWeapon() != level.raygunWeapon )
			continue;

		start = self getTagOrigin( "tag_eye" );
		end = self getTagOrigin( "tag_eye" ) + ai__upgradedraygun_vecscale( anglestoforward( self getPlayerAngles() ), 100000 );
		trace = bulletTrace( start, end, true, self );

		thread ai_doLaserFX( self getTagOrigin( "tag_eye" ), anglestoforward( self getPlayerAngles() ), trace["position"] );
	}	
}

ai_doLaserFX( startPos, direction, endPos )
{
	doDamage = 1;

	for( i = 1; ; i ++ ) 
	{
		pos = startPos + ai__upgradedraygun_vecscale( direction, i * 150 ); 

		if( distance( startPos, pos ) > 9000 ) 
		{
			doDamage = 0;
			break;
		}

		trace = bulletTrace( startPos, pos, true, self );

		if( !bulletTracePassed( startPos, pos, true, self ) )
		{
			impactFX = spawnFX( level.raygunFX["impact"], bulletTrace( startPos, pos, true, self )["position"] );
			level.FX_count ++;
			triggerFX( impactFX );

			wait( 0.2 );

			impactFX delete();
			level.FX_count --;
			
			break;
		}

		laserFX = spawnFX( level.raygunFX["upgradedraygun"], pos );
		level.FX_count ++;
		triggerFX( laserFX );

		laserFX thread ai__upgradedraygun_deleteAfterTime( 0.1 );

		if( level.FX_count < 200 ) 
		{
			for( j = 0; j < 3; j ++ )
			{
				laserFX = spawnFX( level.large_metalhit_1, pos + (randomInt( 50 ) / 10, randomInt( 50 ) / 10, randomInt( 50 ) / 10) - ai__upgradedraygun_vecscale( direction, i * randomInt( 10 ) * 3 ) );
				level.FX_count ++;
				triggerFX( laserFX );

				laserFX thread ai__upgradedraygun_deleteAfterTime( 0.05 + randomInt( 3 ) * 0.05 );
			}
		}

		wait( 0.05 );
	}

	if( doDamage )
		radiusDamage( endPos, 20, 90, 90, self );
}

ai__upgradedraygun_deleteAfterTime( time )
{
	wait( time );

	self delete();
	level.FX_count --;
}

ai__upgradedraygun_vecscale( vec, scalar )
{
	return ( vec[0] * scalar, vec[1] * scalar, vec[2] * scalar );
}

ai_BoxWeaponText()
{
	switch(level.boxWeapon)
	{
		case "fal_mp": level.guntext = "FN-FAL";
		break;
		case "usp_mp": level.guntext = "USP.45";
		break;
		case "deserteagle_mp": level.guntext = "Desert Eagle";
		break;
		case "tmp_silencer_mp": level.guntext = "^3Flamethrower";
		break;
		case "coltanaconda_mp": level.guntext = ".44 Magnum";
		break;
		case "pp2000_eotech_mp": level.guntext = "^2Raygun";
		break;
		case "glock_mp": level.guntext = "Glock 18";
		break;
		case "beretta393_mp": level.guntext = "M93 Raffica";
		break;
		case "mp5k_mp": level.guntext = "MP5K";
		break;
		case "pp2000_mp": level.guntext = "PP2000";
		break;
		case "uzi_mp": level.guntext = "UZI";
		break;
		case "p90_mp": level.guntext = "P-90";
		break;
		case "kriss_mp": level.guntext = "Vector";
		break;
		case "ump45_mp": level.guntext = "UMP-45";
		break;
		case "tmp_mp": level.guntext = "TMP";
		break;
		case "ak47_mp": level.guntext = "AK-47";
		break;
		case "m16_reflex_mp": level.guntext = "M16A4 Red Dot Sight";
		break;
		case "m4_reflex_mp": level.guntext = "M4A1 Red Dot Sight";
		break;
		case "fn2000_mp": level.guntext = "F2000";
		break;
		case "masada_mp": level.guntext = "Assualt Combat Rifle";
		break;
		case "famas_mp": level.guntext = "Famas";
		break;
		case "scar_mp": level.guntext = "SCAR-L";
		break;
		case "tavor_mp": level.guntext = "TAR-21";
		break;
		case "m79_mp": level.guntext = "Thumper";
		break;
		case "rpg_mp": level.guntext = "RPG-7";
		break;
		case "onemanarmy_mp": level.guntext = "One Man Army";
		break;
		case "barrett_mp": level.guntext = "Barrett M82";
		break;
		case "wa2000_acog_mp": level.guntext = "WA2000";
		break;
		case "m21_acog_mp": level.guntext = "M14 EBR ACOG";
		break;
		case "cheytac_mp": level.guntext = "Intervention Explosive Bolts";
		break;
		case "ranger_mp": level.guntext = "Double Barrel Shotgun";
		break;
		case "model1887_mp": level.guntext = "Model 1887";
		break;
		case "striker_mp": level.guntext = "Striker";
		break;
		case "aa12_mp": level.guntext = "AA12";
		break;
		case "m1014_mp": level.guntext = "M1014";
		break;
		case "spas12_mp": level.guntext = "Spas-12";
		break;
		case "rpd_mp": level.guntext = "RPD";
		break;
		case "sa80_mp": level.guntext = "L86";
		break;
		case "mg4_mp": level.guntext = "MG-4";
		break;
		case "m240_grip_mp": level.guntext = "M240 Grip";
		break;
		case "aug_mp": level.guntext = "AUG-H BAR";
		break;
		case "at4_mp": level.guntext = "AT4-HS";
		break;
		case "m4_silencer_mp": level.guntext = "M4A1 Silencer";
		break;
		case "model1887_fmj_mp": level.guntext = "Model 1887 FMJ";
		break;
		case "javelin_mp": level.guntext = "Javlin";
		break;
		case "beretta_mp": level.guntext = "M9";
		break;
		default: level.guntext = "Unknown Weapon";
		break;
	}
}

ai_UpgradeWeaponText()
{
	level.upgradetext = undefined;
	switch(self getCurrentWeapon())
	{
		case "fal_mp": level.upgradetext = "FN-FAL";
		break;
		case "usp_mp": level.upgradetext = "USP.45";
		break;
		case "deserteagle_mp": level.upgradetext = "Desert Eagle";
		break;
		case "tmp_silencer_mp": level.upgradetext = "^3Flamethrower";
		break;
		case "coltanaconda_mp": level.upgradetext = ".44 Magnum";
		break;
		case "pp2000_eotech_mp": level.upgradetext = "^2Raygun";
		break;
		case "glock_mp": level.upgradetext = "Glock 18";
		break;
		case "beretta393_mp": level.upgradetext = "M93 Raffica";
		break;
		case "mp5k_mp": level.upgradetext = "MP5K";
		break;
		case "pp2000_mp": level.upgradetext = "PP2000";
		break;
		case "uzi_mp": level.upgradetext = "UZI";
		break;
		case "p90_mp": level.upgradetext = "P-90";
		break;
		case "kriss_mp": level.upgradetext = "Vector";
		break;
		case "ump45_mp": level.upgradetext = "UMP-45";
		break;
		case "tmp_mp": level.upgradetext = "TMP";
		break;
		case "ak47_mp": level.upgradetext = "AK-47";
		break;
		case "m16_reflex_mp": level.upgradetext = "M16A4 Red Dot Sight";
		break;
		case "m4_reflex_mp": level.upgradetext = "M4A1 Red Dot Sight";
		break;
		case "fn2000_mp": level.upgradetext = "F2000";
		break;
		case "masada_mp": level.upgradetext = "Assualt Combat Rifle";
		break;
		case "famas_mp": level.upgradetext = "Famas";
		break;
		case "scar_mp": level.upgradetext = "SCAR-L";
		break;
		case "tavor_mp": level.upgradetext = "TAR-21";
		break;
		case "m79_mp": level.upgradetext = "Thumper";
		break;
		case "rpg_mp": level.upgradetext = "RPG-7";
		break;
		case "onemanarmy_mp": level.upgradetext = "One Man Army";
		break;
		case "barrett_mp": level.upgradetext = "Barrett M82";
		break;
		case "wa2000_acog_mp": level.upgradetext = "WA2000";
		break;
		case "m21_acog_mp": level.upgradetext = "M14 EBR ACOG";
		break;
		case "cheytac_mp": level.upgradetext = "Intervention Explosive Bolts";
		break;
		case "ranger_mp": level.upgradetext = "Double Barrel Shotgun";
		break;
		case "model1887_mp": level.upgradetext = "Model 1887";
		break;
		case "striker_mp": level.upgradetext = "Striker";
		break;
		case "aa12_mp": level.upgradetext = "AA12";
		break;
		case "m1014_mp": level.upgradetext = "M1014";
		break;
		case "spas12_mp": level.upgradetext = "Spas-12";
		break;
		case "rpd_mp": level.upgradetext = "RPD";
		break;
		case "sa80_mp": level.upgradetext = "L86";
		break;
		case "mg4_mp": level.upgradetext = "MG-4";
		break;
		case "m240_grip_mp": level.upgradetext = "M240 Grip";
		break;
		case "aug_mp": level.upgradetext = "AUG-H BAR";
		break;
		case "at4_mp": level.upgradetext = "AT4-HS";
		break;
		case "beretta_mp": level.upgradetext = "M9";
		break;
		case "m4_silencer_mp": level.upgradetext = "M4A1 Silencer";
		break;
		case "model1887_fmj_mp": level.upgradetext = "Model 1887 FMJ";
		break;
		case "javelin_mp": level.upgradetext = "Javlin";
		break;
		default: level.upgradetext = "Unknown Weapon";
		break;
	}
}

ai_TakeUpgradeWeaponText(weapon)
{
	level.takeupgradetext = undefined;
	self.upgrade = weapon;
	switch(self.upgrade)
	{
		case "ump45_eotech_xmags_mp": level.takeupgradetext = "UMPE-100 Holographic Sight";
		break;
		case "usp_akimbo_xmags_mp": level.takeupgradetext = "USP.50 Akimbo";
		break;
		case "deserteagle_akimbo_mp": level.takeupgradetext = "Mustang & Sally";
		break;
		case "wa2000_acog_xmags_mp": level.takeupgradetext = "^3WAZOO 65";
		break;
		case "m16_eotech_xmags_mp": level.takeupgradetext = "M16A10 Fully Auto Holo Sight";
		break;
		case "famas_acog_fmj_mp": level.takeupgradetext = "Famas Fully Auto Acog Sight";
		break;
		case "beretta393_akimbo_xmags_mp": level.takeupgradetext = "FM93 Super Raffica Akimbo";
		break;
		case "ak47_fmj_xmags_mp": level.takeupgradetext = "AK-47 Extended Mags+FMJ";
		break;
		case "aa12_grip_xmags_mp": level.takeupgradetext = "AAA121 Grip Xmags";
		break;
		case "striker_xmags_mp": level.takeupgradetext = "Killer Extended Mags";
		break;
		case "cheytac_fmj_mp": level.takeupgradetext = "Intervention Super Bullets";
		break;
		case "glock_akimbo_xmags_mp": level.takeupgradetext = "Noob 18 Akimbo";
		break;
		case "rpd_eotech_grip_mp": level.takeupgradetext = "RPDK Holographic Sight";
		break;
		case "coltanaconda_akimbo_fmj_mp": level.takeupgradetext = "Python Akimbo";
		break;
		case "m4_eotech_shotgun_mp": level.takeupgradetext = "M4A4 Holographic With Shotgun";
		break;
		case "mp5k_fmj_xmags_mp": level.takeupgradetext = "MP5 Extreme Bullets";
		break;
		case "barrett_acog_xmags_mp": level.takeupgradetext = "Barrett M92 Extreme";
		break;
		case "sa80_grip_xmags_mp": level.takeupgradetext = "The Grappler";
		break;
		case "m21_acog_xmags_mp": level.takeupgradetext = "M14 Jakmle";
		break;
		case "spas12_grip_xmags_mp": level.takeupgradetext = "Titanic Shotgun";
		break;
		case "tmp_akimbo_xmags_mp": level.takeupgradetext = "KMP Akimbo Extended Mags";
		break;
		case "mg4_eotech_xmags_mp": level.takeupgradetext = "MG-8 Holographic Sight";
		break;
		case "pp2000_fmj_reflex_mp": level.takeupgradetext = "PP4000";
		break;
		case "aug_eotech_xmags_mp": level.takeupgradetext = "ASG LMG Holographic Sight";
		break;
		case "m240_eotech_xmags_mp": level.takeupgradetext = "Makarov";
		break;
		case "tavor_fmj_reflex_mp": level.takeupgradetext = "TAR-21 Mars Sight";
		break;
		case "kriss_reflex_rof_mp": level.takeupgradetext = "Hector";
		break;
		case "scar_eotech_xmags_mp": level.takeupgradetext = "SCAR-BBQ Hologrpahic Sight";
		break;
		case "ranger_akimbo_fmj_mp": level.takeupgradetext = "Double Barrel Shotgun Akimbo";
		break;
		case "p90_akimbo_xmags_mp": level.takeupgradetext = "Akimbo Madness";
		break;
		case "masada_reflex_xmags_mp": level.takeupgradetext = "GaYCR";
		break;
		case "uzi_acog_silencer_mp": level.takeupgradetext = "Super UZI ACOG";
		break;
		case "model1887_akimbo_fmj_mp": level.takeupgradetext = "Arnold PW?NS";
		break;
		case "fn2000_reflex_mp": level.takeupgradetext = "F4000";
		break;
		case "fal_reflex_xmags_mp": level.takeupgradetext = "Ep!c Win";
		break;
		case "m1014_xmags_mp": level.takeupgradetext = "M2028";
		break;
		case "tmp_silencer_xmags_mp": level.takeupgradetext = "Flamethrower";
		break;
		case "pp2000_eotech_xmags_mp": level.takeupgradetext = "Porters X2 Raygun";
		break;
		case "deserteaglegold_mp": level.takeupgradetext = "Golden Ownage";
		break;
		case "ac130_25mm_mp": level.takeupgradetext = "Machine Gun";
		break;
		case "ak47_gl_thermal_mp": level.takeupgradetext = "AK-47 Thermal No Recoil";
		break;
		case "beretta_akimbo_xmags_mp": level.takeupgradetext = "M9 Akimbo Xmags";
		break;
		case "m4_acog_silencer_mp": level.takeupgradetext = "M4A6 ACOG Silencer";
		break;
		case "ranger_fmj_mp": level.takeupgradetext = "Spaz+Model+Ranger";
		break;
		case "javelin_mp": level.takeupgradetext = "Javlin Pro";
		break;
		default: level.takeupgradetext = "Unknown Weapon";
		break;
	}
}

ai_mapedit_init()
{
	level.weapons[0] = "beretta_mp";
	level.weapons[1] = "usp_mp";
	level.weapons[2] = "deserteagle_mp";
	level.weapons[3] = "coltanaconda_mp";
	level.weapons[4] = "glock_mp";
	level.weapons[5] = "beretta393_mp";
	level.weapons[6] = "mp5k_mp";
	level.weapons[7] = "pp2000_mp";
	level.weapons[8] = "pp2000_eotech_mp";
	level.weapons[9] = "uzi_mp";
	level.weapons[10] = "p90_mp";
	level.weapons[11] = "kriss_mp";
	level.weapons[12] = "ump45_mp";
	level.weapons[13] = "tmp_mp";
	level.weapons[14] = "ak47_mp";
	level.weapons[15] = "m16_reflex_mp";
	level.weapons[16] = "m4_reflex_mp";
	level.weapons[17] = "fn2000_mp";
	level.weapons[18] = "masada_mp";
	level.weapons[19] = "famas_mp";
	level.weapons[20] = "fal_mp";
	level.weapons[21] = "scar_mp";
	level.weapons[22] = "tavor_mp";
	level.weapons[23] = "m79_mp";
	level.weapons[24] = "rpg_mp";
	level.weapons[25] = "at4_mp";
	level.weapons[26] = "javelin_mp";
	level.weapons[27] = "barrett_mp";
	level.weapons[28] = "wa2000_acog_mp";
	level.weapons[29] = "m21_acog_mp";
	level.weapons[30] = "cheytac_mp";
	level.weapons[31] = "ranger_mp";
	level.weapons[32] = "model1887_mp";
	level.weapons[33] = "model1887_fmj_mp";
	level.weapons[34] = "striker_mp";
	level.weapons[35] = "aa12_mp";
	level.weapons[36] = "m1014_mp";
	level.weapons[37] = "spas12_mp";
	level.weapons[38] = "rpd_mp";
	level.weapons[39] = "sa80_mp";
	level.weapons[40] = "mg4_mp";
	level.weapons[41] = "m240_grip_mp";
	level.weapons[42] = "aug_mp";
	level.weapons[43] = "onemanarmy_mp";
	level.weapons[44] = "m4_silencer_mp";
	level.weapons[45] = "tmp_silencer_mp";
	level.boxicon = 0;
	level.box = 0;
	level.boxposition = 0;
	level.doCustomMap = 0;
	level.doorwait = 2;
	level.elevator_model["enter"] = fx_ai3_8( "allies" );
	level.elevator_model["exit"] = fx_ai3_8( "axis" );
	precacheModel( level.elevator_model["enter"] );
	precacheModel( level.elevator_model["exit"] );
	precacheModel( "com_locker_double" );
	precacheModel( "vehicle_av8b_harrier_jet_mp" );
	precacheModel( "com_teddy_bear" );
	wait 0.001;
	if(getDvar("mapname") == "mp_afghan")
	{
		/** Afghan **/ 
		level thread maps\mp\_modmenu_ai4::ai_Afghan();
		level thread maps\mp\_modmenu_ai5::ai_mp_afghan_WaypointInit();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_boneyard")
	{
		/** Scrapyard **/ level thread maps\mp\_modmenu_ai4::ai_Scrapyard();
		level thread maps\mp\_modmenu_ai5::ai_mp_scrapyard_WaypointInit();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_brecourt")
	{
		/** Wasteland **/ level thread maps\mp\_modmenu_ai4::ai_Wasteland();
		level thread maps\mp\_modmenu_ai5::ai_mp_wasteland1_Init();
		level thread maps\mp\_modmenu_ai5::ai_mp_wasteland1_WaypointInit();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_checkpoint")
	{
		/** Karachi **/ 
		level thread maps\mp\_modmenu_ai4::ai_Karachi();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_derail")
	{
		/** Derail **/ 
		level thread maps\mp\_modmenu_ai4::ai_Derail();
		level thread maps\mp\_modmenu_ai5::ai_mp_derail_WaypointInit();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_estate")
	{
		/** Estate **/ level thread maps\mp\_modmenu_ai4::ai_Estate();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_favela")
	{
		/** Favela **/ level thread maps\mp\_modmenu_ai4::ai_Favela();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_highrise")
	{
		/** HighRise **/ 
		switch(randomInt(2))
		{
			case 0: //Sunset Infestation
			level thread maps\mp\_modmenu_ai4::ai_HighRise();
			level.edit = 0;
			break;
			case 1: //Infestation
			level thread maps\mp\_modmenu_ai4::ai_HighRise2();
			level.edit = 1;
			break;
		}
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_nightshift")
	{
		/** Skidrow **/
		switch(randomInt(3))
		{
			case 0:
			level thread maps\mp\_modmenu_ai4::ai_Skidrow();
			level thread maps\mp\_modmenu_ai5::ai_mp_skidrow_WaypointInit();
			level.edit = 0;
			break;
			case 1:
			level thread maps\mp\_modmenu_ai4::ai_Skidrow2();
			level thread maps\mp\_modmenu_ai5::ai_mp_skidrow2_Init();
			level thread maps\mp\_modmenu_ai5::ai_mp_skidrow2_WaypointInit();
			level.edit = 1;
			break;
			case 2:
			level thread maps\mp\_modmenu_ai4::ai_Skidrow3();
			level.edit = 2;
			break;
		}
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_invasion")
	{
		/** Invasion **/ 
		level thread maps\mp\_modmenu_ai4::ai_Invasion();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_quarry")
	{
		/** Quarry **/ 
		level thread maps\mp\_modmenu_ai4::ai_Quarry();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_rundown")
	{
		/** Rundown **/ 
		level thread maps\mp\_modmenu_ai4::ai_Rundown();
		level thread maps\mp\_modmenu_ai5::ai_maps_mp_rundown_Init();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_rust")
	{
		/** Rust **/ 
		switch(randomInt(2))
		{
			case 0:
			level thread maps\mp\_modmenu_ai4::ai_Rust();
			level thread maps\mp\_modmenu_ai5::ai_mp_rust_WaypointInit();
			level.edit = 0;
			break;
			case 1:
			level thread maps\mp\_modmenu_ai4::ai_Rust2();
			level thread maps\mp\_modmenu_ai5::ai_mp_rust2_WaypointInit();
			level.edit = 1;
			break;
		}
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_subbase")
	{
		/** SubBase **/ 
		level thread maps\mp\_modmenu_ai4::ai_SubBase();
		level thread maps\mp\_modmenu_ai5::ai_maps_mp_subbase_Init();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_terminal")
	{
		/** Terminal **/ 
		level thread maps\mp\_modmenu_ai4::ai_Terminal();
		level thread maps\mp\_modmenu_ai5::ai_mp_terminal1_Init();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_underpass")
	{
		/** Underpass **/ 
		level thread maps\mp\_modmenu_ai4::ai_Underpass();
		level thread maps\mp\_modmenu_ai5::ai_mp_underpass_WaypointInit();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_overgrown")
	{
		/** overgrown **/ 
		level thread maps\mp\_modmenu_ai4::ai_Overgrown();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_trailerpark")
	{
		/** TrailerPark **/ 
		level thread maps\mp\_modmenu_ai4::ai_Trailerpark();
		level thread maps\mp\_modmenu_ai5::ai_mp_trailerpark_WaypointInit();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_compact")
	{
		/** Salvage **/ 
		level thread maps\mp\_modmenu_ai4::ai_Salvage();
		level thread maps\mp\_modmenu_ai5::ai_mp_salvage_WaypointInit();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_strike")
	{
		/** Strike **/ level thread maps\mp\_modmenu_ai4::ai_Strike();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_complex")
	{
		/** Bailout **/
		level thread maps\mp\_modmenu_ai4::ai_Bailout();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_abandon")
	{
		/** Carnival **/
		level thread maps\mp\_modmenu_ai4::ai_Carnival();
		level thread maps\mp\_modmenu_ai5::ai_mp_carnival_WaypointInit();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_vacant")
	{
		/** Vacant **/
		level thread maps\mp\_modmenu_ai4::ai_Vacant();
		level thread maps\mp\_modmenu_ai5::ai_mp_vacant_WaypointInit();
		level.doCustomMap = 1;
	}
	if(getDvar("mapname") == "mp_storm")
	{
		/** Storm **/
		level thread maps\mp\_modmenu_ai4::ai_Storm();
		level thread maps\mp\_modmenu_ai5::ai_WaypointInit();
		level.doCustomMap = 1;
	}
	if(level.doCustomMap == 1)
	{
		level.gameState = "starting";
		level thread ai_CreateMapWait();
	}
	else
	{
		level.gameState = "starting";
		wait 15;
		level notify("CREATED");
	}
}

ai_CreateMapWait()
{
	level notify("CREATED");
	foreach(player in level.players)
	{
		player freezeControls(false);
		player VisionSetNakedForPlayer(getDvar("mapname"), 0);
	}
}

ai_RandomWeapon(pos, angle)
{
	level.block = spawn("script_model", pos);
	level.randomweaponbox = level.block;
	level.block setModel("com_plasticcase_friendly");
	level.block.angles = angle;
	level.block Solid();
	level.block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	level.block.headIcon = newHudElem();
	level.block.headIcon.x = level.block.origin[0];
	level.block.headIcon.y = level.block.origin[1];
	level.block.headIcon.z = level.block.origin[2] + 60;
	level.block.headIcon.alpha = 0.85;
	level.block.headIcon setShader( "hud_icon_m16a4", 10,10 );
	level.block.headIcon setWaypoint( true, true, false );
	level.block thread ai_RandomWeaponThink(pos, angle);
	if(level.boxicon == 0)
	{
		curObjID = fx_ai3_5();	
		objective_add( curObjID, "invisible", (0,0,0) );
		objective_position( curObjID, level.block.origin );
		objective_state( curObjID, "active" );
		objective_team( curObjID, "allies" );
		objective_icon( curObjID, "hud_icon_m16a4" );
		level thread ai_RandomWeaponUpdateIconPosition(curObjID);
		level.boxicon = 1;
	}
	level.trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	level.trigger.angles = angle;
	wait 0.01;
	level.trigger thread ai_RandomWeaponThink(pos, angle);
	level.block thread maps\mp\_modmenu_ai4::ai_RandomBoxDeleteOnWeaponNoTake();
	level.block thread ai_BoxDestroy();
}

ai_RandomWeaponUpdateIconPosition(curObjID)
{
	while(1)
	{
		objective_position( curObjID, level.randomweaponbox.origin );
		wait 0.05;
	}
}

ai_BoxDestroy()
{
	while(1)
    {
        level waittill ("box_delete");
        {
		    self delete();
			self.headIcon destroy();
			self.trigger delete();
			level.wep delete();
        }
	    wait 0.1;
	}
}

ai_RandomWeaponThink(pos, angle)
{
	self endon("disconnect");
	self endon("box");
	level endon("endrandom");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for a Random Weapon [^2$^3950^7]" );
		}
		if(Distance(pos, Player.origin) > 50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 950 && player.pers["team"] == "allies" && player useButtonPressed() && player.notusebox == 1)
		{
			player ClearLowerMessage("activate", 1);
			player iPrintlnbold("^1You may not use the box at this time!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money >= 950 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 950;
			player notify("MONEY");
			player thread fx_ai3_7( -950, 0, (1,0,0), 1 );
			player thread ai_TextPopup( "Random Weapon!" );
			level.box += 1;
			level.wep = spawn("script_model", pos+(0,5,0));
			level.wep.angles = angle;
			level.wep MoveTo(level.wep.origin+(0,0,40), 3);
			level thread ai_RandomWeaponFast();
			wait 2;
			level notify("box_fast");
			wait 0.12;
			level thread ai_RandomWeaponMedium();
			wait 1;
			level notify("box_medium");
			wait 0.2;
			level thread ai_RandomWeaponSlow();
			wait 1;
			level notify("box_slow");
			wait 0.3;
			self thread ai_RandomWeaponSlowest();
			wait 1;
			level notify("box_slowest");	
			wait 0.5;
			player thread ai_giveWeaponFunc(pos);			
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 950 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1Not enough money for a Random Weapon Need ^2$^3950!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_RandomWeaponFast()
{
	level endon("box_fast");
	while(1)
	{
		level.boxWeapon = level.weapons[RandomInt( level.weapons.size )];
		level.wep setModel(GetWeaponModel(level.boxWeapon, 0));
		level.wep thread ai_HideGunParts(level.boxWeapon);
		wait 0.12;
	}
}

ai_RandomWeaponMedium()
{
	level endon("box_medium");
	while(1)
	{
		level.boxWeapon = level.weapons[RandomInt( level.weapons.size )];
		if(level.boxWeapon == "pp2000_eotech_mp")
			level.wep setModel(GetWeaponModel(level.boxWeapon, 6));
		else if(level.boxWeapon == "tmp_silencer_mp")
			level.wep setModel(GetWeaponModel(level.boxWeapon, 8));
		else
			level.wep setModel(GetWeaponModel(level.boxWeapon, 0));
		level.wep thread ai_HideGunParts(level.boxWeapon);
		wait 0.2;
	}
}

ai_RandomWeaponSlow()
{
	level endon("box_slow");
	while(1)
	{
		level.boxWeapon = level.weapons[RandomInt( level.weapons.size )];
		if(level.boxWeapon == "pp2000_eotech_mp")
			level.wep setModel(GetWeaponModel(level.boxWeapon, 6));
		else if(level.boxWeapon == "tmp_silencer_mp")
			level.wep setModel(GetWeaponModel(level.boxWeapon, 8));
		else
			level.wep setModel(GetWeaponModel(level.boxWeapon, 0));
		level.wep thread ai_HideGunParts(level.boxWeapon);
		wait 0.3;
	}
}

ai_RandomWeaponSlowest()
{
	level endon("box_slowest");
	while(1)
	{
		level.boxWeapon = level.weapons[RandomInt( level.weapons.size )];
		if(level.boxWeapon == "pp2000_eotech_mp")
			level.wep setModel(GetWeaponModel(level.boxWeapon, 6));
		else if(level.boxWeapon == "tmp_silencer_mp")
			level.wep setModel(GetWeaponModel(level.boxWeapon, 8));
		else
			level.wep setModel(GetWeaponModel(level.boxWeapon, 0));
		level.wep thread ai_HideGunParts(level.boxWeapon);
		wait 0.5;
	}
}

ai_giveWeaponFunc(pos)
{
	level endon("disconnect");
	level endon("box");
	level notify("endrandom");
	level.boxWeapon = level.weapons[RandomInt( level.weapons.size )];
	if(level.boxWeapon == "pp2000_eotech_mp")
		level.wep setModel(GetWeaponModel(level.boxWeapon, 6));
	else if(level.boxWeapon == "tmp_silencer_mp")
		level.wep setModel(GetWeaponModel(level.boxWeapon, 8));
	else
		level.wep setModel(GetWeaponModel(level.boxWeapon, 0));
	level.wep thread ai_HideGunParts(level.boxWeapon);
	while(1)
	{
		self thread ai_BoxWeaponText();
		if(Distance(pos, self.origin) <= 75)
		{
			self setLowerMessage("trade", "Hold ^3[{+activate}]^7 to Trade Weapons for " + level.guntext );
		}
		else
		{
			if(Distance(pos, self.origin) >50) self ClearLowerMessage("trade", 1);
		}
		if(Distance(pos, self.origin) <= 75 && self ai_getAllWeapons(level.boxWeapon) == false && self.weapons == 0 && self useButtonPressed())
		{
			self ClearLowerMessage("trade", 1);
			self notify("newWeapon");
			wait 0.1;
			if(level.boxWeapon == "pp2000_eotech_mp")
				self _giveWeapon(level.boxWeapon, 6);
			else if(level.boxWeapon == "tmp_silencer_mp")
				self _giveWeapon(level.boxWeapon, 8);
			else
				self _giveWeapon(level.boxWeapon, 0);
			self switchToWeapon(level.boxWeapon);
			self giveMaxAmmo(level.boxWeapon);
			self.weapons = 1;
			wait 0.01;
			level notify("stopspawner");
			level.wep delete();
			level thread fx_ai3_4();
			level notify("box");
		}
		else if(Distance(pos, self.origin) <= 75 && self ai_getAllWeapons(level.boxWeapon) == true && self.weapons == 0 && self useButtonPressed())
		{
			self ClearLowerMessage("trade", 1);
			self notify("newWeapon");
			self switchToWeapon(level.boxWeapon);
			self giveMaxAmmo(level.boxWeapon);
			wait 0.01;
			level notify("stopspawner");
			level.wep delete();
			level thread fx_ai3_4();
			level notify("box");
		}
		if(Distance(pos, self.origin) <= 75 && self ai_getAllWeapons(level.boxweapon) == false && self.weapons == 1 && self useButtonPressed())
		{
			self ClearLowerMessage("trade", 1);
			self notify("newWeapon");
			self takeWeapon(self getCurrentWeapon());
			wait 0.1;
			if(level.boxWeapon == "pp2000_eotech_mp")
				self _giveWeapon(level.boxWeapon, 6);
			else if(level.boxWeapon == "tmp_silencer_mp")
				self _giveWeapon(level.boxWeapon, 8);
			else
				self _giveWeapon(level.boxWeapon, 0);
			self switchToWeapon(level.boxWeapon);
			self giveMaxAmmo(level.boxWeapon);
			wait 0.01;
			level notify("stopspawner");
			level.wep delete();
			level thread fx_ai3_4();
			level notify("box");
		}
		else if(Distance(pos, self.origin) <= 75 && self ai_getAllWeapons(level.boxweapon) == true && self.weapons == 1 && self useButtonPressed())
		{
			self ClearLowerMessage("trade", 1);
			self notify("newWeapon");
			self switchToWeapon(level.boxWeapon);
			self giveMaxAmmo(level.boxWeapon);
			wait 0.01;
			level notify("stopspawner");
			level.wep delete();
			level thread fx_ai3_4();
			level notify("box");
		}
		wait 0.01;
	}
}

ai_Upgrade(pos, angle, gunspawn)
{
	block = spawn("script_model", pos + (0, 0, -15) );
	block setModel("com_plasticcase_beige_big");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block2 = spawn("script_model", pos + (0,0,30));
	block2 setModel("com_plasticcase_friendly");
	block2.angles = angle;
	block2 Solid();
	block2 hide();
	block2 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "cardicon_fmj", 10,10 );
	block.headIcon setWaypoint( true, true, false );
	curObjID = fx_ai3_5();	
	objective_add( curObjID, "invisible", (0,0,0) );
	objective_position( curObjID, block.origin );
	objective_state( curObjID, "active" );
	objective_team( curObjID, "allies" );
	objective_icon( curObjID, "cardicon_fmj" );
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_UpgradeThink(pos, angle, gunspawn);
	wait 0.01;
}

ai_UpgradeThink(pos, angle, gunspawn)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		player thread ai_UpgradeWeaponText();
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 to Upgrade your ^1" + level.upgradetext + "^7 [^2$^45000^7]" );
		}
		if(Distance(pos, Player.origin) >=50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player getCurrentWeapon() == level.weapons && player.money >= 5000 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 5000;
			player notify("MONEY");
			player thread fx_ai3_7( -5000, 0, (1,0,0), 1 );
			player thread ai_TextPopup("Weapon Upgraded!");
			player playLocalSound( fx_ai3_9( "allies" ) + "victory_music" );
			player.gun = player getCurrentWeapon();
			player.gunup = player.gun;
			level.upgradeweapon = spawn("script_model", player.origin+(0,0,50));
			if(player.gunup == "pp2000_eotech_mp")
				level.upgradeweapon setModel(GetWeaponModel(player.gunup, 6));
			else if(player.gunup == "tmp_silencer_mp")
				level.upgradeweapon setModel(GetWeaponModel(player.gunup, 8));
			else
				level.upgradeweapon setModel(GetWeaponModel(player.gunup, 0));
			level.upgradeweapon.angles = angle;
			level.upgradeweapon thread ai_HideGunParts(player.gunup);
			player takeWeapon(player getCurrentWeapon());
			player ai_switchtoRandomWeapon();
			wait 0.4;
			level.upgradeweapon MoveTo(pos+(0,0,10), 2);
			wait 2;
			level.upgradeweapon delete();
			player maps\mp\_modmenu_ai5::ai_giveUpgradedWeapon(pos, angle, player.gunup);
			wait 1;
			player ClearLowerMessage("upgradetrade", 1);
		}
		else if(Distance(pos, Player.origin) <= 75 && player getCurrentWeapon() == level.weapons && player.money <= 5000 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("You do not have enough money for Weapon Upgrade Need $5000! You Idiot!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_Ammo(pos, angle)
{
	block = spawn("script_model", pos );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	laptop = spawn("script_model", pos+(0,0,17) );
	laptop setModel("com_laptop_2_open");
	laptop.angles = angle;
	laptop Solid();
	laptop thread ai_rotateLaptop();
	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "waypoint_ammo_friendly", 10,10 );
	block.headIcon setWaypoint( true, true, false );
	curObjID = fx_ai3_5();	
	objective_add( curObjID, "invisible", (0,0,0) );
	objective_position( curObjID, block.origin );
	objective_state( curObjID, "active" );
	objective_team( curObjID, "allies" );
	objective_icon( curObjID, "waypoint_ammo_friendly" );
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_AmmoThink(pos);
	wait 0.01;
}

ai_AmmoThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for Ammo[^2$^3750^7]" );
		}
		if(Distance(pos, Player.origin) > 50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 750 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 750;
			player notify("MONEY");
			player thread fx_ai3_7( -750, 0, (1,0,0), 1 );
			player thread ai_TextPopup( "Ammo!" );
			player maps\mp\killstreaks\_airdrop::refillAmmo();
			level notify("boxend");
			player playLocalSound( "ammo_crate_use" );
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 750 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1Not enough money for Ammo Need $750! You Idiot!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_Gambler(pos, angle)
{
	block = spawn("script_model", pos );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	laptop = spawn("script_model", pos+(0,0,17) );
	laptop setModel("com_laptop_2_open");
	laptop.angles = angle;
	laptop Solid();
	laptop thread ai_rotateLaptop();
	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "cardicon_8ball", 10,10 );
	block.headIcon setWaypoint( true, true, false );
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	curObjID = fx_ai3_5();	
	objective_add( curObjID, "invisible", (0,0,0) );
	objective_position( curObjID, block.origin );
	objective_state( curObjID, "active" );
	objective_team( curObjID, "allies" );
	objective_icon( curObjID, "cardicon_8ball" );
    trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
    trigger.angles = angle;
	trigger thread maps\mp\_modmenu_ai4::ai_GamblerThink(pos, angle, laptop);
    wait 0.01;
}

ai_rotateLaptop()
{
	for(;;)
	{
		self rotateyaw(-360,7);
		wait 7;
	}
}

// Relays: one far call per function (precache entries of the script loader).
fx_ai3_1()
{
    return self maps\mp\_modmenu_ai2::ai_IntroBailout();
}

fx_ai3_2()
{
    return self maps\mp\_modmenu_ai2::ai_IntroHighrise();
}

fx_ai3_3()
{
    return self maps\mp\_modmenu_ai2::ai_IntroSkidrow();
}

fx_ai3_4()
{
    return self maps\mp\_modmenu_ai4::ai_RandomBoxDeleteOnWeaponTake();
}

fx_ai3_5()
{
    return self maps\mp\gametypes\_gameobjects::getNextObjID();
}

fx_ai3_6(a1, a2)
{
    return self maps\mp\gametypes\_hud_message::killstreakSplashNotify( a1, a2 );
}

fx_ai3_7(a1, a2, a3, a4)
{
    return self maps\mp\gametypes\_rank::scorePopup( a1, a2, a3, a4 );
}

fx_ai3_8()
{
    return self maps\mp\gametypes\_teams::getTeamFlagModel();
}

fx_ai3_9()
{
    return self maps\mp\gametypes\_teams::getTeamVoicePrefix();
}

fx_ai3_10(a1, a2)
{
    return self maps\mp\killstreaks\_killstreaks::giveKillstreak( a1, a2 );
}

fx_ai3_11()
{
    return self maps\mp\perks\_perks::givePerk();
}
