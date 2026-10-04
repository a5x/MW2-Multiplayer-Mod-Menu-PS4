// WhiteWaterV6.5 (xRobertDavisx, JokerRey; ported by BravSoldat) -- the patch's own
// functions from init.gsc (Forge: bunkers, Merry Go Round, Assault Course), renamed ww_* and called by maps\mp\_modmenu.gsc.
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ww_MoveAbout()
{
    level endon("Merry_Nuked");
    for(;;)
    {
        RandNum = randomfloatrange(1,3);
        self moveto((self.origin[0],self.origin[1],self.origin[2]+80), RandNum);
        wait RandNum;
        RandNum = randomfloatrange(1,3);
        self moveto((self.origin[0],self.origin[1],self.origin[2]-80), RandNum);
        wait RandNum;
    }
}

ww_ForgeOpt(mmArg)
{
    if(self.Forge)
    {
        self notify("StopForge");
        self.Forge=0;
        self iprintln("Forge Mode Disabled");
    }
    else
    {
        self.Forge=1;
        self iprintln("Forge Mode Enabled");
        self thread ww_PickupCrate();
        self thread ww_SpawnCrate();
        self thread maps\mp\gametypes\_hud_message::hintMessage("Press [{+actionslot 2}] to Spawn a Crate");
        wait 5;
        self thread maps\mp\gametypes\_hud_message::hintMessage("Press [{+usereload}] to Move and Drop a Crate");
    }
}

ww_SpawnCrate()
{
    self endon("death");
    self endon("StopForge");
    for(;;)
    {
        self waittill("dpad_down");
        if(!self.MenuIsOpen)
        {
            if(self.ugp>0)
            {
                vec=anglestoforward(self getPlayerAngles());
                end=(vec[0]*200,vec[1]*200,vec[2]*200);
                L=BulletTrace(self gettagorigin("tag_eye"),self gettagorigin("tag_eye")+end,0,self)["position"];
                c=spawn("script_model",L+(0,0,20));
                c CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
                c setModel("com_plasticcase_beige_big");
                c PhysicsLaunchServer((0,0,0),(0,0,0));
                c.angles=self.angles+(0,90,0);
                c.health=250;
                self thread ww_crateManageHealth(c);
                self.ugp--;
            }
        }
    }
}

ww_crateManageHealth(c)
{
    rand=randomint(99999);
    self endon("CrateDestroyed"+rand);
    for(;;)
    {
        c setcandamage(true);
        c.team=self.team;
        c.owner=self.owner;
        c.pers["team"]=self.team;
        if(c.health<0)
        {
            level.chopper_fx["smoke"]["trail"]=loadfx("fire/fire_smoke_trail_L");
            playfx(level.chopper_fx["smoke"]["trail"],c.origin);
            c delete();
            self notify("CrateDestroyed"+rand);
        }
        wait 0.3;
    }
}

ww_PickupCrate()
{
    self endon("death");
    self endon("StopForge");
    for(;;)
    {
        self waittill("button_square");
        if(!self.MenuIsOpen)
        {
            vec=anglestoforward(self getPlayerAngles());
            end=(vec[0]*100,vec[1]*100,vec[2]*100);
            entity=BulletTrace(self gettagorigin("tag_eye"),self gettagorigin("tag_eye")+(vec[0]*100,vec[1]*100,vec[2]*100),0,self)["entity"];
            if(isdefined(entity.model))
            {
                self thread ww_MoveCrate(entity);
                self waittill("button_square");
                self.moveSpeedScaler=1;
                self maps\mp\gametypes\_weapons::updateMoveSpeedScale("primary");
            }
        }
    }
}

ww_MoveCrate(entity)
{
    self endon("button_square");
    for(;;)
    {
        entity.angles=self.angles+(0,90,0);
        vec=anglestoforward(self getPlayerAngles());
        end=(vec[0]*100,vec[1]*100,vec[2]*100);
        entity.origin=(self gettagorigin("tag_eye")+end);
        self.moveSpeedScaler=0.5;
        self maps\mp\gametypes\_weapons::updateMoveSpeedScale("primary");
        wait 0.05;
    }
}

