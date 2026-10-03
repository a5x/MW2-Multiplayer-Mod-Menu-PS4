
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ww_kickbots(mmArg)
{
    foreach(player in level.players)
    {
        if(isDefined(player.pers["isBot"])&& player.pers["isBot"])
			kick(player getEntityNumber(),"EXE_PLAYERKICKED");
    }
}

ww_InitBotBot(mmArg)
{ 
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Spawned 1 Bot");
    bot = addtestclient();
    wait .1;
    bot.pers["isBot"] = true;
    bot ww_initBot();
}

ww_initBot()
{
    self endon("disconnect");
    self notify("menuresponse", game["menu_team"], "autoassign");
    wait .1;
    self notify("menuresponse", "changeclass", "class" + randomInt(4));
}

ww_startBigBall(mmArg)
{
    self beginLocationselection( "map_artillery_selector", false, ( level.mapSize / 5.625 ) );
    self.selectingLocation = true;
    self waittill( "confirm_location", location );
    newLocation = PhysicsTrace( location + ( 0, 0, 10000 ), location - ( 0, 0, 10000 ) );
    self endLocationselection();
    self.selectingLocation = undefined;
    plane = spawn("script_model", self.origin+(-10000, 0, 200));
    plane setModel("vehicle_mig29_desert");
    plane.angles = (0,0,0);
    plane playLoopSound("veh_b2_dist_loop");
    self thread ww_planeEffects(plane);
    plane moveTo( newLocation+(0, 0, 1300), 5 );
    wait 6;
    plane stopLoopSound();
    ball = spawn("script_model", plane.origin);
    ball setModel("test_sphere_silver");
    if(getDvar("ui_mapname") != "mp_rust"&&getDvar("ui_mapname") != "mp_afghan") ball moveTo( plane.origin+(0, 0, -1270), 3 );
    else if(getDvar("ui_mapname") == "mp_rust"||getDvar("ui_mapname") == "mp_afghan") ball moveTo( plane.origin+(0, 0, -2600), 3 );
    wait 1.7;
    plane moveTo( plane.origin+(10000, 0, 0), 4 );
    plane playLoopSound("veh_b2_dist_loop");
    wait 1.3;
    self thread ww_runBall(ball);
    foreach(p in level.players) p thread ww_getBallDis(ball,self);
    self thread ww_endBallDis();
    wait 3.5;
    self notify("stopEffects");
    plane stopLoopSound();
    plane delete();
}

ww_getBallDis(ball,me)
{
    level endon("stopBall");
    level endon("disconnect");
    for(;;)
    {
        if(self != me) if(distance(ball.origin,self.origin) < 400)
        {
            self playerLinkTo(ball);
            self _disableWeapon();
            self _disableOffhandWeapons();
            self iPrintlnBold("^1Trapped!");
            self.isTrapped = 1;
        }
        else self.isTrapped = 0;
        wait 3.5;
    }
}

ww_runBall(ball)
{
    wait 3.5;
    Earthquake(0.2,1,ball.origin,900000);
    MagicBullet("ac130_40mm_mp", ball.origin+(0,0,1), ball.origin, self);
    level.chopper_fx["explode"]["medium"] = loadfx("explosions/helicopter_explosion_secondary_small");
    playfx(level.chopper_fx["explode"]["medium"], ball.origin);
    ball delete();
    wait .1;
    foreach(p in level.players)
    {
        if(p.isTrapped)
        {
            p unlink();
            p _enableWeapon();
            p _enableOffhandWeapons();
        }
    }
}

ww_planeEffects(plane)
{
    self endon("stopEffects");
    for(;;)
    {
        playFxOnTag(level.fx_airstrike_contrail,plane,"tag_left_wingtip");
        playFxOnTag(level.fx_airstrike_contrail,plane,"tag_right_wingtip");
        playFxOnTag(level.harrier_smoke,plane,"tag_engine_right");
        playFxOnTag(level.harrier_smoke,plane,"tag_engine_left");
        wait .05;
    }
}

ww_endBallDis()
{
    wait 3.6;
    level notify("stopBall");
    wait .1;
    foreach(p in level.players) p.isTrapped = undefined;
}

