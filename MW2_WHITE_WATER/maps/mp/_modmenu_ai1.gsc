// AI Zombies eXtreme V1.8 ([115]Death) -- the patch's own functions from aimod/_airdrop.gsc, aimod/_airdropfunc.gsc, aimod/_bot.gsc, aimod/_botutil.gsc,
// renamed ai_* and called by maps\mp\_modmenu_ai.gsc.
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ai_getFlyHeightOffset( dropSite )
{
	lbFlyHeight = 5000;
	heightEnt = GetEnt( "airstrikeheight", "targetname" );
	if ( !isDefined( heightEnt ) )
	{
		if ( isDefined( level.airstrikeHeightScale ) )
		{
			if ( level.airstrikeHeightScale > 2 )
			{
				lbFlyHeight = 5000;
				return( lbFlyHeight * (level.airStrikeHeightScale ) );
			}
			return( lbFlyHeight * level.airStrikeHeightScale + 2000 + dropSite[2] );
		}
		else return ( lbFlyHeight + dropsite[2] );
	}
	else
	{
		return heightEnt.origin[2];
	}
}

ai_c130Setup( owner, pathStart, pathGoal )
{
	forward = vectorToAngles( pathGoal - pathStart );
	c130 = spawnplane( owner, "script_model", pathStart, "compass_objpoint_c130_friendly", "compass_objpoint_c130_enemy" );
	c130 setModel( "vehicle_ac130_low_mp" );
	if ( !isDefined( c130 ) )
	{
		return;
	}
	c130.owner = owner;
	c130.team = "allies";
	level.c130 = c130;
	return c130;
}

ai_createAirDropCrate( owner, dropType, crateType, startPos )
{
	dropCrate = spawn( "script_model", startPos );
	dropCrate.curProgress = 0;
	dropCrate.useTime = 0;
	dropCrate.useRate = 0;
	dropCrate.team = self.team;
	if ( isDefined( owner ) )
	{
		dropCrate.owner = owner;
	}
	else
	{
		dropCrate.owner = undefined;
	}
	dropCrate.targetname = "care_package";
	dropCrate setModel( "com_plasticcase_friendly" );
	return dropCrate;
}

ai_dropTheCrate( dropPoint, dropType, lbHeight, dropImmediately, crateOverride, startPos )
{
	dropCrate = [];
	self.owner endon ( "disconnect" );
	dropCrate = ai_createAirDropCrate( self.owner, dropType, undefined, startPos );
	dropCrate LinkTo( self, "tag_ground" , (64,32,-128) , (0,0,0) );
	dropCrate.angles = (0,0,0);
	dropCrate show();
	dropSpeed = self.veh_speed;
	self waittill ( "drop_crate" );
	dropCrate Unlink();
	dropCrate PhysicsLaunchServer( (0,0,0), (0,0,0) );
	dropCrate setModel( "com_plasticcase_friendly" );
	dropCrate hide();
	ammodrop = spawn("script_model", dropCrate.origin - (0, 0, 15));
	ammodrop setModel("com_plasticcase_friendly");
	ammodrop.classname = "ammoDrop";
	ammodrop linkTo(dropCrate);
	ammodrop thread ai_rotateBonusDrop();
	ammodrop.trigger = spawn("trigger_radius", ammodrop.origin,0,75,50);
	switch(randomInt(5))
	{
		case 0: ammodrop.trigger thread ai_AmmoDropThink();
		ammodrop.headIcon = newHudElem();
		ammodrop.headIcon.x = ammodrop.origin[0];
		ammodrop.headIcon.y = ammodrop.origin[1];
		ammodrop.headIcon.z = ammodrop.origin[2] + 50;
		ammodrop.headIcon.alpha = 0.85;
		ammodrop.headIcon setShader( "waypoint_ammo_friendly", 10,10 );
		ammodrop thread ai__airdropfunc_monitorIconOrigin( ammodrop.headIcon );
		ammodrop.headIcon setWaypoint( true, true, false );
		break;
		case 1: ammodrop.trigger thread ai_InfiniteAmmoDropThink();
		ammodrop.headIcon = newHudElem();
		ammodrop.headIcon.x = ammodrop.origin[0];
		ammodrop.headIcon.y = ammodrop.origin[1];
		ammodrop.headIcon.z = ammodrop.origin[2] + 50;
		ammodrop.headIcon.alpha = 0.85;
		ammodrop.headIcon setShader( "dpad_killstreak_sentry_gun", 10,10 );
		ammodrop thread ai__airdropfunc_monitorIconOrigin( ammodrop.headIcon );
		ammodrop.headIcon setWaypoint( true, true, false );
		break;
		case 2: ammodrop.trigger thread ai_AdrenalineDropThink();
		ammodrop.headIcon = newHudElem();
		ammodrop.headIcon.x = ammodrop.origin[0];
		ammodrop.headIcon.y = ammodrop.origin[1];
		ammodrop.headIcon.z = ammodrop.origin[2] + 50;
		ammodrop.headIcon.alpha = 0.85;
		ammodrop.headIcon setShader( "cardicon_doubletap", 10,10 );
		ammodrop thread ai__airdropfunc_monitorIconOrigin( ammodrop.headIcon );
		ammodrop.headIcon setWaypoint( true, true, false );
		break;
		case 3: ammodrop.trigger thread ai_MoneyDropThink();
		ammodrop.headIcon = newHudElem();
		ammodrop.headIcon.x = ammodrop.origin[0];
		ammodrop.headIcon.y = ammodrop.origin[1];
		ammodrop.headIcon.z = ammodrop.origin[2] + 50;
		ammodrop.headIcon.alpha = 0.85;
		ammodrop.headIcon setShader( "cardicon_gold", 10,10 );
		ammodrop thread ai__airdropfunc_monitorIconOrigin( ammodrop.headIcon );
		ammodrop.headIcon setWaypoint( true, true, false );
		break;
		case 4: ammodrop.trigger thread ai_DeamMachineAirDropThink();
		ammodrop.headIcon = newHudElem();
		ammodrop.headIcon.x = ammodrop.origin[0];
		ammodrop.headIcon.y = ammodrop.origin[1];
		ammodrop.headIcon.z = ammodrop.origin[2] + 50;
		ammodrop.headIcon.alpha = 0.85;
		ammodrop.headIcon setShader( "cardicon_skull", 10,10 );
		ammodrop thread ai__airdropfunc_monitorIconOrigin( ammodrop.headIcon );
		ammodrop.headIcon setWaypoint( true, true, false );
		break;
	}
	ammodrop thread ai_monitorOrigin( ammodrop.trigger );
	ammodrop thread ai_killCrate();
	wait 5;
	ammodrop Unlink();
	dropCrate Unlink();
	dropCrate destroy();
}

ai_C130FlyBy()
{
	owner = maps\mp\_modmenu_ai3::ai_GetHost();
	dropSite = ai_GetAirdropPoint( );
	planeHalfDistance = 24000;
	planeFlySpeed = 2000;
	yaw = vectorToYaw( dropsite );
	direction = ( 0, yaw, 0 );
	flyHeight = self ai_getFlyHeightOffset( dropSite );
	pathStart = dropSite + vector_multiply( anglestoforward( direction ), -1 * planeHalfDistance );
	pathStart = pathStart * ( 1, 1, 0 ) + ( 0, 0, flyHeight );
	pathEnd = dropSite + vector_multiply( anglestoforward( direction ), planeHalfDistance );
	pathEnd = pathEnd * ( 1, 1, 0 ) + ( 0, 0, flyHeight );
	d = length( pathStart - pathEnd );
	flyTime = ( d / planeFlySpeed );
	c130 = ai_c130Setup( owner, pathStart, pathEnd );
	c130.veh_speed = planeFlySpeed;
	c130 playloopsound( "veh_ac130_sonic_boom" );
	c130.angles = direction;
	forward = anglesToForward( direction );
	c130 moveTo( pathEnd, flyTime, 0, 0 );
	minDist = distance2D( c130.origin, dropSite );
	boomPlayed = false;
	for(;;)
	{
		dist = distance2D( c130.origin, dropSite );
		if ( dist < minDist ) minDist = dist;
		else if ( dist > minDist ) break;
		if ( dist < 256 )
		{
			break;
		}
		else if ( dist < 768 )
		{
			earthquake( 0.15, 1.5, dropSite, 1500 );
			if ( !boomPlayed )
			{
				c130 playSound( "veh_ac130_sonic_boom" );
				boomPlayed = true;
			}
		}
		wait ( .05 );
	}
	wait( 0.05 );
	c130 thread ai_dropTheCrate( dropSite, undefined, flyHeight, false, undefined , pathStart );
	wait ( 0.05 );
	c130 notify ( "drop_crate" );
	wait 4.30;
	c130 delete();
}

ai_monitorOrigin( entity )
{
	self endon("crate_gone");
	for(;;)
	{
		entity.origin = self.origin;
		wait 0.05;
	}
}

ai__airdropfunc_monitorIconOrigin( entity )
{
	self endon("random_drop_destroy");
	for(;;)
	{
		entity.x = self.origin[0];
		entity.y = self.origin[1];
		entity.z = self.origin[2] + 50;
		wait 0.05;
	}
}

ai_GetAirdropPoint( )
{
	sReturn = undefined;
	switch( getDvar("mapname") )
	{
		case "mp_afghan": sReturn = (-2125,-780,-1444);
		break;
		case "mp_terminal": sReturn = (1434,3336,1000);
		break;
		case "mp_quarry": sReturn = (-2877,2178,500);
		break;
		case "mp_rust":
		if(level.edit == 0)
			sReturn = (1825,-9861,300);
		if(level.edit == 1)
			sReturn = (1450,-4817,-134);
		break;
		case "mp_derail": sReturn = (2653,1573,500);
		break;
		case "mp_highrise": 
		if(level.edit == 0)
		{
			sReturn = (-8917,5972,3000);
			break;
		}
		if(level.edit == 1)
		{
			sReturn = (-13735,4840,6000);
			break;
		}
		break;
		case "mp_brecourt": sReturn = (9833,6781,700);
		break;
		case "mp_boneyard": sReturn = (36,-1581,329);
		break;
		case "mp_underpass": sReturn = (3855,2627,400);
		break;
		case "mp_nightshift": 
		if(level.edit == 0)
		{
			sReturn = (-1666,-644,1000);
			break;
		}
		if(level.edit == 1)
		{
			sReturn = (686,-1273,500);
			break;
		}
		if(level.edit == 2)
		{
			sReturn = (1779,-1129,500);
			break;
		}
		break;
		case "mp_estate": sReturn = (-2980,-1090,-517);
		break;
		case "mp_favela": sReturn = (2329,2859,800);
		break;
		case "mp_invasion": sReturn = (2423,10866,16);
		break;
		case "mp_checkpoint": sReturn = (2429,2274,11);
		break;
		case "mp_subbase": sReturn = (-337,-4557,600);
		break;
		case "mp_rundown": sReturn = (876, 2593, 80);
		break;
		case "mp_compact": sReturn = (2307,2801,600);
		break;
		case "mp_trailerpark": sReturn = (1569,-2053,600);
		break;
		case "mp_strike": sReturn = (-2593,1441,13);
		break;
		case "mp_complex": sReturn = (2884,-1426,1051);
		break;
		case "mp_vacant": sReturn = (-604,1111,-98);
		break;
		case "mp_abandon": sReturn = (-1338,3444,3);
		break;
		case "mp_storm": sReturn = (3611,-1172,-48);
		break;
	}
	return sReturn;
}

ai_killCrate()
{
	level waittill("random_drop_destroy");
	self delete();
	self.trigger delete();
	self.headIcon destroy();
}

ai__bot_Init()
{
	/* Regular Animations */
	precacheMpAnim("pb_sprint_gundown");
	precacheMpAnim("pb_sprint_akimbo");
	precacheMpAnim("pb_sprint_mg");
	precacheMpAnim("pb_pistol_run_fast");
	precacheMpAnim("pb_sprint_pistol");
	precacheMpAnim("pb_combatrun_forward_loop_stickgrenade");
	precacheMpAnim("pb_sprint_shield");
	precacheMpAnim("pb_walk_forward_shield");
	precacheMpAnim("pb_combatwalk_forward_loop_pistol");
	precacheMpAnim("pb_walk_forward_mg");
	/* Bot Animations */
	precacheMpAnim("pb_stand_alert");
	precacheMpAnim("pb_stand_shoot_walk_forward");
	precacheMpAnim("pt_reload_stand_auto_mp40");
	precacheMpAnim("pt_stand_shoot_auto");
	precacheMpAnim("pb_stand_alert_mg");
	precacheMpAnim("pt_reload_stand_mg");
	precacheMpAnim("pt_stand_shoot_mg");
	/* Regular Death Anim */
	precacheMpAnim("pb_stand_death_leg_kickup");
	precacheMpAnim("pb_stand_death_shoulderback");
	precacheMpAnim("pb_death_run_stumble");
	if(getDvar("mapname") == "mp_afghan" || getDvar("mapname") == "mp_trailerpark" || getDvar("mapname") == "mp_estate")
	{
		precacheMpAnim("pb_shotgun_death_front");
		precacheMpAnim("pb_crouch_death_falltohands");
		precacheMpAnim("pb_crouchrun_death_drop");
		precacheMpAnim("pb_death_run_onfront");
		precacheMpAnim("pb_stand_death_head_straight_back");
		precacheMpAnim("pb_crouchrun_death_drop");
	}
	/* Pain Anim */
	precacheMpAnim("pb_stumble_forward");
	/* Crawling Animations */
	precacheMpAnim("pb_prone_crawl_akimbo");
	precacheMpAnim("pb_prone_death_quickdeath");
	/* Melee Animation */
	precacheMpAnim("pt_melee_pistol_1");

	level.bloodfx = loadfx("impacts/flesh_hit_body_fatal_exit");
	level.nukefx = loadfx("explosions/player_death_nuke");
	level.nuke2fx = loadfx("explosions/player_death_nuke_flash");
	level.empfx = loadfx("explosions/emp_flash_mp");
}

ai_BonusDrops()
{
    self endon("disconnect");
	self endon("bonus_end");
	self endon("bot_is_dead");
	random = randomInt(45);
	randomequels = randomInt(45);
	randomequels2 = randomInt(45);
	self waittill("bot_death");
	if(level.Wave <= 5)
	{
		if(random == randomequels)
		{
			switch(randomInt(7))
			{
			    case 0:
				ai_FreezerDrop(self.origin, self.angles);
				break;
			    case 1:
				ai_NukeDrop(self.origin, self.angles);
				break;
				case 2:
				ai_MoneyDrop(self.origin, self.angles);
				break;
				case 3:
				ai_AdrenalineDrop(self.origin, self.angles);
				break;
				case 4:
				ai_InfiniteAmmoDrop(self.origin, self.angles);
				break;
				case 5:
				ai_DeathMachineDrop(self.origin, self.angles);
				break;
				case 6:
				ai_AmmoDrop(self.origin, self.angles);
				break;
			}
		}
	}
	if(level.Wave >= 5)
	{
		if(random == randomequels == randomequels2)
		{
			switch(randomInt(7))
			{
			    case 0:
				ai_FreezerDrop(self.origin, self.angles);
				break;
			    case 1:
				ai_NukeDrop(self.origin, self.angles);
				break;
				case 2:
				ai_MoneyDrop(self.origin, self.angles);
				break;
				case 3:
				ai_AdrenalineDrop(self.origin, self.angles);
				break;
				case 4:
				ai_InfiniteAmmoDrop(self.origin, self.angles);
				break;
				case 5:
				ai_DeathMachineDrop(self.origin, self.angles);
				break;
				case 6:
				ai_AmmoDrop(self.origin, self.angles);
				break;
			}
		}
	}
}

ai_AmmoDrop(pos, angle)
{
	block = spawn("script_model", pos + (0, 0, 20) );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block notSolid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "waypoint_ammo_friendly", 10,10 );
	block.headIcon setWaypoint( true, true, false );
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_AmmoDropThink(pos);
	trigger thread ai_AmmoDropDestroy();
	block thread ai_AmmoDropDestroy();
	block thread ai_BonusDropAmmoTimerDestroy();
	block thread ai_rotateBonusDrop();
	wait 0.01;
}

ai_rotateBonusDrop()
{
	for(;;)
	{
		self rotateyaw(-360,5);
		wait(5);
	}
}

ai_BonusDropAmmoTimerDestroy()
{
	self endon("ammo_drop_take");
	{
		wait 20;
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		level notify("ammo_drop_take");
	}
}

ai_AmmoDropDestroy()
{
    {
		level waittill("ammo_drop_take");
		self delete();
		self.headIcon destroy();
	}
}

ai_AmmoDropThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			player thread ai_MaxAmmo();
			level notify("ammo_drop_take");
			level notify("random_drop_destroy");
			wait 0.1;
		}
		wait 0.01;
	}
}

ai_NukeDrop(pos, angle)
{
	block = spawn("script_model", pos + (0, 0, 50) );
	block setModel("projectile_cbu97_clusterbomb");
	block.angles = angle-(90,0,0);
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block setContents(0);
	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 70;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "dpad_killstreak_nuke", 10,10 );
	block.headIcon setWaypoint( true, true, false );
	block.headIcon thread ai_NukeIconDestroy();
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_NukeDropThink(pos, angle, block);
	trigger thread ai_NukeDropDestroy();
	block thread ai_NukeDropDestroy();
	block thread ai_BonusDropNukeTimerDestroy();
	block thread ai_rotateBonusDrop();
	block thread ai_MoveNukeIcon(block.headIcon);
	wait 0.01;
}

ai_BonusDropNukeTimerDestroy()
{
	self endon("nuke_drop_take");
	{
		wait 20;
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		level notify("nuke_drop_take");
	}
}

ai_NukeDropDestroy()
{
	level waittill("nuke_drop_take");
	self delete();
	self.headIcon destroy();
}

ai_MoveNukeIcon(entity)
{
	self endon("nuke_icon_destroy");
	for(;;)
	{
		entity.x = self.origin[0];
		entity.y = self.origin[1];
		entity.z = self.origin[2] + 70;
		wait 0.05;
	}
}