ww_build(mmArg)
{
    self endon("death");
    for(;;)
    {
        self iPrintlnBold( "^1Shoot to spawn (flat surface)" );
        self waittill ( "weapon_fired" );
        vec = anglestoforward(self getPlayerAngles());
        end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
        SPLOSIONlocation = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+end, 0, self )[ "position" ];
        level endon("Merry_Nuked");
        level.Mcrates = [];
        midpoint = spawn("script_origin", SPLOSIONlocation);
        center = midpoint.origin;
        level.center = midpoint.origin;
        h = 0;
        LOLCATS = 0;
        for(j=0;j<2;j++)
        {
            for(i=55;i<220;i+=55)
            {
                level.Mcrates[h] = spawn("script_model", center+(i,0,LOLCATS));
                level.Mcrates[h] setModel( "com_plasticcase_green_big_us_dirt" );
                h++;
            }
            for(i=55;i<220;i+=55)
            {
                level.Mcrates[h] = spawn("script_model", center-(i,0,0-LOLCATS));
                level.Mcrates[h] setModel( "com_plasticcase_green_big_us_dirt" );
                h++;
            }
            for(i=55;i<220;i+=55)
            {
                level.Mcrates[h] = spawn("script_model", center-(0,i,0-LOLCATS));
                level.Mcrates[h].angles = (0,90,0);
                level.Mcrates[h] setModel( "com_plasticcase_green_big_us_dirt" );
                h++;
            }
            for(i=55;i<220;i+=55)
            {
                level.Mcrates[h] = spawn("script_model", center+(0,i,LOLCATS));
                level.Mcrates[h].angles = (0,90,0);
                level.Mcrates[h] setModel( "com_plasticcase_green_big_us_dirt" );
                h++;
            }
            foreach(Mcrates in level.Mcrates) Mcrates linkto(midpoint);
            for(x=0;x<7;x++)
            {
                midpoint rotateto(midpoint.angles+(0,11.25,0),0.05);
                wait 0.1;
                for(i=55;i<220;i+=55)
                {
                    level.Mcrates[h] = spawn("script_model", center-(0,i,0-LOLCATS));
                    level.Mcrates[h].angles = (0,90,0);
                    level.Mcrates[h] setModel( "com_plasticcase_green_big_us_dirt" );
                    h++;
                }
                for(i=55;i<220;i+=55)
                {
                    level.Mcrates[h] = spawn("script_model", center+(0,i,LOLCATS));
                    level.Mcrates[h].angles = (0,90,0);
                    level.Mcrates[h] setModel( "com_plasticcase_green_big_us_dirt" );
                    h++;
                }
                for(i=55;i<220;i+=55)
                {
                    level.Mcrates[h] = spawn("script_model", center-(i,0,0-LOLCATS));
                    level.Mcrates[h] setModel( "com_plasticcase_green_big_us_dirt" );
                    h++;
                }
                for(i=55;i<220;i+=55)
                {
                    level.Mcrates[h] = spawn("script_model", center+(i,0,LOLCATS));
                    level.Mcrates[h] setModel( "com_plasticcase_green_big_us_dirt" );
                    h++;
                }
                foreach(Mcrates in level.Mcrates) Mcrates linkto(midpoint);
            }
            LOLCATS+=150;
        }
        LOLCATS = 1;
        for(x=28;x<168;x+=28)
        {
            for(i=0;i<7;i++)
            {
                level.Mcrates[h] = spawn("script_model", center+(0,0,x));
                level.Mcrates[h].angles = (0,i*22.5,0);
                level.Mcrates[h] setModel( "com_plasticcase_green_big_us_dirt" );
                h++;
            }
        }
        level.ControlPanels = [];
        level.ControlPanels[0] = spawn("script_model", center+(75,250,0));
        level.ControlPanels[0] setModel( "com_plasticcase_beige_big" );
        level.ControlPanels[0].angles = (0,30,0);
        level.ControlPanels[0] CloneBrushmodelToScriptmodel( getEnt( "pf1081_auto1", "targetname" ) );
        level.ControlPanels[1] = spawn("script_model", center+(-75,250,0));
        level.ControlPanels[1] setModel( "com_plasticcase_beige_big" );
        level.ControlPanels[1].angles = (0,330,0);
        level.ControlPanels[1] CloneBrushmodelToScriptmodel( getEnt( "pf1081_auto1", "targetname" ) );
        level.ControlPanels[2] = spawn("script_model", center+(-75,250,30));
        level.ControlPanels[2] setModel( "com_laptop_2_open" );
        level.ControlPanels[2].angles = (0,60,0);
        level.ControlPanels[2].num = -1;
        level.ControlPanels[2].othernum = 0;
        level.ControlPanels[3] = spawn("script_model", center+(75,250,30));
        level.ControlPanels[3] setModel( "com_laptop_2_open" );
        level.ControlPanels[3].angles = (0,120,0);
        level.ControlPanels[3].num = 1;
        level.ControlPanels[3].othernum = 1;
        level.ControlPanels[2] thread ww_ChangeSpeed();
        level.ControlPanels[3] thread ww_ChangeSpeed();
        level.ControlPanels[4] = spawn("script_model", center+(0,230,0));
        level.ControlPanels[4] setModel( "com_plasticcase_beige_big" );
        level.ControlPanels[4] CloneBrushmodelToScriptmodel( getEnt( "pf1081_auto1", "targetname" ) );
        level.ControlPanels[5] = spawn("script_model", center+(0,230,30));
        level.ControlPanels[5] setModel( "com_laptop_2_open" );
        level.ControlPanels[5].angles = (0,90,0);
        level.ControlPanels[5].num = -1;
        level.ControlPanels[5] thread ww_switchColors();
        for(i=0;i<level.Mcrates.size;i++) level.Mcrates[i] setmodel("com_plasticcase_black_big_us_dirt");
        level.MerrySeat = [];
        level.MerrySeat[0] = spawn("script_model", center+(-22,100,30));
        level.MerrySeat[0] setmodel("com_barrel_benzin");
        level.MerrySeat[0].angles = (90,0,0);
        level.MerrySeat[1] = spawn("script_model", center+(-22,-100,30));
        level.MerrySeat[1] setmodel("com_barrel_benzin");
        level.MerrySeat[1].angles = (90,0,0);
        level.MerrySeat[2] = spawn("script_model", center+(-100,-22,30));
        level.MerrySeat[2] setmodel("com_barrel_benzin");
        level.MerrySeat[2].angles = (90,90,0);
        level.MerrySeat[3] = spawn("script_model", center+(100,-22,30));
        level.MerrySeat[3] setmodel("com_barrel_benzin");
        level.MerrySeat[3].angles = (90,90,0);
        level.MerrySeat[4] = spawn("script_model", center+(-122,100,30));
        level.MerrySeat[4] setmodel("com_barrel_benzin");
        level.MerrySeat[4].angles = (90,45,0);
        level.MerrySeat[5] = spawn("script_model", center+(122,-100,30));
        level.MerrySeat[5] setmodel("com_barrel_benzin");
        level.MerrySeat[5].angles = (90,-135,0);
        level.MerrySeat[6] = spawn("script_model", center+(-100,-122,30));
        level.MerrySeat[6] setmodel("com_barrel_benzin");
        level.MerrySeat[6].angles = (90,135,0);
        level.MerrySeat[7] = spawn("script_model", center+(100,122,30));
        level.MerrySeat[7] setmodel("com_barrel_benzin");
        level.MerrySeat[7].angles = (90,-45,0);
        level.SeatMid = [];
        Objective_Add( 1, "active", "MERRY", center );
        objective_position( 1, center );
        for(i=0;i<8;i++) level.SeatMid[i] = spawn("script_origin", SPLOSIONlocation);
        level.FakeSeat = [];
        for(i=0;i<8;i++)
        {
            level.FakeSeat[i] = spawn("script_origin", level.MerrySeat[i].origin-(0,0,37));
            level.FakeSeat[i].num = i;
            level.FakeSeat[i].InUse = false;
        }
        i = 0;
        foreach(FakeSeat in level.FakeSeat)
        {
            FakeSeat linkto(level.MerrySeat[i]);
            FakeSeat thread ww_ManageDistance();
            i++;
        }
        i = 0;
        foreach(MerrySeat in level.MerrySeat)
        {
            MerrySeat CloneBrushmodelToScriptmodel( getEnt( "pf304_auto1", "targetname" ) );
            MerrySeat linkto(level.SeatMid[i]);
            level.SeatMid[i] thread ww_MoveAbout();
            i++;
        }
        foreach(Mcrates in level.Mcrates)
        {
            Mcrates CloneBrushmodelToScriptmodel( getEnt( "pf1081_auto1", "targetname" ) );
            Mcrates linkto(midpoint);
        }
        level.MERRYSP00DZ = 80;
        thread ww_MerryNuke();
        //thread Speedcheck();
        for(;;)
        {
            midpoint rotateyaw(-720,level.MERRYSP00DZ/10);
            foreach(SeatMid in level.SeatMid) SeatMid rotateyaw(-720,level.MERRYSP00DZ/10);
            wait level.MERRYSP00DZ/10;
        }
    }
}