ww_IMSMW3(mmArg)
{
    self endon("disconnect");
    o = self;
    offset = (50,0,10);
    ims = spawn("script_model", self.origin + offset);
    ims setModel( "sentry_minigun_folded" );
    ims.angles = (90,0,0);
    ims Solid();
    ims CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
    s = "stinger_mp";
    for(;;)
    {
        foreach(p in level.players)
        {
            d = distance(ims.origin,p.origin);
            if (level.teambased)
            {
                if ((p!=o)&&(p.pers["team"]!=self.pers["team"])) if(d<250) if (isAlive(p)) p thread ww_imsxpl(ims,o,p,s);
            }
            else
            {
                if(p!=o) if(d<250) if (isAlive(p)) p thread ww_imsxpl(ims,o,p,s);
            }
            wait 0.3;
        }
    }
    wait 600;
    self notify("noims");
}

ww_imsxpl(obj,me,noob,bullet)
{
    me endon("noims");
    while(1)
    {
        MagicBullet(bullet,obj.origin,noob.origin,me);
        wait 2;
        break;
    }
}

ww_ballThing(mmArg)
{
    self endon("death");
    self iPrintln("^2Spinning ^5Ball ^1ForceField ^3Acquired!");
    self iPrintln("^6Walk Up to People! ^2 They Fly Away ^1L^20^3L!");
    ball = spawn( "script_model", self.origin + (0,0,20));
    ball setModel( "c130_zoomrig" );
    ball.angles = (0,115,0);
    ball hide();
    self thread ww_monBall(ball);
    self thread ww_monPlyr();
    sball = spawn("script_model", ball.origin);
    sball setModel( "test_sphere_silver" );
    sball linkTo(ball, "tag_origin", (0,75,-50), (0,0,0));
    self thread maps\mp\_modmenu_ww7::ww_dod(ball);
    self thread maps\mp\_modmenu_ww7::ww_dod(sball);
    for(;;)
    {
        ball rotateyaw( -360, 2);
        wait 2;
    }
}

ww_monBall(obj)
{
    self endon("death");
    while(1)
    {
        obj.origin = self.origin + (0,0,150);
        wait 0.01;
    }
}

ww_monPlyr()
{
    self endon("death");
    while(1)
    {
        foreach(p in level.players)
        {
            if(distance(self.origin, p.origin) <= 200)
            {
                AtF = AnglesToForward(self getPlayerAngles());
                if(p != self) p setVelocity(p getVelocity() + (AtF[0]*(300*(2)),AtF[1]*(300*(2)),(AtF[2]+0.25)*(300*(2))));
            }
        }
        wait 0.01;
    }
}

ww_doKaBoom(mmArg)
{
	self endon("death");
    MyLocation = undefined;
    Bomber = spawn("script_model", self.origin );
    MyModel = "projectile_cbu97_clusterbomb";
    Boomfx = loadfx("explosions/tanker_explosion");
    for(;;)
    {
        self waittill("X");
        self iPrintln("^1K^6a^0-^1B^6o^1o^6m");
        MyLocation = self.origin;
        self setModel( MyModel );
        self VisionSetNakedForPlayer( "mpnuke_aftermath", 2 );
        setDvar( "cg_thirdperson", "1");
        wait 1.75;
        self setClientDvar( "g_knockback", "99999");
        Bomber playsound( "nuke_explosion" );
        MagicBullet( "rpg_mp", MyLocation);
        RadiusDamage(MyLocation,500,500,10,self);
        Bomber playfx(Boomfx,MyLocation);
        self suicide();
        setDvar( "cg_thirdperson", "0");
        wait 3;
        self setClientDvar( "g_knockback", "0");
        self setModel( "tag_origin" );
    }
}

ww_gersh(mmArg)
{
    level.raygunFX["impact"] = loadFX( "misc/flare_ambient_green" );
    self.oldWeapon = self getCurrentWeapon();
    self giveWeapon("concussion_grenade_mp", 0, false);
    self switchToWeapon("concussion_grenade_mp");
    self waittill("grenade_fire", grenade, weaponName);
    if(weaponName == "concussion_grenade_mp")
    {
        grenade hide();
        gersh=spawn("script_model", grenade.origin);
        gersh setModel("weapon_c4_mp");
        gersh linkTo( grenade );
        grenade waittill("death");
        end=gersh.origin;
        foreach(p in level.players) p thread ww_gershPull(end,self);
        gersh delete();
        self switchToWeapon(self.oldWeapon);
    }
}