ai_NukeIconDestroy()
{
	level waittill("nuke_icon_destroy");
	self destroy();
}

ai_NukeDropThink(pos, angle, block)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
		    block playSound( "veh_mig29_sonic_boom" );
		    block MoveTo(pos+(0,0,4000),6);
			wait 6;
			block.angles = angle+(90,0,0);
			block MoveTo(pos,3);
			wait 3;
			playFx(level.nukefx,self.origin+(0,0,500));
			playFx(level.nuke2fx,self.origin+(0,0,30));
			if(getDvarInt("z_dedicated") == 0)
				setDvar("timescale", 0.5);
			foreach(player in level.players)
			{
				player playlocalsound( "nuke_explosion" );
				player playlocalsound( "nuke_wave" );
			}
			level notify("nuke_drop_kill");
			level notify("nuke_drop_take");
			level notify("random_drop_destroy");
			level notify("nuke_icon_destroy");
			self thread ai_NukeKill();
			foreach(player in level.players)
			{
				earthquake(1,1.5, player.origin + (0,0,40), 60);
			}
			wait 1.5;
			if(getDvarInt("z_dedicated") == 0)
				setDvar("timescale", 1);
			wait 3.5;
			level notify("nuke_drop_end");
			foreach(player in level.players)
			{
			    player.money += 400;
				player thread fx_ai1_12("Nuke");
				player thread fx_ai1_3("Nuke!", 0.85, (25.5,25.5,25.5),(0.9,0.9,0.1),0.60); 
				player thread fx_ai1_2("dpad_killstreak_nuke");
				player notify("MONEY");
				player thread fx_ai1_16( 400, 0, (0,1,0), 1 );
			}
		}
		wait 0.1;
	}
}

ai_NukeKill()
{
    level endon("nuke_drop_end");
    while(1)
	{
	    level notify("nuke_drop_kill");
		wait 0.1;
	}
}

ai_FreezerDrop(pos, angle)
{
	block = spawn("script_model", pos + (0, 0, 50) );
	block setModel("projectile_cbu97_clusterbomb");
	block.angles = angle-(90,0,0);
	block setContents(0);
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 70;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "dpad_killstreak_emp", 10,10 );
	block.headIcon setWaypoint( true, true, false );
	block.headIcon.color = (0.1,0.9,0.9);
	block.headIcon thread ai_FreezerIconDestroy();
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_FreezerDropThink(pos, angle, block, trigger);
	trigger thread ai_FreezerDropDestroy();
	block thread ai_MoveFreezerIcon(block.headIcon);
	block thread ai_BonusDropFreezerTimerDestroy();
	block thread ai_rotateFreezerBonusDrop();
	block thread ai_FreezerDropDestroy();
	wait 0.01;
}

ai_BonusDropFreezerTimerDestroy()
{
	level endon("freeze_drop_take");
	{
		wait 20;
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		level notify("freeze_drop_notake");
	}
}

ai_rotateFreezerBonusDrop()
{
    level endon("freeze_drop_take");
	for(;;)
	{
		self rotateyaw(-360,5);
		wait(5);
	}
}

ai_MoveFreezerIcon(entity)
{
	self endon("freeze_drop");
	for(;;)
	{
		entity.x = self.origin[0];
		entity.y = self.origin[1];
		entity.z = self.origin[2] + 70;
		wait 0.05;
	}
}

ai_FreezerIconDestroy()
{
	level waittill("freeze_drop");
	self destroy();
}

ai_FreezerDropDestroy()
{
	level waittill("freeze_drop_notake");
	self delete();
	self.headIcon destroy();
}

ai_FreezerDropThink(pos, angle, block, trigger)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			trigger delete();
		    block playSound( "veh_mig29_sonic_boom" );
		    block MoveTo(pos+(0,0,4000),6);
			level notify("freeze_drop_take");
			level notify("random_drop_destroy");
			foreach(player in level.players)
			{
				player thread fx_ai1_3("Freezer!", 0.85, (25.5,25.5,25.5),(0.1,0.9,0.9),0.60); 
				player thread fx_ai1_2("dpad_killstreak_emp", (0.1,0.9,0.9));
			}
			wait 6;
			level notify("freeze_drop");
			block playSound( "emp_activate" );
			playFx(level.empfx,block.origin);
			level notify("freeze_drop_notake");
			level thread ai_FreezeZombies();
			wait 10;
			level notify("freeze_over");
			level notify("freeze_model_gone");
			foreach(player in level.players)
			{
			    player.money += 200;
				player thread fx_ai1_12("Freezer");
				player notify("MONEY");
				player thread fx_ai1_16( 200, 0, (0,1,0), 1 );
			}
		}
		wait 0.1;
	}
}

ai_FreezeZombies()
{
	for(i = 0; i < 15; i += 1)
	{
		foreach(zombie in level.bots)
		{
			if(zombie.pers["isAlive"] == "false")
				continue;
			
			zombie.freezed = 1;
			zombie.speed = 1;
		}
		wait 1;
	}
	foreach(zombie in level.bots)
	{
		if(zombie.pers["isAlive"] == "false")
			continue;
			
		zombie.freezed = 0;
		zombie.speed = zombie.speed2;
	}
}

ai_InfiniteAmmoDrop(pos, angle)
{
	block = spawn("script_model", pos + (0, 0, 20) );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block notSolid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "dpad_killstreak_sentry_gun", 10,10 );
	block.headIcon setWaypoint( true, true, false );
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_InfiniteAmmoDropThink(pos);
	trigger thread ai_InfiniteAmmoDropDestroy();
	block thread ai_InfiniteAmmoDropDestroy();
	block thread ai_BonusDropInfiniteAmmoTimerDestroy();
	block thread ai_rotateBonusDrop();
	wait 0.01;
}

ai_BonusDropInfiniteAmmoTimerDestroy()
{
	self endon("infinite_ammo_drop_take");
	{
		wait 20;
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		level notify("infinite_ammo_drop_take");
	}
}

ai_InfiniteAmmoDropDestroy()
{
    {
		level waittill("infinite_ammo_drop_take");
		self delete();
		self.headIcon destroy();
	}
}

ai_InfiniteAmmoDropThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			foreach(player in level.players)
			{
				player thread ai_InfiniteAmmo();
			}
			level notify("infinite_ammo_drop_take");
			level notify("random_drop_destroy");
			wait 0.1;
		}
		wait 0.1;
	}
}

ai_AdrenalineDrop(pos, angle)
{
	block = spawn("script_model", pos + (0, 0, 20) );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block notSolid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "cardicon_doubletap", 10,10 );
	block.headIcon setWaypoint( true, true, false );
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_AdrenalineDropThink(pos);
	trigger thread ai_AdrenalineDropDestroy();
	block thread ai_AdrenalineDropDestroy();
	block thread ai_BonusDropAdrenalineTimerDestroy();
	block thread ai_rotateBonusDrop();
	wait 0.01;
}

ai_BonusDropAdrenalineTimerDestroy()
{
	self endon("adrenaline_drop_take");
	{
		wait 20;
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		level notify("adrenaline_drop_take");
	}
}

ai_AdrenalineDropDestroy()
{
    {
		level waittill("adrenaline_drop_take");
		self delete();
		self.headIcon destroy();
	}
}

ai_AdrenalineDropThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			foreach(player in level.players)
			{
				player thread ai_Adrenaline();
			}
			level notify("adrenaline_drop_take");
			level notify("random_drop_destroy");
			wait 0.1;
		}
		wait 0.1;
	}
}

ai_DeathMachineDrop(pos, angle)
{
	block = spawn("script_model", pos + (0, 0, 20) );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block notSolid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "cardicon_skull", 10,10 );
	block.headIcon setWaypoint( true, true, false );
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_DeathMachineDropThink(pos);
	trigger thread ai_DeathMachineDropDestroy();
	block thread ai_DeathMachineDropDestroy();
	block thread ai_BonusDropDeathMachineTimerDestroy();
	block thread ai_rotateBonusDrop();
	wait 0.01;
}

ai_BonusDropDeathMachineTimerDestroy()
{
	self endon("deathmachine_drop_take");
	{
		wait 20;
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		level notify("deathmachine_drop_take");
	}
}

ai_DeathMachineDropDestroy()
{
    {
		level waittill("deathmachine_drop_take");
		self delete();
		self.headIcon destroy();
	}
}

ai_DeathMachineDropThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			player thread ai_DeathMachineStart();
			level notify("deathmachine_drop_take");
			level notify("random_drop_destroy");
		}
		wait 0.1;
	}
}

ai_MoneyDrop(pos, angle)
{
	block = spawn("script_model", pos + (0, 0, 20) );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block notSolid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	block.headIcon = newHudElem();
	block.headIcon.x = block.origin[0];
	block.headIcon.y = block.origin[1];
	block.headIcon.z = block.origin[2] + 50;
	block.headIcon.alpha = 0.85;
	block.headIcon setShader( "cardicon_gold", 10,10 );
	block.headIcon setWaypoint( true, true, false );
    trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
    trigger.angles = angle;
	trigger thread ai_MoneyDropThink(pos);
	trigger thread ai_MoneyDropDestroy();
	block thread ai_MoneyDropDestroy();
	block thread ai_BonusDropMoneyTimerDestroy();
	block thread ai_rotateBonusDrop();
    wait 0.01;
}

ai_BonusDropMoneyTimerDestroy()
{
	self endon("money_drop_take");
	{
		wait 20;
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		wait 0.5;
		self hide();
		wait 0.5;
		self show();
		level notify("money_drop_take");
	}
}

ai_MoneyDropDestroy()
{
    {
		level waittill("money_drop_take");
		self delete();
		self.headIcon destroy();
	}
}

ai_MoneyDropThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			player thread ai_ExtraMoney();
			level notify("money_drop_take");
			level notify("random_drop_destroy");
			wait 0.1;
		}
		wait 0.1;
	}
}

ai_InfiniteAmmo()
{ 
    level endon("disconnect");
	self endon("take_infiniteammo");
	{
	    self thread fx_ai1_12( "Infinite Ammo!" );
	    self thread fx_ai1_3("Infinite Ammo!", 0.85, (25.5,25.5,25.5),(0.3,0.3,0.9),0.60); 
		self thread fx_ai1_2("dpad_killstreak_sentry_gun");
	    self thread ai_InfiniteAmmoStart();
		wait 15;
		self thread fx_ai1_3("^1No more Infinite Ammo!", 0.85, (25.5,25.5,25.5),(0.9,0.3,0.3),0.60); 
		self thread fx_ai1_2("dpad_killstreak_sentry_gun");
		self notify("take_infiniteammo");
		self notify("bonus_end");
		level.nobonus = 0;
	}
	wait 0.1;
}

ai_BonusDropHud( text, waitdestroy )
{
	if(self.bonusdrophud == 1)
	{
		self.bonusdrophud1 = NewClientHudElem( self );
		self.bonusdrophud1.alignX = "center";
		self.bonusdrophud1.alignY = "middle";
		self.bonusdrophud1.horzAlign = "center";
		self.bonusdrophud1.vertAlign = "middle";
		self.bonusdrophud1.x = -350;
		self.bonusdrophud1.y = 140;
		self.bonusdrophud1.foreground = true;
		self.bonusdrophud1.fontScale = 0.750;
		self.bonusdrophud1.font = "hudbig";
		self.bonusdrophud1.alpha = 1;
		self.bonusdrophud1.fontscale = 0.75;
		self.bonusdrophud1.alpha = 0.85;
		self.bonusdrophud1 setText(text);
		self.bonushudtimer += 1;
		self waittill(waitdestroy);
		self.bonusdrophud1 destroy();
	}
	else if(self.bonusdrophud == 2)
	{
		self.bonusdrophud2 = NewClientHudElem( self );
		self.bonusdrophud2.alignX = "center";
		self.bonusdrophud2.alignY = "middle";
		self.bonusdrophud2.horzAlign = "center";
		self.bonusdrophud2.vertAlign = "middle";
		self.bonusdrophud2.x = -350;
		self.bonusdrophud2.y = 110;
		self.bonusdrophud2.foreground = true;
		self.bonusdrophud2.fontScale = 0.750;
		self.bonusdrophud2.font = "hudbig";
		self.bonusdrophud2.alpha = 1;
		self.bonusdrophud2.fontscale = 0.75;
		self.bonusdrophud2.alpha = 0.85;
		self.bonusdrophud2 setText(text);
		self.bonushudtimer += 1;
		self waittill(waitdestroy);
		self.bonusdrophud2 destroy();
	}
	else if(self.bonusdrophud == 3)
	{
		self.bonusdrophud3 = NewClientHudElem( self );
		self.bonusdrophud3.alignX = "center";
		self.bonusdrophud3.alignY = "middle";
		self.bonusdrophud3.horzAlign = "center";
		self.bonusdrophud3.vertAlign = "middle";
		self.bonusdrophud3.x = -350;
		self.bonusdrophud3.y = 80;
		self.bonusdrophud3.foreground = true;
		self.bonusdrophud3.fontScale = 0.750;
		self.bonusdrophud3.font = "hudbig";
		self.bonusdrophud3.alpha = 1;
		self.bonusdrophud3.fontscale = 0.75;
		self.bonusdrophud3.alpha = 0.85;
		self.bonusdrophud3 setText(text);
		self.bonushudtimer += 1;
		self waittill(waitdestroy);
		self.bonusdrophud3 destroy();
	}
	else if(self.bonusdrophud == 4)
	{
		self.bonusdrophud4 = NewClientHudElem( self );
		self.bonusdrophud4.alignX = "center";
		self.bonusdrophud4.alignY = "middle";
		self.bonusdrophud4.horzAlign = "center";
		self.bonusdrophud4.vertAlign = "middle";
		self.bonusdrophud4.x = -350;
		self.bonusdrophud4.y = 50;
		self.bonusdrophud4.foreground = true;
		self.bonusdrophud4.fontScale = 0.750;
		self.bonusdrophud4.font = "hudbig";
		self.bonusdrophud4.alpha = 1;
		self.bonusdrophud4.fontscale = 0.75;
		self.bonusdrophud4.alpha = 0.85;
		self.bonusdrophud4 setText(text);
		self.bonushudtimer += 1;
		self waittill(waitdestroy);
		self.bonusdrophud4 destroy();
	}
}

ai_InfiniteAmmoStart()
{
	self endon("disconnect");
	self endon("take_infiniteammo");
	while(1)
	{
		currentWeapon = self getCurrentWeapon();
		if ( currentWeapon != "none" && self getCurrentWeapon() != "ac130_105mm_mp")
		{
			self setWeaponAmmoClip( currentWeapon, 9999, "right" );
			self setWeaponAmmoClip( currentWeapon, 9999, "left" );
		}
		currentoffhand = self GetCurrentOffhand() && self getCurrentWeapon() != "ac130_105mm_mp";
		if ( currentoffhand != "none" )
		{
			self setWeaponAmmoClip( currentoffhand, 9999, "right" );
			self setWeaponAmmoClip( currentoffhand, 9999, "left" );
		}
		self waittill( "weapon_fired" );
	}
}

ai_MaxAmmo()
{ 
    level endon("disconnect");
    foreach(player in level.players)
	{
	    player thread fx_ai1_12( "Max Ammo!" );
	    player thread fx_ai1_3("Max Ammo!", 0.85, (25.5,25.5,25.5),(0.7,0.7,0.3),0.60); 
		player thread fx_ai1_2("waypoint_ammo_friendly");
		player playLocalSound("mp_level_up");
	    player fx_ai1_18();  
		self notify("bonus_end");
		level.nobonus = 0;
	}
	wait 0.1;
}

ai_ExtraMoney()
{ 
    level endon("disconnect");
    foreach(player in level.players)
	{
	    player thread fx_ai1_12( "Extra Cash!" );
		player playLocalSound("mp_level_up");
		player thread fx_ai1_3("Extra Cash!", 0.85, (25.5,25.5,25.5),(0.3,0.9,0.3),0.60); 
		player thread fx_ai1_2("cardicon_gold");
	    player.money += 1000;
		player notify("MONEY");
		self notify("bonus_end");
		level.nobonus = 0;
	}
	wait 0.1;
}

ai_DeathMachineStart()
{ 
    level endon("disconnect");
	self endon("no_deathmachine");
	{
	    self thread fx_ai1_12( "Death Machine!" );
		self thread fx_ai1_3("Death Machine!", 0.85, (25.5,25.5,25.5),(0.3,0.3,0.9),0.60); 
		self thread fx_ai1_2("hud_icon_m240");
		self playLocalSound("mp_level_up");
		self thread ai_DeathMachine();
		self thread ai_DeathMachineNoSwitch();
	    self giveWeapon( "m240_xmags_mp", 6, false);
		self switchToWeapon("m240_xmags_mp");
		self GiveMaxAmmo("m240_xmags_mp");
		self.bonusdrophud += 1;
		self.notusebox = 1;
		wait 30;
		self.notusebox = 0;
		self.bonusdrophud -= 1;
		self takeWeapon("m240_xmags_mp");
		wait 0.1;
		self fx_ai1_11();
		self thread fx_ai1_3("No more Death Machine!", 0.85, (25.5,25.5,25.5),(0.3,0.3,0.9),0.60); 
		self thread fx_ai1_2("hud_icon_m240");
		self playLocalSound("mp_level_up");
		level notify("bonus_end");
		level.nobonus = 0;
		self notify("no_deathmachine");
	}
	wait 0.1;
}