ww_switchColors()
{
    level endon("Merry_Nuked");
    thread ww_ChangeColor();
    level.color = 0;
    for(;;)
    {
        foreach(player in level.players)
        {
            if(distance(self.origin, player.origin) <70)
            {
                if(level.xenon && self.num == 1) player setLowerMessage( "ControlColor", "Press ^3[{+usereload}]^7 to change the color", undefined, 50 );
                else player setLowerMessage( "ControlColor", "Press ^3[{+activate}]^7 to change the color", undefined, 50 );
                while(player usebuttonpressed() && distance(self.origin, player.origin) <70)
                {
                    level.color++;
                    if(level.color == 3) level.color = 0;
                    level notify("updateColor");
                    //player iprintln(level.color);
                    wait 0.2;
                }
            }
            if(distance(self.origin, player.origin) >70) player clearLowerMessage( "ControlColor" );
        }
        wait 0.05;
    }
}

ww_MerryNuke()
{
    level endon("nuked");
    level.GasTanks = spawn("script_model", level.center+(70,-300,50));
    level.GasTanks setmodel("com_propane_tank02_small");
    level.Detonator = spawn("script_model", level.center+(60,-355,0));
    level.Detonator setmodel("prop_remotecontrol");
    level.Detonator.angles = (0,90,0);
    level.Bomb = spawn("script_model", level.center+(60,-340,6));
    level.Bomb setmodel("projectile_hellfire_missile");
    Detonator = level.Detonator;
    GasTanks = level.GasTanks;
    Collision = [];
    Collision[0] = spawn("script_model", level.center+(0,-320,14));
    Collision[1] = spawn("script_model", level.center+(0,-320,42));
    Collision[2] = spawn("script_model", level.center+(0,-280,42));
    Collision[3] = spawn("script_model", level.center+(0,-280,14));
    Collision[4] = spawn("script_model", level.center+(55,-320,14));
    Collision[5] = spawn("script_model", level.center+(55,-320,42));
    Collision[6] = spawn("script_model", level.center+(55,-280,42));
    Collision[7] = spawn("script_model", level.center+(55,-280,14));
    Collision[8] = spawn("script_model", level.center+(110,-320,14));
    Collision[9] = spawn("script_model", level.center+(110,-320,42));
    Collision[10] = spawn("script_model", level.center+(110,-280,42));
    Collision[11] = spawn("script_model", level.center+(110,-280,14));
    Collision[12] = spawn("script_model", level.center+(145,-320,14));
    Collision[13] = spawn("script_model", level.center+(145,-320,42));
    Collision[14] = spawn("script_model", level.center+(145,-280,42));
    Collision[15] = spawn("script_model", level.center+(145,-280,14));
    Collision[16] = spawn("script_model", level.center+(60,-330,0));
    Collision[17] = spawn("script_model", level.center+(60,-330,0));
    Collision[17].angles = (0,90,0);
    level.MerryNuke = false;
    foreach(Col in Collision) Col CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    for(;;)
    {
        foreach(player in level.players)
        {
            if(distance(Detonator.origin, player gettagorigin("j_head")) <30 && level.MerryNuke == false)
            {
                if(level.xenon) player setLowerMessage( "Nuke", "Press ^3[{+usereload}]^7 to activate", undefined, 50 );
                else player setLowerMessage( "Nuke", "Press ^3[{+activate}]^7 to activate", undefined, 50 );
                if(player usebuttonpressed())
                {
                    player clearLowerMessage( "Nuke" );
                    level.MerryNuke = true;
                    self thread ww_NukeTimer();
                    wait 1;
                    level notify("nuked");
                }
            }
            if(distance(Detonator.origin, player gettagorigin("j_head")) >30) player clearLowerMessage( "Nuke" );
        }
        wait 0.05;
    }
}

ww_NukeTimer()
{
    Timer = NewHudElem();
    Timer.alignX = "right";
    Timer.alignY = "top";
    Timer.horzAlign = "right";
    Timer.vertAlign = "top";
    Timer.foreground = true;
    Timer.fontScale = 1;
    Timer.font = "hudbig";
    Timer.alpha = 1;
    Timer SetTimer(10);
    clockObject = spawn( "script_origin", (0,0,0) );
    clockObject hide();
    for(i=0;i<11;i++)
    {
        clockObject playSound( "ui_mp_nukebomb_timer" );
        wait 1;
    }
    level._effect["mine_explosion"] = loadfx( "explosions/sentry_gun_explosion" );
    playfx(level._effect["mine_explosion"],level.Bomb.origin);
    wait 3;
    self thread ww_Explode();
    wait 1;
    Timer destroy();
}

ww_Explode()
{
    Explosion = loadfx("explosions/propane_large_exp");
    playfx( Explosion, level.Bomb.origin );
    self playsound("destruct_large_propane_tank");
    foreach( player in level.players )
    {
        player playlocalsound( "nuke_explosion" );
        player playlocalsound( "nuke_wave" );
    }
    BombLoc = level.Bomb.origin;
    level.GasTanks setmodel("com_propane_tank02_small_des");
    level.Detonator delete();
    level.Bomb delete();
    earthquake (0.5, 3, BombLoc, 4000);
    RadiusDamage( BombLoc, 500, 1000, 500, self );
    wait 0.25;
    level notify("Merry_Nuked");
    foreach(Mcrates in level.Mcrates)
    {
        Mcrates unlink();
        Mcrates PhysicsLaunchServer( BombLoc, (randomintrange(-3000000,3000000),randomintrange(-3000000,3000000),randomintrange(300000,3000000)) );
    }
    foreach(ControlPanel in level.ControlPanels) ControlPanel delete();
    foreach(MerrySeat in level.MerrySeat) MerrySeat delete();
}

