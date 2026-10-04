// AI Zombies eXtreme V1.8 ([115]Death) -- the patch's own functions from maps/mp/gametypes/mapedit.gsc, maps/mp/gametypes/solidstuff.gsc,
// renamed ai_* and called by maps\mp\_modmenu_ai.gsc.
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ai_GamblerThink(pos, angle, laptop)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for Gambler [^2$^31000^7]" );
		}
		if(Distance(pos, Player.origin) >= 50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 1000 && player.gambler == 0 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 1000;
			player notify("MONEY");
			player thread fx_ai4_13( -1000, 0, (1,0,0), 1 );
			player thread fx_ai4_9( "Gambler!" );
			player.gambler = 1;
			laptop MoveTo(laptop.origin+(0,0,30), 2);
			player iPrintlnBold(" ^2Your results will show in 10 seconds");
			wait 1.0;
			player iPrintlnBold(" ^29");
			wait 1.0;
			player iPrintlnBold(" ^28");
			wait 1.0;
			player iPrintlnBold(" ^27");
			wait 1.0;
			player iPrintlnBold(" ^26");
			wait 1.0;
			player iPrintlnBold(" ^25");
			wait 1.0;
			player iPrintlnBold(" ^24");
			wait 1.0;
			player iPrintlnBold(" ^23");
			wait 1.0;
			laptop MoveTo(laptop.origin-(0,0,30), 2);
			player iPrintlnBold(" ^22");
			wait 1.0;
			player iPrintlnBold(" ^21");
			wait 1.0;
			player thread ai_MoneyGambler();
			level notify("boxend");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 1000 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1Not enough money for Gambler Need $1000! You Idiot!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money >= 1000 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1You may only use the gambler once per round!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_SpeedReload(pos, angle)
{
	block = spawn("script_model", pos+(0,0,50) );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block moveto(pos,3);
	curObjID = fx_ai4_11();	
	objective_add( curObjID, "invisible", (0,0,0) );
	objective_position( curObjID, block.origin );
	objective_state( curObjID, "active" );
	objective_team( curObjID, "allies" );
	objective_icon( curObjID, "specialty_fastreload_upgrade" );
    trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
    trigger.angles = angle;
	trigger thread ai_SpeedReloadThink(pos);
    wait 0.01;
}

ai_SpeedReloadThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for Speed Cola [^2$^33000^7]" );
		}
		if(Distance(pos, Player.origin) >50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 3000 && player.pers["team"] == "allies" && player.speedreload == 0 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 3000;
			player notify("MONEY");
			player thread fx_ai4_13( -3000, 0, (1,0,0), 1 );
			player thread fx_ai4_9( "Speed Reload!" );
			player _setPerk("specialty_fastreload");
			player _setPerk("specialty_quickdraw");
			player.speedreload = 1;
			player.zombieperks += 1;
			wait 0.1;
			player thread ai_PerkHud( "specialty_fastreload_upgrade" );
			level notify("boxend");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 3000 && player.speedreload == 0 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1Not enough money for Speed Cola Need $3000! You Idiot!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money >= 0 && player.speedreload == 1 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1You have already bought Speed Cola!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_SteadyAim(pos, angle)
{
	block = spawn("script_model", pos+(0,0,50) );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block moveto(pos,3);
	curObjID = fx_ai4_11();	
	objective_add( curObjID, "invisible", (0,0,0) );
	objective_position( curObjID, block.origin );
	objective_state( curObjID, "active" );
	objective_team( curObjID, "allies" );
	objective_icon( curObjID, "specialty_steadyaim_upgrade" );
    trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
    trigger.angles = angle;
	trigger thread ai_SteadyAimThink(pos);
    wait 0.01;
}

ai_SteadyAimThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for Steady Aim [^2$^32000^7]" );
		}
		if(Distance(pos, Player.origin) >50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 2000 && player.pers["team"] == "allies" && player.steadyaim == 0 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 2000;
			player notify("MONEY");
			player thread fx_ai4_13( -2000, 0, (1,0,0), 1 );
			player thread fx_ai4_9( "Steady Aim!" );
			player _setPerk("specialty_bulletaccuracy");
			player _setPerk("specialty_steelnerves");
			player.steadyaim = 1;
			player setClientDvar("ui_drawCrosshair", 1);
			player.zombieperks += 1;
			wait 0.1;
			player thread ai_PerkHud( "specialty_steadyaim_upgrade" );
			level notify("boxend");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 2000 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1Not enough money for Steady Aim Need $2000! You Idiot!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money >= 2000 && player.steadyaim == 1 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1You have already bought Steady Aim!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_AmmOMatic(pos, angle)
{
	block = spawn("script_model", pos+(0,0,50) );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block moveto(pos,3);
	curObjID = fx_ai4_11();	
	objective_add( curObjID, "invisible", (0,0,0) );
	objective_position( curObjID, block.origin );
	objective_state( curObjID, "active" );
	objective_team( curObjID, "allies" );
	objective_icon( curObjID, "cardicon_bullets_50cal" );
    trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
    trigger.angles = angle;
	trigger thread ai_AmmOMaticThink(pos);
    wait 0.01;
}

ai_AmmOMaticThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for Amm-O-Matic [^2$^36500^7]" );
		}
		if(Distance(pos, Player.origin) >50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 6500 && player.pers["team"] == "allies" && player.ammomatic == 0 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 6500;
			player notify("MONEY");
			player thread fx_ai4_13( -6500, 0, (1,0,0), 1 );
			player thread fx_ai4_9( "Amm-O-Matic!" );
			player.ammomatic = 1;
			player.zombieperks += 1;
			wait 0.1;
			player thread ai_PerkHud( "cardicon_bullets_50cal" );
			level notify("boxend");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 6500 && player useButtonPressed())
		{
			player iPrintln("^1Not enough money for Amm-O-Matic Need $6500! You Idiot!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money >= 6500 && player.ammomatic == 1 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1You have already bought Amm-O-Matic!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_StoppingPower(pos, angle)
{
	block = spawn("script_model", pos+(0,0,50) );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block moveto(pos,3);
	curObjID = fx_ai4_11();	
	objective_add( curObjID, "invisible", (0,0,0) );
	objective_position( curObjID, block.origin );
	objective_state( curObjID, "active" );
	objective_team( curObjID, "allies" );
	objective_icon( curObjID, "specialty_bulletdamage_upgrade" );
    trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
    trigger.angles = angle;
	trigger thread ai_StoppingPowerThink(pos);
    wait 0.01;
}

ai_StoppingPowerThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for Stopping Power [^2$^32500^7]" );
		}
		if(Distance(pos, Player.origin) >50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 2500 && player.pers["team"] == "allies" && player.stoppingpower == 0 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 2500;
			player notify("MONEY");
			player thread fx_ai4_13( -2500, 0, (1,0,0), 1 );
			player thread fx_ai4_9( "Stopping Power!" );
			player _setPerk("specialty_bulletdamage");
			player.stoppingpower = 1;
			player.zombieperks += 1;
			wait 0.1;
			player thread ai_PerkHud( "specialty_bulletdamage_upgrade" );
			level notify("boxend");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 2500 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1Not enough money for Stopping Power Need $2500! You Idiot!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money >= 2500 && player.stoppingpower == 1 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1You have already bought StoppingPower!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_LastStandPro(pos, angle)
{
	block = spawn("script_model", pos+(0,0,50) );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block moveto(pos,3);
	curObjID = fx_ai4_11();	
	objective_add( curObjID, "invisible", (0,0,0) );
	objective_position( curObjID, block.origin );
	objective_state( curObjID, "active" );
	objective_team( curObjID, "allies" );
	objective_icon( curObjID, "specialty_pistoldeath_upgrade" );
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_LastStandProThink(pos);
	wait 0.01;
}

ai_LastStandProThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for Last Stand Pro [^2$^32500^7]" );
		}
		if(Distance(pos, Player.origin) >50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 2500 && player.pers["team"] == "allies" && player.autorevive == 0 && player.standpro <= 2 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 2500;
			player notify("MONEY");
			player thread fx_ai4_13( -2500, 0, (1,0,0), 1 );
			player thread fx_ai4_9( "Last Stand Pro!" );
			player fx_ai4_15("specialty_finalstand");
			player.autorevive += 1;
			player.standpro += 1;
			wait 0.1;
			player thread ai_PerkLastStandPro();
			level notify("boxend");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 2500 && player useButtonPressed())
		{
			player iPrintln("^1Not enough money for Last Stand Pro Need $2500! You Idiot!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money >= 2500 && player.autorevive == 1 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1You have already bought Last Stand Pro!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money >= 2500 && player.autorevive >= 0 && player.standpro >= 2 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1You have already bought Last Stand Pro 3 Times!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_PerkLastStandPro()
{
	self.laststandpro = NewClientHudElem( self );
	self.laststandpro.alignX = "center";
	self.laststandpro.alignY = "middle";
	self.laststandpro.horzAlign = "center";
	self.laststandpro.vertAlign = "middle";
	self.laststandpro.x = 0;
	self.laststandpro.y = 0;
	self.laststandpro.foreground = true;
	self.laststandpro setIconShader( "specialty_pistoldeath_upgrade" );
	self.laststandpro setIconSize( 100, 100 );
	self.laststandpro.alpha = 1;	
	self.laststandpro scaleOverTime( 3, 40, 40 );
	self.laststandpro moveOverTime( 3 );
	self.laststandpro.x = 0;
	self.laststandpro.y = 220;
}

ai_Speedy(pos, angle)
{
	block = spawn("script_model", pos+(0,0,50) );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block moveto(pos,3);
	curObjID = fx_ai4_11();	
	objective_add( curObjID, "invisible", (0,0,0) );
	objective_position( curObjID, block.origin );
	objective_state( curObjID, "active" );
	objective_team( curObjID, "allies" );
	objective_icon( curObjID, "specialty_lightweight_upgrade" );
    trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
    trigger.angles = angle;
	trigger thread ai_SpeedyThink(pos);
    wait 0.01;
}

ai_SpeedyThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for Stamin-Up [^2$^32500^7]" );
		}
		if(Distance(pos, Player.origin) >50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 2500 && player.pers["team"] == "allies" && player.speedy == 0 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 2500;
			player notify("MONEY");
			player thread fx_ai4_13( -2500, 0, (1,0,0), 1 );
			player thread fx_ai4_9( "Stamin-Up!" );
			player _setPerk("specialty_marathon");
			player _setPerk("specialty_lightweight");
			player _setPerk("specialty_fastsprintrecovery");
			player.speedy = 1;
			player.zombieperks += 1;
			wait 0.1;
			player thread ai_PerkHud( "specialty_lightweight_upgrade" );
			level notify("boxend");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 2500 && player.speedy == 0 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1Not enough money for Stamin-Up Need $2500! You Idiot!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money >= 0 && player.speedy == 1 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1You have already bought Stamin-Up!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_DoublePoints(pos, angle)
{
	block = spawn("script_model", pos+(0,0,50) );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	level.extra = 0;
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block moveto(pos,3);
	curObjID = fx_ai4_11();	
	objective_add( curObjID, "invisible", (0,0,0) );
	objective_position( curObjID, block.origin );
	objective_state( curObjID, "active" );
	objective_team( curObjID, "allies" );
	objective_icon( curObjID, "specialty_hardline_upgrade" );
    trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
    trigger.angles = angle;
	trigger thread ai_DoublePointsThink(pos);
    wait 0.01;
}

ai_DoublePointsThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for Double Points ^3[^5Need 200 Bonus Points^3]" );
		}
		if(Distance(pos, Player.origin) >50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.bonus >= 200 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.bonus -= 200;
			player notify("BONUS");
			player thread fx_ai4_13( -200, 0, (0,1,1), 1 );
			player thread fx_ai4_9( "Double Points!" );
			player.extra = 1;
			player.zombieperks += 1;
			wait 0.1;
			player thread ai_PerkHud( "specialty_hardline_upgrade" );
			level notify("boxend");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 2500 && player.bonus <= 200 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1Not enough ^5Bonus Points ^1for Double Points Need 200 Bonus Points!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_PerkHud( shader )
{
	if(self.zombieperks == 1)
	{
		self.perk1 = NewClientHudElem( self );
		self.perk1.alignX = "center";
		self.perk1.alignY = "middle";
		self.perk1.horzAlign = "center";
		self.perk1.vertAlign = "middle";
		self.perk1.x = 0;
		self.perk1.y = 0;
		self.perk1.foreground = true;
		self.perk1 setIconShader( shader );
		self.perk1 setIconSize( 100, 100 );
		self.perk1.alpha = 1;
		self.perk1 scaleOverTime( 3, 25, 25 );
		self.perk1 moveOverTime( 3 );
		self.perk1.x = -410;
		self.perk1.y = 187;
	}
	if(self.zombieperks == 2)
	{
		self.perk2 = NewClientHudElem( self );
		self.perk2.alignX = "center";
		self.perk2.alignY = "middle";
		self.perk2.horzAlign = "center";
		self.perk2.vertAlign = "middle";
		self.perk2.x = 0;
		self.perk2.y = 0;
		self.perk2.foreground = true;
		self.perk2 setIconShader( shader );
		self.perk2 setIconSize( 100, 100 );
		self.perk2.alpha = 1;
		self.perk2 scaleOverTime( 3, 25, 25 );
		self.perk2 moveOverTime( 3 );
		self.perk2.x = -388;
		self.perk2.y = 187;
	}
	if(self.zombieperks == 3)
	{
		self.perk3 = NewClientHudElem( self );
		self.perk3.alignX = "center";
		self.perk3.alignY = "middle";
		self.perk3.horzAlign = "center";
		self.perk3.vertAlign = "middle";
		self.perk3.x = 0;
		self.perk3.y = 0;
		self.perk3.foreground = true;
		self.perk3 setIconShader( shader );
		self.perk3 setIconSize( 100, 100 );
		self.perk3.alpha = 1;
		self.perk3 scaleOverTime( 3, 25, 25 );
		self.perk3 moveOverTime( 3 );
		self.perk3.x = -366;
		self.perk3.y = 187;
	}
	if(self.zombieperks == 4)
	{
		self.perk4 = NewClientHudElem( self );
		self.perk4.alignX = "center";
		self.perk4.alignY = "middle";
		self.perk4.horzAlign = "center";
		self.perk4.vertAlign = "middle";
		self.perk4.x = 0;
		self.perk4.y = 0;
		self.perk4.foreground = true;
		self.perk4 setIconShader( shader );
		self.perk4 setIconSize( 100, 100 );
		self.perk4.alpha = 1;
		self.perk4 scaleOverTime( 3, 25, 25 );
		self.perk4 moveOverTime( 3 );
		self.perk4.x = -344;
		self.perk4.y = 187;
	}
	if(self.zombieperks == 5)
	{
		self.perk5 = NewClientHudElem( self );
		self.perk5.alignX = "center";
		self.perk5.alignY = "middle";
		self.perk5.horzAlign = "center";
		self.perk5.vertAlign = "middle";
		self.perk5.x = 0;
		self.perk5.y = 0;
		self.perk5.foreground = true;
		self.perk5 setIconShader( shader );
		self.perk5 setIconSize( 100, 100 );
		self.perk5.alpha = 1;
		self.perk5 scaleOverTime( 3, 25, 25 );
		self.perk5 moveOverTime( 3 );
		self.perk5.x = -322;
		self.perk5.y = 187;
	}
	if(self.zombieperks == 6)
	{
		self.perk6 = NewClientHudElem( self );
		self.perk6.alignX = "center";
		self.perk6.alignY = "middle";
		self.perk6.horzAlign = "center";
		self.perk6.vertAlign = "middle";
		self.perk6.x = 0;
		self.perk6.y = 0;
		self.perk6.foreground = true;
		self.perk6 setIconShader( shader );
		self.perk6 setIconSize( 100, 100 );
		self.perk6.alpha = 1;
		self.perk6 scaleOverTime( 3, 25, 25 );
		self.perk6 moveOverTime( 3 );
		self.perk6.x = -300;
		self.perk6.y = 187;
	}
	if(self.zombieperks == 7)
	{
		self.perk7 = NewClientHudElem( self );
		self.perk7.alignX = "center";
		self.perk7.alignY = "middle";
		self.perk7.horzAlign = "center";
		self.perk7.vertAlign = "middle";
		self.perk7.x = 0;
		self.perk7.y = 0;
		self.perk7.foreground = true;
		self.perk7 setIconShader( shader );
		self.perk7 setIconSize( 100, 100 );
		self.perk7.alpha = 1;
		self.perk7 scaleOverTime( 3, 25, 25 );
		self.perk7 moveOverTime( 3 );
		self.perk7.x = -278;
		self.perk7.y = 187;
	}
}

ai_Health(pos, angle)
{
	block = spawn("script_model", pos+(0,0,50) );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block moveto(pos,3);
	curObjID = fx_ai4_11();	
	objective_add( curObjID, "invisible", (0,0,0) );
	objective_position( curObjID, block.origin );
	objective_state( curObjID, "active" );
	objective_team( curObjID, "allies" );
	objective_icon( curObjID, "cardicon_juggernaut_2" );
    trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
    trigger.angles = angle;
	trigger thread ai_HealthThink(pos);
    wait 0.01;
}

ai_HealthThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 for Juggernog [^2$^32500^7]" );
		}
		if(Distance(pos, Player.origin) >50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 2500 && player.nobuyhealth == 0 && player.maxhealth <= 100 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 2500;
			player notify("MONEY");
			player thread fx_ai4_13( -2500, 0, (1,0,0), 1 );
			player thread fx_ai4_9( "Juggernog!" );
			player.maxhealth += 100;
			player.zombieperks += 1;
			wait 0.1;
			player thread ai_PerkHud( "cardicon_juggernaut_2" );
			level notify("boxend");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 2500 && player.maxhealth <= 100 && player.nobuyhealth == 0 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1Not enough money for Juggernog $2500! You Idiot!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money >= 0 && player useButtonPressed() && player.maxhealth >= 100 && player.nobuyhealth == 0)
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1You have already bought Juggernog!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money >= 0 && player useButtonPressed() && player.nobuyhealth == 1)
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1You may not buy Juggernog at this time!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_Power(pos, angle)
{
	block = spawn("script_model", pos );
	block setModel("com_locker_double");
	block.angles = angle;
	block Solid();
	level.power = 0;
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "cardicon_bulb", 10,10 );
	block.headIcon setWaypoint( true, true, false );
	block.headIcon thread ai_PowerDestroy();
    trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
    trigger.angles = angle;
	trigger thread ai_PowerThink(pos);
	block thread ai_PowerDestroy();
    wait 0.01;
}