ai_DeathMachineAirdropStart()
{ 
    level endon("disconnect");
	self endon("no_deathmachine");
	{
	    self thread fx_ai1_12( "Death Machine!" );
	    self thread fx_ai1_3("Death Machine!", 0.85, (25.5,25.5,25.5),(0.3,0.3,0.9),0.60); 
		self thread fx_ai1_2("hud_icon_m240");
		self playLocalSound("mp_level_up");
		self thread ai_DeathMachine();
		self thread ai_DeathMachineNoSwitch();
	    self giveWeapon( "m240_xmags_mp", 6, false);
		self switchToWeapon("m240_xmags_mp");
		self GiveMaxAmmo("m240_xmags_mp");
		self.notusebox = 1;
		wait 60;
		self.notusebox = 0;
		self takeWeapon("m240_xmags_mp");
		wait 0.1;
		self fx_ai1_11();
		self thread fx_ai1_3("No more Death Machine!", 0.85, (25.5,25.5,25.5),(0.9,0.3,0.3),0.60); 
		self thread fx_ai1_2("hud_icon_m240");
		self playLocalSound("mp_level_up");
		level notify("bonus_end");
		level.nobonus = 0;
		self notify("no_deathmachine");
	}
	wait 0.1;
}

ai_DeamMachineAirDropThink(pos, angle)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			foreach(player in level.players)
			{
				player thread ai_DeathMachineAirdropStart();
			}
			level notify("random_drop_destroy");
			wait 0.1;
		}
		wait .8;
	}
}

ai_DeathMachineNoSwitch()
{
    self endon("no_deathmachine");
    while(1)
	{
	    self switchToWeapon("m240_xmags_mp");
		wait 0.1;
	}
}

ai_DeathMachine()
{
    self endon("death");
	self endon("no_deathmachine");
    for( ;; )
    {
        self waittill( "weapon_fired" );
        if ( self getCurrentWeapon() == "m240_xmags_mp" )
        {
			self GiveMaxAmmo("m240_xmags_mp");
			self setWeaponAmmoClip( "m240_xmags_mp", 200 );
        }
    }
}

ai_Adrenaline()
{
	level endon("disconnect");
	if(self.speedreload == 1)
	{
		self thread fx_ai1_12( "Adrenaline!" );
		self thread fx_ai1_3("Adrenaline!", 0.85, (25.5,25.5,25.5),(0.9,0.3,0.3),0.60); 
		self thread fx_ai1_2("cardicon_doubletap");
		self playLocalSound("mp_level_up");
		if ( self _hasPerk( "specialty_lightweight" ) )
		{
			self.moveSpeedScaler = 1.25;
			self fx_ai1_17( "primary" );
		}
		else
		{
			self.moveSpeedScaler = 1.2;
			self fx_ai1_17( "primary" );
		}
		self.bonusdrophud += 1;
		wait 15;
		if ( self _hasPerk( "specialty_lightweight" ) )
		{
			self.moveSpeedScaler = 1.1;
			self fx_ai1_17( "primary" );
		}
		else
		{
			self.moveSpeedScaler = 1.0;
			self fx_ai1_17( "primary" );
		}
		self.bonusdrophud -= 1;
		self thread fx_ai1_3("Adrenaline has ran out!", 0.85, (25.5,25.5,25.5),(0.9,0.3,0.3),0.60); 
		self thread fx_ai1_2("cardicon_doubletap");
		self notify("adrenaline_out");
		level notify("bonus_end");
		level.nobonus = 0;
	}
	else if(self.speedreload == 0)
	{
		self thread fx_ai1_12( "Adrenaline!" );
		self thread fx_ai1_3("Adrenaline!", 0.85, (25.5,25.5,25.5),(0.9,0.3,0.3),0.60); 
		self thread fx_ai1_2("cardicon_doubletap");
		self playLocalSound("mp_level_up");
		self _setPerk("specialty_fastreload");
		self _setPerk("specialty_quickdraw");
		if ( self _hasPerk( "specialty_lightweight" ) )
		{
			self.moveSpeedScaler = 1.25;
			self fx_ai1_17( "primary" );
		}
		else
		{
			self.moveSpeedScaler = 1.2;
			self fx_ai1_17( "primary" );
		}
		wait 15;
		if ( self _hasPerk( "specialty_lightweight" ) )
		{
			self.moveSpeedScaler = 1.1;
			self fx_ai1_17( "primary" );
		}
		else
		{
			self.moveSpeedScaler = 1.0;
			self fx_ai1_17( "primary" );
		}
		self _unsetPerk("specialty_fastreload");
		self _unsetPerk("specialty_quickdraw");
		self thread fx_ai1_3("Adrenaline has ran out!", 0.85, (25.5,25.5,25.5),(0.9,0.3,0.3),0.60); 
		self thread fx_ai1_2("cardicon_doubletap");
		self notify("adrenaline_out");
		self notify("bonus_end");
		level.nobonus = 0;
	}
	wait 0.1;
}

ai_BotMain()
{
	if(level.Wave == 9 && getdvar("mapname") == "mp_subbase" || level.Wave == 19 && getdvar("mapname") == "mp_subbase" || level.Wave == 29 && getdvar("mapname") == "mp_subbase" || level.Wave == 9 && getdvar("mapname") == "mp_estate" || level.Wave == 19 && getdvar("mapname") == "mp_estate" || level.Wave == 29 && getdvar("mapname") == "mp_estate")
	{
		ai_CreateHellBossWave( );
	}
	else if(level.Wave == 4 && getdvar("mapname") == "mp_subbase" || level.Wave == 14 && getdvar("mapname") == "mp_subbase" || level.Wave == 24 && getdvar("mapname") == "mp_subbase" || level.Wave == 4 && getdvar("mapname") == "mp_estate" || level.Wave == 14 && getdvar("mapname") == "mp_estate" || level.Wave == 24 && getdvar("mapname") == "mp_estate")
	{
		ai_CreateHellWave( );
	}
	else if(getdvar("mapname") == "mp_subbase" || getdvar("mapname") == "mp_estate")
	{
		ai_CreateBotWaveHell( );
	}
	else if(level.Wave == 9 && getdvar("mapname") != "mp_subbase" || level.Wave == 19 && getdvar("mapname") || level.Wave == 29 && getdvar("mapname") != "mp_subbase" || level.Wave == 9 && getdvar("mapname") != "mp_estate" || level.Wave == 19 && getdvar("mapname") != "mp_estate" || level.Wave == 29 && getdvar("mapname") != "mp_estate")
	{
		ai_CreateBossWave( );
	}
	else if(level.Wave == 4 && getdvar("mapname") != "mp_subbase" || level.Wave == 14 && getdvar("mapname") != "mp_subbase" || level.Wave == 24 && getdvar("mapname") != "mp_subbase" || level.Wave == 4 && getdvar("mapname") != "mp_estate" || level.Wave == 14 && getdvar("mapname") != "mp_estate" || level.Wave == 24 && getdvar("mapname") != "mp_estate")
	{
		ai_CreateCrawlerWave( );
	}
	else if(getdvar("mapname") != "mp_subbase" || getdvar("mapname") != "mp_estate")
	{
		ai_CreateBotWave( );
	}
}

ai_FXFire()
{
	self endon("bot_death");
	while(1)
	{
		playFx(loadfx("props/barrel_fire"),self.origin+(0,0,53));
		wait 1;
	}
}

ai_NukeZombies()
{ 
	self endon("bot_is_death");
	{
	    level waittill("nuke_drop_kill");
		self notify("bot_death");
		self.knife delete();
		self.crate1 thread ai_DeleteZombie();
	    self.speed = 1;
		self hidepart("tag_head");
		playFx(level.bloodfx,self getTagOrigin("tag_head"));
		self.crate1 maps\mp\_modmenu_ai3::ai_KillEnt(self.crate1, 0);
		self thread maps\mp\_modmenu_ai3::ai_ExplosionDeath(); //Death from Explosion Animations
		self thread fx_ai1_5(); //Death Sounds
	    wait 0.5;
		self startRagDoll(1);
		wait 0.5;
		self thread ai_DeleteZombie();
		self notify("bonus_end");
		level.nobonus = 0;
		self notify("bot_is_dead");
	}
	wait 0.1;
}

ai_CreateBotWave( )
{
	level endon("game_ended");
	level.Wave++;
	level.BotsForWave = (10 * level.Wave);
	level.RealSpawnedBots = 0;
	level.ZombieHealth += 15;
	level.zState = "playing";
	level notify("zombie_round_started_end");
	level maps\mp\_modmenu_ai3::ai_SetNormalRound();
	level notify("crate_gone");
	level thread ai_ZombieMarkers();
	foreach( player in level.players )
	{
		player thread fx_ai1_10(&"Wave ", 1, (1,1,1), (0.3,0.3,0.9), 0.85, level.Wave);
		player PlayLocalSound("flag_spawned");
	}
	for( i = 0;i < level.BotsForWave;i++ )
	{
		while(ai_ZombieCount() >= 25)
		{
			wait 1;
		}
		if(level.RealSpawnedBots < level.BotsForWave)
		{
			level.RealSpawnedBots++;
		}
		level.bots[i] = spawn("script_model", ai_GetMapSpawnPoint());
		level.bots[i] setModel(ai_GetSpawnModel());
		level.bots[i].crate1 = spawn("script_model", level.bots[i] getTagOrigin( "j_spinelower" ) + (-5,0,-10)); 
		level.bots[i].crate1 setModel("com_plasticcase_beige_big");
		level.bots[i].crate1 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		level.bots[i].crate1.angles = (90,0,0);
		level.bots[i].crate1 Solid();
		level.bots[i].crate1 hide();
		level.bots[i].crate1.team = "axis";
		level.bots[i].crate1.name = "botCrate" + i;
		level.bots[i].crate1 setCanDamage(true);
		level.bots[i].crate1.maxhealth = level.ZombieHealth;
		level.bots[i].crate1.health = level.ZombieHealth;
		level.bots[i].crate1 linkto( level.bots[i], "j_spinelower" );
		
		level.bots[i].head = spawn("script_model", level.bots[i] getTagOrigin( "j_spine4" ));
		level.bots[i].head setModel(ai_GetHeadSpawnModelZombie());
		level.bots[i].head.angles = (270,0,270);
		level.bots[i].head.team = "axis";
		level.bots[i].head linkto( level.bots[i], "j_spine4" );
		
		level.bots[i].hasMarker = false;
		level.bots[i].team = "axis";
		level.bots[i].name = "bot" + i;
		level.bots[i].targetname = "bot";
		level.bots[i].classname = "bot";
		level.bots[i].currentsurface = "default";
		level.bots[i].kills = 0;
		level.bots[i].pers["isAlive"] = "true";
		level.bots[i].type = "normal_zombie";
		level.bots[i] thread ai_BonusDrops();
		level.bots[i] thread ai_MonitorAttackPlayers( );
		level.bots[i] thread ai_MonitorBotHealth();
		level.bots[i] thread ai__bot_KillIfUnderMap();
		level.bots[i] thread ai_GetBestPlayerAndMoveTo();
		level.bots[i] thread ai_NukeZombies();
		level.bots[i] thread fx_ai1_8();
		level.bots[i] thread maps\mp\_modmenu_ai3::ai_RegularAnim();
		wait 0.3;
	}
	level thread ai_MonitorFinish();
}

ai_CreateBotWaveHell( )
{
	level endon("game_ended");
	level.Wave++;
	level.BotsForWave = (25 * level.Wave);
	level.RealSpawnedBots = 0;
	level.ZombieHealth += 25;
	level.zState = "playing";
	level notify("zombie_round_started_end");
	if(level.BotsForWave >= 250)
	{
	    level.BotsForWave = 250;
	}
	if(level.Wave == 6)
	{
		level.BotsForWave = 40;
		level.ZombieHealth = 255;
	}
	else if(level.Wave == 11)
	{
		level.BotsForWave = 75;
		level.ZombieHealth = 300;
	}
	else if(level.Wave == 16)
	{
		level.BotsForWave = 100;
		level.ZombieHealth = 315;
	}
	else if(level.Wave == 21)
	{
		level.BotsForWave = 200;
		level.ZombieHealth = 435;
	}
	else if(level.Wave == 26)
	{
		level.BotsForWave = 260;
		level.ZombieHealth = 500;
	}
	level thread ai_ZombieMarkers();
	level notify("crate_gone");
	foreach( player in level.players )
	{
		player thread fx_ai1_10(&"Hell Zombie Wave ", 1, (1,1,1), (0.3,0.3,0.9), 0.85, level.Wave);
		player PlayLocalSound("flag_spawned");
	}
	for( i = 0;i < level.BotsForWave;i++ )
	{
		while(ai_ZombieCount() >= 25)
		{
			wait 1;
		}
		if(level.RealSpawnedBots < level.BotsForWave)
		{
			level.RealSpawnedBots++;
		}
		level.bots[i] = spawn("script_model", ai_GetMapSpawnPoint());
		level.bots[i] setModel(ai_GetSpawnModel());
		level.bots[i].crate1 = spawn("script_model", level.bots[i] getTagOrigin( "j_spinelower" ) + (-5,0,-10)); 
		level.bots[i].crate1 setModel("com_plasticcase_beige_big");
		level.bots[i].crate1 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		level.bots[i].crate1.angles = (90,0,0);
		level.bots[i].crate1 Solid();
		level.bots[i].crate1 hide();
		level.bots[i].crate1.team = "axis";
		level.bots[i].crate1.name = "botCrate" + i;
		level.bots[i].crate1 setCanDamage(true);
		level.bots[i].crate1.maxhealth = level.ZombieHealth;
		level.bots[i].crate1.health = level.ZombieHealth;
		level.bots[i].crate1 linkto( level.bots[i], "j_spinelower" );
		
		level.bots[i].head = spawn("script_model", level.bots[i] getTagOrigin( "j_spine4" ));
		level.bots[i].head setModel(ai_GetHeadSpawnModelZombie());
		level.bots[i].head.angles = (270,0,270);
		level.bots[i].head.team = "axis";
		level.bots[i].head linkto( level.bots[i], "j_spine4" );
		
		level.bots[i].hasMarker = false;
		level.bots[i].team = "axis";
		level.bots[i].name = "bot" + i;
		level.bots[i].targetname = "bot";
		level.bots[i].classname = "bot";
		level.bots[i].currentsurface = "default";
		level.bots[i].kills = 0;
		level.bots[i].pers["isAlive"] = "true";
		level.bots[i].type = "hell_zombie";
		level.bots[i] thread ai_BonusDrops();
		level.bots[i] thread ai_MonitorAttackPlayers( );
		level.bots[i] thread ai_MonitorBotHealth();
		level.bots[i] thread ai__bot_KillIfUnderMap();
		level.bots[i] thread ai_GetBestPlayerAndMoveTo();
		level.bots[i] thread fx_ai1_6();
		level.bots[i] thread ai_NukeZombies();
		level.bots[i] thread fx_ai1_8();
		wait 0.3;
	}
	level thread ai_MonitorFinishHell();
}

ai_CreateHellBossWave( )
{
	level endon("game_ended");
	level.Wave++;
	level.BotsForWave = 1;
	level.RealSpawnedBots = 0;
	level.ZombieHealth = 12500;
	level.zState = "playing";
	level notify("zombie_round_started_end");
	if(level.Wave == 10)
	{
		level.BotsForWave = 1;
		wait 0.05;
	}
	else if(level.Wave == 20)
	{
		level.BotsForWave = 3;
		wait 0.05;
	}
	else if(level.Wave == 30)
	{
		level.BotsForWave = 6;
		wait 0.05;
	}
	if(getDvarInt("z_dedicated") == 0)
	{
		foreach(player in level.players)
		{
			switch(randomInt(2))
			{
				case 0:
				player playLocalSound("mp_killstreak_pavelow");
				break;
				case 1:
				player playLocalSound("mp_killstreak_counteruav");
				break;
			}
		}
	}
	level thread ai_ZombieMarkers();
	level notify("crate_gone");
	foreach( player in level.players )
	{
		player thread fx_ai1_10(&"Hell Boss Wave ", 1, (1,1,1), (0.9,0.3,0.3), 0.85, level.Wave);
		player thread fx_ai1_10(&"Boss Health ", 1, (1,1,1), (0.9,0.3,0.3), 0.85, level.ZombieHealth);
		player PlayLocalSound("flag_spawned");
	}
	wait 0.05;
	for( i = 0;i < level.BotsForWave;i++ )
	{
		if(level.RealSpawnedBots < level.BotsForWave)
		{
			level.RealSpawnedBots++;
		}
		level.bots[i] = spawn("script_model", ai_GetMapSpawnPoint());
		level.bots[i] setModel(ai_GetBossSpawnModel( ));
		level.bots[i].crate1 = spawn("script_model", level.bots[i] getTagOrigin( "j_spinelower" ) + (-5,0,-10)); 
		level.bots[i].crate1 setModel("com_plasticcase_beige_big");
		level.bots[i].crate1 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		level.bots[i].crate1.angles = (90,0,0);
		level.bots[i].crate1 Solid();
		level.bots[i].crate1 hide();
		level.bots[i].crate1.team = "axis";
		level.bots[i].crate1.name = "botCrate" + i;
		level.bots[i].crate1 setCanDamage(true);
		level.bots[i].crate1.maxhealth = level.ZombieHealth;
		level.bots[i].crate1.health = level.ZombieHealth;
		level.bots[i].crate1 linkto( level.bots[i], "j_spinelower" );
		
		level.bots[i].head = spawn("script_model", level.bots[i] getTagOrigin( "j_spine4" ));
		level.bots[i].head setModel(ai_GetBossHeadSpawnModel());
		level.bots[i].head.angles = (270,0,270);
		level.bots[i].head.team = "axis";
		level.bots[i].head linkto( level.bots[i], "j_spine4" );
		
		level.bots[i].hasMarker = false;
		level.bots[i].team = "axis";
		level.bots[i].name = "bot" + i;
		level.bots[i].targetname = "bot";
		level.bots[i].classname = "bot";
		level.bots[i].currentsurface = "default";
		level.bots[i].kills = 0;
		level.bots[i].pers["isAlive"] = "true";
		level.bots[i].type = "hell_boss_zombie";
		level.bots[i] thread ai_BonusDrops();
		level.bots[i] thread ai_MonitorAttackPlayers( );
		level.bots[i] thread ai_MonitorBotHealth();
		level.bots[i] thread ai__bot_KillIfUnderMap();
		level.bots[i] thread ai_GetBestPlayerAndMoveTo();
		level.bots[i] thread maps\mp\_modmenu_ai3::ai_BossAnim();
		level.bots[i] thread ai_NukeZombies();
		level.bots[i] thread fx_ai1_8();
		level.bots[i] thread ai_FXFire();
		wait 0.3;
	}
	level thread ai_MonitorFinishHellBoss();
}