ww_ChangeColor()
{
    level endon("Merry_Nuked");
    for(;;)
    {
        level waittill("updateColor");
		if(level.color == 0)
		{
			foreach(crate in level.Mcrates) crate setmodel("com_plasticcase_green_big_us_dirt");
		}
		else if(level.color == 1)
		{
			foreach(crate in level.Mcrates) crate setmodel("com_plasticcase_beige_big");
		}
		else if(level.color == 2)
		{
			foreach(crate in level.Mcrates) crate setmodel("com_plasticcase_black_big_us_dirt");
		}
    }
}

ww_ChangeSpeed()
{
    level endon("Merry_Nuked");
    self.num = 1;
    for(;;)
    {
        foreach(player in level.players)
        {
            if(distance(self.origin, player.origin) <70)
            {
                if(level.xenon && self.num == 1) player setLowerMessage( "Control"+self.othernum, "Press ^3[{+usereload}]^7 to decrease speed. Current: "+level.MERRYSP00DZ, undefined, 50 );
                else if(level.xenon && self.num == -1) player setLowerMessage( "Control"+self.othernum, "Press ^3[{+usereload}]^7 to increase speed. Current: "+level.MERRYSP00DZ, undefined, 50 );
                if(!level.xenon && self.num == 1) player setLowerMessage( "Control"+self.othernum, "Press ^3[{+activate}]^7 to decrease speed. Current: "+level.MERRYSP00DZ, undefined, 50 );
                else if(!level.xenon && self.num == -1) player setLowerMessage( "Control"+self.othernum, "Press ^3[{+activate}]^7 to increase speed. Current: "+level.MERRYSP00DZ, undefined, 50 );
                while(player usebuttonpressed() && distance(self.origin, player.origin) <70)
                {
                    if(self.num == -1) level.MERRYSP00DZ--;
                    if(self.num == 1) level.MERRYSP00DZ++;
                    if(level.MERRYSP00DZ == 1) level.MERRYSP00DZ = 2;
                    if(level.xenon && self.num == 1) player setLowerMessage( "Control"+self.othernum, "Press ^3[{+usereload}]^7 to decrease speed. Current: "+level.MERRYSP00DZ, undefined, 50 );
                    else if(level.xenon && self.num == -1) player setLowerMessage( "Control"+self.othernum, "Press ^3[{+usereload}]^7 to increase speed. Current: "+level.MERRYSP00DZ, undefined, 50 );
                    if(!level.xenon && self.num == 1) player setLowerMessage( "Control"+self.othernum, "Press ^3[{+activate}]^7 to decrease speed. Current: "+level.MERRYSP00DZ, undefined, 50 );
                    else if(!level.xenon && self.num == -1) player setLowerMessage( "Control"+self.othernum, "Press ^3[{+activate}]^7 to increase speed. Current: "+level.MERRYSP00DZ, undefined, 50 );
                    wait 0.2;
                }
            }
            if(distance(self.origin, player.origin) >70) player clearLowerMessage( "Control"+self.othernum );
        }
        wait 0.05;
    }
}

ww_ManageDistance()
{
    level endon("Merry_Nuked");
    for(;;)
    {
        foreach(player in level.players)
        {
            if(distance(self.origin, player.origin) <100 && self.InUse == false)
            {
                if(level.xenon) player setLowerMessage( "Merry"+self.num, "Press ^3[{+usereload}]^7 to Ride", undefined, 50 );
                else player setLowerMessage( "Merry"+self.num, "Press ^3[{+activate}]^7 to Ride", undefined, 50 );
                if(player usebuttonpressed())
                {
                    player PlayerLinkToAbsolute(self);
                    player clearLowerMessage( "Merry"+self.num );
                    self.InUse = true;
                    wait 1;
                }
            }
            else if(distance(self.origin, player.origin) <100 && self.InUse == true && player usebuttonpressed())
            {
                player unlink();
                self.InUse = false;
                player setorigin(level.center+(-250,0,0));
                wait 1;
            }
            if(distance(self.origin, player.origin) >100 ) player clearLowerMessage( "Merry"+self.num );
        }
        wait 0.05;
    }
}

ww_WP(D,Z,P)
{
    L=strTok(D,",");
    for(i=0;i<L.size;i+=2)
    {
        if(i>0&&i%30==0) wait 0.05;
        B=spawn("script_model",self.origin+(int(L[i]),int(L[i+1]),Z));
        if(!P)B.angles=(90,0,0);
        B setModel("com_plasticcase_friendly");
        B Solid();
        B CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
    }
}

ww_FG(D,Z,P)
{
    L=strTok(D,",");
    for(i=0;i<L.size;i+=2)
    {
        if(i>0&&i%30==0) wait 0.05;
        B=spawn("script_model",self.origin+(int(L[i]),int(L[i+1]),Z));
        if(!P)B.angles=(90,0,0);
        B setModel( level.elevator_model["exit"] );
        B Solid();
        B CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
    }
}