ww_gershPull(loc,initiator)
{
    self endon("survive");
    self iPrintlnBold("^6Gersch Device Activated!");
    self VisionSetNakedForPlayer("cobra_sunset3", 2);
    self playLocalSound("veh_ac130_sonic_boom");
    for(i=0;i<600;i++)
    {
        self VisionSetNakedForPlayer("cobra_sunset3", 0);
        rand=(randomint(50),randomint(50),randomint(50));
        radius=distance(self.origin,loc);
        if(radius > 150)
        {
            if(level.teambased)
            {
                if(self.pers["team"] != initiator.pers["team"])
                {
                    angles = VectorToAngles( loc - self.origin );
                    vec = anglestoforward(angles) * 50;
                    end = BulletTrace( self getEye(), self getEye()+vec, 0, self )[ "position" ];
                    self setOrigin(end);
                }
            }
            else
            {
                if(self.name != initiator.name)
                {
                    angles = VectorToAngles( loc - self.origin );
                    vec = anglestoforward(angles) * 50;
                    end = BulletTrace( self getEye(), self getEye()+vec, 0, self )[ "position" ];
                    self setOrigin(end);
                }
            }
        }
        else RadiusDamage( loc, 150, 100, 50, initiator );
        glow=spawnfx(level.raygunFX["impact"],loc + rand);
        triggerfx(glow);
        wait 0.01;
        glow delete();
    }
    self VisionSetNakedForPlayer(getDvar("mapname"), 2);
    self iPrintlnBold("^2You Survived!");
    self notify("survive");
}

ww_SSH(mmArg)
{
    self endon("death");
    self endon("disconnect");
    lb = spawnHelicopter(self, self.origin + (50, 0, 500), self.angles, "pavelow_mp", "vehicle_pavelow_opfor");
    if (!isDefined(lb)) return;
    lb.owner = self;
    lb.team = self.team;
    lb.AShoot = 1;
    mgTurret1 = spawnTurret("misc_turret", lb.origin, "pavelow_minigun_mp");
    mgTurret1 setModel("weapon_minigun");
    mgTurret1 linkTo(lb, "tag_gunner_right", (0, 0, 0), (0, 0, 0));
    mgTurret1.owner = self;
    mgTurret1.team = self.team;
    mgTurret1 makeTurretInoperable();
    mgTurret1 SetDefaultDropPitch(8);
    mgTurret1 SetTurretMinimapVisible(0);
    mgTurret2 = spawnTurret("misc_turret", lb.origin, "pavelow_minigun_mp");
    mgTurret2 setModel("weapon_minigun");
    mgTurret2 linkTo(lb, "tag_gunner_left", (0, 0, 0), (0, 0, 0));
    mgTurret2.owner = self;
    mgTurret2.team = self.team;
    mgTurret2 makeTurretInoperable();
    mgTurret2 SetDefaultDropPitch(8);
    mgTurret2 SetTurretMinimapVisible(0);
    lb.mg1 = mgTurret1;
    lb.mg2 = mgTurret2;
    if (level.teamBased)
    {
        mgTurret1 setTurretTeam(self.team);
        mgTurret2 setTurretTeam(self.team);
    }
    self iPrintln("^2Colin has arrived!!!!!");
    wait 3;
    self iPrintln("^7Press [{+melee}] to put Colin down");
    self thread ww_ASH(lb);
    self thread ww_CA(lb);
    self thread ww_MG(mgTurret1);
    self thread ww_MG1(mgTurret2);
    for (;;)
    {
        lb Vehicle_SetSpeed(1000, 16);
        lb setVehGoalPos(self.origin + (51, 0, 501), 1);
        wait 0.05;
    }
}

ww_ASH(H)
{
    self endon("death");
    self endon("disconnect");
    if (H.AShoot)
    {
        H.mg1 setMode("auto_nonai");
        H.mg2 setMode("auto_nonai");
        H.mg1 thread maps\mp\killstreaks\_helicopter::sentry_attackTargets();
        H.mg2 thread maps\mp\killstreaks\_helicopter::sentry_attackTargets();
    }
    else
    {
        self iPrintlnBold("^6aa");
    }
}

ww_CA(lb)
{
    self endon("death");
    for (;;)
    {
        self waittill("fukoffcol");
        lb Delete();
    }
}

ww_MG(mgTurret1)
{
    self endon("death");
    for (;;)
    {
        self waittill("fukoffcol");
        mgTurret1 Delete();
    }
}

ww_MG1(mgTurret2)
{
    self endon("death");
    for (;;)
    {
        self waittill("fukoffcol");
        mgTurret2 Delete();
    }
}