ai_CreateHellWave( )
{
	level endon("game_ended");
	level.Wave++;
	level.BotsForWave = 1;
	level.RealSpawnedBots = 0;
	level.ZombieHealth = 6500;
	level.zState = "playing";
	level notify("zombie_round_started_end");
	if(level.Wave == 5)
	{
		level.BotsForWave = 150;
		level.ZombieHealth = 200;
		wait 0.05;
	}
	else if(level.Wave == 15)
	{
		level.BotsForWave = 300;
		level.ZombieHealth = 400;
		wait 0.05;
	}
	else if(level.Wave == 25)
	{
		level.BotsForWave = 450;
		level.ZombieHealth = 600;
		wait 0.05;
	}
	if(getDvarInt("z_dedicated") == 0)
	{
		foreach(player in level.players)
		{
			switch(randomInt(2))
			{
				case 0:
				player playLocalSound("mp_killstreak_pavelow");
				break;
				case 1:
				player playLocalSound("mp_killstreak_counteruav");
				break;
			}
		}
	}
	level thread ai_ZombieMarkers();
	level notify("crate_gone");
	foreach( player in level.players)
	{
		player thread fx_ai1_10(&"Hell Zombie Wave ", 1, (1,1,1), (0.9,0.3,0.3), 0.85, level.Wave);
		player PlayLocalSound("flag_spawned");
		wait 0.05;
	}
	for( i = 0;i < level.BotsForWave;i++ )
	{
		while(ai_ZombieCount() >= 25)
		{
			wait 1;
		}
		if(level.RealSpawnedBots < level.BotsForWave)
		{
			level.RealSpawnedBots++;
		}
		level.bots[i] = spawn("script_model", ai_GetMapSpawnPoint());
		level.bots[i] setModel(ai_GetSpawnModel());
		level.bots[i].crate1 = spawn("script_model", level.bots[i] getTagOrigin( "j_spinelower" ) + (-5,0,-10)); 
		level.bots[i].crate1 setModel("com_plasticcase_beige_big");
		level.bots[i].crate1 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		level.bots[i].crate1.angles = (90,0,0);
		level.bots[i].crate1 Solid();
		level.bots[i].crate1 hide();
		level.bots[i].crate1.team = "axis";
		level.bots[i].crate1.name = "botCrate" + i;
		level.bots[i].crate1 setCanDamage(true);
		level.bots[i].crate1.maxhealth = level.ZombieHealth;
		level.bots[i].crate1.health = level.ZombieHealth;
		level.bots[i].crate1 linkto( level.bots[i], "j_spinelower" );
		
		level.bots[i].head = spawn("script_model", level.bots[i] getTagOrigin( "j_spine4" ));
		level.bots[i].head setModel(ai_GetHeadSpawnModelZombie());
		level.bots[i].head.angles = (270,0,270);
		level.bots[i].head.team = "axis";
		level.bots[i].head linkto( level.bots[i], "j_spine4" );
		
		level.bots[i].hasMarker = false;
		level.bots[i].team = "axis";
		level.bots[i].name = "bot" + i;
		level.bots[i].targetname = "bot";
		level.bots[i].classname = "bot";
		level.bots[i].currentsurface = "default";
		level.bots[i].kills = 0;
		level.bots[i].pers["isAlive"] = "true";
		level.bots[i].type = "normal_hell_zombie";
		level.bots[i] thread ai_BonusDrops();
		level.bots[i] thread ai_MonitorAttackPlayers( );
		level.bots[i] thread ai_MonitorBotHealth();
		level.bots[i] thread ai__bot_KillIfUnderMap();
		level.bots[i] thread ai_GetBestPlayerAndMoveTo();
		level.bots[i] thread ai_NukeZombies();
		level.bots[i] thread fx_ai1_8();
		level.bots[i] thread fx_ai1_6();
		wait 0.3;
	}
	level thread ai_MonitorFinishEvil();
}

ai_CreateCrawlerWave( )
{
	level endon("game_ended");
	level.Wave++;
	level.BotsForWave = 1;
	level.RealSpawnedBots = 0;
	level.ZombieHealth = 6500;
	level.zState = "playing";
	level notify("zombie_round_started_end");
	if(level.Wave == 5)
	{
		level.BotsForWave = 50;
		level.ZombieHealth = 100;
		wait 0.05;
	}
	else if(level.Wave == 15)
	{
		level.BotsForWave = 100;
		level.ZombieHealth = 300;
		wait 0.05;
	}
	else if(level.Wave == 25)
	{
		level.BotsForWave = 200;
		level.ZombieHealth = 500;
		wait 0.05;
	}
	if(getDvarInt("z_dedicated") == 0)
	{
		foreach(player in level.players)
		{
			switch(randomInt(2))
			{
				case 0:
				player playLocalSound("mp_killstreak_pavelow");
				break;
				case 1:
				player playLocalSound("mp_killstreak_counteruav");
				break;
			}
		}
	}
	level thread ai_ZombieMarkers();
	level notify("crate_gone");
	foreach( player in level.players)
	{
		player thread fx_ai1_10("Crawler Wave", 1, (1,1,1), (0.3,0.3,0.9), 0.85);
		player PlayLocalSound("flag_spawned");
		wait 0.05;
	}
	for( i = 0;i < level.BotsForWave;i++ )
	{
		while(ai_ZombieCount() >= 20)
		{
			wait 1;
		}
		if(level.RealSpawnedBots < level.BotsForWave)
		{
			level.RealSpawnedBots++;
		}
		level.bots[i] = spawn("script_model", ai_GetMapSpawnPoint());
		level.bots[i] setModel(ai_GetCrawlerSpawnModel());
		level.bots[i].crate1 = spawn("script_model", level.bots[i] getTagOrigin( "j_spinelower" ) + (-5,0,-10)); 
		level.bots[i].crate1 setModel("com_plasticcase_beige_big");
		level.bots[i].crate1 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		level.bots[i].crate1.angles = (90,0,0);
		level.bots[i].crate1 Solid();
		level.bots[i].crate1 hide();
		level.bots[i].crate1.team = "axis";
		level.bots[i].crate1.name = "botCrate" + i;
		level.bots[i].crate1 setCanDamage(true);
		level.bots[i].crate1.maxhealth = level.ZombieHealth;
		level.bots[i].crate1.health = level.ZombieHealth;
		level.bots[i].crate1 linkto( level.bots[i], "j_spinelower" );
		
		level.bots[i].head = spawn("script_model", level.bots[i] getTagOrigin( "j_spine4" ));
		level.bots[i].head setModel(ai_GetCrawlerHeadModel());
		level.bots[i].head.angles = (270,0,270);
		level.bots[i].head.team = "axis";
		level.bots[i].head linkto( level.bots[i], "j_spine4" );
		
		level.bots[i].hasMarker = false;
		level.bots[i].team = "axis";
		level.bots[i].name = "bot" + i;
		level.bots[i].targetname = "bot";
		level.bots[i].classname = "bot";
		level.bots[i].currentsurface = "default";
		level.bots[i].kills = 0;
		level.bots[i].pers["isAlive"] = "true";
		level.bots[i].type = "zombie_crawler";
		level.bots[i] thread ai_BonusDrops();
		level.bots[i] thread ai_MonitorAttackPlayers( );
		level.bots[i] thread ai_MonitorBotHealth();
		level.bots[i] thread ai__bot_KillIfUnderMap();
		level.bots[i] thread ai_GetBestPlayerAndMoveTo();
		level.bots[i] thread maps\mp\_modmenu_ai3::ai_CrawlerAnim();
		level.bots[i] thread ai_NukeZombies();
		level.bots[i] thread fx_ai1_8();
		wait 0.3;
	}
	level thread ai_MonitorFinishCrawler();
}

ai_CreateBossWave( )
{
	level endon("game_ended");
	level.Wave++;
	level.BotsForWave = 1;
	level.RealSpawnedBots = 0;
	level.ZombieHealth = 50;
	level.zState = "playing";
	level notify("zombie_round_started_end");
	if(level.Wave == 10)
	{
		level.BotsForWave = 5;
		level.ZombieHealth = 5000;
		if(getDvarInt("z_dedicated") == 0)
		{
			foreach(player in level.players)
			{
				switch(randomInt(2))
				{
					case 0:
					player playLocalSound("mp_killstreak_pavelow");
					break;
					case 1:
					player playLocalSound("mp_killstreak_counteruav");
					break;
				}
			}
		}
		wait 0.05;
	}
	else if(level.Wave == 20)
	{
		level.BotsForWave = 10;
		level.ZombieHealth = 7500;
		if(getDvarInt("z_dedicated") == 0)
		{
			foreach(player in level.players)
			{
				switch(randomInt(2))
				{
					case 0:
					player playLocalSound("mp_killstreak_pavelow");
					break;
					case 1:
					player playLocalSound("mp_killstreak_counteruav");
					break;
				}
			}
		}
		wait 0.05;
	}
	else if(level.Wave == 30)
	{
		level.BotsForWave = 20;
		level.ZombieHealth = 10000;
		if(getDvarInt("z_dedicated") == 0)
		{
			foreach(player in level.players)
			{
				player playLocalSound("mp_killstreak_pavelow");
			}
		}
		wait 0.05;
	}
	level thread ai_ZombieMarkers();
	level notify("crate_gone");
	foreach( player in level.players )
	{
		player PlayLocalSound("flag_spawned");
		player thread fx_ai1_10("Boss Wave", 1, (1,1,1), (0.9,0.3,0.3), 0.85);
		player thread fx_ai1_10(&"^1Boss Health: ", 1, (1,1,1), (0.9,0.3,0.3), 0.85, level.ZombieHealth);
	}
	wait 0.05;
	for( i = 0;i < level.BotsForWave;i++ )
	{
		if(level.RealSpawnedBots < level.BotsForWave)
		{
			level.RealSpawnedBots++;
		}
		level.bots[i] = spawn("script_model", ai_GetMapSpawnPoint());
		level.bots[i] setModel(ai_GetBossSpawnModel( ));
		level.bots[i].crate1 = spawn("script_model", level.bots[i] getTagOrigin( "j_spinelower" ) + (-5,0,-10)); 
		level.bots[i].crate1 setModel("com_plasticcase_beige_big");
		level.bots[i].crate1 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		level.bots[i].crate1.angles = (90,0,0);
		level.bots[i].crate1 Solid();
		level.bots[i].crate1 hide();
		level.bots[i].crate1.team = "axis";
		level.bots[i].crate1.name = "botCrate" + i;
		level.bots[i].crate1 setCanDamage(true);
		level.bots[i].crate1.maxhealth = level.ZombieHealth;
		level.bots[i].crate1.health = level.ZombieHealth;
		level.bots[i].crate1 linkto( level.bots[i], "j_spinelower" );
		
		level.bots[i].head = spawn("script_model", level.bots[i] getTagOrigin( "j_spine4" ));
		level.bots[i].head setModel(ai_GetBossHeadSpawnModel());
		level.bots[i].head.angles = (270,0,270);
		level.bots[i].head.team = "axis";
		level.bots[i].head linkto( level.bots[i], "j_spine4" );
		
		level.bots[i].hasMarker = false;
		level.bots[i].team = "axis";
		level.bots[i].name = "bot" + i;
		level.bots[i].targetname = "bot";
		level.bots[i].classname = "bot";
		level.bots[i].currentsurface = "default";
		level.bots[i].kills = 0;
		level.bots[i].pers["isAlive"] = "true";
		level.bots[i].type = "zombie_boss";
		level.bots[i] thread ai_BonusDrops();
		level.bots[i] thread ai_MonitorAttackPlayers( );
		level.bots[i] thread ai_MonitorBotHealth();
		level.bots[i] thread ai__bot_KillIfUnderMap();
		level.bots[i] thread ai_GetBestPlayerAndMoveTo();
		level.bots[i] thread maps\mp\_modmenu_ai3::ai_BossAnim2();
		level.bots[i] thread ai_NukeZombies();
		level.bots[i] thread fx_ai1_8();
		wait 0.3;
	}
	level thread ai_MonitorFinishBoss();
}

ai_MonitorFinishHell( )
{
	level endon("crate_gone");
	for(;;)
	{
		if(ai_ZombieCount() <= 0 && level.Wave < level.MaxWaves)
		{
			level.zState = "intermission";
			wait 2;
			foreach( player in level.players ) if(isDefined( player.needsToSpawn ) && player.needsToSpawn)
			{
				player notify("respawn");
				player thread [[level.SpawnClient]]();
				player allowSpectateTeam( "freelook", false );
				player.pers["botKillstreak"] = 0;
				player.pers["lastKillstreak"] = "";
				player clearLowerMessage("spawn_info");
			}
			Announcement( "^2Bonus Cash $100" );
			foreach( player in level.players )
			{
				player.gambler = 0;
				player.money += 100;
				player notify("MONEY");
				player fx_ai1_19( "frag_grenade_mp" );
				player thread fx_ai1_15( "revenge", 100 );
			}
			level.AmmoDrop = undefined;
			level thread ai_C130FlyBy();
			wait 2.5;
			foreach( player in level.players )
			{
				player thread fx_ai1_9(&"Survived Hell Wave ", 1, (1,1,1), (0.3,0.9,0.3), 0.85, level.Wave);
				player thread fx_ai1_7("20 Second Intermission", 1, (1,1,0.5), (1,1,0.5), 0);
			}
			wait 2.5;
			level notify("round_ended");
			level notify("zombie_round_started_end");
			break;
		}
		else if(ai_ZombieCount() <= 0 && level.Wave >= level.MaxWaves)
		{
			level thread fx_ai1_14();
			break;
		}
		wait 0.05;
	}
}

ai_MonitorFinishHellBoss( )
{
	level endon("crate_gone");
	for(;;)
	{
		if(ai_ZombieCount() <= 0 && level.Wave < level.MaxWaves)
		{
			level.zState = "intermission";
			wait 2;
			foreach( player in level.players ) if(isDefined( player.needsToSpawn ) && player.needsToSpawn)
			{
				player notify("respawn");
				player thread [[level.SpawnClient]]();
				player allowSpectateTeam( "freelook", false );
				player clearLowerMessage("spawn_info");
			}
			Announcement( "^2Max Ammo for All Players And $2000" );
			foreach( player in level.players )
			{
				player.gambler = 0;
				player.money += 2000;
				player notify("MONEY");
				player thread fx_ai1_15( "execution", 2000 );
				player thread fx_ai1_13("^3Max Ammo!", "^2$2000", "waypoint_ammo_friendly", "ammo_crate_use");
				player fx_ai1_19( "frag_grenade_mp" );
				player fx_ai1_18();
			}
			level.AmmoDrop = undefined;
			level thread ai_C130FlyBy();
			wait 2.5;
			foreach( player in level.players )
			{
				player thread fx_ai1_9("Hell Boss Wave Survived", 1, (1,1,1), (0.3,0.9,0.3), 0.85);
				player thread fx_ai1_7("20 Second Intermission", 1, (1,1,0.5), (1,1,0.5), 0);
			}
			wait 2.5;
			level notify("round_ended");
			level notify("zombie_round_started_end");
			break;
		}
		else if(ai_ZombieCount() <= 0 && level.Wave >= level.MaxWaves)
		{
			level thread fx_ai1_14();
			break;
		}
		wait 0.05;
	}
}

ai_MonitorFinishEvil( )
{
	level endon("crate_gone");
	for(;;)
	{
		if(ai_ZombieCount() <= 0 && level.Wave < level.MaxWaves)
		{
			level.zState = "intermission";
			wait 2;
			foreach( player in level.players ) if(isDefined( player.needsToSpawn ) && player.needsToSpawn)
			{
				player notify("respawn");
				player thread [[level.SpawnClient]]();
				player allowSpectateTeam( "freelook", false );
				player clearLowerMessage("spawn_info");
			}
			Announcement( "^2Max Ammo for All Players And $500" );
			foreach( player in level.players )
			{
				player.gambler = 0;
				player.money += 500;
				player notify("MONEY");
				player thread fx_ai1_15( "comeback", 500 );
				player thread fx_ai1_13("^3Max Ammo!", "^2$500", "waypoint_ammo_friendly", "ammo_crate_use");
				player fx_ai1_19( "frag_grenade_mp" );
				player fx_ai1_18();
			}
			level.AmmoDrop = undefined;
			level thread ai_C130FlyBy();
			wait 2.5;
			foreach( player in level.players )
			{
				player thread fx_ai1_9("Hell Wave Survived", 1, (1,1,1), (0.3,0.9,0.3), 0.85);
				player thread fx_ai1_7("20 Second Intermission", 1, (1,1,0.5), (1,1,0.5), 0);
			}
			wait 2.5;
			level notify("round_ended");
			level notify("zombie_round_started_end");
			break;
		}
		else if(ai_ZombieCount() <= 0 && level.Wave >= level.MaxWaves)
		{
			level thread fx_ai1_14();
			break;
		}
		wait 0.05;
	}
}

ai_MonitorFinish( )
{
	level endon("crate_gone");
	for(;;)
	{
		if(ai_ZombieCount() <= 0 && level.Wave < level.MaxWaves)
		{
			level.zState = "intermission";
			wait 2;
			foreach( player in level.players ) if(isDefined( player.needsToSpawn ) && player.needsToSpawn)
			{
				player notify("respawn");
				player thread [[level.SpawnClient]]();
				player allowSpectateTeam( "freelook", false );
				player.pers["botKillstreak"] = 0;
				player.pers["lastKillstreak"] = "";
				player clearLowerMessage("spawn_info");
			}
			Announcement( "^2Bonus Cash $100" );
			foreach( player in level.players )
			{
				player.gambler = 0;
				player thread fx_ai1_16( 100, 0, (0,1,0), 1 );
				player.money += 100;
				player notify("MONEY");
				player fx_ai1_19( "frag_grenade_mp" );
				player thread fx_ai1_15( "revenge", 100 );
			}
			wait 2.5;
			foreach( player in level.players )
			{
				player thread fx_ai1_9(&"Survived Wave ", 1, (1,1,1), (0.3,0.9,0.3), 0.85, level.Wave);
				player thread fx_ai1_7("20 Second Intermission", 1, (1,1,0.5), (1,1,0.5), 0);
			}
			wait 2.5;
			level notify("round_ended");
			level notify("zombie_round_started_end");
			break;
		}
		else if(ai_ZombieCount() <= 0 && level.Wave >= level.MaxWaves)
		{
			level thread fx_ai1_14();
			break;
		}
		wait 0.05;
	}
}