ww_DTBunker(z)
{
    ww_FG("0,0,1375,870,55,1470",150,1);
    ww_FG("0,0",390,1);
    ww_FG("0,0",620,1);
    //WP("0,0,55,0,110,0,0,30,110,30,55,60,0,90,110,90,55,120,0,150,110,150,55,180,0,210,110,210,55,240,0,270,110,270,55,300,0,330,110,330,55,360,0,390,110,390,55,420,0,450,110,450,55,480,0,510,110,510,55,540,0,570,110,570,55,600,0,630,110,630,55,660,0,690,110,690,55,720,1155,720,1210,720,1265,720,1320,720,1375,720,0,750,110,750,1155,750,1210,750,1265,750,1320,750,1375,750,55,780,1100,780,1155,780,1210,780,1265,780,1320,780,1375,780,0,810,110,810,1100,810,1155,810,1210,810,1265,810,1320,810,1375,810,55,840,1100,840,1155,840,1210,840,1265,840,1320,840,1375,840,0,870,110,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,55,900,0,930,110,930,55,960,0,990,110,990,55,1020,0,1050,110,1050,55,1080,0,1110,110,1110,55,1140,0,1170,110,1170,165,1170,55,1200,165,1200,0,1230,110,1230,55,1260,0,1290,110,1290,55,1320,0,1350,110,1350,55,1380,0,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470",0,1);
    //WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,1050,110,1080,0,1470,55,1470,110,1470",25,1);
    //WP("0,0,55,0,110,0,880,690,990,690,1100,690,1155,690,1210,690,1265,690,1320,690,1375,690,550,720,1100,720,1155,720,1210,720,1265,720,1320,720,1375,720,495,750,550,750,605,750,660,750,770,750,880,750,1045,750,1100,750,1155,750,1375,750,550,780,1045,780,1100,780,1155,780,1375,780,1045,810,1100,810,1375,810,1045,840,1100,840,1375,840,1045,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,900,1045,900,1100,900,1155,900,1210,900,1265,900,1320,900,1375,900,110,930,0,1470,55,1470,110,1470",50,1);
    //WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,110,780,1100,780,1155,780,1375,780,110,810,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",75,1);
    //WP("0,0,55,0,110,0,110,690,110,720,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",100,1);
    //WP("0,0,55,0,110,0,110,600,110,630,110,660,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",125,1);
    //WP("0,0,55,0,110,0,0,30,55,30,110,30,165,30,220,30,0,60,55,60,110,60,220,60,275,60,330,60,0,90,55,90,110,90,330,90,55,120,330,120,55,150,330,150,55,180,330,180,55,210,330,210,330,240,385,240,440,240,495,240,550,240,605,240,550,270,605,270,605,300,605,330,605,360,605,390,605,420,660,420,715,420,770,420,825,420,880,420,935,420,935,450,605,480,935,480,605,510,935,510,935,540,990,540,1045,540,1100,540,1155,540,605,570,1155,570,1210,570,1210,600,1265,600,165,630,330,630,495,630,550,630,605,630,660,630,1210,630,1265,630,165,660,330,660,495,660,1210,660,1265,660,1320,660,330,690,495,690,1210,690,1265,690,1320,690,1375,690,165,720,330,720,385,720,440,720,495,720,550,720,605,720,660,720,1100,720,1155,720,1210,720,1265,720,1320,720,1375,720,165,750,495,750,660,750,1100,750,1155,750,1375,750,495,780,660,780,935,780,990,780,1045,780,1100,780,1155,780,1375,780,330,810,385,810,440,810,495,810,660,810,935,810,1100,810,1375,810,935,840,1100,840,1375,840,935,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,935,900,935,930,935,960,935,990,935,1020,935,1050,935,1080,935,1110,935,1140,935,1170,935,1200,935,1230,935,1260,935,1290,935,1320,55,1350,110,1350,165,1350,220,1350,275,1350,330,1350,385,1350,440,1350,495,1350,550,1350,605,1350,660,1350,715,1350,770,1350,825,1350,880,1350,935,1350,55,1380,0,1410,55,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470",150,1);
    ww_WP("165,0",160,1);
    ww_WP("220,0",170,1);
    ww_WP("275,0",180,1);
    ww_WP("330,0",190,1);
    ww_WP("385,0",200,1);
    ww_WP("440,0",210,1);
    ww_WP("495,0",220,1);
    ww_WP("540,0",230,1);
    ww_WP("595,0",240,1);
    ww_WP("650,0",250,1);
    ww_WP("705,0",260,1);
    ww_WP("760,0",270,1);
    ww_WP("760,30,760,90,760,60",270,1);
    ww_WP("705,90",280,1);
    ww_WP("650,90",290,1);
    ww_WP("595,90",300,1);
    ww_WP("540,90",310,1);
    ww_WP("495,90",320,1);
    ww_WP("440,90",330,1);
    ww_WP("385,90",340,1);
    ww_WP("330,90",350,1);
    ww_WP("275,90",360,1);
    ww_WP("220,90",370,1);
    ww_WP("165,90",380,1);
    ww_WP("105,90",380,1);
    ww_WP("0,30,55,30,0,60,55,60,0,90,55,90",390,1);
    ww_WP("0,0,55,0",390,1);
    ww_WP("105,0",400,1);
    ww_WP("165,0",400,1);
    ww_WP("220,0",410,1);
    ww_WP("275,0",420,1);
    ww_WP("330,0",430,1);
    ww_WP("385,0",440,1);
    ww_WP("440,0",450,1);
    ww_WP("495,0",460,1);
    ww_WP("540,0",470,1);
    ww_WP("595,0",480,1);
    ww_WP("650,0",490,1);
    ww_WP("705,0",500,1);
    ww_WP("760,0",510,1);
    ww_WP("760,30,760,90,760,60",510,1);
    ww_WP("705,90",520,1);
    ww_WP("650,90",530,1);
    ww_WP("595,90",540,1);
    ww_WP("540,90",550,1);
    ww_WP("495,90",560,1);
    ww_WP("440,90",570,1);
    ww_WP("385,90",580,1);
    ww_WP("330,90",590,1);
    ww_WP("275,90",600,1);
    ww_WP("220,90",610,1);
    ww_WP("165,90",620,1);
    ww_WP("105,90",620,1);
    ww_WP("0,30,55,30,0,60,55,60,0,90,55,90",620,1);
    ww_WP("0,0,55,0",0,1);
    ww_WP("165,1410",0,1);
    ww_WP("220,1410",20,1);
    ww_WP("275,1410",40,1);
    ww_WP("330,1410",60,1);
    ww_WP("385,1410",80,1);
    ww_WP("440,1410",100,1);
    ww_WP("495,1410",120,1);
    ww_WP("550,1410",140,1);
    ww_WP("550,1390",140,1);
}