ai_PowerThink(pos, angle)
{
	self endon("disconnect");
	level endon("Destroy");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 to activate power [^2$^110000^7]" );
		}
		if(Distance(pos, Player.origin) >50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 10000 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 10000;
			player notify("MONEY");
			player thread ai_EmpEffect();
			player playSound("nuke_explosion");
			player thread fx_ai4_13( -10000, 0, (1,0,0), 1 );
			level.playername = player.name;
			foreach(player in level.players)
			{
			    player thread fx_ai4_9( "Power!" );
				player thread fx_ai4_4( 1, (2,1,0), (1,0,0), 0.50, level.playername );
				player thread fx_ai4_5( "Power Activated", 1, (1,0,0), (1,0,0), 0.50 );
			}
			Announcement( "^2" + self.name + "^3Has activated the power." );
			level.power = 1;
			level.activeUAVs["allies"]++;	
			level notify("uav_update");
			level thread ai_PowerSpawner();
			level notify("power_activated");
			level notify("Destroy");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 10000 && player.money <= 750 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1Not enough money for Power Need 10000! You Idiot!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_Power3(pos, angle)
{
	level endon("Destroy"); 
	block = spawn("script_model", pos );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	level.power = 0;
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "cardicon_bulb", 10,10 );
	block.headIcon setWaypoint( true, true, false );
	block.headIcon thread ai_PowerDestroy();
    trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
    trigger.angles = angle;
	trigger thread ai_Power3Think(pos);
	block thread ai_PowerDestroy();
    wait 0.01;
}