ai_MonitorFinishBoss( )
{
	level endon("crate_gone");
	for(;;)
	{
		if(ai_ZombieCount() <= 0 && level.Wave < level.MaxWaves)
		{
			level.zState = "intermission";
			wait 2;
			foreach( player in level.players ) if(isDefined( player.needsToSpawn ) && player.needsToSpawn)
			{
				player notify("respawn");
				player thread [[level.SpawnClient]]();
				player allowSpectateTeam( "freelook", false );
				player clearLowerMessage("spawn_info");
			}
			Announcement( "^2Max Ammo for All Players And $2000" );
			foreach( player in level.players )
			{
				player.gambler = 0;
				player.money += 2000;
				player notify("MONEY");
				player thread fx_ai1_13("^3Max Ammo!", "^2$2000", "waypoint_ammo_friendly", "ammo_crate_use");
				player thread fx_ai1_12( "Max Ammo!" );
				player thread fx_ai1_16( 2000, 0, (0,1,0), 1 );
				player fx_ai1_19( "frag_grenade_mp" );
				player fx_ai1_18();
			}
			level.AmmoDrop = undefined;
			level thread ai_C130FlyBy();
			wait 2.5;
			foreach( player in level.players )
			{
				player thread fx_ai1_9("Boss Wave Survived", 1, (1,1,1), (0.3,0.9,0.3), 0.85);
				player thread fx_ai1_7("20 Second Intermission", 1, (1,1,0.5), (1,1,0.5), 0);
			}
			wait 2.5;
			level notify("round_ended");
			level notify("zombie_round_started_end");
			break;
		}
		else if(ai_ZombieCount() <= 0 && level.Wave >= level.MaxWaves)
		{
			level thread fx_ai1_14();
			break;
		}
		wait 0.05;
	}
}

ai_MonitorFinishCrawler( )
{
	level endon("crate_gone");
	for(;;)
	{
		if(ai_ZombieCount() <= 0 && level.Wave < level.MaxWaves)
		{
			level.zState = "intermission";
			wait 2;
			foreach( player in level.players ) if(isDefined( player.needsToSpawn ) && player.needsToSpawn)
			{
				player notify("respawn");
				player thread [[level.SpawnClient]]();
				player allowSpectateTeam( "freelook", false );
				player clearLowerMessage("spawn_info");
			}
			Announcement( "^2Max Ammo for All Players And $500" );
			foreach( player in level.players )
			{
				player.gambler = 0;
				player.money += 500;
				player notify("MONEY");
				player thread fx_ai1_13("^3Max Ammo!", "^2$500", "waypoint_ammo_friendly", "ammo_crate_use");
				player thread fx_ai1_12( "Max Ammo!" );
				player thread fx_ai1_16( 500, 0, (0,1,0), 1 );
				player fx_ai1_19( "frag_grenade_mp" );
				player fx_ai1_18();
			}
			level.AmmoDrop = undefined;
			level thread ai_C130FlyBy();
			wait 2.5;
			foreach( player in level.players )
			{
				player thread fx_ai1_9("Crawler Wave Survived", 1, (1,1,1), (0.3,0.9,0.3), 0.85);
				player thread fx_ai1_7("20 Second Intermission", 1, (1,1,0.5), (1,1,0.5), 0);
			}
			wait 2.5;
			level notify("round_ended");
			level notify("zombie_round_started_end");
			break;
		}
		else if(ai_ZombieCount() <= 0 && level.Wave >= level.MaxWaves)
		{
			level thread fx_ai1_14();
			break;
		}
		wait 0.05;
	}
}

ai_MonitorBotHealth( )
{
	self endon("bot_is_dead");
	level endon("round_ended");
	pTemp = "";
	for(;;)
	{
		self.crate1 waittill("damage", iDamage, attacker, iDFlags, vPoint, type, victim, vDir, sHitLoc, psOffsetTime, sWeapon);
			
		{
			attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(sHitLoc);
			{
				playFx(level.bloodfx,vPoint);
				self notify("hit");
				if(!isDefined(self.c4) || self.type != "zombie_crawler")
				{
					self thread maps\mp\_modmenu_ai3::ai_HitPainAnim();
				}
				attacker.money += 5;
				attacker thread fx_ai1_16( 5, 0, (0,1,0), 1 );
				attacker notify("MONEY");
				attacker.score += 5;
				if(sWeapon == "pavelow_minigun_mp")
					self.crate1.health += 20;
				self thread maps\mp\_modmenu_ai3::ai_IncreaseDamage(sWeapon,type);
			}
		}
		if( (self.crate1.health <= 0) && (self.name != pTemp) )
		{
		    self.crate1 thread ai_DeleteZombie();
			self.speed = 1;
			self.pers["isAlive"] = "false";
			wait 0.1;
			self notify("bot_death");
			self.knife delete();
			playFx(level.bloodfx,vPoint);
			if(self.type == "zombie_crawler")
				self scriptModelPlayAnim("pb_prone_death_quickdeath"); // Crawler Death
			else
				self thread fx_ai1_4(); //Reguler Death Anim
			self thread fx_ai1_5(); //Death Sound
			if(attacker.usingairstrike == "true")
			{
				attacker thread maps\mp\_modmenu_ai3::ai_ZombieAirstrikeSound(sWeapon);
			}
			attacker thread maps\mp\_modmenu_ai3::ai_multikill();
			if(maps\mp\_modmenu_ai3::ai_IfCanBlowUp(sWeapon) == true)
				self maps\mp\_modmenu_ai3::ai_blowBackGrenade(vPoint);
			if(maps\mp\_modmenu_ai3::ai_IfCanSetOnFire(sWeapon) == true)
				self thread maps\mp\_modmenu_ai3::ai_PlayFireDeath();
			if(attacker.extra <= 0 && attacker.ammomatic == 0)
			{
				attacker thread fx_ai1_16( 50, 0, (0,1,0), 1 );
				attacker.kills += 1;
				attacker.pers["kills"] = attacker.kills;
				attacker notify("zombie_killed");
				attacker.money += 50;
				attacker notify("MONEY");
				attacker.score += 50;
				attacker.bonus += 1;
				attacker notify("BONUS");
				attacker.pers["score"] = attacker.score;
				attacker.pers["botKillstreak"]++;
			}
			else if(attacker.extra >= 1 && attacker.ammomatic == 0)
			{
				attacker thread fx_ai1_16( 100, 0, (0,1,0), 1 );
				attacker.kills += 1;
				attacker.pers["kills"] = attacker.kills;
				attacker notify("zombie_killed");
				attacker.money += 100;
				attacker notify("MONEY");
				attacker.score += 100;
				attacker.bonus += 1;
				attacker notify("BONUS");
				attacker.pers["score"] = attacker.score;
				attacker.pers["botKillstreak"]++;
			}
			else if(attacker.extra <= 0 && attacker.ammomatic == 1)
			{
				currentWeapon = attacker getCurrentWeapon();
				stock = attacker getWeaponAmmoStock(currentWeapon);
				attacker thread fx_ai1_16( 50, 0, (0,1,0), 1 );
				attacker.kills += 1;
				attacker.pers["kills"] = attacker.kills;
				attacker notify("zombie_killed");
				attacker.money += 50;
				attacker notify("MONEY");
				attacker.score += 50;
				attacker.bonus += 1;
				attacker notify("BONUS");
				attacker.pers["score"] = attacker.score;
				attacker.pers["botKillstreak"]++;
				attacker setWeaponAmmoStock( currentWeapon, stock + fx_ai1_1(sWeapon) );
			}
			else if(attacker.extra >= 1 && attacker.ammomatic == 1)
			{
				currentWeapon = attacker getCurrentWeapon();
				stock = attacker getWeaponAmmoStock(currentWeapon);
				attacker thread fx_ai1_16( 100, 0, (0,1,0), 1 );
				attacker.kills += 1;
				attacker.pers["kills"] = attacker.kills;
				attacker notify("zombie_killed");
				attacker.money += 100;
				attacker notify("MONEY");
				attacker.score += 100;
				attacker.bonus += 1;
				attacker notify("BONUS");
				attacker.pers["score"] = attacker.score;
				attacker.pers["botKillstreak"]++;
				attacker setWeaponAmmoStock( currentWeapon, stock + fx_ai1_1(sWeapon) );
			}
			if(isDefined(self.hasc4))
			{
				playFx(loadFx("props/barrelExp"), self.origin);
				RadiusDamage( self.origin, 150, 90, 10, attacker );
				PhysicsExplosionSphere( self.origin, 230, 0, 3 );
				self playSound("explo_mine");
				self.c4 delete();
			}
			wait 0.5;
			self startRagDoll(1);
			wait 5;
			pTemp = self.name;
			self thread ai_DeleteZombie();
			self notify("bot_is_dead");
		}
		wait 0.05;
	}
}

ai_DeleteZombie()
{
	wait 0.001;
	self delete();
	self.head delete();
	self.c4 delete();
	self.knife delete();
	self.shield delete();
}

ai_BotMoveWaypoints()
{
	if(self.automove == 1)
	{
		return;
	}
	self endon("stop_auto_move");
	self endon("bot_death");
	TmpDist = 0;
	pTarget = undefined;
	pWaypoint = undefined;
	movetoLoc = undefined;
	if(!isDefined(self.currentwaypoint))
	{
		self.currentwaypoint = level.botwaypoints[999999999999999];
	}
	if(isDefined(level.botwaypoints))
	{
		for(i = 0; i < level.botwaypoints.size; i++)
		{
			if(distance(self.origin, level.botwaypoints[i].origin) > TmpDist && self.currentwaypoint != level.botwaypoints[i] && bulletTracePassed( self.origin+(0,0,75), level.botwaypoints[i].origin, false, self ))
			{
				TmpDist = distance(self.origin, level.botwaypoints[i].origin);
				pWaypoint = level.botwaypoints[i];
			}
		}
	}
	if(isDefined(pWaypoint))
	{
		self.automove = 1;
		self.currentwaypoint = pWaypoint;
		movetoLoc = VectorToAngles( pWaypoint.origin - self.origin );
		self RotateTo((0,movetoLoc[1],0), 0.1);
		while(self.origin[0] != pWaypoint.origin[0])
		{
			trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, self);
			if(isdefined(trace["entity"]) && isDefined(trace["entity"].targetname) && trace["entity"].targetname == "bot")
				trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, trace["entity"]);
			self.origin = (trace["position"]);
			self.currentsurface = trace["surfacetype"];
			if(self.currentsurface == "none")
				self.currentsurface = "default";
			self MoveTo(pWaypoint.origin, (distance(self.origin, pWaypoint.origin) / self.speed));
			wait 0.2;
		}
		self.automove = 0;
	}
}

ai_GetBestPlayerAndMoveTo( )
{
	self endon("bot_death");
	self endon("stop_bot");

	for(;;)
	{
		TmpDist = 999999999;
		pTarget = undefined;
		pAngles = undefined;
		movetoLoc = undefined;

		while(self.freezed == 1 || getDvarInt("z_find") == 0)
		{
			//Clamp to the ground has been moved into one function
			trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, self);
			if(isdefined(trace["entity"]) && isDefined(trace["entity"].targetname) && trace["entity"].targetname == "bot")
				trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, trace["entity"]);
			self.origin = (trace["position"]);
			self.currentsurface = trace["surfacetype"];
			if(self.currentsurface == "none")
				self.currentsurface = "default";
				
			if(self.idleanimation == 0)
			{
				self scriptModelPlayAnim("pb_stand_alert");
				self.idleanimation = 1;
			}
			
			wait 0.1;
		}
			
		foreach( player in level.players )
		{				
			if(!isAlive(player))
                continue;
				
			if(level.teamBased && self.team == player.pers["team"])
                continue;
				
			if( !bulletTracePassed( self.origin+(0,0,75), player.origin+(0,0,65), false, self ) )
                continue;
				
			if(player.sessionstate != "playing")
				continue;
				
			if(player.inLastStand == true)
				continue;
				
			if(distancesquared(self.origin, player.origin) < TmpDist)
			{
				TmpDist = distancesquared(self.origin, player.origin);
				pTarget = player;
				pAngles = "player";
			}
		}
		if(pAngles == "player")
		{
			movetoLoc = VectorToAngles( pTarget.origin - self.origin );
		}
		if(!isDefined(pTarget))
		{
			if(!isDefined(level.botwaypoints[0]))
			{
				if(self.idleanimation == 0)
				{
					self scriptModelPlayAnim("pb_stand_alert");
					self.idleanimation = 1;
					//Clamp to the ground has been moved into one function
					trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, self);
					if(isdefined(trace["entity"]) && isDefined(trace["entity"].targetname) && trace["entity"].targetname == "bot")
						trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, trace["entity"]);
					self.origin = (trace["position"]);
					self.currentsurface = trace["surfacetype"];
					if(self.currentsurface == "none")
						self.currentsurface = "default";
				}
			}
			else
			{
				self thread ai_BotMoveWaypoints();
			}
		}
		if(isDefined(pTarget))
		{
			if(self.idleanimation == 1)
			{
				self scriptModelPlayAnim(self.animation);
				self.idleanimation = 0;
			}
			//Clamp to the ground has been moved into one function
			trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, self);
			if(isdefined(trace["entity"]) && isDefined(trace["entity"].targetname) && trace["entity"].targetname == "bot")
				trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, trace["entity"]);
			self.origin = (trace["position"]);
			self.currentsurface = trace["surfacetype"];
			if(self.currentsurface == "none")
				self.currentsurface = "default";
			self notify("stop_auto_move");
			self.automove = 0;
		}
		movetoLoc = VectorToAngles( pTarget getTagOrigin("j_head") - self getTagOrigin( "j_head" ) );
		self RotateTo((0,movetoLoc[1],0), 0.1);
		self MoveTo(pTarget.origin, (distance(self.origin, pTarget.origin) / self.speed));
		
	wait 0.1;
	}
}

ai_MonitorAttackPlayers( )
{
	self endon("bot_death");
	while(isDefined(self))
	{
		foreach( player in level.players )
		{
			pTarget = player;
			if(distancesquared(player.origin, self.origin) <= 729 && player.inLastStand != true && player.inFinalStand != true && player.pers["team"] == "allies")
			{
				self.knife = spawn("script_model", self getTagOrigin("tag_inhand"));
				self.knife setModel("weapon_parabolic_knife");
				self.knife.angles = (0,0,0);
				self.knife linkto( self, "tag_inhand" );
				self scriptModelPlayAnim("pt_melee_pistol_1");
				wait 0.15;
				self playSound("melee_knife_stab");
				playFx(level.bloodfx,self.origin+(0,0,30));
				player thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper( self, self, 50, 0, "MOD_MELEE", "none", player.origin, player.origin, "none", 0, 0 );
				wait 1;
				self.knife delete();
				self scriptModelPlayAnim(self.animation);
			}
		}
		wait 0.07;
	}
}

ai_ZombieMarkers()
{
	self endon("bot_is_dead");
	level endon("round_ended");
	wait 5;
	for(;;)
	{
		if(ai_ZombieCount() <= level.BotsForIcons && level.RealSpawnedBots > level.BotsForIcons) for(i = 0;i < level.BotsForWave;i++)
		{
			if((isDefined(level.bots[i])) && (isDefined(level.bots[i].crate1.health)) && (level.bots[i].crate1.health > 0) && (!level.bots[i].hasMarker))
			{
				if ( isdefined( self.lastDeathIcon ) )
				{
					level.bots[i].lastDeathIcon destroy();
				}
				newdeathicon = newHudElem();
				newdeathicon.x = level.bots[i].origin[0];
				newdeathicon.y = level.bots[i].origin[1];
				newdeathicon.z = level.bots[i].origin[2] + 54;
				newdeathicon.alpha = .61;
				newdeathicon.archived = true;
				newdeathicon setShader("cardicon_skull", 10, 10);
				newdeathicon setwaypoint( true, false );
				level.bots[i].lastDeathIcon = newdeathicon;
				level.bots[i].hasMarker = true;
				level.bots[i] thread ai_MoveIcon(level.bots[i].lastDeathIcon);
				level.bots[i] thread maps\mp\_modmenu_ai3::ai_BotDestroyOnDeath(level.bots[i].lastDeathIcon);
			}
		}
		else if(ai_ZombieCount() > level.BotsForIcons) for(i = 0;i < level.BotsForWave;i++)
		{
			if((isDefined(level.bots[i])) && (isDefined(level.bots[i].crate1.health)) && (level.bots[i].crate1.health > 0) && (level.bots[i].hasMarker))
			{
				if ( isdefined( self.lastDeathIcon ) )
				{
					level.bots[i].lastDeathIcon destroy();
				}
				level.bots[i].hasMarker = false;
				level.bots[i] notify("noicon");
			}
		}
		wait 0.1;
	}
}

ai_MoveIcon(icon)
{
	self endon("bot_is_dead");
	self endon("noicon");
	for(;;)
	{
		icon.x = self.origin[0];
		icon.y = self.origin[1];
		icon.z = self.origin[2] + 54;
		wait 0.05;
	}
}