ww_terminalflags(mmArg)
{
    self thread ww_b();
    ww_CreateElevator((-10583,-5339,80),(-19658,-3947,80));
    ww_CreateElevator((17589,-3947,80),(-19711,-3947,80));
    ww_CreateElevator((-19711,-3947,80),(-19711,21452,80));
    ww_CreateElevator((-19711,21452,80),(17589,21452,80));
    ww_CreateElevator((17589,21452,80),(17589,-3947,80));
    ww_CreateElevator((-10867,-3715,80),(-10782,-3538,80));
    ww_CreateElevator((-10782,-3538,80),(-10787,-3392,80));
    ww_CreateElevator((-10787,-3392,80),(-10877,-3337,80));
    ww_CreateElevator((-10877,-3337,80),(-11073,-3358,80));
    ww_CreateElevator((-11073,-3358,80),(-11150,-3458,80));
    ww_CreateElevator((-11150,-3458,80),(-11049,-3671,80));
    ww_CreateElevator((-11049,-3671,80),(-10867,-3715,80));
    ww_CreateElevator((1110,3760,90),(-10585,-4490,80));
    ww_CreateElevator((1111,4918,90),(-10585,-4490,80));
    ww_CreateElevator((1074,5992,247),(-10585,-4490,80));
    ww_CreateElevator((-11210,-4240,90),(-11230,-4240,85));
    ww_CreateElevator((-11250,-4240,80),(-11270,-4240,80));
    ww_CreateElevator((-11290,-4240,90),(-11320,-4240,70));
    ww_CreateElevator((-11350,-4240,80),(-11370,-4240,85));
    ww_CreateElevator((-11390,-4240,90),(-11420,-4240,80));
    ww_CreateElevator((-11440,-4240,80),(-11460,-4240,70));
    ww_CreateElevator((-11480,-4240,90),(-11510,-4240,85));
    ww_CreateElevator((-11530,-4240,80),(-11550,-4240,80));
    ww_CreateElevator((-11570,-4240,90),(-11590,-4240,70));
    ww_CreateElevator((-11620,-4240,80),(-11640,-4240,85));
    ww_CreateElevator((-11660,-4240,90),(-11680,-4240,80));
    ww_CreateElevator((-11720,-4240,80),(-11740,-4240,70));
    ww_CreateElevator((-11760,-4240,90),(-11780,-4240,85));
    ww_CreateElevator((-11810,-4240,80),(-11830,-4240,80));
    ww_CreateElevator((-11810,-4240,90),(-11210,-4340,80));
    ww_CreateElevator((-11210,-4340,80),(-11230,-4340,85));
    ww_CreateElevator((-11250,-4340,90),(-11270,-4340,80));
    ww_CreateElevator((-11290,-4340,80),(-11320,-4340,70));
    ww_CreateElevator((-11350,-4340,90),(-11370,-4340,85));
    ww_CreateElevator((-11390,-4340,80),(-11420,-4340,80));
    ww_CreateElevator((-11440,-4340,90),(-11460,-4340,70));
    ww_CreateElevator((-11480,-4340,80),(-11510,-4340,85));
    ww_CreateElevator((-11530,-4340,90),(-11550,-4340,80));
    ww_CreateElevator((-11570,-4340,80),(-11590,-4340,70));
    ww_CreateElevator((-11620,-4340,90),(-11640,-4340,85));
    ww_CreateElevator((-11660,-4340,80),(-11680,-4340,80));
    ww_CreateElevator((-11720,-4340,90),(-11740,-4340,70));
    ww_CreateElevator((-11760,-4340,80),(-11780,-4340,85));
    ww_CreateElevator((-11810,-4340,90),(-11830,-4340,80));
    ww_CreateElevator((-11830,-4340,80),(-11210,-4440,80));
    ww_CreateElevator((-11210,-4440,90),(-11230,-4440,86));
    ww_CreateElevator((-11250,-4440,80),(-11270,-4440,80));
    ww_CreateElevator((-11290,-4440,90),(-11320,-4440,70));
    ww_CreateElevator((-11350,-4440,80),(-11370,-4440,85));
    ww_CreateElevator((-11390,-4440,90),(-11420,-4440,80));
    ww_CreateElevator((-11440,-4440,80),(-11460,-4440,70));
    ww_CreateElevator((-11480,-4440,90),(-11510,-4440,85));
    ww_CreateElevator((-11530,-4440,80),(-11550,-4440,80));
    ww_CreateElevator((-11570,-4440,90),(-11590,-4440,70));
    ww_CreateElevator((-11620,-4440,80),(-11640,-4440,85));
    ww_CreateElevator((-11660,-4440,90),(-11680,-4440,80));
    ww_CreateElevator((-11720,-4440,80),(-11740,-4440,80));
    ww_CreateElevator((-11760,-4440,90),(-11780,-4440,85));
    ww_CreateElevator((-11810,-4440,80),(-11830,-4440,80));
    ww_CreateElevator((-11810,-4440,90),(-11210,-4540,80));
    ww_CreateElevator((-11210,-4540,80),(-11230,-4540,85));
    ww_CreateElevator((-11250,-4540,90),(-11270,-4540,80));
    ww_CreateElevator((-11290,-4540,80),(-11320,-4540,70));
    ww_CreateElevator((-11350,-4540,90),(-11370,-4540,85));
    ww_CreateElevator((-11390,-4540,80),(-11420,-4540,80));
    ww_CreateElevator((-11440,-4540,90),(-11460,-4540,70));
    ww_CreateElevator((-11480,-4540,80),(-11510,-4540,85));
    ww_CreateElevator((-11530,-4540,90),(-11550,-4540,80));
    ww_CreateElevator((-11570,-4540,80),(-11590,-4540,70));
    ww_CreateElevator((-11620,-4540,90),(-11640,-4540,85));
    ww_CreateElevator((-11660,-4540,80),(-11680,-4540,80));
    ww_CreateElevator((-11720,-4540,90),(-11740,-4540,70));
    ww_CreateElevator((-11760,-4540,80),(-11780,-4540,85));
    ww_CreateElevator((-11810,-4540,90),(-11830,-4540,80));
    ww_CreateElevator((-11810,-4540,80),(-11210,-4640,80));
    ww_CreateElevator((-11210,-4640,90),(-11230,-4640,85));
    ww_CreateElevator((-11250,-4640,80),(-11270,-4640,80));
    ww_CreateElevator((-11290,-4640,90),(-11320,-4640,70));
    ww_CreateElevator((-11350,-4640,80),(-11370,-4640,85));
    ww_CreateElevator((-11390,-4640,90),(-11420,-4640,80));
    ww_CreateElevator((-11440,-4640,80),(-11460,-4640,70));
    ww_CreateElevator((-11480,-4640,90),(-11510,-4640,85));
    ww_CreateElevator((-11530,-4640,80),(-11550,-4640,80));
    ww_CreateElevator((-11570,-4640,90),(-11590,-4640,70));
    ww_CreateElevator((-11620,-4640,80),(-11640,-4640,85));
    ww_CreateElevator((-11660,-4640,90),(-11680,-4640,80));
    ww_CreateElevator((-11720,-4640,80),(-11740,-4640,70));
    ww_CreateElevator((-11760,-4640,90),(-11780,-4640,85));
    ww_CreateElevator((-11810,-4640,80),(-11830,-4640,80));
    ww_CreateElevator((-11810,-4640,90),(-11210,-4740,80));
    ww_CreateElevator((-11210,-4740,90),(-11230,-4740,85));
    ww_CreateElevator((-11250,-4740,80),(-11270,-4740,80));
    ww_CreateElevator((-11290,-4740,90),(-11320,-4740,70));
    ww_CreateElevator((-11350,-4740,80),(-11370,-4740,85));
    ww_CreateElevator((-11390,-4740,90),(-11420,-4740,80));
    ww_CreateElevator((-11440,-4740,80),(-11460,-4740,70));
    ww_CreateElevator((-11480,-4740,90),(-11510,-4740,85));
    ww_CreateElevator((-11530,-4740,80),(-11550,-4740,80));
    ww_CreateElevator((-11570,-4740,90),(-11590,-4740,70));
    ww_CreateElevator((-11620,-4740,80),(-11640,-4740,85));
    ww_CreateElevator((-11660,-4740,90),(-11680,-4740,80));
    ww_CreateElevator((-11720,-4740,80),(-11740,-4740,70));
    ww_CreateElevator((-11760,-4740,90),(-11780,-4740,85));
    ww_CreateElevator((-11810,-4740,80),(-11830,-4740,80));
    ww_CreateElevator((-11810,-4740,90),(-11210,-4840,80));
    ww_CreateElevator((-11210,-4840,90),(-11230,-4840,85));
    ww_CreateElevator((-11250,-4840,80),(-11270,-4840,80));
    ww_CreateElevator((-11290,-4840,90),(-11320,-4840,70));
    ww_CreateElevator((-11350,-4840,80),(-11370,-4840,85));
    ww_CreateElevator((-11390,-4840,90),(-11420,-4840,80));
    ww_CreateElevator((-11440,-4840,80),(-11460,-4840,70));
    ww_CreateElevator((-11480,-4840,90),(-11510,-4840,85));
    ww_CreateElevator((-11530,-4840,80),(-11550,-4840,80));
    ww_CreateElevator((-11570,-4840,90),(-11590,-4840,70));
    ww_CreateElevator((-11620,-4840,80),(-11640,-4840,85));
    ww_CreateElevator((-11660,-4840,90),(-11680,-4840,80));
    ww_CreateElevator((-11720,-4840,80),(-11740,-4840,70));
    ww_CreateElevator((-11760,-4840,90),(-11780,-4840,85));
    ww_CreateElevator((-11810,-4840,80),(-11830,-4840,80));
    ww_CreateElevator((-11830,-4840,80),(-11210,-4940,80));
    ww_CreateElevator((-11210,-4940,90),(-11230,-4940,85));
    ww_CreateElevator((-11250,-4940,80),(-11270,-4940,80));
    ww_CreateElevator((-11290,-4940,90),(-11320,-4940,70));
    ww_CreateElevator((-11350,-4940,80),(-11370,-4940,85));
    ww_CreateElevator((-11390,-4940,90),(-11420,-4940,80));
    ww_CreateElevator((-11440,-4940,80),(-11460,-4940,70));
    ww_CreateElevator((-11480,-4940,90),(-11510,-4940,85));
    ww_CreateElevator((-11530,-4940,80),(-11550,-4940,80));
    ww_CreateElevator((-11570,-4940,90),(-11590,-4940,70));
    ww_CreateElevator((-11620,-4940,80),(-11640,-4940,85));
    ww_CreateElevator((-11660,-4940,90),(-11680,-4940,80));
    ww_CreateElevator((-11720,-4940,80),(-11740,-4940,70));
    ww_CreateElevator((-11760,-4940,90),(-11780,-4940,85));
    ww_CreateElevator((-11810,-4940,80),(-11830,-5040,80));
    ww_CreateElevator((-11830,-5040,80),(-11210,-5040,80));
    ww_CreateElevator((-11210,-5040,90),(-11230,-5040,85));
    ww_CreateElevator((-11250,-5040,80),(-11270,-5040,80));
    ww_CreateElevator((-11290,-5040,90),(-11320,-5040,70));
    ww_CreateElevator((-11350,-5040,80),(-11370,-5040,85));
    ww_CreateElevator((-11390,-5040,90),(-11420,-5040,80));
    ww_CreateElevator((-11440,-5040,80),(-11460,-5040,70));
    ww_CreateElevator((-11480,-5040,90),(-11510,-5040,85));
    ww_CreateElevator((-11530,-5040,80),(-11550,-5040,80));
    ww_CreateElevator((-11570,-5040,90),(-11590,-5040,70));
    ww_CreateElevator((-11620,-5040,80),(-11640,-5040,85));
    ww_CreateElevator((-11660,-5040,90),(-11680,-5040,80));
    ww_CreateElevator((-11720,-5040,80),(-11740,-5040,70));
    ww_CreateElevator((-11760,-5040,90),(-11810,-5040,85));
    ww_CreateElevator((-11810,-5040,80),(-11830,-5140,80));
    ww_CreateElevator((-11830,-5140,80),(-11210,-5140,80));
    ww_CreateElevator((-11210,-5140,90),(-11230,-5140,85));
    ww_CreateElevator((-11250,-5140,80),(-11270,-5140,80));
    ww_CreateElevator((-11290,-5140,90),(-11320,-5140,70));
    ww_CreateElevator((-11350,-5140,80),(-11370,-5140,85));
    ww_CreateElevator((-11390,-5140,90),(-11420,-5140,80));
    ww_CreateElevator((-11440,-5140,80),(-11460,-5140,70));
    ww_CreateElevator((-11480,-5140,90),(-11510,-5140,85));
    ww_CreateElevator((-11530,-5140,80),(-11550,-5140,80));
    ww_CreateElevator((-11570,-5140,90),(-11590,-5140,70));
    ww_CreateElevator((-11620,-5140,80),(-11640,-5140,85));
    ww_CreateElevator((-11660,-5140,90),(-11680,-5140,80));
    ww_CreateElevator((-11720,-5140,80),(-11740,-5140,70));
    ww_CreateElevator((-11760,-5140,90),(-11780,-5140,85));
    ww_CreateElevator((-11780,-5140,80),(-11210,-4240,80));
}