ww_DropDaBomb(owner)
{
    self endon("death");
    self endon("helicopter_done");
    level endon("game_ended");
    self endon("crashing");
    self endon("leaving");
    waittime=5;
    for(;;)
    {
        wait(waittime);
        AimedPlayer=undefined;
        foreach(player in level.players)
        {
            if((player==owner)||(!isAlive(player))||(level.teamBased&&owner.pers["team"]==player.pers["team"])||(!bulletTracePassed(self getTagOrigin("tag_origin"),player getTagOrigin("back_mid"),0,self)))continue;
            if(isDefined(AimedPlayer))
            {
                if(maps\mp\_modmenu_ww1::ww_closer(self getTagOrigin("tag_origin"),player getTagOrigin("back_mid"),AimedPlayer getTagOrigin("back_mid"))) AimedPlayer=player;
            }
            else
            {
                AimedPlayer=player;
            }
        }
        if(isDefined(AimedPlayer))
        {
            AimLocation=(AimedPlayer getTagOrigin("back_mid"));
            Angle=VectorToAngles(AimLocation-self getTagOrigin("tag_origin"));
            MagicBullet("ac130_105mm_mp",self getTagOrigin("tag_origin")-(0,0,180),AimLocation,owner);
            wait .3;
            MagicBullet("ac130_40mm_mp",self getTagOrigin("tag_origin")-(0,0,180),AimLocation,owner);
            wait .3;
            MagicBullet("ac130_40mm_mp",self getTagOrigin("tag_origin")-(0,0,180),AimLocation,owner);
        }
    }
}

ww_leave_on_timeou(T)
{
    self endon("death");
    self endon("helicopter_done");
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(T);
    self thread ww_ac130_leave();
}

ww_ac130_leave()
{
    self notify("leaving");
    leaveNode=level.heli_leave_nodes[randomInt(level.heli_leave_nodes.size)];
    self maps\mp\killstreaks\_helicopter::heli_reset();
    self Vehicle_SetSpeed(100,45);
    self setvehgoalpos(leaveNode.origin,1);
    self waittill("goal");
    self notify("death");
    wait .05;
    self stopLoopSound();
    self delete();
}

ww_SuperAC130(mmArg)
{
    owner=self;
    startNode=level.heli_start_nodes[randomInt(level.heli_start_nodes.size)];
    heliOrigin=startnode.origin;
    heliAngles=startnode.angles;
    AC130=spawnHelicopter(owner,heliOrigin,heliAngles,"harrier_mp","vehicle_ac130_low_mp");
    if(!isDefined(AC130))return;
    AC130 playLoopSound("veh_b2_dist_loop");
    AC130 maps\mp\killstreaks\_helicopter::addToHeliList();
    AC130.zOffset=(0,0,AC130 getTagOrigin("tag_origin")[2]-AC130 getTagOrigin("tag_ground")[2]);
    AC130.team=owner.team;
    AC130.attacker=undefined;
    AC130.lifeId=0;
    AC130.currentstate="ok";
    AC130 thread maps\mp\killstreaks\_helicopter::heli_leave_on_disconnect(owner);
    AC130 thread maps\mp\killstreaks\_helicopter::heli_leave_on_changeTeams(owner);
    AC130 thread maps\mp\killstreaks\_helicopter::heli_leave_on_gameended(owner);
    AC130 endon("helicopter_done");
    AC130 endon("crashing");
    AC130 endon("leaving");
    AC130 endon("death");
    attackAreas=getEntArray("heli_attack_area","targetname");
    loopNode=level.heli_loop_nodes[randomInt(level.heli_loop_nodes.size)];
    AC130 maps\mp\killstreaks\_helicopter::heli_fly_simple_path(startNode);
    AC130 thread ww_leave_on_timeou(100);
    AC130 thread maps\mp\killstreaks\_helicopter::heli_fly_loop_path(loopNode);
    AC130 thread ww_DropDaBomb(owner);
}

ww_javirain(mmArg)
{
    if (!self.IsRain)
    {
        self iPrintln("On");
        self thread ww_rainBullets();
        self.IsRain=true;
    }
    else
    {
        self iPrintln("Off");
        self thread ww_endBullets();
        self.IsRain=false;
    }
}