ai__bot_KillIfUnderMap()
{
	self endon("bot_is_dead");
	for(;;)
	{
		if(self.origin[2] <= -1585 && getDvar("mapname") == "mp_afghan")
		{
			self notify("bot_death");
			self.crate1 delete();
			self.crate1 notify("bot_death");
			if(self.type == "crawler")
				self scriptModelPlayAnim("pb_prone_death_quickdeath"); // Crawler Death
			else
				self thread fx_ai1_4(); //Reguler Death Anim
			self thread fx_ai1_5();
			wait 1;
			self startRagDoll(1);
			wait 5;
			self thread ai_DeleteZombie();
			self notify("bot_is_dead");
			break;
		}	
		if(self.origin[2] <= -350 && getDvar("mapname") == "mp_vacant")
		{
			self notify("bot_death");
			self.crate1 delete();
			self.crate1 notify("bot_death");
			if(self.type == "crawler")
				self scriptModelPlayAnim("pb_prone_death_quickdeath"); // Crawler Death
			else
				self thread fx_ai1_4(); //Reguler Death Anim
			self thread fx_ai1_5();
			wait 1;
			self startRagDoll(1);
			wait 5;
			self thread ai_DeleteZombie();
			self notify("bot_is_dead");
			break;
		}	
		if(self.origin[2] <= -100 && getDvar("mapname") == "mp_storm")
		{
			self notify("bot_death");
			self.crate1 delete();
			self.crate1 notify("bot_death");
			if(self.type == "crawler")
				self scriptModelPlayAnim("pb_prone_death_quickdeath"); // Crawler Death
			else
				self thread fx_ai1_4(); //Reguler Death Anim
			self thread fx_ai1_5();
			wait 1;
			self startRagDoll(1);
			wait 5;
			self thread ai_DeleteZombie();
			self notify("bot_is_dead");
			break;
		}	
		if(self.origin[2] <= -333 && getDvar("mapname") == "mp_rust")
		{
			self notify("bot_death");
			self.crate1 delete();
			self.crate1 notify("bot_death");
			if(self.type == "crawler")
				self scriptModelPlayAnim("pb_prone_death_quickdeath"); // Crawler Death
			else
				self thread fx_ai1_4(); //Reguler Death Anim
			self thread fx_ai1_5();
			wait 1;
			self startRagDoll(1);
			wait 5;
			self thread ai_DeleteZombie();
			self notify("bot_is_dead");
			break;
		}	
		if(self.origin[2] <= -782 && getDvar("mapname") == "mp_estate")
		{
			self notify("bot_death");
			self.crate1 delete();
			self.crate1 notify("bot_death");
			if(self.type == "crawler")
				self scriptModelPlayAnim("pb_prone_death_quickdeath"); // Crawler Death
			else
				self thread fx_ai1_4(); //Reguler Death Anim
			self thread fx_ai1_5();
			wait 1;
			self startRagDoll(1);
			wait 5;
			self thread ai_DeleteZombie();
			self notify("bot_is_dead");
			break;
		}	
		wait 1;
	}
}

ai_ZombieCount()
{
	zombCount = 0;
	for(i = 0;i < level.BotsForWave;i++)
	{
		if(isDefined(level.bots[i]) && level.bots[i].crate1.health >= 1 && level.bots[i].pers["isAlive"] == "true") 
			zombCount++;
	}
	return zombCount;
}

ai_SpawnTrigger(Torigin, gotoOrigin, width, height, map_name)
{
	trig = spawn("trigger_radius", Torigin,0,width,height);
	trig.goto = gotoOrigin;
	trig thread ai_waitfortrig(map_name);
	return trig;
}

ai_waitfortrig(map_name)
{
	while(getdvar("mapname") == map_name)
	{
		self waittill("trigger",player);
		if(player.sessionstate != "playing") 
		{
			continue;
		}
		player setOrigin(self.goto);
		player iPrintlnBold("Anti-Glitch");
		wait 0.05;
	}
}

ai_GetMapSpawnPoint( )
{
	level endon("game_ended");
	Waypoint = undefined;
	switch( getDvar("mapname") )
	{
		case "mp_afghan": switch( randomInt(5) )
		{
			case 0: Waypoint = (-3883,-553,-1448);
			break;
			case 1: Waypoint = (-3975,3,-1448);
			break;
			case 2: Waypoint = (-3828,-1164,-1448);
			break;
			case 3: Waypoint = (-4523,1006,-1449);
			break;
			case 4: Waypoint = (-4422,1209,-1449);
			break;
		}
		break;
		case "mp_highrise": if(level.edit == 0) switch( randomInt(6) )
		{
			case 0: Waypoint = (-10570.8,3467.6,2331.1);
			break;
			case 1: Waypoint = (-10585.3,4465.4,2331.1);
			break;
			case 2: Waypoint = (-10584.8,5087.2,2331.1);
			break;
			case 3: Waypoint = (-10582.4,5734.4,2331.1);
			break;
			case 4: Waypoint = (-10585.2,6343.9,2331.1);
			break;
			case 5: Waypoint = (-10590.7,6788.7,2331.1);
			break;
		}
		else if(level.edit == 1) switch( randomInt(6) )
		{
			case 0: Waypoint = (-12790.8,6852.1,5439.1);
			break;
			case 1: Waypoint = (-13306.1,6843.3,5439.1);
			break;
			case 2: Waypoint = (-13634.1,6833.1,5439.1);
			break;
			case 3: Waypoint = (-14091.3,6824.7,5439.1);
			break;
			case 4: Waypoint = (-15127.1,6834.4,5439.1);
			break;
			case 5: Waypoint = (-15743.5,6837.2,5439.1);
			break;
		}
		break;
		case "mp_quarry": switch( randomInt(5) )
		{
			case 0: Waypoint = (-5450.5,2040.9,98.4);
			break;
			case 1: Waypoint = (-5299.9,2052.6,96.5);
			break;
			case 2: Waypoint = (-4564.2,3020.4,81.6);
			break;
			case 3: Waypoint = (-2071.8,765.1,29);
			break;
			case 4: Waypoint = (-2208.5,762.4,28.8);
			break;
		}
		break;
		case "mp_brecourt": switch( randomInt(6) )
		{
			case 0: Waypoint = (10961,6828,358);
			break;
			case 1: Waypoint = (10955,6688,358);
			break;
			case 2: Waypoint = (9850,8886,358);
			break;
			case 3: Waypoint = (9693,8883,358);
			break;
			case 4: Waypoint = (12867,7423,1486);
			break;
			case 5: Waypoint = (12856,7070,1486);
			break;
		}
		break;
		case "mp_rust": if(level.edit == 0) switch( randomInt(8) )
		{
			case 0: Waypoint = (3703,-6900,-220);
			break;
			case 1: Waypoint = (2638,-6917,-258);
			break;
			case 2: Waypoint = (2524,-6328,-231);
			break;
			case 3: Waypoint = (4281,-10529,-162);
			break;
			case 4: Waypoint = (4489,-10224,-199);
			break;
			case 5: Waypoint = (-1342,-9528,-243);
			break;
			case 6: Waypoint = (-1294,-9813,-191);
			break;
			case 7: Waypoint = (-1165,-9661,-213);
			break;
		}
		else if(level.edit == 1) switch( randomInt(8) )
		{
			case 0: Waypoint = (532,-9970,-75);
			break;
			case 1: Waypoint = (842,-10000,-92);
			break;
			case 2: Waypoint = (1154,-9684,-131);
			break;
			case 3: Waypoint = (1483,-9520,-164);
			break;
			case 4: Waypoint = (-651,-5268,-201);
			break;
			case 5: Waypoint = (-712,-5424,-217);
			break;
			case 6: Waypoint = (-2660,-6704,-252);
			break;
			case 7: Waypoint = (-2775,-7030,-245);
			break;
		}
		break;
		case "mp_terminal": switch( randomInt(5) )
		{
			case 0: Waypoint = (2814,2838,63);
			break;
			case 1: Waypoint = (45,4253,51);
			break;
			case 2: Waypoint = (11,4157,51);
			break;
			case 3: Waypoint = (2917,3983,95);
			break;
			case 4: Waypoint = (2426,4398,198);
			break;
		}
		break;
		case "mp_boneyard": switch( randomInt(7) )
		{
			case 0: Waypoint = (-674,-3297,-12);
			break;
			case 1: Waypoint = (1287,-2771,-52);
			break;
			case 2: Waypoint = (1268,-2908,-52);
			break;
			case 3: Waypoint = (1205,-2046,-52);
			break;
			case 4: Waypoint = (1440,-4082,-52);
			break;
			case 5: Waypoint = (-1036,-3259,-12);
			break;
			case 6: Waypoint = (-1212,-2318,-7);
			break;
		}
		break;
		case "mp_underpass": switch( randomInt(4) )
		{
			case 0: Waypoint = (2811,3147,400);
			break;
			case 1: Waypoint = (3009,2663,424);
			break;
			case 2: Waypoint = (2799,2946,395);
			break;
			case 3: Waypoint = (4036,3602,432);
			break;
		}
		break;
		case "mp_derail": switch( randomInt(8) )
		{
			case 0: Waypoint = (981,3216,192);
			break;
			case 1: Waypoint = (1042,3240,192);
			break;
			case 2: Waypoint = (914,1633,198);
			break;
			case 3: Waypoint = (933,1567,176);
			break;
			case 4: Waypoint = (2760,819,186);
			break;
			case 5: Waypoint = (2987,823,188);
			break;
			case 6: Waypoint = (2541,3475,247);
			break;
			case 7: Waypoint = (1695,2781,129);
			break;
		}
		break;
		case "mp_nightshift": if(level.edit == 0) switch( randomInt(7) )
		{
			case 0: Waypoint = (-103.6,-1894.1,11.1);
			break;
			case 1: Waypoint = (48.9,927.4,91.1);
			break;
			case 2: Waypoint = (48.9,805.9,91.1);
			break;
			case 3: Waypoint = (-1856.9,-2192.3,11.9);
			break;
			case 4: Waypoint = (-1803.5,-2203.2,16.1);
			break;
			case 5: Waypoint = (-323.3,-713.0,7.1);
			break;
			case 6: Waypoint = (-364.8,-538.5,7.1);
			break;
		}
		else if(level.edit == 1) switch( randomInt(6) )
		{
			case 0: Waypoint = (-610,-1922,16);
			break;
			case 1: Waypoint = (1904,-1258,3);
			break;
			case 2: Waypoint = (-205,-745,16);
			break;
			case 3: Waypoint = (-107,672,24);
			break;
			case 4: Waypoint = (-6,593,24);
			break;
			case 5: Waypoint = (-611,-1873,16);
			break;
		}
		else if(level.edit == 2) switch( randomInt(4) )
		{
			case 0: Waypoint = (1963,-3377,8);
			break;
			case 1: Waypoint = (1740,-3359,16);
			break;
			case 2: Waypoint = (1666,-3366,16);
			break;
			case 3: Waypoint = (1599,-3368,16);
			break;
		}
		break;
		case "mp_estate": switch( randomInt(3) )
		{
			case 0: Waypoint = (-2602,-2388,-490);
			break;
			case 1: Waypoint = (-2698,-2395,-491);
			break;
			case 2: Waypoint = (-2771,-2384,-489);
			break;
		}
		break;
		case "mp_favela": switch( randomInt(3) )
		{
			case 0: Waypoint = (2951,3108,296);
			break;
			case 1: Waypoint = (2892,3025,296);
			break;
			case 2: Waypoint = (2699,3120,296);
			break;
		}
		break;
		case "mp_invasion": switch( randomInt(5) )
		{
			case 0: Waypoint = (4707,12271,4);
			break;
			case 1: Waypoint = (4656,11899,9);
			break;
			case 2: Waypoint = (4139,11325,-37);
			break;
			case 3: Waypoint = (2401,8462,16);
			break;
			case 4: Waypoint = (2460,8366,16);
			break;
		}
		break;
		case "mp_checkpoint": switch( randomInt(8) )
		{
			case 0: Waypoint = (2584,5298,-15);
			break;
			case 1: Waypoint = (2280,5295,-15);
			break;
			case 2: Waypoint = (-42,3239,16);
			break;
			case 3: Waypoint = (-39,3020,16);
			break;
			case 4: Waypoint = (4030,2730,-28);
			break;
			case 5: Waypoint = (4083,3150,-28);
			break;
			case 6: Waypoint = (-68,2785,19);
			break;
			case 7: Waypoint = (4308,2511,3);
			break;
		}
		break;
		case "mp_subbase": switch( randomInt(3) )
		{
			case 0: Waypoint = (-422,-6429,16);
			break;
			case 1: Waypoint = (-339,-6430,16);
			break;
			case 2: Waypoint = (-252,-6434,16);
			break;
		}
		break;
		case "mp_trailerpark": switch( randomInt(6) )
		{
			case 0: Waypoint = (2772.9,-2118.9,16.1);
			break;
			case 1: Waypoint = (2785.4,-2068.2,16.1);
			break;
			case 2: Waypoint = (2754.0,-1988.4,17.1);
			break;
			case 3: Waypoint = (-1299.1,-2064.4,16.0);
			break;
			case 4: Waypoint = (-1176.7,-1980.7,16.0);
			break;
			case 5: Waypoint = (-1203.7,-2142.3,16.0);
			break;
		}
		break;
		case "mp_rundown": switch( randomInt(5) )
		{
			case 0: Waypoint = (647,2218,105);
			break;
			case 1: Waypoint = (1502,2331,58);
			break;
			case 2: Waypoint = (263,2633,121);
			break;
			case 3: Waypoint = (317,2398,138);
			break;
			case 4: Waypoint = (514,3748,41);
			break;
		}
		break;
		case "mp_compact": switch( randomInt(4) )
		{
			case 0: Waypoint = (3764,2701,285);
			break;
			case 1: Waypoint = (1050,2000,116);
			break;
			case 2: Waypoint = (1072,1943,133);
			break;
			case 3: Waypoint = (3763,2759,285);
			break;
		}
		break;
		case "mp_strike": switch( randomInt(2) )
		{
			case 0: Waypoint = (-3888,1311,17);
			break;
			case 1: Waypoint = (-3879,1459,16);
			break;
		}
		break;
		case "mp_complex": switch( randomInt(2) )
		{
			case 0: Waypoint = (3133,-849,1056);
			break;
			case 1: Waypoint = (2909,-828,1056);
			break;
		}
		break;
		case "mp_abandon": switch( randomInt(13) )
		{
			case 0: Waypoint = (-1249,1119,3);
			break;
			case 1: Waypoint = (-2064,1635,3);
			break;
			case 2: Waypoint = (-1143,1217,3);
			break;
			case 3: Waypoint = (-842,2015,3);
			break;
			case 4: Waypoint = (-290,3437,3);
			break;
			case 5: Waypoint = (-829,4036,3);
			break;
			case 6: Waypoint = (-2844,5341,3);
			break;
			case 7: Waypoint = (-3144,5303,3);
			break;
			case 8: Waypoint = (-3674,4526,3);
			break;
			case 9: Waypoint = (-4415,3575,3);
			break;
			case 10: Waypoint = (-4112,1326,1);
			break;
			case 11: Waypoint = (-3793,1030,1);
			break;
			case 12: Waypoint = (-3395,777,1);
			break;
		}
		break;
		case "mp_vacant": switch( randomInt(6) )
		{
			case 0: Waypoint = (-1768,1765,-87);
			break;
			case 1: Waypoint = (-1830,1769,-87);
			break;
			case 2: Waypoint = (-734,1782,-97);
			break;
			case 3: Waypoint = (68,-1375,-88);
			break;
			case 4: Waypoint = (494,-1189,-85);
			break;
			case 5: Waypoint = (-972,-1366,-91);
			break;
		}
		break;
		case "mp_storm": switch( randomInt(6) )
		{
			case 0: Waypoint = (5136,-1295,48);
			break;
			case 1: Waypoint = (5120,-1105,48);
			break;
			case 2: Waypoint = (4957,851,-47);
			break;
			case 3: Waypoint = (4787,794,-48);
			break;
			case 4: Waypoint = (2851,-1777,8);
			break;
			case 5: Waypoint = (4210,-837,8);
			break;
		}
		break;
	}
	return Waypoint;
}