ww_b()
{
    self sayall("Flag Located in Middle Of Map");
    wait 5;
    self sayall("keep pressing X to keep going");
    wait 5;
}

ww_CreateElevator(enter,exit,angle)
{
    flag=spawn("script_model",enter);
    flag setModel(level.elevator_model["enter"]);
    wait 0.01;
    flag=spawn("script_model",exit);
    flag setModel(level.elevator_model["exit"]);
    wait 0.01;
    self thread ww_ElevatorThink(enter,exit,angle);
}

ww_ElevatorThink(enter,exit,angle)
{
    self endon("disconnect");
    while(1)
    {
        foreach(player in level.players)
        {
            if(Distance(enter,player.origin)<= 50)
            {
                player SetOrigin(exit);
                player SetPlayerAngles(angle);
            }
        }
        wait .25;
    }
}

ww_MakeBunker(mmArg)
{
    self endon("death");
    self thread ww_CreateBunker();
}

ww_CreateBunker()
{
    Location=self.origin+(0,0,20);
    ww_MakeCPWall(Location,"X",5,8);
    ww_MakeCPWall(Location+(0,5*30,0),"X",5,8);
    ww_MakeCPWall(Location,"Y",5,8);
    ww_MakeCPWall(Location+(5*55,0,0),"Y",6,8);
    ww_MakeCPWall(Location,"Z",5,5);
    ww_MakeCPWall(Location+(0,0,5*25),"Z",5,4);
    ww_CreateTurret(Location+(0.25*(5*55),18,35+(4*30)));
    ww_CreateTurret(Location+(0.25*(5*55),(5*25)+1,35+(4*30)));
    ww_SCP(Location+((4*55),84,20+4));
    ww_SCP(Location+((4*55),74,30+6));
    ww_SCP(Location+((4*55),64,40+8));
    ww_SCP(Location+((4*55),54,50+10));
    ww_SCP(Location+((4*55),44,60+12));
    ww_SCP(Location+((4*55),34,70+14));
    ww_SCP(Location+((4*55),24,80+16));
    ww_SCP(Location+((4*55),14,90+18));
    ww_SCP(Location+(45,10,6*25));
    ww_SCP(Location+(45,(5*25)+15,(6*25)));
    self thread ww_SpawnWeapon(undefined,"javelin_mp","Javelin",Location+(80,30,25),0);
    self thread ww_SpawnWeapon(undefined,"rpg_mp","RPG",Location+(80,65,25),0);
    self thread ww_SpawnWeapon(undefined,"cheytac_fmj_xmags_mp","Intervention",Location+(60,90,25),0);
    self thread ww_SpawnWeapon(undefined,"barrett_fmj_xmags_mp","Barrett .50",Location+(60,115,25),0);
    self thread ww_SpawnWeapon(undefined,"frag_grenade_mp","Frag",Location+(115,30,25),0);
    self thread ww_SpawnWeapon(::ww_UsePredator,"com_plasticcase_friendly","Predator",Location+(165,30,25),0);
    self SetOrigin(Location+(100,100,35));
}