ai_Power3Think(pos, angle)
{
	self endon("disconnect");
	level endon("Destroy");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 to activate power [^2$^110000^7]" );
		}
		if(Distance(pos, Player.origin) >50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 10000 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 10000;
			player notify("MONEY");
			player thread ai_EmpEffect();
			player playSound( "nuke_explosion" );
			player thread fx_ai4_13( -10000, 0, (1,0,0), 1 );
			level.playername = player.name;
			foreach(player in level.players)
			{
			    player thread fx_ai4_9( "Power!" );
				player thread fx_ai4_4( 1, (2,1,0), (1,0,0), 0.50, level.playername );
				player thread fx_ai4_5( "Power Activated", 1, (1,0,0), (1,0,0), 0.50 );
			}
			level.power = 1;
			level.activeUAVs["allies"]++;	
			level notify("uav_update");
			level thread ai_PowerSpawner();
			level notify("power_activated");
			level notify("Destroy");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 10000 && player.money <= 750 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1Not enough money for Power Need 10000! You Idiot!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_PowerDestroy()
{
	while(1)
    {
        if(level.power == 1)
        {
		    self delete();
			self.headIcon destroy();
        }
	    wait 0.1;
	}
}

ai_CreateBlocks(pos, angle)
{
	block = spawn("script_model", pos );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	wait 0.01;
}

ai_CreateDoors(open, close, angle, size, height, hp, range)
{

}

ai_CreateRamps(top, bottom)
{
	D = Distance(top, bottom);
	blocks = ai_roundUp(D/30);
	CX = top[0] - bottom[0];
	CY = top[1] - bottom[1];
	CZ = top[2] - bottom[2];
	XA = CX/blocks;
	YA = CY/blocks;
	ZA = CZ/blocks;
	CXY = Distance((top[0], top[1], 0), (bottom[0], bottom[1], 0));
	Temp = VectorToAngles(top - bottom);
	BA = (Temp[2], Temp[1] + 90, Temp[0]);
	for(b = 0;b < blocks;b++)
	{
		block = spawn("script_model", (bottom + ((XA, YA, ZA) * b)));
		block setModel("com_plasticcase_friendly");
		block.angles = BA;
		block Solid();
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		wait 0.01;
	}
	block = spawn("script_model", (bottom + ((XA, YA, ZA) * blocks) - (0, 0, 5)));
	block setModel("com_plasticcase_friendly");
	block.angles = (BA[0], BA[1], 0);
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	wait 0.001;
}

ai_CreateGrids(corner1, corner2, angle)
{
	W = Distance((corner1[0], 0, 0), (corner2[0], 0, 0));
	L = Distance((0, corner1[1], 0), (0, corner2[1], 0));
	H = Distance((0, 0, corner1[2]), (0, 0, corner2[2]));
	CX = corner2[0] - corner1[0];
	CY = corner2[1] - corner1[1];
	CZ = corner2[2] - corner1[2];
	ROWS = ai_roundUp(W/55);
	COLUMNS = ai_roundUp(L/30);
	HEIGHT = ai_roundUp(H/20);
	XA = CX/ROWS;
	YA = CY/COLUMNS;
	ZA = CZ/HEIGHT;
	center = spawn("script_model", corner1);
	for(r = 0;r <= ROWS;r++)
	{
		for(c = 0;c <= COLUMNS;c++)
		{
			for(h = 0;h <= HEIGHT;h++)
			{
				block = spawn("script_model", (corner1 + (XA * r, YA * c, ZA * h)));
				block setModel("com_plasticcase_friendly");
				block.angles = (0, 0, 0);
				block Solid();
				block LinkTo(center);
				block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
				wait 0.001;
			}
		}
	}
	center.angles = angle;
}

ai_CreateWalls(start, end)
{
	D = Distance((start[0], start[1], 0), (end[0], end[1], 0));
	H = Distance((0, 0, start[2]), (0, 0, end[2]));
	blocks = ai_roundUp(D/55);
	height = ai_roundUp(H/30);
	CX = end[0] - start[0];
	CY = end[1] - start[1];
	CZ = end[2] - start[2];
	XA = (CX/blocks);
	YA = (CY/blocks);
	ZA = (CZ/height);
	TXA = (XA/4);
	TYA = (YA/4);
	Temp = VectorToAngles(end - start);
	Angle = (0, Temp[1], 90);
	for(h = 0;h < height;h++)
	{
		block = spawn("script_model", (start + (TXA, TYA, 10) + ((0, 0, ZA) * h)));
		block setContents(1);
		block.angles = Angle;
		wait 0.0001;
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		for(i = 1;i < blocks;i++)
		{
			block = spawn("script_model", (start + ((XA, YA, 0) * i) + (0, 0, 10) + ((0, 0, ZA) * h)));
			block setContents(1);
			block.angles = Angle;
			block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
			wait 0.0001;
		}
		block = spawn("script_model", ((end[0], end[1], start[2]) + (TXA * -1, TYA * -1, 10) + ((0, 0, ZA) * h)));
		block setContents(1);
		block.angles = Angle;
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		wait 0.0001;
	}
}

ai_roundUp( floatVal )
{
	if ( int( floatVal ) != floatVal )
	{
		return int( floatVal+1 );
	}
	else
	{
		return int( floatVal );
	}
}

ai_Afghan()
{
	fx_ai4_8((-1672,-1081,-1444),(0,44,0));
	fx_ai4_6((-2710,-424,-1444),(0,34,0));
	ai_Power((-3136,41,-1446),(0,333,0));
	ai_DoublePoints((-2928,-417,-1444),(0,123,0));
	fx_ai4_7((-2199,-28,-1444),(0,313,0));
	ai_CreateWalls((-2135,-62,-1440),(-2209,43,-1297));
	ai_CreateWalls((-3501,567,-1443),(-3410,1545,-1233));
}

ai_Derail()
{
	ai_CreateWalls((1506,1760,130),(1501,1462,244));
	ai_CreateWalls((1671,3064,130),(1600,2944,244));
	ai_CreateWalls((2711,1122,130),(2523,1152,244));
	ai_CreateWalls((2713,3136,142),(2520,3131,244));
	ai_CreateWalls((1680,3110,158),(1687,3345,227));
	ai_CreateBlocks((2346,3447,294),(0,0,0));
	ai_CreateBlocks((2346,3447,250),(0,0,0));
	ai_CreateBlocks((2346,3447,350),(0,0,0));
	ai_CreateBlocks((1884,3190,456),(0,90,0));
	ai_CreateBlocks((1884,3190,500),(0,90,0));
	ai_CreateBlocks((1884,3190,550),(0,90,0));
	ai_CreateBlocks((1884,3254,450),(0,90,0));
	ai_CreateBlocks((1884,3254,500),(0,90,0));
	ai_CreateBlocks((1884,3254,550),(0,90,0));
	ai_CreateBlocks((2602,2809,158),(0,0,0));
	ai_CreateBlocks((2602,2809,200),(0,0,0));
	ai_CreateBlocks((2602,2809,250),(0,0,0));
	ai_CreateBlocks((1820,2127,320),(0,90,0));
	ai_CreateBlocks((1820,2127,370),(0,90,0));
	ai_CreateBlocks((1820,2198,320),(0,90,0));
	ai_CreateBlocks((1820,2198,370),(0,90,0));
	ai_CreateBlocks((1683,3186,344),(0,90,0));
	ai_CreateBlocks((1684,3269,344),(0,90,0));
	fx_ai4_8((1790,3371,294),(0,0,0));
	fx_ai4_6((1888,2672,158),(0,90,0));
	ai_Power3((1959,2233,294),(0,90,0));
	ai_DoublePoints((1738,3371,158),(0,0,0));
	fx_ai4_7((1810,3084,158),(0,0,0));
}

ai_Estate()
{
	fx_ai4_8((-3191,-1275,-527),(0,156,0));
	fx_ai4_10((-3591,-749,-527),(0,24,0));
	fx_ai4_6((-3473,-814,-575),(0,116,0));
	ai_DoublePoints((-2042,-525,-341),(0,113,0));
	fx_ai4_7((-2321,-45,-286),(0,0,0));
}

ai_Favela()
{
	fx_ai4_8((1873,2458,296),(0,207,0));
	fx_ai4_6((1717,2640,296),(0,25,0));
	ai_Power3((2189,2635,296),(0,207,0));
	ai_DoublePoints((2034,2829,296),(0,25,0));
	fx_ai4_7((2292,2692,296),(0,207,0));
	ai_CreateWalls((2740,2858,250),(3047,3047,469));
}

ai_HighRise()
{
	fx_ai4_8((-8060.7,6789.3,2331.1),(0,0,0));
	fx_ai4_6((-8245.9,6795.1,2331.1),(0,0,0));
	ai_Power3((-7898.1,5330.9,2331.1),(0,224.9,0));
	ai_DoublePoints((-8124.8,5095.5,2331.1),(0,224.9,0));
	fx_ai4_7((-8471.1,4745.8,2331.1),(0,224.9,0));
}

ai_HighRise2()
{
	ai_CreateRamps((-14404,7069.8,5300),(-14380,6890.9,5419.1));
	fx_ai4_8((-13630.1,3855.1,5439.1),(0,0,0));
	fx_ai4_6((-13051.8,3855.1,5439.1),(0,0,0));
	ai_Power3((-12808.9,3855.1,5439.1),(0,0,0));
	ai_DoublePoints((-15781.4,4024.6,5439.1),(0,90,0));
	fx_ai4_7((-15781.4,4223.6,5439.1),(0,90,0));
}

ai_Invasion()
{
	fx_ai4_8((2335,12023,11),(0,90,0));
	ai_Power3((2403,12760,11),(0,0,0));
	ai_DoublePoints((2471,11593,11),(0,90,0));
	fx_ai4_6((2335,11223,11),(0,90,0));
	fx_ai4_7((2472,10874,11),(0,90,0));
}

ai_Karachi()
{
	fx_ai4_8((2740,2738,8),(0,90,0));
	ai_Power3((2597,2610,3),(0,0,0));
	ai_DoublePoints((2361,2807,11),(0,90,0));
	fx_ai4_6((2582,2892,8),(0,0,0));
	fx_ai4_7((2701,2889,3),(0,0,0));
}

ai_Quarry()
{
	fx_ai4_8((-1462.1,2046.0,171.1),(0,90,0));
	fx_ai4_6((-1832.9,2074.2,171.1),(0,90,0));
	ai_Power3((-4825.4,1997.4,187.1),(0,90,0));
	ai_DoublePoints((-3362.6,1901.5,163.2),(0,90,0));
	fx_ai4_7((-1431.1,1693.2,35.1),(0,90,0));
}

ai_Rundown()
{
	fx_ai4_8((1407,2651,77),(0,0,0));
	ai_Power3((497,3358,59),(0,0,0));
	ai_DoublePoints((1496,3056,77),(0,90,0));
	fx_ai4_6((830,2953,75),(0,90,0));
	fx_ai4_7((1215,2988,77),(0,0,0));
	ai_CreateWalls((1536,2303,50),(1472,2300,200));
	ai_CreateWalls((695,2131,100),(495,2174,200));
	ai_CreateWalls((304,2327,140),(163,2936,250));
}

ai_Rust()
{
	thread ai_CreateWalls((-579.5,-9976.5,-290.5),(-1192,-9332.6,0));
	thread ai_CreateWalls((3281.4,-10772.8,-271.1),(3136.1,-9614.3,-73.2));
	fx_ai4_8((2749.3,-9489.3,-271.5),(0,-25.1,0));
	ai_Power3((1477.0,-10211.9,-162.4),(0,162.4,0));
	ai_DoublePoints((515.5,-10056.6,-67.3),(0,172.1,0));
	fx_ai4_6((1777.3,-10392.6,-201.5),(0,155,0));
	fx_ai4_7((2630.3,-9443.5,-276.5),(0,340.8,0));
}

ai_Rust2()
{
	thread ai_CreateGrids((1302,-6124,-286),(936,-6674,-281),(0,0,0));
	thread ai_CreateGrids((1338,-5722,-286),(929,-5392,-281),(0,0,0));
	thread ai_CreateRamps((1184,-6110,-286),(1174,-5741,-286));
	thread ai_CreateRamps((1370,-5368,-270),(1597,-5147,-255));
	fx_ai4_8((1138,-5393,-255),(0,0,0));
	ai_DoublePoints((1106,-6128,-255),(0,0,0));
	fx_ai4_6((1092,-6437,-255),(0,0,0));
	fx_ai4_7((924,-6453,-255),(0,90,0));
	ai_Power3((1783,-4733,-163),(0,90,0));
}

ai_Scrapyard()
{
	fx_ai4_8((167,-1775,-124),(0,105,0));
	fx_ai4_6((-56,-1799,-120),(0,100,0));
	ai_Power3((88,-2355,-119),(0,120,0));
	ai_DoublePoints((314,-2309,-124),(0,131,0));
	fx_ai4_7((960,-1661,-51),(0,90,0));
}

ai_Skidrow()
{
	ai_CreateWalls((-760.1, -918.8, 12.1), (-760.1, -918.8, 100.9));
	ai_CreateWalls((-856.2, 343.4, 152.1), (-856.8, 235.9, 235.9));
	ai_CreateWalls((-152.7, 719.5, 101.2), (55.9, 722.2, 236.8));
	ai_CreateWalls((-266.6, -720.1, 16.1), (-266.6, -767.9, 100.0));
	ai_CreateWalls((-2.1, -1840.1, 16.1), (-5.5, -1935.7, 111.8));
	ai_CreateWalls((-647.9, -1676.0, 152.1), (-536.1, -1676.3, 253.9));
	fx_ai4_8((-2000.1,-366.9,144.1),(0,90,0));
	ai_Power3((-923.7,217.4,152.1),(0,0,0));
	ai_DoublePoints((-2082.8,-1556.8,-39.9),(0,0,0));
	fx_ai4_6((-2281.3,267.9,32.1),(0,0,0));
	fx_ai4_7((-2496.9,-433.0,139.1),(0,90,0));
}

ai_Skidrow2()
{
	ai_CreateWalls((-760,-918,12),(-760, -918, 100));
	ai_CreateWalls((-856,343,152),(-856, 235, 235));
	ai_CreateWalls((-152,719,101),(55, 722, 236));
	ai_CreateWalls((-266,-720,16),(-266, -767, 100.0));
	ai_CreateWalls((-685,-1840,16),(-684,-1935,111));
	ai_CreateWalls((-647,-1676,152),(-536, -1676, 253));
	ai_CreateWalls((-197,-275,200),(-200,-448,263));
	ai_CreateBlocks((-126,-458,214),(0, 0, 0));
	fx_ai4_8((1965,-500,16),(0,90,0));
	ai_Power3((-185,96,16),(0,90,0));
	ai_DoublePoints((-2082,-1556,-39),(0,0,0));
	fx_ai4_6((1772,-284,16),(0,0,0));
	fx_ai4_7((1818,-185,227),(0,0,0));
}

ai_Skidrow3()
{
	ai_CreateWalls((2057,-3601,0),(1576,-3623,200));
	ai_CreateBlocks((2032,-833,16),(0,180,0));
	ai_CreateBlocks((2032,-833,50),(0,180,0));
	ai_CreateBlocks((2032,-833,100),(0,180,0));
	fx_ai4_8((2040,-1266,16),(0,90,0));
	ai_Power3((1584,-1842,16),(0,90,0));
	ai_DoublePoints((1825,-1967,8),(0,0,0));
	fx_ai4_6((1608,-1247,8),(0,90,0));
	fx_ai4_7((1792,-1580,8),(0,90,0));
}

ai_SubBase()
{
	fx_ai4_8((-208,-4142,27),(0,90,0));
	fx_ai4_6((-495,-4193,17),(0,90,0));
	ai_LastStandPro((-215,-4328,22),(0,90,0));
	fx_ai4_7((-488,-4360,25),(0,90,0));
}

ai_Terminal()
{
	ai_CreateWalls((2295, 4425, 210), (2695, 4435, 400.2));
	ai_CreateBlocks((2209,4257,315),(0,180,0));
	ai_CreateBlocks((1453,4440,315),(0,0,0));
	ai_CreateBlocks((1505,4439,315),(0,0,0));
	fx_ai4_8((1840,4339,179),(0,90,0));
	ai_Power3((1658,2948,195),(0,190,0));
	ai_DoublePoints((2038,3294,136),(0,316,0));
	fx_ai4_6((715,2893,56),(0,0,0));
	fx_ai4_7((610,4202,218),(0,180,0));
	ai_CreateWalls((1802,4782, 216),(605, 4781, 267));
	ai_CreateWalls((407,4646, 207),(304, 4648, 293));
	ai_CreateWalls((1858,4435, 324),(1858, 4046, 419));
	ai_CreateWalls((1858,3935, 326),(1858, 3554, 418));
	ai_CreateWalls((1913,3429, 200),(2151, 3191, 295));
}

ai_Underpass()
{
	fx_ai4_8((3975,2304,400),(0,90,0));
	ai_Power3((3655,1726,400),(0,0,0));
	ai_DoublePoints((3514,2015,400),(0,132,0));
	fx_ai4_6((3545,1552,400),(0,90,0));
	fx_ai4_7((3691,2508,400),(0,90,0));
	ai_CreateWalls((4113,3144,432),(4129,3448,500));
	ai_CreateWalls((4129,3448,432),(4008,3468,500));
	ai_CreateWalls((3669,2446,400),(3426,2553,500));
	ai_CreateWalls((3414,2536,400),(3659,2529,500));
	ai_CreateWalls((3426,2553,400),(3414,2536,500));
	ai_CreateWalls((3669,2446,400),(3659,2529,500));
}

ai_Bailout()
{
	fx_ai4_8((2717,-2032,1051),(0,0,0));
	ai_Power3((2620,-1948,1051),(0,90,0));
	ai_DoublePoints((2624,-1767,1051),(0,90,0));
	fx_ai4_6((2918,-1806,1056),(0,0,0));
	fx_ai4_7((3164,-1666,1056),(0,90,0));
}

ai_Carnival()
{
	fx_ai4_8((-2779,2928,3),(0,54,0));
	ai_Power3((-2339,2609,3),(0,50,0));
	ai_DoublePoints((-2319,1661,3),(0,140,0));
	fx_ai4_6((-2307,3170,3),(0,234,0));
	fx_ai4_7((-1759,2968,3),(0,138,0));
	ai_TriggerSolid((-2944,3684,3),(0,0,0),0,100,200);
}

ai_Wasteland()
{
	fx_ai4_8((10113,7044,358),(0,90,0));
	ai_Power3((10113,7198,358),(0,90,0));
	ai_DoublePoints((10113,7327,358),(0,90,0));
	fx_ai4_6((9480,6527,358),(0,90,0));
	fx_ai4_6((10901,7439,1481),(0,0,0));
	fx_ai4_7((10113,8312,358),(0,90,0));
	ai_CreateWalls((10694,6956,1545),(10693,7477,1600));
}

ai_Overgrown()
{
	/* Created by maarten551 */ ai_CreateRamps((1096, -4260, -13), (500, -4388, 109));
	ai_CreateGrids((500, -4200, 114), (143, -4667, 114), (0, 0, 0));
	ai_CreateWalls((500, -4200, 114), (143, -4200, 275));
	/* Door Stuff */ ai_CreateWalls((500, -4200, 114), (500, -4301, 160));
	ai_CreateWalls((500, -4667, 114), (500, -4489, 160));
	ai_CreateWalls((500, -4200, 220), (500, -4667, 275));
	ai_CreateDoors((510, -4301, 120), (500, -4400, 120),(90, 0, 0), 5, 2, 15, 75);
	/* End Door Stuff */ ai_CreateWalls((143, -4667, 114), (500, -4667, 275));
	ai_CreateWalls((143, -4667, 114), (143, -4200, 275));
}

ai_Trailerpark()
{
	fx_ai4_8((271.1,-2360.1,11.1),(0,90,0));
	fx_ai4_6((2739.8,-2575.6,18.1),(0,90,0));
	ai_Power3((-232.8,-1456.2,11.3),(0,0,0));
	ai_DoublePoints((773.1,-2683.9,20.1),(0,0,0));
	fx_ai4_7((977.1,-2744.9,11.1),(0,90,0));
}

ai_Vacant()
{
	fx_ai4_8((445,1526,-96),(0,0,0));
	fx_ai4_6((-241,692,-31),(0,0,0));
	ai_Power3((-1659,208,-91),(0,90,0));
	ai_DoublePoints((-539,86,-36),(0,90,0));
	fx_ai4_7((-828,-261,-37),(0,90,0));
	ai_CreateWalls((-846,-503,-8),(-849,-384,50));
	ai_CreateWalls((-520,16,-31),(-518,-96,50));
	ai_CreateWalls((-848,640,-8),(-846,520,50));
	ai_CreateWalls((-4,677,-32),(-52,675,50));
	ai_CreateWalls((72,959,-32),(73,848,46));
	ai_CreateWalls((343,-880,-32),(346,-928,50));
}

ai_Storm()
{
	fx_ai4_8((3465,-975,-52),(0,0,0));
	fx_ai4_6((4207,-1009,-52),(0,90,0));
	ai_Power3((4646,-975,-52),(0,0,0));
	ai_DoublePoints((5040,-1235,-52),(0,90,0));
	fx_ai4_7((4826,-1328,-52),(0,0,0));
	ai_CreateWalls((4700,-62,8),(4737,-59,100));
	ai_CreateWalls((2163,-843,8),(2120,-842,100));
	ai_CreateWalls((5088,-1360,8),(5004,-1347,100));
}

ai_Salvage()
{
	fx_ai4_8((2250.3,3311.6,63.7),(0,0,0));
	fx_ai4_6((1644.0,3350.7,87.4),(0,0,0));
	ai_Power3((1608.1,2025.3,152.1),(0,90,0));
	ai_DoublePoints((2103.8,2230.2,16.1),(0,90,0));
	fx_ai4_7((1801.2,2000.1,16.1),(0,0,0));
	ai_CreateBlocks((3505.8,2665.8,11.1),(0,0,0));
	ai_CreateBlocks((3505.8,2665.8,51.1),(0,0,0));
	ai_CreateBlocks((3505.8,2665.8,91.1),(0,0,0));
	ai_CreateBlocks((2044.4,1984.2,42.1),(0,0,0));
	ai_CreateBlocks((1998.0,1986.2,42.1),(0,0,0));
	ai_CreateBlocks((1846.3,1989.2,178.1),(0,0,0));
	ai_CreateBlocks((1787.8,1982.3,178.1),(0,0,0));
	ai_CreateBlocks((1595.5,2060.3,45.1),(0,90,0));
	ai_CreateWalls((1936.1,2335.9,300.9),(2487.9,2339.0,0.8));
	ai_CreateWalls((984.1,2623.8,96.1),(1095.9,2614.9,202.4));
}

ai_Strike()
{
	fx_ai4_8((-2199,1240,31),(0,0,0));
	fx_ai4_6((-2185,1615,24),(0,0,0));
	ai_Power3((-3116,1240,20),(0,0,0));
	ai_DoublePoints((-3959,1380,16),(0,90,0));
	fx_ai4_7((-2577,1615,24),(0,0,0));
	ai_CreateWalls((-3538,1216,32),(-3959,1211,128));
	ai_CreateWalls((-3530,1627,16),(-3959,1621,128));
}

ai_RandomBoxDeleteOnWeaponNoTake()
{
	level endon("disconnect");
	level endon("stopspawner");
	{
		level waittill ("endrandom");
		level.wep MoveTo(level.wep.origin+(0,0,-30), 12);
		wait 12;
		level notify("box_move");
		level notify("box");
		level.block delete();
		level.block.headIcon destroy();
		level.block.trigger delete();
		level.wep delete();
		if(getDvar("mapname") == "mp_derail" && level.box >= 6 && level.boxposition == 0)
		{
			level thread ai_BoxSwitchDerail();
		}
		else if(getDvar("mapname") == "mp_derail" && level.box <= 6 && level.boxposition == 0)
		{
			fx_ai4_8((1790,3371,294),(0,0,0));
		}
		if(getDvar("mapname") == "mp_derail" && level.box >= 6 && level.boxposition == 1)
		{
			level thread ai_BoxSwitchDerail();
		}
		else if(getDvar("mapname") == "mp_derail" && level.box <= 6 && level.boxposition == 1)
		{
			fx_ai4_8((2191,2949,158),(0,90,0));
		}
		if(getDvar("mapname") == "mp_derail" && level.box >= 6 && level.boxposition == 2)
		{
			level thread ai_BoxSwitchDerail();
		}
		else if(getDvar("mapname") == "mp_derail" && level.box <= 6 && level.boxposition == 2)
		{
			fx_ai4_8((1901,2060,294),(0,0,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 5 && level.boxposition == 0 && level.edit == 2)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 5 && level.boxposition == 0 && level.edit == 2)
		{
			fx_ai4_8((2040,-1266,16),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 5 && level.boxposition == 1 && level.edit == 2)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 5 && level.boxposition == 1 && level.edit == 2)
		{
			fx_ai4_8((1590,-1393,8),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 5 && level.boxposition == 2 && level.edit == 2)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 5 && level.boxposition == 2 && level.edit == 2)
		{
			fx_ai4_8((1830,-2360,4),(0,0,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 5 && level.boxposition == 0 && level.edit == 1)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 5 && level.boxposition == 0 && level.edit == 1)
		{
			fx_ai4_8((1965,-500,16),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 5 && level.boxposition == 1 && level.edit == 1)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 5 && level.boxposition == 1 && level.edit == 1)
		{
			fx_ai4_8((1574,426,24),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 5 && level.boxposition == 2 && level.edit == 1)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 5 && level.boxposition == 2 && level.edit == 1)
		{
			fx_ai4_8((505,-734,11),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 3 && level.edit == 1)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 6 && level.boxposition == 3 && level.edit == 1)
		{
			fx_ai4_8((865,-2096,43),(0,180,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 4 && level.edit == 1)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 6 && level.boxposition == 4 && level.edit == 1)
		{
			fx_ai4_8((1631,-770,119),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 0 && level.edit == 0)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 6 && level.boxposition == 0 && level.edit == 0)
		{
			fx_ai4_8((-2000.1,-366.9,144.1),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 1 && level.edit == 0)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box < 6 && level.boxposition == 1 && level.edit == 0)
		{
			fx_ai4_8((-2356.7,-912.9,139.1),(0,0,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 2 && level.edit == 0)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 6 && level.boxposition == 2 && level.edit == 0)
		{
			fx_ai4_8((-1176.0,-1986.6,11.1),(0,180,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 3 && level.edit == 0)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 6 && level.boxposition == 3 && level.edit == 0)
		{
			fx_ai4_8((-1432.0,-192.9,3.1),(0,180,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 4 && level.edit == 0)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 6 && level.boxposition == 4 && level.edit == 0)
		{
			fx_ai4_8((-1414.8,-1984.9,3.1),(0,180,0));
		}
		if(getDvar("mapname") == "mp_rust" && level.edit == 0)
		{
			fx_ai4_8((2749,-9489,-271),(0,-25.1,0));
		}
		if(getDvar("mapname") == "mp_rust" && level.edit == 1)
		{
			fx_ai4_8((1138,-5393,-255),(0,0,0));
		}
		if(getDvar("mapname") == "mp_afghan" && level.box >= 4 && level.boxposition == 0)
		{
			level thread ai_BoxSwitchAfghan();
		}
		else if(getDvar("mapname") == "mp_afghan" && level.box <= 4 && level.boxposition == 0)
		{
			fx_ai4_8((-1672,-1081,-1444),(0,44,0));
		}
		if(getDvar("mapname") == "mp_afghan" && level.box >= 4 && level.boxposition == 1)
		{
			level thread ai_BoxSwitchAfghan();
		}
		else if(getDvar("mapname") == "mp_afghan" && level.box <= 4 && level.boxposition == 1)
		{
			fx_ai4_8((-3434,1581,-1443),(0,115,0));
		}
		if(getDvar("mapname") == "mp_afghan" && level.box >= 4 && level.boxposition == 2)
		{
			level thread ai_BoxSwitchAfghan();
		}
		else if(getDvar("mapname") == "mp_afghan" && level.box <= 5 && level.boxposition == 2)
		{
			fx_ai4_8((-2629,-267,-1439),(0,79,0));
		}
		if(getDvar("mapname") == "mp_afghan" && level.box >= 4 && level.boxposition == 3)
		{
			level thread ai_BoxSwitchAfghan();
		}
		else if(getDvar("mapname") == "mp_afghan" && level.box <= 5 && level.boxposition == 3)
		{
			fx_ai4_8((-2755,-1177,-1440),(0,73,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box >= 5 && level.boxposition == 0)
		{
			level thread ai_BoxSwitchHighrise();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box <= 5 && level.boxposition == 0)
		{
			fx_ai4_8((-8060.7,6789.3,2331.1),(0,0,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box >= 5 && level.boxposition == 1)
		{
			level thread ai_BoxSwitchHighrise();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box <= 5 && level.boxposition == 1)
		{
			fx_ai4_8((-9049.5,6786.7,2331.1),(0,0,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box >= 5 && level.boxposition == 2)
		{
			level thread ai_BoxSwitchHighrise();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box <= 5 && level.boxposition == 2)
		{
			fx_ai4_8((-8942.2,4284.3,2331.1),(0,225,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box >= 5 && level.boxposition == 3)
		{
			level thread ai_BoxSwitchHighrise();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box <= 5 && level.boxposition == 3)
		{
			fx_ai4_8((-9248.9,5427.1,2331.1),(0,90,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box >= 6 && level.boxposition == 0)
		{
			level thread ai_BoxSwitchHighrise2();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box <= 6 && level.boxposition == 0)
		{
			fx_ai4_8((-13630.1,3855.1,5439.1),(0,0,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box >= 6 && level.boxposition == 1)
		{
			level thread ai_BoxSwitchHighrise2();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box <= 6 && level.boxposition == 1)
		{
			fx_ai4_8((-14032.2,7520.0,5391.1),(0,35,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box >= 6 && level.boxposition == 2)
		{
			level thread ai_BoxSwitchHighrise2();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box <= 6 && level.boxposition == 2)
		{
			fx_ai4_8((-15771.6,6051.3,5439.1),(0,90,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box >= 6 && level.boxposition == 3)
		{
			level thread ai_BoxSwitchHighrise2();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box <= 6 && level.boxposition == 3)
		{
			fx_ai4_8((-14614.7,7443.9,5386.1),(0,33,0));
		}
		if(getDvar("mapname") == "mp_invasion")
		{
			fx_ai4_8((2335,12023,11),(0,90,0));
		}
		if(getDvar("mapname") == "mp_favela")
		{
			fx_ai4_8((1873,2458,296),(0,207,0));
		}
		if(getDvar("mapname") == "mp_checkpoint")
		{
			fx_ai4_8((2740,2738,8),(0,90,0));
		}
		if(getDvar("mapname") == "mp_quarry")
		{
			fx_ai4_8((-1462.1,2046.0,171.1),(0,90,0));
		}
		if(getDvar("mapname") == "mp_subbase")
		{
			fx_ai4_8((-208,-4142,27),(0,90,0));
		}
		if(getDvar("mapname") == "mp_strike")
		{
			fx_ai4_8((-2199,1240,31),(0,0,0));
		}
		if(getDvar("mapname") == "mp_vacant")
		{
			fx_ai4_8((445,1526,-96),(0,0,0));
		}
		if(getDvar("mapname") == "mp_underpass")
		{
			fx_ai4_8((3975,2304,400),(0,90,0));
		}
		if(getDvar("mapname") == "mp_rundown")
		{
			fx_ai4_8((1407,2651,77),(0,0,0));
		}
		if(getDvar("mapname") == "mp_fuel2")
		{
			fx_ai4_8((16183,28529,7212),(0,0,0));
		}
		if(getDvar("mapname") == "mp_storm")
		{
			fx_ai4_8((3465,-975,-52),(0,0,0));
		}
		if(getDvar("mapname") == "mp_estate")
		{
			fx_ai4_8((-3191,-1275,-527),(0,121,0));
		}
		if(getDvar("mapname") == "mp_boneyard")
		{
			fx_ai4_8((167,-1775,-124),(0,80,0));
		}
		if(getDvar("mapname") == "mp_terminal")
		{
			fx_ai4_8((1840,4339,179),(0,90,0));
		}
		if(getDvar("mapname") == "mp_brecourt")
		{
			fx_ai4_8((10113,7044,358),(0,90,0));
		}
		if(getDvar("mapname") == "mp_overgrown")
		{
			fx_ai4_8((1284,2651,-157),(0,90,0));
		}
		if(getDvar("mapname") == "mp_compact")
		{
			fx_ai4_8((2250.3,3311.6,63.7),(0,0,0));
		}
		if(getDvar("mapname") == "mp_crash")
		{
			fx_ai4_8((-1239,-2646,86),(0,90,0));
		}
		if(getDvar("mapname") == "mp_abandon")
		{
			fx_ai4_8((-2779,2928,3),(0,54,0));
		}
		if(getDvar("mapname") == "mp_complex")
		{
			fx_ai4_8((2717,-2032,1051),(0,0,0));
		}
		if(getDvar("mapname") == "mp_trailerpark")
		{
			fx_ai4_8((271.1,-2360.1,11.1),(0,90,0));
		}
		wait 1;
	}
}

ai_RandomBoxDeleteOnWeaponTake()
{

	{
		level endon("disconnect");
		wait 1;
		level notify("box_delete");
		level notify("box");
		level.block delete();
		level.block.headIcon destroy();
		level.block.trigger delete();
		foreach(weaps in level.wep)
		{
			weaps delete();
		}
		if(getDvar("mapname") == "mp_derail" && level.box >= 6 && level.boxposition == 0)
		{
			level thread ai_BoxSwitchDerail();
		}
		else if(getDvar("mapname") == "mp_derail" && level.box <= 6 && level.boxposition == 0)
		{
			fx_ai4_8((1790,3371,294),(0,0,0));
		}
		if(getDvar("mapname") == "mp_derail" && level.box >= 6 && level.boxposition == 1)
		{
			level thread ai_BoxSwitchDerail();
		}
		else if(getDvar("mapname") == "mp_derail" && level.box <= 6 && level.boxposition == 1)
		{
			fx_ai4_8((2191,2949,158),(0,90,0));
		}
		if(getDvar("mapname") == "mp_derail" && level.box >= 6 && level.boxposition == 2)
		{
			level thread ai_BoxSwitchDerail();
		}
		else if(getDvar("mapname") == "mp_derail" && level.box <= 6 && level.boxposition == 2)
		{
			fx_ai4_8((1901,2060,294),(0,0,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 5 && level.boxposition == 0 && level.edit == 2)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 5 && level.boxposition == 0 && level.edit == 2)
		{
			fx_ai4_8((2040,-1266,16),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 5 && level.boxposition == 1 && level.edit == 2)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 5 && level.boxposition == 1 && level.edit == 2)
		{
			fx_ai4_8((1590,-1393,8),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 5 && level.boxposition == 2 && level.edit == 2)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 5 && level.boxposition == 2 && level.edit == 2)
		{
			fx_ai4_8((1830,-2360,4),(0,0,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 5 && level.boxposition == 0 && level.edit == 1)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 5 && level.boxposition == 0 && level.edit == 1)
		{
			fx_ai4_8((1965,-500,16),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 5 && level.boxposition == 1 && level.edit == 1)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 5 && level.boxposition == 1 && level.edit == 1)
		{
			fx_ai4_8((1574,426,24),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 5 && level.boxposition == 2 && level.edit == 1)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 5 && level.boxposition == 2 && level.edit == 1)
		{
			fx_ai4_8((505,-734,11),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 3 && level.edit == 1)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 6 && level.boxposition == 3 && level.edit == 1)
		{
			fx_ai4_8((865,-2096,43),(0,180,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 4 && level.edit == 1)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 6 && level.boxposition == 4 && level.edit == 1)
		{
			fx_ai4_8((1631,-770,119),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 0 && level.edit == 0)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 6 && level.boxposition == 0 && level.edit == 0)
		{
			fx_ai4_8((-2000.1,-366.9,144.1),(0,90,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 1 && level.edit == 0)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box < 6 && level.boxposition == 1 && level.edit == 0)
		{
			fx_ai4_8((-2356.7,-912.9,139.1),(0,0,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 2 && level.edit == 0)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 6 && level.boxposition == 2 && level.edit == 0)
		{
			fx_ai4_8((-1176.0,-1986.6,11.1),(0,180,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 3 && level.edit == 0)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 6 && level.boxposition == 3 && level.edit == 0)
		{
			fx_ai4_8((-1432.0,-192.9,3.1),(0,180,0));
		}
		if(getDvar("mapname") == "mp_nightshift" && level.box >= 6 && level.boxposition == 4 && level.edit == 0)
		{
			level thread ai_BoxSwitchSkidrow();
		}
		else if(getDvar("mapname") == "mp_nightshift" && level.box <= 6 && level.boxposition == 4 && level.edit == 0)
		{
			fx_ai4_8((-1414.8,-1984.9,3.1),(0,180,0));
		}
		if(getDvar("mapname") == "mp_rust" && level.edit == 0)
		{
			fx_ai4_8((2749.3,-9489.3,-271.5),(0,-25.1,0));
		}
		if(getDvar("mapname") == "mp_rust" && level.edit == 1)
		{
			fx_ai4_8((1138,-5393,-255),(0,0,0));
		}
		if(getDvar("mapname") == "mp_afghan" && level.box >= 4 && level.boxposition == 0)
		{
			level thread ai_BoxSwitchAfghan();
		}
		else if(getDvar("mapname") == "mp_afghan" && level.box <= 4 && level.boxposition == 0)
		{
			fx_ai4_8((-1672,-1081,-1444),(0,44,0));
		}
		if(getDvar("mapname") == "mp_afghan" && level.box >= 4 && level.boxposition == 1)
		{
			level thread ai_BoxSwitchAfghan();
		}
		else if(getDvar("mapname") == "mp_afghan" && level.box <= 4 && level.boxposition == 1)
		{
			fx_ai4_8((-3434,1581,-1443),(0,115,0));
		}
		if(getDvar("mapname") == "mp_afghan" && level.box >= 4 && level.boxposition == 2)
		{
			level thread ai_BoxSwitchAfghan();
		}
		else if(getDvar("mapname") == "mp_afghan" && level.box <= 5 && level.boxposition == 2)
		{
			fx_ai4_8((-2629,-267,-1439),(0,79,0));
		}
		if(getDvar("mapname") == "mp_afghan" && level.box >= 4 && level.boxposition == 3)
		{
			level thread ai_BoxSwitchAfghan();
		}
		else if(getDvar("mapname") == "mp_afghan" && level.box <= 5 && level.boxposition == 3)
		{
			fx_ai4_8((-2755,-1177,-1440),(0,73,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box >= 5 && level.boxposition == 0)
		{
			level thread ai_BoxSwitchHighrise();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box <= 5 && level.boxposition == 0)
		{
			fx_ai4_8((-8060.7,6789.3,2331.1),(0,0,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box >= 5 && level.boxposition == 1)
		{
			level thread ai_BoxSwitchHighrise();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box <= 5 && level.boxposition == 1)
		{
			fx_ai4_8((-9049.5,6786.7,2331.1),(0,0,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box >= 5 && level.boxposition == 2)
		{
			level thread ai_BoxSwitchHighrise();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box <= 5 && level.boxposition == 2)
		{
			fx_ai4_8((-8942.2,4284.3,2331.1),(0,225,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box >= 5 && level.boxposition == 3)
		{
			level thread ai_BoxSwitchHighrise();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.box <= 5 && level.boxposition == 3)
		{
			fx_ai4_8((-9248.9,5427.1,2331.1),(0,90,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box >= 6 && level.boxposition == 0)
		{
			level thread ai_BoxSwitchHighrise2();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box <= 6 && level.boxposition == 0)
		{
			fx_ai4_8((-13630.1,3855.1,5439.1),(0,0,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box >= 6 && level.boxposition == 1)
		{
			level thread ai_BoxSwitchHighrise2();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box <= 6 && level.boxposition == 1)
		{
			fx_ai4_8((-14032.2,7520.0,5391.1),(0,35,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box >= 6 && level.boxposition == 2)
		{
			level thread ai_BoxSwitchHighrise2();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box <= 6 && level.boxposition == 2)
		{
			fx_ai4_8((-15771.6,6051.3,5439.1),(0,90,0));
		}
		if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box >= 6 && level.boxposition == 3)
		{
			level thread ai_BoxSwitchHighrise2();
		}
		else if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.box <= 6 && level.boxposition == 3)
		{
			fx_ai4_8((-14614.7,7443.9,5386.1),(0,33,0));
		}
		if(getDvar("mapname") == "mp_invasion")
		{
			fx_ai4_8((2335,12023,11),(0,90,0));
		}
		if(getDvar("mapname") == "mp_favela")
		{
			fx_ai4_8((1873,2458,296),(0,207,0));
		}
		if(getDvar("mapname") == "mp_checkpoint")
		{
			fx_ai4_8((2740,2738,8),(0,90,0));
		}
		if(getDvar("mapname") == "mp_quarry")
		{
			fx_ai4_8((-1462.1,2046.0,171.1),(0,90,0));
		}
		if(getDvar("mapname") == "mp_subbase")
		{
			fx_ai4_8((-208,-4142,27),(0,90,0));
		}
		if(getDvar("mapname") == "mp_strike")
		{
			fx_ai4_8((-2199,1240,31),(0,0,0));
		}
		if(getDvar("mapname") == "mp_vacant")
		{
			fx_ai4_8((445,1526,-96),(0,0,0));
		}
		if(getDvar("mapname") == "mp_underpass")
		{
			fx_ai4_8((3975,2304,400),(0,90,0));
		}
		if(getDvar("mapname") == "mp_rundown")
		{
			fx_ai4_8((1407,2651,77),(0,0,0));
		}
		if(getDvar("mapname") == "mp_fuel2")
		{
			fx_ai4_8((16183,28529,7212),(0,0,0));
		}
		if(getDvar("mapname") == "mp_storm")
		{
			fx_ai4_8((3465,-975,-52),(0,0,0));
		}
		if(getDvar("mapname") == "mp_estate")
		{
			fx_ai4_8((-3191,-1275,-527),(0,121,0));
		}
		if(getDvar("mapname") == "mp_boneyard")
		{
			fx_ai4_8((167,-1775,-124),(0,80,0));
		}
		if(getDvar("mapname") == "mp_terminal")
		{
			fx_ai4_8((1840,4339,179),(0,90,0));
		}
		if(getDvar("mapname") == "mp_brecourt")
		{
			fx_ai4_8((10113,7044,358),(0,90,0));
		}
		if(getDvar("mapname") == "mp_overgrown")
		{
			fx_ai4_8((1284,2651,-157),(0,90,0));
		}
		if(getDvar("mapname") == "mp_compact")
		{
			fx_ai4_8((2250.3,3311.6,63.7),(0,0,0));
		}
		if(getDvar("mapname") == "mp_crash")
		{
			fx_ai4_8((-1239,-2646,86),(0,90,0));
		}
		if(getDvar("mapname") == "mp_abandon")
		{
			fx_ai4_8((-2779,2928,3),(0,54,0));
		}
		if(getDvar("mapname") == "mp_complex")
		{
			fx_ai4_8((2717,-2032,1051),(0,0,0));
		}
		if(getDvar("mapname") == "mp_trailerpark")
		{
			fx_ai4_8((271.1,-2360.1,11.1),(0,90,0));
		}
		wait 1;
	}
}

ai_PowerSpawner()
{
	level endon("disconnect");
	wait 1;
	Announcement("^2Power Activated!");
	wait 3.0;
	if(getDvar("mapname") == "mp_rust" && level.edit == 0)
	{
		ai_CreateRamps((2314,-9299,-287),(2654,-8577,-287));
		fx_ai4_10((2649,-8583,-261),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((1637.8,-9032.8,-274.2),(0,341.8,0));
		ai_SteadyAim((2176.6,-9246.8,-274.8),(0,335.1,0));
		ai_StoppingPower((3161.6,-10811.7,-176.2),(0,206.2,0));
		ai_Speedy((756.5,-10078.5,-89.8),(0,180,0));
		ai_Health((-161.8,-10090.0,-155.0),(0,177.6,0));
		ai_AmmOMatic((1885,-10492,-216),(0,138,0));
		ai_LastStandPro((1673,-10304,-187),(0,140,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_rust" && level.edit == 1)
	{
		fx_ai4_10((1580,-4481,-147),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((914,-5550,-255),(0,90,0));
		ai_Health((1353,-5549,-255),(0,90,0));
		ai_LastStandPro((1317,-6359,-255),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_afghan")
	{
		fx_ai4_10((-2841,-394,-1332),(0,120,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((-2502,-13,-1444),(0,7,0));
		ai_SteadyAim((-2863,-195,-1445),(0,246,0));
		ai_StoppingPower((-3420,379,-1448),(0,280,0));
		ai_Speedy((-3499,920,-1448),(0,282,0));
		ai_Health((-3822,1390,-1448),(0,185,0));
		ai_AmmOMatic((-3481,-342,-1448),(0,8,0));
		ai_LastStandPro((-3541,-511,-1448),(0,343,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_highrise" && level.edit == 0)
	{
		fx_ai4_10((-8493.3,5516.3,2331.1),(0,0,0),(-8491,5565,2331));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((-8487.1,5452.1,2331.1),(0,0,0));
		ai_SteadyAim((-8791.6,5474.1,2331.1),(0,90,0));
		ai_StoppingPower((-8666.7,5587.1,2331.1),(0,0,0));
		ai_Speedy((-8642.2,5469.6,2331.1),(0,90,0));
		ai_Health((-8767.5,5348.4,2331.1),(0,0,0));
		ai_AmmOMatic((-9728,6049,2331),(0,90,0));
		ai_LastStandPro((-8443,5731,2331),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_highrise" && level.edit == 1)
	{
		fx_ai4_10((-14434.5,4573.5,5439.1),(0,0,0),(-14432,4534,5434));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((-12757.6,4033.2,5439.1),(0,90,0));
		ai_SteadyAim((-12757.6,4232.4,5439.1),(0,90,0));
		ai_StoppingPower((-12757.6,4373.7,5439.1),(0,90,0));
		ai_Speedy((-12757.6,4640.9,5439.1),(0,90,0));
		ai_Health((-12757.6,5044.7,5439.1),(0,90,0));
		ai_AmmOMatic((-14593,5474,5434),(0,0,0));
		ai_LastStandPro((-14313,3862,5434),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_invasion")
	{
		fx_ai4_10((2403,12760,11),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((2335,12127,11),(0,90,0));
		ai_SteadyAim((2335,11544,11),(0,90,0));
		ai_StoppingPower((2476,11173,11),(0,90,0));
		ai_Speedy((2335,10865,11),(0,90,0));
		ai_Health((2472,10567,11),(0,90,0));
		ai_AmmOMatic((2335,10182,11),(0,90,0));
		ai_LastStandPro((2474,10170,11),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_favela")
	{
		fx_ai4_10((2043,2561,291),(0,207,0),(2023,2599,291));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((1468,2492,291),(0,25,0));
		ai_SteadyAim((1606,2570,291),(0,25,0));
		ai_StoppingPower((1572,2310,291),(0,207,0));
		ai_Speedy((1756,2400,291),(0,207,0));
		ai_Health((2695,3160,291),(0,352,0));
		ai_AmmOMatic((2149,2889,291),(0,25,0));
		ai_LastStandPro((1049,2424,292),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
	}
	if(getDvar("mapname") == "mp_checkpoint")
	{
		fx_ai4_10((2588,2714,3),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_Health((2490,2216,12),(0,90,0));
		ai_LastStandPro((2364,2267,11),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
	}
	if(getDvar("mapname") == "mp_quarry")
	{
		fx_ai4_10((-1839.9,768.7,169.5),(0,90,0),(-1792,768,169));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_CreateRamps((-1634.4,1019.0,20.1),(-1623.5,823.6,176.1));
		ai_SpeedReload((-1660.2,727.1,35.1),(0,0,0));
		ai_SteadyAim((-2395.3,1288.9,31.1),(0,0,0));
		ai_StoppingPower((-1815.1,2789.7,84.9),(0,90,0));
		ai_Speedy((-2020.9,1687.1,35.1),(0,0,0));
		ai_Health((-1424.1,778.7,171.5),(0,90,0));
		ai_AmmOMatic((-2658,2767,84),(0,0,0));
		ai_LastStandPro((-1565,727,169),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_subbase")
	{
		fx_ai4_8((-412,-6440,0),(0,0,0));
	}
	if(getDvar("mapname") == "mp_nightshift" && level.edit == 0)
	{
		fx_ai4_10((-2016.4,-50.8,8.1),(0,90,0),(-1972,-48,3));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((-1576.1,-2213.3,27.1),(0,90,0));
		ai_SteadyAim((-1328.1,-1864.5,8.1),(0,90,0));
		ai_StoppingPower((-318.6,-2023.9,16.1),(0,0,0));
		ai_Speedy((-496.1,-1728.4,152.1),(0,90,0));
		ai_Health((-752.6,-883.2,12.2),(0,0,0));
		ai_AmmOMatic((-1757,304,3),(0,0,0));
		ai_LastStandPro((-1968,-292,3),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_nightshift" && level.edit == 1)
	{
		fx_ai4_10((1947,309,119),(0,360,0),(1947,257,119));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((31,-991,11),(0,0,0));
		ai_SteadyAim((827,-1799,43),(0,0,0));
		ai_StoppingPower((504,-912,11),(0,90,0));
		ai_Speedy((615,-112,19),(0,180,0));
		ai_Health((1867,186,224),(0,245,0));
		ai_AmmOMatic((-309,-2016,11),(0,0,0));
		ai_LastStandPro((1104,-2112,43),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_nightshift" && level.edit == 2)
	{
		fx_ai4_10((1834,-2794,8),(0,0,0),(1830,-2744,3));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((2023,-1613,16),(0,90,0));
		ai_SteadyAim((2022,-1792,16),(0,90,0));
		ai_StoppingPower((2023,-1990,16),(0,90,0));
		ai_Speedy((1576,-2521,16),(0,90,0));
		ai_Health((1576,-2863,16),(0,90,0));
		ai_AmmOMatic((1828,-2283,134),(0,0,0));
		ai_LastStandPro((1787,-1748,3),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_strike")
	{
		fx_ai4_10((-2385,1608,19),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((-2378,1248,22),(0,0,0));
		ai_SteadyAim((-2627,1247,17),(0,0,0));
		ai_StoppingPower((-2777,1247,16),(0,0,0));
		ai_Speedy((-2950,1247,15),(0,0,0));
		ai_Health((-3302,1247,12),(0,0,0));
		ai_AmmOMatic((-2742,1608,19),(0,0,0));
		ai_LastStandPro((-3065,1608,19),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_vacant")
	{
		fx_ai4_10((-1625,972,-83),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((-1404,152,-98),(0,0,0));
		ai_SteadyAim((-1760,-62,-100),(0,0,0));
		ai_StoppingPower((-659,78,-100),(0,90,0));
		ai_Speedy((-867,409,-98),(0,90,0));
		ai_Health((196,1600,-101),(0,90,0));
		ai_AmmOMatic((764,1663,-100),(0,90,0));
		ai_LastStandPro((53,1093,-36),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_underpass")
	{
		fx_ai4_10((3732,2105,395),(0,48,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((3778,1731,395),(0,0,0));
		ai_SteadyAim((4094,1039,427),(0,0,0));
		ai_StoppingPower((3542,1426,395),(0,90,0));
		ai_Speedy((3660,1968,395),(0,46,0));
		ai_Health((3015,3354,395),(0,90,0));
		ai_AmmOMatic((3495,2273,395),(0,238,0));
		ai_LastStandPro((4164,1904,427),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_rundown")
	{
		fx_ai4_10((1236,2644,82),(0,0,0),(1235,2704,77));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((1426,3187,82),(0,0,0));
		ai_SteadyAim((1343,3187,82),(0,0,0));
		ai_StoppingPower((1366,3028,82),(0,0,0));
		ai_Speedy((1279,3028,82),(0,0,0));
		ai_Health((1708,3040,73),(0,90,0));
		ai_AmmOMatic((391,2320,134),(0,0,0));
		ai_LastStandPro((963,2919,80),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_fuel2")
	{
		fx_ai4_8((16183,28529,7212),(0,0,0));
	}
	if(getDvar("mapname") == "mp_storm")
	{
		fx_ai4_10((3843,-1903,8),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((3913,-1519,16),(0,0,0));
		ai_SteadyAim((3144,-968,-48),(0,0,0));
		ai_StoppingPower((3668,-1335,-48),(0,0,0));
		ai_Speedy((2120,-902,8),(0,90,0));
		ai_Health((3412,-844,8),(0,90,0));
		ai_AmmOMatic((5056,-1806,8),(0,90,0));
		ai_LastStandPro((5097,-1360,8),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_derail")
	{
		fx_ai4_10((2495,3319,294),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((1896,2060,158),(0,0,0));
		ai_SteadyAim((1824,2158,158),(0,90,0));
		ai_StoppingPower((1824,2308,158),(0,90,0));
		ai_Speedy((1824,2450,158),(0,90,0));
		ai_Health((2154,2606,282),(0,0,0));
		ai_AmmOMatic((2153,3196,425),(0,90,0));
		ai_LastStandPro((2299,2788,153),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_estate")
	{
		fx_ai4_8((1362,3719,65),(0,0,0));
	}
	if(getDvar("mapname") == "mp_boneyard")
	{
		fx_ai4_10((-537,-2008,-88),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((-370,-756,-65),(0,0,0));
		ai_SteadyAim((-553,-756,-76),(0,0,0));
		ai_StoppingPower((-875,-1093,-84),(0,163,0));
		ai_Speedy((-122,-875,-108),(0,90,0));
		ai_Health((1301,-2258,-51),(0,0,0));
		ai_AmmOMatic((-261,-3077,-68),(0,31,0));
		ai_LastStandPro((-565,-2420,0),(0,70,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_terminal")
	{
		fx_ai4_10((609,2763,213),(0,180,0),(607,2808,213));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((550,3062,213),(0,90,0));
		ai_SteadyAim((673,3059,213),(0,90,0));
		ai_StoppingPower((550,3527,213),(0,90,0));
		ai_Speedy((1392,4730,55),(0,90,0));
		ai_Health((1761,4215,448),(0,90,0));
		ai_AmmOMatic((354,4595,201),(0,0,0));
		ai_LastStandPro((674,4020,213),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_brecourt")
	{
		fx_ai4_10((10727,7210,1486),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((9983,6227,358),(0,0,0));
		ai_SteadyAim((10116,6224,358),(0,0,0));
		ai_StoppingPower((10241,6224,358),(0,0,0));
		ai_Speedy((10374,-6224,358),(0,0,0));
		ai_Health((10528,6222,358),(0,0,0));
		ai_AmmOMatic((11909,7442,1486),(0,0,0));
		ai_LastStandPro((11911,6989,1486),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_overgrown")
	{
		fx_ai4_8((1284,2651,-157),(0,90,0));
	}
	if(getDvar("mapname") == "mp_compact")
	{
		fx_ai4_10((2807.9,2835.5,70.1),(0,90,0),(2756,2840,70));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_CreateRamps((1957.5,2666.8,0.1),(2027.9,2406.3,130));
		ai_SpeedReload((2060.0,3351.9,77.5),(0,0,0));
		ai_SteadyAim((2103.9,2078.5,16.1),(0,90,0));
		ai_StoppingPower((1608.1,2261.2,16.1),(0,90,0));
		ai_Speedy((2491.9,2472.4,29.0),(0,-90,0));
		ai_Health((1937.4,2392.1,16.1),(0,0,0));
		ai_AmmOMatic((1753,2360,11),(0,0,0));
		ai_LastStandPro((1718,2399,11),(0,0,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_crash")
	{
		fx_ai4_8((-1239,-2646,86),(0,90,0));
	}
	if(getDvar("mapname") == "mp_abandon")
	{
		fx_ai4_10((-1553,2798,3),(0,141,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((-2119,3865,3),(0,20,0));
		ai_SteadyAim((-2898,3629,3),(0,38,0));
		ai_StoppingPower((-3878,2865,3),(0,140,0));
		ai_Speedy((-3281,2486,3),(0,318,0));
		ai_Health((-2248,1351,3),(0,323,0));
		ai_AmmOMatic((-2552,1984,3),(0,140,0));
		ai_LastStandPro((-1901,1150,3),(0,189,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_complex")
	{
		fx_ai4_10((3164,-1536,1051),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_SpeedReload((3166,-1787,1051),(0,90,0));
		ai_SteadyAim((2624,-1642,1051),(0,90,0));
		ai_StoppingPower((2625,-1473,1051),(0,90,0));
		ai_Speedy((3167,-1346,1051),(0,90,0));
		ai_Health((2936,-767,1051),(0,0,0));
		ai_AmmOMatic((2628,-1067,1051),(0,90,0));
		ai_LastStandPro((3138,-899,1051),(0,90,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
	if(getDvar("mapname") == "mp_trailerpark")
	{
		fx_ai4_10((1958.9,-1706.1,15.4),(0,0,0),(1963,-1752,15));
		foreach(player in level.players)
		{
			player thread fx_ai4_2( "Upgrade Has Spawned" );
		}
		wait 3.0;
		ai_CreateRamps((1739.2, -2213.0, 0), (1741.3, -2479, 190.1));
		ai_SpeedReload((1613.4,-2907.3,190.1),(0,73.6,0));
		ai_SteadyAim((2124.6,-3191.7,190.1),(0,180,0));
		ai_StoppingPower((1918.2,-3199.3,190.1),(0,180,0));
		ai_Speedy((2165.5,-2986.4,190.1),(0,-90,0));
		ai_Health((1672.3,-2478.2,190.1),(0,90,0));
		ai_AmmOMatic((1468,-2950,15),(0,0,0));
		ai_LastStandPro((649,-2676,15),(0,180,0));
		foreach(player in level.players)
		{
			player thread fx_ai4_3( "Perks Have Spawned" );
		}
		wait 3.0;
	}
}

ai_EmpEffect()
{
	level._effect["empuse"] = loadfx ("explosions/emp_flash_mp");
	PlayFx(level._effect["empuse"],self.origin);
}

ai_PowerHud()
{
	self endon("disconnect");
	if(!isDefined(self.powertext))
	{
		self.powertext = self createFontString( "default", 2 );
		self.powertext setPoint( "TOPRIGHT", "TOPRIGHT", 0, 30);
		self.powertext.HideWhenInMenu = true;
	}
	while(1)
	{
		if(level.power <= 0)
		{
			self.powertext setText ("Power Not Activated");
			self.powertext.fontScale = 1.650;
			self.powertext.glowColor = (0.9,0.3,0.3);
			self.powertext.glowAlpha = 1;
		}
		else
		{
			self.powertext fadeOverTime( 3.00 );
			self.powertext.alpha = 0;
			wait 3.0;
			self.powertext setText ("Power Activated");
			self.powertext.fontScale = 1.650;
			self.powertext.glowColor = (0.3,0.9,0.3);
			self.powertext.glowAlpha = 1;
			self.powertext fadeOverTime( 2.00 );
			self.powertext.alpha = 1;
			wait 2.0;
			self.powertext ChangeFontScaleOverTime( 0.1 );
			self.powertext.fontScale = 1.850;
			wait 0.1;
			self.powertext ChangeFontScaleOverTime( 0.1 );
			self.powertext.fontScale = 1.650;
		}
		level waittill("power_activated");
	}
}

ai_MoneyGambler()
{
	self endon("disconnect");
	switch(randomInt(22))
	{
		case 0: self iPrintlnBold(" ^2You have won $500");
		self.money += 500;
		self thread ai_mapedit_Money();
		self notify("MONEY");
		break;
		case 1: self iPrintlnBold(" ^2You have won $1000");
		self.money += 1000;
		self thread ai_mapedit_Money();
		self notify("MONEY");
		break;
		case 2: self iPrintlnBold(" ^1You have lost -$1000");
		self.money -= 1000;
		self notify("MONEY");
		break;
		case 3: self iPrintlnBold(" ^2You have won $1500");
		self.money += 1500;
		self thread ai_mapedit_Money();
		self notify("MONEY");
		break;
		case 4: self iPrintlnBold(" ^2You have won $2000");
		self.money += 2000;
		self thread ai_mapedit_Money();
		self notify("MONEY");
		break;
		case 5: self iPrintlnBold(" ^2You have won $5000");
		self.money += 5000;
		self thread ai_mapedit_Money();
		self notify("MONEY");
		break;
		case 6: self iPrintlnBold(" ^2You have won $10000");
		self.money += 10000;
		self thread ai_mapedit_Money();
		self notify("MONEY");
		break;
		case 7: self iPrintlnBold(" ^2You have won $7500");
		self.money += 7500;
		self thread ai_mapedit_Money();
		self notify("MONEY");
		break;
		case 8: self iPrintlnBold(" ^1You have lost all your cash");
		self.money = 0;
		self notify("MONEY");
		break;
		case 9: self iPrintlnBold(" ^1You have lost -$500");
		self.money -= 500;
		self notify("MONEY");
		break;
		case 10: self iPrintlnBold(" ^2You have won a Predator Missile");
		self fx_ai4_14( "predator_missile", true );
		self fx_ai4_12( "predator_missile_pickup");
		case 11: self iPrintlnBold(" ^2You have won a Airstrike");
		self playlocalsound("mp_level_up");
		self fx_ai4_14( "uav", true );
		self fx_ai4_12( "airstrike");
		break;
		case 12: self iPrintlnBold(" ^2You have won a Sentry Gun!");
		self fx_ai4_14( "sentry", true );
		self fx_ai4_12( "sentry_pickup");
		break;
		case 13: self iPrintlnBold(" ^2You have won a Super Airstrike");
		self fx_ai4_14( "counter_uav", true );
		self fx_ai4_12( "ac130");
		break;
		case 14: self iPrintlnBold(" ^2You have won an Overwatch");
		self thread maps\mp\_modmenu_ai5::ai_OverwatchStreak();
		self thread maps\mp\_modmenu_ai3::ai_TextPopup2("Press [{+actionslot 2}] to use Overwatch");
		self fx_ai4_12( "littlebird_support");
		break;
		case 15: self iPrintlnBold(" ^2You have won a Extra Weapon Slot");
		self giveWeapon("defaultweapon_mp",10,false);
		wait 0.1;
		self switchToWeapon("defaultweapon_mp",10,false);
		break;
		case 16: self iPrintlnBold(" ^2You have won a Model 1887");
		self.curWeap = self getCurrentWeapon();
		self takeWeapon(self.curWeap);
		self giveWeapon("model1887_fmj_mp",0,false);
		wait 0.1;
		self switchToWeapon("model1887_fmj_mp",0,false);
		self giveMaxAmmo("model1887_fmj_mp",0,false);
		break;
		case 17: self iPrintlnBold("^2God decides if you live or die in 5 seconds");
		wait 1;
		self iPrintlnBold("^24");
		wait 1;
		self iPrintlnBold("^23");
		wait 1;
		self iPrintlnBold("^22");
		wait 1;
		self iPrintlnBold("^21");
		wait 1;
		self thread ai_Die();
		break;
		case 18: self iPrintlnBold("^3You have a 1/2 Chance of a Max Ammo");
		wait 2;
		self thread ai_MaxAmmoRandom();
		break;
		case 19: self iPrintlnBold("^2You get infinite health for 30 seconds");
		self thread ai_InfiniteHealth();
		break;
		case 20: self iPrintlnBold("^2You get double health for 30 seconds");
		self thread ai_DoubleHealth();
		break;
		case 21: self iPrintlnBold("^1All Perks Tooken away and $200");
		self thread ai_TakePerks();
		break;
	}
}

ai_mapedit_Money()
{
	level._effect["money"] = loadfx ("props/cash_player_drop");
	PlayFx(level._effect["money"],self.origin);
}

ai_Die()
{
	switch(randomInt(4))
	{
		case 0: self notify("menuresponse", game["menu_team"], "spectator");
		break;
		case 1: self iPrintlnBold("^2You live");
		break;
		case 2: self iPrintlnBold("^2You live");
		break;
		case 3: self iPrintlnBold("^2You live");
		break;
	}
}

ai_MaxAmmoRandom()
{
	switch(randomInt(2))
	{
		case 0: self iPrintlnBold("^2You have won the MaxAmmo!");
		self maps\mp\killstreaks\_airdrop::refillAmmo();
		break;
		case 1: self iPrintlnBold("^1No Max Ammo For You!");
		break;
	}
}

ai_InfiniteHealth()
{
	if(self.health == 100)
	{
		self.maxhealth = 999999;
		self.health = self.maxhealth;
		self.nobuyhealth = 1;
		self thread fx_ai4_1( "Infinite Health", "infinite_health_end" );
		wait 30;
		self notify("infinite_health_end");
		self.maxhealth = 100;
		self.health = self.maxhealth;
		self iPrintlnBold("^1Infinite Health Over!");
		self.nobuyhealth = 0;
	}
	else if(self.health == 200)
	{
		self.maxhealth = 999999;
		self.health = self.maxhealth;
		self.health = 20000;
		self.nobuyhealth = 1;
		self thread fx_ai4_1( "Infinite Health", "infinite_health_end" );
		wait 30;
		self notify("infinite_health_end");
		self.maxhealth = 200;
		self.health = self.maxhealth;
		self iPrintlnBold("^1Infinite Health Over!");
		self.nobuyhealth = 0;
	}
}

ai_DoubleHealth()
{
	if(self.health == 100)
	{
		self.maxhealth = 200;
		self.health = self.maxhealth;
		self.nobuyhealth = 1;
		self thread fx_ai4_1( "Double Health", "double_health_end" );
		wait 30;
		self notify("double_health_end");
		self.maxhealth = 100;
		self.health = self.maxhealth;
		self iPrintlnBold("^1Double Health Over!");
		self.nobuyhealth = 0;
	}
	else if(self.health == 200)
	{
		self.maxhealth = 400;
		self.health = self.maxhealth;
		self.nobuyhealth = 1;
		self thread fx_ai4_1( "Double Health", "double_health_end" );
		wait 30;
		self notify("double_health_end");
		self.maxhealth = 200;
		self.health = self.maxhealth;
		self iPrintlnBold("^1Double Health Over!");
		self.nobuyhealth = 0;
	}
}

ai_TakePerks()
{
	if ( self _hasPerk( "specialty_finalstand" ) )
	{
		self _ClearPerks();
		self fx_ai4_15( "specialty_finalstand" );
	}
	else
	{
		self _ClearPerks();
	}
	self.speedy = 0;
	self.stoppingpower = 0;
	self.steadyaim = 0;
	self.speedreload = 0;
	self.maxhealth = 100;
	self.health = self.maxhealth;
	self.ammomatic = 0;
	self.extra = 1;
	self.zombieperks = 0;
	self thread maps\mp\_modmenu_ai2::ai_DestoyPerkHud();
	self.money -= 200;
}

ai_TriggerSolid(pos, angle, number, width, height)
{
	trigger = spawn( "trigger_radius", pos, 0, width, height );
	trigger.angles = angle;
	trigger Solid();
	trigger setContents(1);
	trigger Solid();
}

ai_BoxSwitchAfghan()
{
	switch(randomInt(4))
	{
		case 0: level thread ai_BoxMoveAnimation();
		wait 4;
		level.blockfreeze delete();
		level.bearmove delete();
		foreach( player in level.players )
		{
			player playLocalSound( "emp_activate" );
		}
		fx_ai4_8((-1672,-1081,-1444),(0,44,0));
		wait 0.1;
		level.boxposition = 0;
		level.box = 0;
		break;
		case 1: level thread ai_BoxMoveAnimation();
		wait 4;
		level.blockfreeze delete();
		level.bearmove delete();
		foreach( player in level.players )
		{
			player playLocalSound( "emp_activate" );
		}
		fx_ai4_8((-3434,1581,-1443),(0,115,0));
		wait 0.1;
		level.boxposition = 1;
		level.box = 0;
		break;
		case 2: level thread ai_BoxMoveAnimation();
		wait 4;
		level.blockfreeze delete();
		level.bearmove delete();
		foreach( player in level.players )
		{
			player playLocalSound( "emp_activate" );
		}
		fx_ai4_8((-2629,-267,-1439),(0,79,0));
		wait 0.1;
		level.boxposition = 2;
		level.box = 0;
		break;
		case 3: level thread ai_BoxMoveAnimation();
		wait 4;
		level.blockfreeze delete();
		level.bearmove delete();
		foreach( player in level.players )
		{
			player playLocalSound( "emp_activate" );
		}
		fx_ai4_8((-2755,-1177,-1440),(0,73,0));
		wait 0.1;
		level.boxposition = 3;
		level.box = 0;
		break;
	}
}

ai_BoxSwitchHighrise()
{
	switch(randomInt(4))
	{
		case 0: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((-8060.7,6789.3,2331.1),(0,0,0));
		wait 0.1;
		level.boxposition = 0;
		level.box = 0;
		break;
		case 1: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((-9049.5,6786.7,2331.1),(0,0,0));
		wait 0.1;
		level.boxposition = 1;
		level.box = 0;
		break;
		case 2: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((-8942.2,4284.3,2331.1),(0,225,0));
		wait 0.1;
		level.boxposition = 2;
		level.box = 0;
		break;
		case 3: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((-9248.9,5427.1,2331.1),(0,90,0));
		wait 0.1;
		level.boxposition = 3;
		level.box = 0;
		break;
	}
}

ai_BoxSwitchHighrise2()
{
	switch(randomInt(4))
	{
		case 0: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((-13630.1,3855.1,5439.1),(0,0,0));
		wait 0.1;
		level.boxposition = 0;
		level.box = 0;
		break;
		case 1: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((-14032.2,7520.0,5391.1),(0,35,0));
		wait 0.1;
		level.boxposition = 1;
		level.box = 0;
		break;
		case 2: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((-15771.6,6051.3,5439.1),(0,90,0));
		wait 0.1;
		level.boxposition = 2;
		level.box = 0;
		break;
		case 3: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((-14614.7,7443.9,5386.1),(0,33,0));
		wait 0.1;
		level.boxposition = 3;
		level.box = 0;
		break;
	}
}

ai_BoxSwitchSkidrow()
{
	if(level.edit == 0) switch(randomInt(5))
	{
		case 0: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((-2000.1,-366.9,144.1),(0,90,0));
		wait 0.1;
		level.boxposition = 0;
		level.box = 0;
		break;
		case 1: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((-2356.7,-912.9,139.1),(0,0,0));
		wait 0.1;
		level.boxposition = 1;
		level.box = 0;
		break;
		case 2: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((-1176.0,-1986.6,11.1),(0,180,0));
		wait 0.1;
		level.boxposition = 2;
		level.box = 0;
		break;
		case 3: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((-1432.0,-192.9,3.1),(0,180,0));
		wait 0.1;
		level.boxposition = 3;
		level.box = 0;
		break;
		case 4: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((-1414.8,-1984.9,3.1),(0,180,0));
		wait 0.1;
		level.boxposition = 4;
		level.box = 0;
		break;
	}
	else if(level.edit == 1) switch(randomInt(5))
	{
		case 0: level thread ai_BoxMoveAnimation();
		wait 3;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((1965,-500,16),(0,90,0));
		wait 0.1;
		level.boxposition = 0;
		level.box = 0;
		break;
		case 1: level thread ai_BoxMoveAnimation();
		wait 3;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((1574,426,24),(0,90,0));
		wait 0.1;
		level.boxposition = 1;
		level.box = 0;
		break;
		case 2: level thread ai_BoxMoveAnimation();
		wait 3;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((505,-734,11),(0,90,0));
		wait 0.1;
		level.boxposition = 2;
		level.box = 0;
		break;
		case 3: level thread ai_BoxMoveAnimation();
		wait 3;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((865,-2096,43),(0,180,0));
		wait 0.1;
		level.boxposition = 3;
		level.box = 0;
		break;
		case 4: level thread ai_BoxMoveAnimation();
		wait 3;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((1631,-770,119),(0,90,0));
		wait 0.1;
		level.boxposition = 4;
		level.box = 0;
		break;
	}
	else if(level.edit == 2) switch(randomInt(3))
	{
		case 0: level thread ai_BoxMoveAnimation();
		wait 3;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((2040,-1266,16),(0,90,0));
		wait 0.1;
		level.boxposition = 0;
		level.box = 0;
		break;
		case 1: level thread ai_BoxMoveAnimation();
		wait 3;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((1590,-1393,8),(0,90,0));
		wait 0.1;
		level.boxposition = 1;
		level.box = 0;
		break;
		case 2: level thread ai_BoxMoveAnimation();
		wait 3;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((1830,-2360,4),(0,0,0));
		wait 0.1;
		level.boxposition = 2;
		level.box = 0;
		break;
	}
}

ai_BoxSwitchDerail()
{
	switch(randomInt(3))
	{
		case 0: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((1790,3371,294),(0,0,0));
		wait 0.1;
		level.boxposition = 0;
		level.box = 0;
		break;
		case 1: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((2191,2949,158),(0,90,0));
		wait 0.1;
		level.boxposition = 1;
		level.box = 0;
		break;
		case 2: level thread ai_BoxMoveAnimation();
		wait 5;
		level.blockmove delete();
		level playSound( "emp_activate" );
		fx_ai4_8((1901,2060,294),(0,0,0));
		wait 0.1;
		level.boxposition = 2;
		level.box = 0;
		break;
	}
}

ai_BoxMoveAnimation()
{
	level endon("disconnect");
	if(getDvar("mapname") == "mp_afghan" && level.boxposition == 0)
	{
		level.blockfreeze = spawn("script_model", (-1672,-1081,-1444));
		level.blockfreeze.angles = (0,40,0);
		level.blockfreeze setModel("com_plasticcase_friendly");
		level.blockfreeze Solid();
		level.blockfreeze CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		level.bearmove = spawn("script_model", level.blockfreeze.origin + (0,0,30));
		level.bearmove.angles = (0,180,0);
		level.bearmove setModel("com_teddy_bear");
		level.bearmove scriptModelPlayAnim("pb_sprint");
		wait 1;
		level.bearmove MoveTo(level.bearmove.origin+(0,0,40), 3);
	}
	else if(getDvar("mapname") == "mp_afghan" && level.boxposition == 1)
	{
		level.blockfreeze = spawn("script_model", (-3434,1581,-1443));
		level.blockfreeze.angles = (0,0,0);
		level.blockfreeze setModel("com_plasticcase_friendly");
		level.blockfreeze Solid();
		level.blockfreeze CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		level.bearmove = spawn("script_model", level.blockfreeze.origin + (0,0,30));
		level.bearmove.angles = (0,90,0);
		level.bearmove setModel("com_teddy_bear");
		wait 1;
		level.bearmove MoveTo(level.bearmove.origin+(0,0,40), 3);
	}
	else if(getDvar("mapname") == "mp_afghan" && level.boxposition == 2)
	{
		level.blockfreeze = spawn("script_model", (-2629,-267,-1439));
		level.blockfreeze.angles = (0,90,0);
		level.blockfreeze setModel("com_plasticcase_friendly");
		level.blockfreeze Solid();
		level.blockfreeze CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		level.bearmove = spawn("script_model", level.blockfreeze.origin + (0,0,30));
		level.bearmove.angles = (0,180,0);
		level.bearmove setModel("com_teddy_bear");
		wait 1;
		level.bearmove MoveTo(level.bearmove.origin+(0,0,40), 3);
	}
	else if(getDvar("mapname") == "mp_afghan" && level.boxposition == 3)
	{
		level.blockfreeze = spawn("script_model", (-2755,-1177,-1440));
		level.blockfreeze.angles = (0,0,0);
		level.blockfreeze setModel("com_plasticcase_friendly");
		level.blockfreeze Solid();
		level.blockfreeze CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		level.bearmove = spawn("script_model", level.blockfreeze.origin + (0,0,30));
		level.bearmove.angles = (0,90,0);
		level.bearmove setModel("com_teddy_bear");
		wait 1;
		level.bearmove MoveTo(level.bearmove.origin+(0,0,40), 3);
	}
	if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.boxposition == 0)
	{
		level.blockmove = spawn("script_model", (-8060.7,6789.3,2331.1));
		level.blockmove.angles = (0,0,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,100), 5);
	}
	else if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.boxposition == 1)
	{
		level.blockmove = spawn("script_model", (-9049.5,6786.7,2331.1));
		level.blockmove.angles = (0,0,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,100), 5);
	}
	else if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.boxposition == 2)
	{
		level.blockmove = spawn("script_model", (-8942.2,4284.3,2331.1));
		level.blockmove.angles = (0,225,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,100), 5);
	}
	else if(getDvar("mapname") == "mp_highrise" && level.edit == 0 && level.boxposition == 3)
	{
		level.blockmove = spawn("script_model", (-9248.9,5427.1,2331.1));
		level.blockmove.angles = (0,90,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,100), 5);
	}
	if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.boxposition == 0)
	{
		level.blockmove = spawn("script_model", (-13630.1,3855.1,5439.1));
		level.blockmove.angles = (0,0,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,100), 5);
	}
	else if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.boxposition == 1)
	{
		level.blockmove = spawn("script_model", (-14032.2,7520.0,5391.1));
		level.blockmove.angles = (0,35,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,100), 5);
	}
	else if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.boxposition == 2)
	{
		level.blockmove = spawn("script_model", (-15771.6,6051.3,5439.1));
		level.blockmove.angles = (0,90,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,100), 5);
	}
	else if(getDvar("mapname") == "mp_highrise" && level.edit == 1 && level.boxposition == 3)
	{
		level.blockmove = spawn("script_model", (-14614.7,7443.9,5386.1));
		level.blockmove.angles = (0,33,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,100), 5);
	}
	if(getDvar("mapname") == "mp_nightshift" && level.boxposition == 0 && level.edit == 0)
	{
		level.blockmove = spawn("script_model", (-2000.1,-366.9,144.1));
		level.blockmove.angles = (0,90,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,100), 5);
	}
	else if(getDvar("mapname") == "mp_nightshift" && level.boxposition == 1 && level.edit == 0)
	{
		level.blockmove = spawn("script_model", (-2356.7,-912.9,139.1));
		level.blockmove.angles = (0,0,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,100), 5);
	}
	else if(getDvar("mapname") == "mp_nightshift" && level.boxposition == 2 && level.edit == 0)
	{
		level.blockmove = spawn("script_model", (-1176.0,-1986.6,11.1));
		level.blockmove.angles = (0,180,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,100), 5);
	}
	else if(getDvar("mapname") == "mp_nightshift" && level.boxposition == 3 && level.edit == 0)
	{
		level.blockmove = spawn("script_model", (-1432.0,-192.9,3.1));
		level.blockmove.angles = (0,180,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,100), 5);
	}
	else if(getDvar("mapname") == "mp_nightshift" && level.boxposition == 4 && level.edit == 0)
	{
		level.blockmove = spawn("script_model", (-1414.8,-1984.9,3.1));
		level.blockmove.angles = (0,180,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,100), 5);
	}
	if(getDvar("mapname") == "mp_nightshift" && level.boxposition == 0 && level.edit == 1)
	{
		level.blockmove = spawn("script_model", (1965,-500,16));
		level.blockmove.angles = (0,90,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,60), 3);
	}
	else if(getDvar("mapname") == "mp_nightshift" && level.boxposition == 1 && level.edit == 1)
	{
		level.blockmove = spawn("script_model", (1574,426,24));
		level.blockmove.angles = (0,90,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,60), 3);
	}
	else if(getDvar("mapname") == "mp_nightshift" && level.boxposition == 2 && level.edit == 1)
	{
		level.blockmove = spawn("script_model", (505,-734,11));
		level.blockmove.angles = (0,90,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,60), 3);
	}
	else if(getDvar("mapname") == "mp_nightshift" && level.boxposition == 3 && level.edit == 1)
	{
		level.blockmove = spawn("script_model", (865,-2096,43));
		level.blockmove.angles = (0,180,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,60), 3);
	}
	else if(getDvar("mapname") == "mp_nightshift" && level.boxposition == 4 && level.edit == 1)
	{
		level.blockmove = spawn("script_model", (-1414.8,-1984.9,3.1));
		level.blockmove.angles = (0,90,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,-60), 3);
	}
	if(getDvar("mapname") == "mp_nightshift" && level.boxposition == 0 && level.edit == 2)
	{
		level.blockmove = spawn("script_model", (2040,-1266,16));
		level.blockmove.angles = (0,90,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,60), 3);
	}
	else if(getDvar("mapname") == "mp_nightshift" && level.boxposition == 1 && level.edit == 2)
	{
		level.blockmove = spawn("script_model", (1590,-1393,8));
		level.blockmove.angles = (0,90,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,60), 3);
	}
	else if(getDvar("mapname") == "mp_nightshift" && level.boxposition == 2 && level.edit == 2)
	{
		level.blockmove = spawn("script_model", (1830,-2360,4));
		level.blockmove.angles = (0,0,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,60), 3);
	}
	if(getDvar("mapname") == "mp_derail" && level.boxposition == 0)
	{
		level.blockmove = spawn("script_model", (1790,3371,294));
		level.blockmove.angles = (0,0,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,60), 5);
	}
	else if(getDvar("mapname") == "mp_derail" && level.boxposition == 1)
	{
		level.blockmove = spawn("script_model", (2191,2949,158));
		level.blockmove.angles = (0,90,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,60), 5);
	}
	else if(getDvar("mapname") == "mp_derail" && level.boxposition == 2)
	{
		level.blockmove = spawn("script_model", (1901,2060,294));
		level.blockmove.angles = (0,0,0);
		level.blockmove setModel("com_plasticcase_friendly");
		level.blockmove Solid();
		level.blockmove MoveTo(level.blockmove.origin+(0,0,60), 5);
	}
}

// Relays: one far call per function (precache entries of the script loader).
fx_ai4_1()
{
    return self maps\mp\_modmenu_ai1::ai_BonusDropHud();
}

fx_ai4_2()
{
    return self maps\mp\_modmenu_ai2::ai_IntroText();
}

fx_ai4_3()
{
    return self maps\mp\_modmenu_ai2::ai_IntroText2();
}

fx_ai4_4(a1, a2, a3, a4, a5)
{
    return self maps\mp\_modmenu_ai2::ai_TextMap( a1, a2, a3, a4, a5 );
}

fx_ai4_5(a1, a2, a3, a4, a5)
{
    return self maps\mp\_modmenu_ai2::ai_TextMap2( a1, a2, a3, a4, a5 );
}

fx_ai4_6(a1, a2)
{
    return self maps\mp\_modmenu_ai3::ai_Ammo( a1, a2 );
}

fx_ai4_7(a1, a2)
{
    return self maps\mp\_modmenu_ai3::ai_Gambler( a1, a2 );
}

fx_ai4_8(a1, a2)
{
    return self maps\mp\_modmenu_ai3::ai_RandomWeapon( a1, a2 );
}

fx_ai4_9()
{
    return self maps\mp\_modmenu_ai3::ai_TextPopup();
}

fx_ai4_10(a1, a2, a3)
{
    return self maps\mp\_modmenu_ai3::ai_Upgrade( a1, a2, a3 );
}

fx_ai4_11()
{
    return self maps\mp\gametypes\_gameobjects::getNextObjID();
}

fx_ai4_12()
{
    return self maps\mp\gametypes\_hud_message::killstreakSplashNotify();
}

fx_ai4_13(a1, a2, a3, a4)
{
    return self maps\mp\gametypes\_rank::scorePopup( a1, a2, a3, a4 );
}

fx_ai4_14(a1, a2)
{
    return self maps\mp\killstreaks\_killstreaks::giveKillstreak( a1, a2 );
}

fx_ai4_15()
{
    return self maps\mp\perks\_perks::givePerk();
}