ai_GetHeadSpawnModelZombie( )
{
	rModel = "";

	switch( getDvar("mapname") )
	{
		case "mp_afghan": switch( randomInt(5) )
		{
			case 0: rModel = "head_opforce_arab_a";
			break;
			case 1: rModel = "head_opforce_arab_b";
			break;
			case 2: rModel = "head_opforce_arab_c";
			break;
			case 3: rModel = "head_opforce_arab_d_hat";
			break;
			case 4: rModel = "head_opforce_arab_e";
			break;
		}
		break;
		case "mp_strike": switch( randomInt(5) )
		{
			case 0: rModel = "head_opforce_arab_a";
			break;
			case 1: rModel = "head_opforce_arab_b";
			break;
			case 2: rModel = "head_opforce_arab_c";
			break;
			case 3: rModel = "head_opforce_arab_d_hat";
			break;
			case 4: rModel = "head_opforce_arab_e";
			break;
		}
		break;
		case "mp_rust": switch( randomInt(5) )
		{
			case 0: rModel = "head_opforce_arab_a";
			break;
			case 1: rModel = "head_opforce_arab_b";
			break;
			case 2: rModel = "head_opforce_arab_c";
			break;
			case 3: rModel = "head_opforce_arab_d_hat";
			break;
			case 4: rModel = "head_opforce_arab_e";
			break;
		}
		case "mp_boneyard": switch( randomInt(5) )
		{
			case 0: rModel = "head_opforce_arab_a";
			break;
			case 1: rModel = "head_opforce_arab_b";
			break;
			case 2: rModel = "head_opforce_arab_c";
			break;
			case 3: rModel = "head_opforce_arab_d_hat";
			break;
			case 4: rModel = "head_opforce_arab_e";
			break;
		}
		break;
		case "mp_trailerpark": switch( randomInt(5) )
		{
			case 0: rModel = "head_opforce_arab_a";
			break;
			case 1: rModel = "head_opforce_arab_b";
			break;
			case 2: rModel = "head_opforce_arab_c";
			break;
			case 3: rModel = "head_opforce_arab_d_hat";
			break;
			case 4: rModel = "head_opforce_arab_e";
			break;
		}
		break;
		case "mp_invasion": switch( randomInt(5) )
		{
			case 0: rModel = "head_opforce_arab_a";
			break;
			case 1: rModel = "head_opforce_arab_b";
			break;
			case 2: rModel = "head_opforce_arab_c";
			break;
			case 3: rModel = "head_opforce_arab_d_hat";
			break;
			case 4: rModel = "head_opforce_arab_e";
			break;
		}
		break;
		case "mp_checkpoint": switch( randomInt(5) )
		{
			case 0: rModel = "head_opforce_arab_a";
			break;
			case 1: rModel = "head_opforce_arab_b";
			break;
			case 2: rModel = "head_opforce_arab_c";
			break;
			case 3: rModel = "head_opforce_arab_d_hat";
			break;
			case 4: rModel = "head_opforce_arab_e";
			break;
		}
		break;
		case "mp_underpass": switch( randomInt(4) )
		{
			case 0: rModel = "head_militia_ba_blk";
			break;
			case 1: rModel = "head_militia_bb_blk_hat";
			break;
			case 2: rModel = "head_militia_bc_blk";
			break;
			case 3: rModel = "head_militia_bd_blk";
			break;
		}
		break;
		case "mp_quarry": switch( randomInt(4) )
		{
			case 0: rModel = "head_militia_ba_blk";
			break;
			case 1: rModel = "head_militia_bb_blk_hat";
			break;
			case 2: rModel = "head_militia_bc_blk";
			break;
			case 3: rModel = "head_militia_bd_blk";
			break;
		}
		break;
		case "mp_favela": switch( randomInt(4) )
		{
			case 0: rModel = "head_militia_ba_blk";
			break;
			case 1: rModel = "head_militia_bb_blk_hat";
			break;
			case 2: rModel = "head_militia_bc_blk";
			break;
			case 3: rModel = "head_militia_bd_blk";
			break;
		}
		break;
		case "mp_rundown": switch( randomInt(4) )
		{
			case 0: rModel = "head_militia_ba_blk";
			break;
			case 1: rModel = "head_militia_bb_blk_hat";
			break;
			case 2: rModel = "head_militia_bc_blk";
			break;
			case 3: rModel = "head_militia_bd_blk";
			break;
		}
		break;
		case "mp_abandon": switch( randomInt(4) )
		{
			case 0: rModel = "head_militia_ba_blk";
			break;
			case 1: rModel = "head_militia_bb_blk_hat";
			break;
			case 2: rModel = "head_militia_bc_blk";
			break;
			case 3: rModel = "head_militia_bd_blk";
			break;
		}
		break;
		case "mp_derail": switch( randomInt(4) )
		{
			case 0: rModel = "head_opforce_arctic_a";
			break;
			case 1: rModel = "head_opforce_arctic_b";
			break;
			case 2: rModel = "head_opforce_arctic_c";
			break;
			case 3: rModel = "head_opforce_arctic_d";
			break;
		}
		break;
		case "mp_compact": switch( randomInt(4) )
		{
			case 0: rModel = "head_opforce_arctic_a";
			break;
			case 1: rModel = "head_opforce_arctic_b";
			break;
			case 2: rModel = "head_opforce_arctic_c";
			break;
			case 3: rModel = "head_opforce_arctic_d";
			break;
		}
		break;
		case "mp_subbase": switch( randomInt(4) )
		{
			case 0: rModel = "head_opforce_arctic_a";
			break;
			case 1: rModel = "head_opforce_arctic_b";
			break;
			case 2: rModel = "head_opforce_arctic_c";
			break;
			case 3: rModel = "head_opforce_arctic_d";
			break;
		}
		break;
		case "mp_highrise": switch( randomInt(5) )
		{
			case 0: rModel = "head_airborne_a";
			break;
			case 1: rModel = "head_airborne_b";
			break;
			case 2: rModel = "head_airborne_c";
			break;
			case 3: rModel = "head_airborne_d";
			break;
			case 4: rModel = "head_airborne_e";
			break;
		}
		break;
		case "mp_terminal": switch( randomInt(5) )
		{
			case 0: rModel = "head_airborne_a";
			break;
			case 1: rModel = "head_airborne_b";
			break;
			case 2: rModel = "head_airborne_c";
			break;
			case 3: rModel = "head_airborne_d";
			break;
			case 4: rModel = "head_airborne_e";
			break;
		}
		break;
		case "mp_complex": switch( randomInt(5) )
		{
			case 0: rModel = "head_airborne_a";
			break;
			case 1: rModel = "head_airborne_b";
			break;
			case 2: rModel = "head_airborne_c";
			break;
			case 3: rModel = "head_airborne_d";
			break;
			case 4: rModel = "head_airborne_e";
			break;
		}
		break;
		case "mp_brecourt": switch( randomInt(5) )
		{
			case 0: rModel = "head_airborne_a";
			break;
			case 1: rModel = "head_airborne_b";
			break;
			case 2: rModel = "head_airborne_c";
			break;
			case 3: rModel = "head_airborne_d";
			break;
			case 4: rModel = "head_airborne_e";
			break;
		}
		break;
		case "mp_nightshift": switch( randomInt(5) )
		{
			case 0: rModel = "head_airborne_a";
			break;
			case 1: rModel = "head_airborne_b";
			break;
			case 2: rModel = "head_airborne_c";
			break;
			case 3: rModel = "head_airborne_d";
			break;
			case 4: rModel = "head_airborne_e";
			break;
		}
		break;
		case "mp_estate": switch( randomInt(5) )
		{
			case 0: rModel = "head_airborne_a";
			break;
			case 1: rModel = "head_airborne_b";
			break;
			case 2: rModel = "head_airborne_c";
			break;
			case 3: rModel = "head_airborne_d";
			break;
			case 4: rModel = "head_airborne_e";
			break;
		}
		break;
		case "mp_vacant": switch( randomInt(5) )
		{
			case 0: rModel = "head_airborne_a";
			break;
			case 1: rModel = "head_airborne_b";
			break;
			case 2: rModel = "head_airborne_c";
			break;
			case 3: rModel = "head_airborne_d";
			break;
			case 4: rModel = "head_airborne_e";
			break;
		}
		break;
		case "mp_storm": switch( randomInt(5) )
		{
			case 0: rModel = "head_airborne_a";
			break;
			case 1: rModel = "head_airborne_b";
			break;
			case 2: rModel = "head_airborne_c";
			break;
			case 3: rModel = "head_airborne_d";
			break;
			case 4: rModel = "head_airborne_e";
			break;
		}
		break;
	}

	return rModel;
}

ai_GetBossSpawnModel( )
{
	level endon("game_ended");
	rModel = "";
	switch( getDvar("mapname") )
	{
		case "mp_underpass": rModel = "mp_body_riot_op_militia";
		break;
		case "mp_quarry": rModel = "mp_body_riot_op_militia";
		break;
		case "mp_afghan": rModel = "mp_body_riot_op_arab";
		break;
		case "mp_strike": rModel = "mp_body_riot_op_arab";
		break;
		case "mp_rust": rModel = "mp_body_riot_op_arab";
		break;
		case "mp_boneyard": rModel = "mp_body_riot_op_arab";
		break;
		case "mp_trailerpark": rModel = "mp_body_riot_op_arab";
		break;
		case "mp_derail": rModel = "mp_body_riot_op_arctic";
		break;
		case "mp_compact": rModel = "mp_body_riot_op_arctic";
		break;
		case "mp_highrise": rModel = "mp_body_riot_op_airborne";
		break;
		case "mp_terminal": rModel = "mp_body_riot_op_airborne";
		break;
		case "mp_complex": rModel = "mp_body_riot_op_airborne";
		break;
		case "mp_brecourt": rModel = "mp_body_riot_op_airborne";
		break;
		case "mp_nightshift": rModel = "mp_body_riot_op_airborne";
		break;
		case "mp_estate": rModel = "mp_body_riot_op_airborne";
		break;
		case "mp_favela": rModel = "mp_body_riot_op_militia";
		break;
		case "mp_invasion": rModel = "mp_body_riot_op_arab";
		break;
		case "mp_checkpoint": rModel = "mp_body_riot_op_arab";
		break;
		case "mp_subbase": rModel = "mp_body_riot_op_arctic";
		break;
		case "mp_rundown": rModel = "mp_body_riot_op_militia";
		break;
		case "mp_abandon": rModel = "mp_body_riot_op_militia";
		break;
		case "mp_vacant": rModel = "mp_body_riot_op_airborne";
		break;
		case "mp_storm": rModel = "mp_body_riot_op_airborne";
		break;
	}
	return rModel;
}

ai_GetBossHeadSpawnModel( )
{
	rModel = "";
	switch( getDvar("mapname") )
	{
		case "mp_underpass": rModel = "head_riot_op_militia";
		break;
		case "mp_quarry": rModel = "head_riot_op_militia";
		break;
		case "mp_afghan": rModel = "head_riot_op_arab";
		break;
		case "mp_strike": rModel = "head_riot_op_arab";
		break;
		case "mp_rust": rModel = "head_riot_op_arab";
		break;
		case "mp_boneyard": rModel = "head_riot_op_arab";
		break;
		case "mp_trailerpark": rModel = "head_riot_op_arab";
		break;
		case "mp_derail": rModel = "head_riot_op_arctic";
		break;
		case "mp_compact": rModel = "head_riot_op_arctic";
		break;
		case "mp_highrise": rModel = "head_riot_op_airborne";
		break;
		case "mp_complex": rModel = "head_riot_op_airborne";
		break;
		case "mp_terminal": rModel = "head_riot_op_airborne";
		break;
		case "mp_brecourt": rModel = "head_riot_op_airborne";
		break;
		case "mp_nightshift": rModel = "head_riot_op_airborne";
		break;
		case "mp_estate": rModel = "mp_body_op_sniper_ghillie_forest";
		break;
		case "mp_favela": rModel = "head_riot_op_militia";
		break;
		case "mp_invasion": rModel = "head_riot_op_arab";
		break;
		case "mp_checkpoint": rModel = "head_riot_op_arab";
		break;
		case "mp_subbase": rModel = "head_riot_op_arctic";
		break;
		case "mp_rundown": rModel = "head_riot_op_militia";
		break;
		case "mp_abandon": rModel = "head_riot_op_militia";
		break;
		case "mp_vacant": rModel = "head_riot_op_airborne";
		break;
		case "mp_storm": rModel = "head_riot_op_airborne";
		break;
	}
	return rModel;
}

ai_GetCrawlerHeadModel( )
{
	level endon("game_ended");
	rModel = "";
	switch( getDvar("mapname") )
	{
		case "mp_underpass": rModel = "head_op_sniper_ghillie_forest";
		break;
		case "mp_quarry": rModel = "head_allies_sniper_ghillie_desert";
		break;
		case "mp_afghan": rModel = "head_allies_sniper_ghillie_desert";
		break;
		case "mp_strike": rModel = "head_allies_sniper_ghillie_desert";
		break;
		case "mp_rust": rModel = "head_allies_sniper_ghillie_desert";
		break;
		case "mp_boneyard": rModel = "head_allies_sniper_ghillie_desert";
		break;
		case "mp_trailerpark": rModel = "head_opforce_arab_d_hat";
		break;
		case "mp_derail": rModel = "head_allies_sniper_ghillie_arctic";
		break;
		case "mp_compact": rModel = "head_opforce_arctic_c";
		break;
		case "mp_highrise": rModel = "head_allies_sniper_ghillie_urban";
		break;
		case "mp_terminal": rModel = "head_allies_sniper_ghillie_urban";
		break;
		case "mp_complex": rModel = "head_allies_sniper_ghillie_urban";
		break;
		case "mp_brecourt": rModel = "head_allies_sniper_ghillie_forest";
		break;
		case "mp_nightshift": rModel = "head_allies_sniper_ghillie_urban";
		break;
		case "mp_estate": rModel = "head_allies_sniper_ghillie_forest";
		break;
		case "mp_favela": rModel = "head_allies_sniper_ghillie_urban";
		break;
		case "mp_invasion": rModel = "head_allies_sniper_ghillie_urban";
		break;
		case "mp_checkpoint": rModel = "head_allies_sniper_ghillie_urban";
		break;
		case "mp_subbase": rModel = "head_allies_sniper_ghillie_urban";
		break;
		case "mp_rundown": rModel = "head_allies_sniper_ghillie_desert";
		break;
		case "mp_abandon": rModel = "head_allies_sniper_ghillie_urban";
		break;
		case "mp_vacant": rModel = "head_allies_sniper_ghillie_urban";
		break;
		case "mp_storm": rModel = "head_allies_sniper_ghillie_urban";
		break;
	}
	return rModel;
}

ai_GetCrawlerSpawnModel( )
{
	level endon("game_ended");
	rModel = "";
	switch( getDvar("mapname") )
	{
		case "mp_underpass": rModel = "mp_body_op_sniper_ghillie_forest";
		break;
		case "mp_quarry": rModel = "mp_body_ally_sniper_ghillie_desert";
		break;
		case "mp_afghan": rModel = "mp_body_ally_sniper_ghillie_desert";
		break;
		case "mp_strike": rModel = "mp_body_ally_sniper_ghillie_desert";
		break;
		case "mp_rust": rModel = "mp_body_ally_sniper_ghillie_desert";
		break;
		case "mp_boneyard": rModel = "mp_body_ally_sniper_ghillie_desert";
		break;
		case "mp_trailerpark": rModel = "mp_body_opforce_arab_lmg_a";
		break;
		case "mp_derail": rModel = "mp_body_ally_sniper_ghillie_arctic";
		break;
		case "mp_compact": rModel = "mp_body_opforce_arctic_lmg_c";
		break;
		case "mp_highrise": rModel = "mp_body_ally_sniper_ghillie_urban";
		break;
		case "mp_terminal": rModel = "mp_body_ally_sniper_ghillie_urban";
		break;
		case "mp_complex": rModel = "mp_body_ally_sniper_ghillie_urban";
		break;
		case "mp_brecourt": rModel = "mp_body_ally_sniper_ghillie_forest";
		break;
		case "mp_nightshift": rModel = "mp_body_op_sniper_ghillie_urban";
		break;
		case "mp_estate": rModel = "mp_body_op_sniper_ghillie_forest";
		break;
		case "mp_favela": rModel = "mp_body_ally_sniper_ghillie_urban";
		break;
		case "mp_invasion": rModel = "mp_body_op_sniper_ghillie_urban";
		break;
		case "mp_checkpoint": rModel = "mp_body_ally_sniper_ghillie_urban";
		break;
		case "mp_subbase": rModel = "mp_body_ally_sniper_ghillie_urban";
		break;
		case "mp_rundown": rModel = "mp_body_ally_sniper_ghillie_desert";
		break;
		case "mp_abandon": rModel = "mp_body_ally_sniper_ghillie_urban";
		break;
		case "mp_vacant": rModel = "mp_body_op_sniper_ghillie_urban";
		break;
		case "mp_storm": rModel = "mp_body_op_sniper_ghillie_urban";
		break;
	}
	return rModel;
}