ww_UsePredator()
{
    maps\mp\killstreaks\_remotemissile::tryUsePredatorMissile(self.pers["killstreaks"][0].lifeId);
}

ww_CreateTurret(Location)
{
    mgTurret=spawnTurret("misc_turret",Location+(0,0,45),"pavelow_minigun_mp");
    mgTurret setModel("weapon_minigun");
    mgTurret.owner=self.owner;
    mgTurret.team=self.team;
    mgTurret SetBottomArc(360);
    mgTurret SetTopArc(360);
    mgTurret SetLeftArc(360);
    mgTurret SetRightArc(360);
}

ww_SpawnWeapon(WFunc,Weapon,WeaponName,Location,TakeOnce)
{
    self endon("disconnect");
    weapon_model = getWeaponModel(Weapon);
    if(weapon_model=="")weapon_model=Weapon;
    Wep=spawn("script_model",Location+(0,0,3));
    Wep setModel(weapon_model);
    for(;;)
    {
        foreach(player in level.players)
        {
            Radius=distance(Location,player.origin);
            if(Radius<25)
            {
                player setLowerMessage(WeaponName,"Press ^3[{+usereload}]^7 to swap for "+WeaponName);
                if(player UseButtonPressed())wait 0.2;
                if(player UseButtonPressed())
                {
                    if(!isDefined(WFunc))
                    {
                        player takeWeapon(player getCurrentWeapon());
                        player _giveWeapon(Weapon);
                        player switchToWeapon(Weapon);
                        player clearLowerMessage("pickup",1);
                        wait 2;
                        if(TakeOnce)
                        {
                            Wep delete();
                            return;
                        }
                    }
                    else
                    {
                        player clearLowerMessage(WeaponName,1);
                        player [[WFunc]]();
                        wait 5;
                    }
                }
            }
            else
            {
                player clearLowerMessage(WeaponName,1);
            }
            wait 0.1;
        }
        wait 0.5;
    }
}

ww_SCP(Location)
{
    Mod=spawn("script_model",Location);
    Mod setModel("com_plasticcase_enemy");
    Mod Solid();
    Mod CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
}

ww_MakeCPLine(Location,X,Y,Z)
{
    for(i=0;i<X;i++)ww_SCP(Location+(i*55,0,0));
    for(i=0;i<Y;i++)ww_SCP(Location+(0,i*30,0));
    for(i=0;i<Z;i++)ww_SCP(Location+(0,0,i*25));
}

ww_MakeCPWall(Location,Axis,X,Y)
{
    if(Axis=="X")
    {
        ww_MakeCPLine(Location,X,0,0);
        for(i=0;i<X;i++)ww_MakeCPLine(Location+(i*55,0,0),0,0,Y);
    }
    else if(Axis=="Y")
    {
        ww_MakeCPLine(Location,0,X,0);
        for(i=0;i<X;i++)ww_MakeCPLine(Location+(0,i*30,0),0,0,Y);
    }
    else if(Axis=="Z")
    {
        ww_MakeCPLine(Location,0,X,0);
        for(i=0;i<X;i++)ww_MakeCPLine(Location+(0,i*30,0),Y,0,0);
    }
}