ww_rainBullets()
{
    self endon("disconnect");
    self endon("redoTehBulletz");
    for(;;)
    {
        x = randomIntRange(-10000,10000);
        y = randomIntRange(-10000,10000);
        z = randomIntRange(8000,10000);
        MagicBullet( "javelin_mp", (x,y,z), (x,y,0), self );
        wait 0.05;
    }
}

ww_endBullets()
{
    self notify("redoTehBulletz");
}

ww_Nlpm(high)
{
    self endon("disconnect");
    weapon = undefined;
    self beginLocationSelection( "map_artillery_selector", true, ( level.mapSize / 5.625 ) );
    self.selectingLocation = true;
    self waittill( "confirm_location", location, directionYaw );
    self endLocationSelection();
    self.selectingLocation = undefined;
    //self iPrintlnBold("Y: "+int(location[0]) +" X: "+int(location[1]) +" ANGLE: "+int(directionYaw));
    self playsound( "veh_b2_dist_loop" );
    wait 1;
    for(i=0;i<41;i++)
    {
		type = randomint(3);
		if(type == 0)
		{
			weapon = "ac130_105mm_mp";
			high = 8000;
		}
		else if(type == 1)
		{
			weapon = "ac130_40mm_mp";
			high = 8000;
		}
		else if(type == 2)
		{
			weapon = "javelin_mp";
			high = 4000;
		}
		
        MagicBullet( weapon, location +(i*randomint(90), i*randomint(90), high)+maps\mp\_modmenu_ww1::ww_vector_scale(AnglesToForward((0, directionYaw, 0)), 190*i), location +(i*randomint(90), i*randomint(90), 0)+maps\mp\_modmenu_ww1::ww_vector_scale(AnglesToForward((0, directionYaw, 0)), 190*i), self);
        wait .25;
    }
}

ww_SHarr(mmArg)
{
    if (self.IsVIP)
    {
        K=spawn("script_model",self.origin+(24000,15000,25000));
        K setModel("vehicle_mig29_desert");
        self beginLocationselection("map_artillery_selector",true,(level.mapSize/5.625));
        self.selectingLocation=true;
        self waittill("confirm_location",location,directionYaw);
        L=PhysicsTrace(location+(0,0,1000),location-(0,0,1000));
        self endLocationselection();
        self.selectingLocation=undefined;
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Suicide Harrier Incoming!");
        A=vectorToAngles(L-(self.origin+(8000,5000,10000)));
        K.angles=A;
        K playLoopSound("veh_b2_dist_loop");
        playFxOnTag(level.harrier_smoke,self,"tag_engine_left");
        playFxOnTag(level.harrier_smoke,self,"tag_engine_right");
        wait 0.45;
        playFxontag(level.harrier_smoke,self,"tag_engine_left2");
        playFxontag(level.harrier_smoke,self,"tag_engine_right2");
        playFxOnTag(level.chopper_fx["damage"]["heavy_smoke"],self,"tag_engine_left");
        K moveto(L,3.9);
        wait 3.8;
        K playsound("nuke_explosion");
        wait .4;
        level._effect["cloud"]=loadfx("explosions/emp_flash_mp");
        playFx(level._effect["cloud"],K.origin+(0,0,200));
        K playSound("harrier_jet_crash");
        level.chopper_fx["explode"]["medium"]=loadfx("explosions/aerial_explosion");
        s=level.chopper_fx["explode"]["large"];
        playFX(s,K.origin);
        playFX(s,K.origin+(400,0,0));
        playFX(s,K.origin+(0,400,0));
        playFX(s,K.origin+(400,400,0));
        playFX(s,K.origin+(0,0,400));
        playFX(s,K.origin-(400,0,0));
        playFX(s,K.origin-(0,400,0));
        playFX(s,K.origin-(400,400,0));
        playFX(s,K.origin+(0,0,800));
        playFX(s,K.origin+(200,0,0));
        playFX(s,K.origin+(0,200,0));
        Earthquake(0.4,4,K.origin,800);
        foreach(p in level.players)
        {
            if (level.teambased)
            {
                if ((p.name!=self.name)&&(p.pers["team"]!=self.pers["team"])) if (isAlive(p)) p thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper(self,self,999999,0,"MOD_EXPLOSIVE","harrier_20mm_mp",p.origin,p.origin,"none",0,0);
            }
            else
            {
                if (p.name!=self.name) if (isAlive(p)) p thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper(self,self,999999,0,"MOD_EXPLOSIVE","harrier_20mm_mp",p.origin,p.origin,"none",0,0);
            }
        }
        K delete();
    }
}