ai_GetSpawnModel( )
{
	level endon("game_ended");
	rModel = "";
	switch( getDvar("mapname") )
	{
		case "mp_underpass": switch( randomInt(11) )
		{
			case 0: rModel = "mp_body_militia_assault_aa_blk";
			break;
			case 1: rModel = "mp_body_militia_assault_aa_wht";
			break;
			case 2: rModel = "mp_body_militia_assault_ab_blk";
			break;
			case 3: rModel = "mp_body_militia_assault_ac_blk";
			break;
			case 4: rModel = "mp_body_militia_lmg_aa_blk";
			break;
			case 5: rModel = "mp_body_militia_lmg_ab_blk";
			break;
			case 6: rModel = "mp_body_militia_lmg_ac_blk";
			break;
			case 7: rModel = "mp_body_militia_smg_aa_blk";
			break;
			case 8: rModel = "mp_body_militia_smg_aa_wht";
			break;
			case 9: rModel = "mp_body_militia_smg_ab_blk";
			break;
			case 10: rModel = "mp_body_militia_smg_ac_blk";
			break;
		}
		break;
		case "mp_quarry": switch( randomInt(11) )
		{
			case 0: rModel = "mp_body_militia_assault_aa_blk";
			break;
			case 1: rModel = "mp_body_militia_assault_aa_wht";
			break;
			case 2: rModel = "mp_body_militia_assault_ab_blk";
			break;
			case 3: rModel = "mp_body_militia_assault_ac_blk";
			break;
			case 4: rModel = "mp_body_militia_lmg_aa_blk";
			break;
			case 5: rModel = "mp_body_militia_lmg_ab_blk";
			break;
			case 6: rModel = "mp_body_militia_lmg_ac_blk";
			break;
			case 7: rModel = "mp_body_militia_smg_aa_blk";
			break;
			case 8: rModel = "mp_body_militia_smg_aa_wht";
			break;
			case 9: rModel = "mp_body_militia_smg_ab_blk";
			break;
			case 10: rModel = "mp_body_militia_smg_ac_blk";
			break;
		}
		break;
		case "mp_afghan": switch( randomInt(4) )
		{
			case 0: rModel = "mp_body_opforce_arab_lmg_a";
			break;
			case 1: rModel = "mp_body_opforce_arab_shotgun_a";
			break;
			case 2: rModel = "mp_body_opforce_arab_smg_a";
			break;
			case 3: rModel = "mp_body_opforce_arab_assault_a";
			break;
		}
		break;
		case "mp_strike": switch( randomInt(4) )
		{
			case 0: rModel = "mp_body_opforce_arab_lmg_a";
			break;
			case 1: rModel = "mp_body_opforce_arab_shotgun_a";
			break;
			case 2: rModel = "mp_body_opforce_arab_smg_a";
			break;
			case 3: rModel = "mp_body_opforce_arab_assault_a";
			break;
		}
		break;
		case "mp_rust": switch( randomInt(8) )
		{
			case 0: rModel = "mp_body_opforce_arab_lmg_a";
			break;
			case 1: rModel = "mp_body_opforce_arab_shotgun_a";
			break;
			case 2: rModel = "mp_body_opforce_arab_smg_a";
			break;
			case 3: rModel = "mp_body_opforce_arab_assault_a";
			break;
			case 4: rModel = "mp_body_desert_tf141_assault_a";
			break;
			case 5: rModel = "mp_body_desert_tf141_lmg";
			break;
			case 6: rModel = "mp_body_desert_tf141_smg";
			break;
			case 7: rModel = "mp_body_desert_tf141_shotgun";
			break;
		}
		break;
		case "mp_boneyard": switch( randomInt(4) )
		{
			case 0: rModel = "mp_body_opforce_arab_lmg_a";
			break;
			case 1: rModel = "mp_body_opforce_arab_shotgun_a";
			break;
			case 2: rModel = "mp_body_opforce_arab_smg_a";
			break;
			case 3: rModel = "mp_body_opforce_arab_assault_a";
			break;
		}
		break;
		case "mp_trailerpark": switch( randomInt(4) )
		{
			case 0: rModel = "mp_body_opforce_arab_lmg_a";
			break;
			case 1: rModel = "mp_body_opforce_arab_shotgun_a";
			break;
			case 2: rModel = "mp_body_opforce_arab_smg_a";
			break;
			case 3: rModel = "mp_body_opforce_arab_assault_a";
			break;
		}
		break;
		case "mp_derail": switch( randomInt(12) )
		{
			case 0: rModel = "mp_body_opforce_arctic_lmg_c";
			break;
			case 1: rModel = "mp_body_opforce_arctic_assault_b";
			break;
			case 2: rModel = "mp_body_opforce_arctic_assault_c";
			break;
			case 3: rModel = "mp_body_opforce_arctic_lmg";
			break;
			case 4: rModel = "mp_body_opforce_arctic_lmg_b";
			break;
			case 5: rModel = "mp_body_opforce_arctic_shotgun";
			break;
			case 6: rModel = "mp_body_opforce_arctic_shotgun_b";
			break;
			case 7: rModel = "mp_body_opforce_arctic_shotgun_c";
			break;
			case 8: rModel = "mp_body_opforce_arctic_smg";
			break;
			case 9: rModel = "mp_body_opforce_arctic_smg_b";
			break;
			case 10: rModel = "mp_body_opforce_arctic_smg_c";
			break;
			case 11: rModel = "mp_body_opforce_arctic_assault_a";
			break;
		}
		break;
		case "mp_compact": switch( randomInt(12) )
		{
			case 0: rModel = "mp_body_opforce_arctic_lmg_c";
			break;
			case 1: rModel = "mp_body_opforce_arctic_assault_b";
			break;
			case 2: rModel = "mp_body_opforce_arctic_assault_c";
			break;
			case 3: rModel = "mp_body_opforce_arctic_lmg";
			break;
			case 4: rModel = "mp_body_opforce_arctic_lmg_b";
			break;
			case 5: rModel = "mp_body_opforce_arctic_shotgun";
			break;
			case 6: rModel = "mp_body_opforce_arctic_shotgun_b";
			break;
			case 7: rModel = "mp_body_opforce_arctic_shotgun_c";
			break;
			case 8: rModel = "mp_body_opforce_arctic_smg";
			break;
			case 9: rModel = "mp_body_opforce_arctic_smg_b";
			break;
			case 10: rModel = "mp_body_opforce_arctic_smg_c";
			break;
			case 11: rModel = "mp_body_opforce_arctic_assault_a";
			break;
		}
		break;
		case "mp_highrise": switch( randomInt(12) )
		{
			case 0: rModel = "mp_body_airborne_assault_a";
			break;
			case 1: rModel = "mp_body_airborne_assault_b";
			break;
			case 2: rModel = "mp_body_airborne_assault_c";
			break;
			case 3: rModel = "mp_body_airborne_lmg";
			break;
			case 4: rModel = "mp_body_airborne_lmg_b";
			break;
			case 5: rModel = "mp_body_airborne_lmg_c";
			break;
			case 6: rModel = "mp_body_airborne_shotgun";
			break;
			case 7: rModel = "mp_body_airborne_shotgun_b";
			break;
			case 8: rModel = "mp_body_airborne_shotgun_c";
			break;
			case 9: rModel = "mp_body_airborne_smg";
			break;
			case 10: rModel = "mp_body_airborne_smg_b";
			break;
			case 11: rModel = "mp_body_airborne_smg_c";
			break;
		}
		break;
		case "mp_terminal": switch( randomInt(12) )
		{
			case 0: rModel = "mp_body_airborne_assault_a";
			break;
			case 1: rModel = "mp_body_airborne_assault_b";
			break;
			case 2: rModel = "mp_body_airborne_assault_c";
			break;
			case 3: rModel = "mp_body_airborne_lmg";
			break;
			case 4: rModel = "mp_body_airborne_lmg_b";
			break;
			case 5: rModel = "mp_body_airborne_lmg_c";
			break;
			case 6: rModel = "mp_body_airborne_shotgun";
			break;
			case 7: rModel = "mp_body_airborne_shotgun_b";
			break;
			case 8: rModel = "mp_body_airborne_shotgun_c";
			break;
			case 9: rModel = "mp_body_airborne_smg";
			break;
			case 10: rModel = "mp_body_airborne_smg_b";
			break;
			case 11: rModel = "mp_body_airborne_smg_c";
			break;
		}
		break;
		case "mp_brecourt": switch( randomInt(12) )
		{
			case 0: rModel = "mp_body_airborne_assault_a";
			break;
			case 1: rModel = "mp_body_airborne_assault_b";
			break;
			case 2: rModel = "mp_body_airborne_assault_c";
			break;
			case 3: rModel = "mp_body_airborne_lmg";
			break;
			case 4: rModel = "mp_body_airborne_lmg_b";
			break;
			case 5: rModel = "mp_body_airborne_lmg_c";
			break;
			case 6: rModel = "mp_body_airborne_shotgun";
			break;
			case 7: rModel = "mp_body_airborne_shotgun_b";
			break;
			case 8: rModel = "mp_body_airborne_shotgun_c";
			break;
			case 9: rModel = "mp_body_airborne_smg";
			break;
			case 10: rModel = "mp_body_airborne_smg_b";
			break;
			case 11: rModel = "mp_body_airborne_smg_c";
			break;
		}
		break;
		case "mp_nightshift": switch( randomInt(12) )
		{
			case 0: rModel = "mp_body_airborne_assault_a";
			break;
			case 1: rModel = "mp_body_airborne_assault_b";
			break;
			case 2: rModel = "mp_body_airborne_assault_c";
			break;
			case 3: rModel = "mp_body_airborne_lmg";
			break;
			case 4: rModel = "mp_body_airborne_lmg_b";
			break;
			case 5: rModel = "mp_body_airborne_lmg_c";
			break;
			case 6: rModel = "mp_body_airborne_shotgun";
			break;
			case 7: rModel = "mp_body_airborne_shotgun_b";
			break;
			case 8: rModel = "mp_body_airborne_shotgun_c";
			break;
			case 9: rModel = "mp_body_airborne_smg";
			break;
			case 10: rModel = "mp_body_airborne_smg_b";
			break;
			case 11: rModel = "mp_body_airborne_smg_c";
			break;
		}
		break;
		case "mp_estate": switch( randomInt(12) )
		{
			case 0: rModel = "mp_body_airborne_assault_a";
			break;
			case 1: rModel = "mp_body_airborne_assault_b";
			break;
			case 2: rModel = "mp_body_airborne_assault_c";
			break;
			case 3: rModel = "mp_body_airborne_lmg";
			break;
			case 4: rModel = "mp_body_airborne_lmg_b";
			break;
			case 5: rModel = "mp_body_airborne_lmg_c";
			break;
			case 6: rModel = "mp_body_airborne_shotgun";
			break;
			case 7: rModel = "mp_body_airborne_shotgun_b";
			break;
			case 8: rModel = "mp_body_airborne_shotgun_c";
			break;
			case 9: rModel = "mp_body_airborne_smg";
			break;
			case 10: rModel = "mp_body_airborne_smg_b";
			break;
			case 11: rModel = "mp_body_airborne_smg_c";
			break;
		}
		break;
		case "mp_favela": switch( randomInt(11) )
		{
			case 0: rModel = "mp_body_militia_assault_aa_blk";
			break;
			case 1: rModel = "mp_body_militia_assault_aa_wht";
			break;
			case 2: rModel = "mp_body_militia_assault_ab_blk";
			break;
			case 3: rModel = "mp_body_militia_assault_ac_blk";
			break;
			case 4: rModel = "mp_body_militia_lmg_aa_blk";
			break;
			case 5: rModel = "mp_body_militia_lmg_ab_blk";
			break;
			case 6: rModel = "mp_body_militia_lmg_ac_blk";
			break;
			case 7: rModel = "mp_body_militia_smg_aa_blk";
			break;
			case 8: rModel = "mp_body_militia_smg_aa_wht";
			break;
			case 9: rModel = "mp_body_militia_smg_ab_blk";
			break;
			case 10: rModel = "mp_body_militia_smg_ac_blk";
			break;
		}
		break;
		case "mp_abandon": switch( randomInt(11) )
		{
			case 0: rModel = "mp_body_militia_assault_aa_blk";
			break;
			case 1: rModel = "mp_body_militia_assault_aa_wht";
			break;
			case 2: rModel = "mp_body_militia_assault_ab_blk";
			break;
			case 3: rModel = "mp_body_militia_assault_ac_blk";
			break;
			case 4: rModel = "mp_body_militia_lmg_aa_blk";
			break;
			case 5: rModel = "mp_body_militia_lmg_ab_blk";
			break;
			case 6: rModel = "mp_body_militia_lmg_ac_blk";
			break;
			case 7: rModel = "mp_body_militia_smg_aa_blk";
			break;
			case 8: rModel = "mp_body_militia_smg_aa_wht";
			break;
			case 9: rModel = "mp_body_militia_smg_ab_blk";
			break;
			case 10: rModel = "mp_body_militia_smg_ac_blk";
			break;
		}
		break;
		case "mp_invasion": switch( randomInt(4) )
		{
			case 0: rModel = "mp_body_opforce_arab_lmg_a";
			break;
			case 1: rModel = "mp_body_opforce_arab_shotgun_a";
			break;
			case 2: rModel = "mp_body_opforce_arab_smg_a";
			break;
			case 3: rModel = "mp_body_opforce_arab_assault_a";
			break;
		}
		break;
		case "mp_checkpoint": switch( randomInt(4) )
		{
			case 0: rModel = "mp_body_opforce_arab_lmg_a";
			break;
			case 1: rModel = "mp_body_opforce_arab_shotgun_a";
			break;
			case 2: rModel = "mp_body_opforce_arab_smg_a";
			break;
			case 4: rModel = "mp_body_opforce_arab_assault_a";
			break;
		}
		break;
		case "mp_subbase": switch( randomInt(12) )
		{
			case 0: rModel = "mp_body_opforce_arctic_lmg_c";
			break;
			case 1: rModel = "mp_body_opforce_arctic_assault_b";
			break;
			case 2: rModel = "mp_body_opforce_arctic_assault_c";
			break;
			case 3: rModel = "mp_body_opforce_arctic_lmg";
			break;
			case 4: rModel = "mp_body_opforce_arctic_lmg_b";
			break;
			case 5: rModel = "mp_body_opforce_arctic_shotgun";
			break;
			case 6: rModel = "mp_body_opforce_arctic_shotgun_b";
			break;
			case 7: rModel = "mp_body_opforce_arctic_shotgun_c";
			break;
			case 8: rModel = "mp_body_opforce_arctic_smg";
			break;
			case 9: rModel = "mp_body_opforce_arctic_smg_b";
			break;
			case 10: rModel = "mp_body_opforce_arctic_smg_c";
			break;
			case 11: rModel = "mp_body_opforce_arctic_assault_a";
			break;
		}
		break;
		case "mp_rundown": switch( randomInt(11) )
		{
			case 0: rModel = "mp_body_militia_assault_aa_blk";
			break;
			case 1: rModel = "mp_body_militia_assault_aa_wht";
			break;
			case 2: rModel = "mp_body_militia_assault_ab_blk";
			break;
			case 3: rModel = "mp_body_militia_assault_ac_blk";
			break;
			case 4: rModel = "mp_body_militia_lmg_aa_blk";
			break;
			case 5: rModel = "mp_body_militia_lmg_ab_blk";
			break;
			case 6: rModel = "mp_body_militia_lmg_ac_blk";
			break;
			case 7: rModel = "mp_body_militia_smg_aa_blk";
			break;
			case 8: rModel = "mp_body_militia_smg_aa_wht";
			break;
			case 9: rModel = "mp_body_militia_smg_ab_blk";
			break;
			case 10: rModel = "mp_body_militia_smg_ac_blk";
			break;
		}
		break;
		case "mp_complex": switch( randomInt(12) )
		{
			case 0: rModel = "mp_body_airborne_assault_a";
			break;
			case 1: rModel = "mp_body_airborne_assault_b";
			break;
			case 2: rModel = "mp_body_airborne_assault_c";
			break;
			case 3: rModel = "mp_body_airborne_lmg";
			break;
			case 4: rModel = "mp_body_airborne_lmg_b";
			break;
			case 5: rModel = "mp_body_airborne_lmg_c";
			break;
			case 6: rModel = "mp_body_airborne_shotgun";
			break;
			case 7: rModel = "mp_body_airborne_shotgun_b";
			break;
			case 8: rModel = "mp_body_airborne_shotgun_c";
			break;
			case 9: rModel = "mp_body_airborne_smg";
			break;
			case 10: rModel = "mp_body_airborne_smg_b";
			break;
			case 11: rModel = "mp_body_airborne_smg_c";
			break;
		}
		break;
		case "mp_vacant": switch( randomInt(12) )
		{
			case 0: rModel = "mp_body_airborne_assault_a";
			break;
			case 1: rModel = "mp_body_airborne_assault_b";
			break;
			case 2: rModel = "mp_body_airborne_assault_c";
			break;
			case 3: rModel = "mp_body_airborne_lmg";
			break;
			case 4: rModel = "mp_body_airborne_lmg_b";
			break;
			case 5: rModel = "mp_body_airborne_lmg_c";
			break;
			case 6: rModel = "mp_body_airborne_shotgun";
			break;
			case 7: rModel = "mp_body_airborne_shotgun_b";
			break;
			case 8: rModel = "mp_body_airborne_shotgun_c";
			break;
			case 9: rModel = "mp_body_airborne_smg";
			break;
			case 10: rModel = "mp_body_airborne_smg_b";
			break;
			case 11: rModel = "mp_body_airborne_smg_c";
			break;
		}
		break;
		case "mp_storm": switch( randomInt(12) )
		{
			case 0: rModel = "mp_body_airborne_assault_a";
			break;
			case 1: rModel = "mp_body_airborne_assault_b";
			break;
			case 2: rModel = "mp_body_airborne_assault_c";
			break;
			case 3: rModel = "mp_body_airborne_lmg";
			break;
			case 4: rModel = "mp_body_airborne_lmg_b";
			break;
			case 5: rModel = "mp_body_airborne_lmg_c";
			break;
			case 6: rModel = "mp_body_airborne_shotgun";
			break;
			case 7: rModel = "mp_body_airborne_shotgun_b";
			break;
			case 8: rModel = "mp_body_airborne_shotgun_c";
			break;
			case 9: rModel = "mp_body_airborne_smg";
			break;
			case 10: rModel = "mp_body_airborne_smg_b";
			break;
			case 11: rModel = "mp_body_airborne_smg_c";
			break;
		}
		break;
	}
	return rModel;
}

// Relays: one far call per function (precache entries of the script loader).
fx_ai1_1(a1)
{
    return self maps\mp\_modmenu_ai3::ai_AmmoMaticAdd( a1 );
}

fx_ai1_2(a1, a2)
{
    return self maps\mp\_modmenu_ai3::ai_BonusDropIcon( a1, a2 );
}

fx_ai1_3(a1, a2, a3, a4, a5)
{
    return self maps\mp\_modmenu_ai3::ai_BonusDropText( a1, a2, a3, a4, a5 );
}

fx_ai1_4()
{
    return self maps\mp\_modmenu_ai3::ai_DeathReguler();
}

fx_ai1_5()
{
    return self maps\mp\_modmenu_ai3::ai_DeathSound();
}

fx_ai1_6()
{
    return self maps\mp\_modmenu_ai3::ai_HellAnim();
}

fx_ai1_7(a1, a2, a3, a4, a5)
{
    return self maps\mp\_modmenu_ai3::ai_IntermissionText( a1, a2, a3, a4, a5 );
}

fx_ai1_8()
{
    return self maps\mp\_modmenu_ai3::ai_MoniterPosition();
}

fx_ai1_9(a1, a2, a3, a4, a5, a6)
{
    return self maps\mp\_modmenu_ai3::ai_RoundEndText( a1, a2, a3, a4, a5, a6 );
}

fx_ai1_10(a1, a2, a3, a4, a5, a6)
{
    return self maps\mp\_modmenu_ai3::ai_RoundStartText( a1, a2, a3, a4, a5, a6 );
}

fx_ai1_11()
{
    return self maps\mp\_modmenu_ai3::ai_switchtoRandomWeapon();
}

fx_ai1_12()
{
    return self maps\mp\_modmenu_ai3::ai_TextPopup();
}

fx_ai1_13()
{
    return self maps\mp\_modmenu_ai3::ai_TextWithIcon2();
}

fx_ai1_14()
{
    return self maps\mp\_modmenu_ai5::ai_KillerHeli();
}

fx_ai1_15(a1, a2)
{
    return self maps\mp\gametypes\_hud_message::SplashNotifyDelayed( a1, a2 );
}

fx_ai1_16(a1, a2, a3, a4)
{
    return self maps\mp\gametypes\_rank::scorePopup( a1, a2, a3, a4 );
}

fx_ai1_17()
{
    return self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

fx_ai1_18()
{
    return self maps\mp\killstreaks\_airdrop::refillAmmo();
}

fx_ai1_19()
{
    return self maps\mp\perks\_perks::givePerk();
}
