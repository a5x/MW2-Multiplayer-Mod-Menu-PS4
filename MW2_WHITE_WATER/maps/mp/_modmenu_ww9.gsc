// WhiteWaterV6.5 (xRobertDavisx, JokerRey; ported by BravSoldat) -- the patch's own
// functions from init.gsc (Admin Menu: Flyable Harrier, Littlebirds, Aimbot), renamed ww_* and called by maps\mp\_modmenu.gsc.
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ww_GetCursorPos1337()
{
    forward = self getTagOrigin("tag_eye");
    end = self maps\mp\_modmenu_ww1::ww_vector_scale(anglestoforward(self getPlayerAngles()),1000000);
    location = BulletTrace( forward, end, 0, self)[ "position" ];
    return location;
}

ww_fixDeathGlitch()
{
    self waittill( "death" );
    self thread ww_useMinigun();
}

ww_destroyOnDeath1( waaat )
{
    self waittill( "death" );
    waaat destroy();
}

ww_destroyOnEndJet( waaat )
{
    self waittill( "endjet" );
    waaat destroy();
}

ww_forwardMoveTimer(SpeedToMove)
{
    self endon("death");
    self endon( "endjet" );
    if(isdefined(self.jetflying)) self.jetflying delete();
    self.jetflying = spawn("script_origin", self.origin);
    self.flyingJetSpeed = SpeedToMove;
    while(1)
    {
        self.jetflying.origin = self.origin;
        self playerlinkto(self.jetflying);
        vec = anglestoforward(self getPlayerAngles());
        vec2iguess = maps\mp\_modmenu_ww1::ww_vector_scale(vec, self.flyingJetSpeed);
        self.jetflying.origin = self.jetflying.origin+vec2iguess;
        wait 0.05;
    }
}

ww_engineSmoke()
{
    self endon( "endjet" );
    playFxOnTag( level.harrier_smoke, self, "tag_engine_left" );
    playFxOnTag( level.harrier_smoke, self, "tag_engine_right" );
    playFxOnTag( level.harrier_smoke, self, "tag_engine_left" );
    playFxOnTag( level.harrier_smoke, self, "tag_engine_right" );
}

ww_toggleJetSpeedUp()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "endjet" );
    self thread ww_toggleJetUpPress();
    for(;;)
    {
        s = 0;
        if(self FragButtonPressed())
        {
            wait 1;
            while(self FragButtonPressed())
            {
                if(s<4)
                {
                    wait 2;
                    s++;
                }
                if(s>3&&s<7)
                {
                    wait 1;
                    s++;
                }
                if(s>6)
                {
                    wait .5;
                    s++;
                }
                if(s==10) wait .5;
                if(self FragButtonPressed())
                {
                    if(s<4) self.flyingJetSpeed = self.flyingJetSpeed + 50;
                    if(s>3&&s<7) self.flyingJetSpeed = self.flyingJetSpeed + 100;
                    if(s>6) self.flyingJetSpeed = self.flyingJetSpeed + 200;
                    self.speedHUD setValue( self.flyingJetSpeed );
                }
            }
            s = 0;
        }
        wait .04;
    }
}

ww_toggleJetSpeedDown()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "endjet" );
    self thread ww_toggleJetDownPress();
    for(;;)
    {
        h = 0;
        if(self SecondaryOffhandButtonPressed())
        {
            wait 1;
            while(self SecondaryOffhandButtonPressed())
            {
                if(h<4)
                {
                    wait 2;
                    h++;
                }
                if(h>3&&h<7)
                {
                    wait 1;
                    h++;
                }
                if(h>6)
                {
                    wait .5;
                    h++;
                }
                if(h==10) wait .5;
                if(self SecondaryOffhandButtonPressed())
                {
                    if(h<4) self.flyingJetSpeed = self.flyingJetSpeed - 50;
                    if(h>3&&h<7) self.flyingJetSpeed = self.flyingJetSpeed - 100;
                    if(h>6) self.flyingJetSpeed = self.flyingJetSpeed - 200;
                    self.speedHUD setValue( self.flyingJetSpeed );
                }
            }
            h = 0;
        }
        wait .04;
    }
}

ww_toggleJetUpPress()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "endjet" );
    for(;;)
    {
        self waittill( "RB" );
        self.flyingJetSpeed = self.flyingJetSpeed + 10;
        self.speedHUD setValue( self.flyingJetSpeed );
    }
}

ww_toggleJetDownPress()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "endjet" );
    for(;;)
    {
        self waittill( "LB" );
        self.flyingJetSpeed = self.flyingJetSpeed - 10;
        self.speedHUD setValue( self.flyingJetSpeed );
    }
}

ww_initJet(mmArg)
{
    self thread ww_jetStartup(1, 0, 1, 1);
    self thread ww_toggleJetSpeedDown();
    self thread ww_toggleJetSpeedUp();
    self thread ww_initHudElems();
}

ww_jetStartup(UseWeapons, Speed, Silent, ThirdPerson)
{
    self takeAllWeapons();
    self thread maps\mp\_modmenu_ww1::ww_MGod();
    self thread ww_forwardMoveTimer(Speed);
    if(ThirdPerson == 1)
    {
        wait 0.1;
        self setClientDvar("cg_thirdPerson", 1 );
        self setClientDvar("cg_fovscale", "3" );
        self setClientDvar("cg_thirdPersonRange", "1000" );
    }
    jetflying111 = "vehicle_mig29_desert";
    self attach(jetflying111, "tag_weapon_left", false);
    self thread ww_engineSmoke();
    if(UseWeapons == 1)
    {
        self ww_useMinigun();
        self thread ww_makeHUD();
        self thread ww_migTimer();
        self thread ww_makeJetWeapons();
        self thread ww_fixDeathGlitch();
        self setClientDvar( "compassClampIcons", "999" );
    }
    if(Silent == 0)
    {
        self playLoopSound( "veh_b2_dist_loop" );
    }
}

ww_useMinigun()
{
    self.minigun = 1;
    self.carpet = 0;
    self.explosives = 0;
    self.missiles = 0;
}

ww_useCarpet()
{
    self.minigun = 0;
    self.carpet = 1;
    self.explosives = 0;
    self.missiles = 0;
}

ww_useExplosives()
{
    self.minigun = 0;
    self.carpet = 0;
    self.explosives = 1;
    self.missiles = 0;
}

ww_useMissiles()
{
    self.minigun = 0;
    self.carpet = 0;
    self.explosives = 0;
    self.missiles = 1;
}

ww_makeHUD()
{
    self endon("disconnect");
    self endon("death");
    self endon( "endjet" );
    for(;;)
    {
        if(self.minigun == 1)
        {
            self.weaponHUD maps\mp\_modmenu_ww1::ww_setSafeText( "CURRENT WEAPON: ^1AC130" );
        }
        else if(self.carpet == 1)
        {
            self.weaponHUD maps\mp\_modmenu_ww1::ww_setSafeText( "CURRENT WEAPON: ^1RPG" );
        }
        else if(self.explosives == 1)
        {
            self.weaponHUD maps\mp\_modmenu_ww1::ww_setSafeText( "CURRENT WEAPON: ^1NOOBTUBE" );
        }
        else if(self.missiles == 1)
        {
            self.weaponHUD maps\mp\_modmenu_ww1::ww_setSafeText( "CURRENT WEAPON: ^1STINGER" );
        }
        wait 0.5;
    }
}

ww_initHudElems()
{
    self.weaponHUD = self createFontString( "default", 1.4 );
    self.weaponHUD setPoint( "TOPRIGHT", "TOPRIGHT", 0, 23 );
    self.weaponHUD maps\mp\_modmenu_ww1::ww_setSafeText( "CURRENT WEAPON: ^1AC130" );
    // the speed is a number (setValue) between two fixed texts: "SPEED: "+n+" MPH"
    // was a new text, and a text slot, on every change of speed
    self.speedText = self createFontString( "default", 1.4 );
    self.speedText setPoint( "RIGHT", "TOP", -85, 9 );
    self.speedText maps\mp\_modmenu_ww1::ww_setSafeText( "SPEED:" );
    self.speedUnit = self createFontString( "default", 1.4 );
    self.speedUnit setPoint( "LEFT", "TOP", -45, 9 );
    self.speedUnit maps\mp\_modmenu_ww1::ww_setSafeText( "MPH" );
    self.speedHUD = self createFontString( "default", 1.4 );
    self.speedHUD setPoint( "CENTER", "TOP", -65, 9 );
    if(!isDefined(self.flyingJetSpeed)) self.flyingJetSpeed = 0;
    self.speedHUD setValue( self.flyingJetSpeed );
    self thread ww_destroyOnDeath1( self.speedText );
    self thread ww_destroyOnDeath1( self.speedUnit );
    self thread ww_destroyOnEndJet( self.speedText );
    self thread ww_destroyOnEndJet( self.speedUnit );
    self thread ww_destroyOnDeath1( self.weaponHUD );
    self thread ww_destroyOnDeath1( self.speedHUD );
    self thread ww_destroyOnEndJet( self.weaponHUD );
    self thread ww_destroyOnEndJet( self.speedHUD );
}

ww_migTimer()
{
    self endon ( "death" );
    self endon ( "disconnect" );
    self endon( "endjet" );
    while(1)
    {
        self waittill( "G" );
        self thread ww_useCarpet();
        self waittill( "G" );
        self thread ww_useExplosives();
        self waittill( "G" );
        self thread ww_useMissiles();
        self waittill( "G" );
        self thread ww_useMinigun();
    }
}

ww_makeJetWeapons()
{
    self endon ( "death" );
    self endon ( "disconnect" );
    self endon( "endjet" );
    while(1)
    {
        self waittill( "fiya" );
        if(self.minigun == 1)
        {
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "ac130_105mm_mp", self.origin, firing, self );
            wait 0.1;
        }
        else if(self.carpet == 1)
        {
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait .01;
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait .01;
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait .01;
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait .01;
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait 0.2;
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait .01;
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait .01;
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait .01;
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait .01;
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait 0.2;
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait .01;
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait .01;
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait .01;
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait .01;
            firing = ww_GetCursorPos1337();
            MagicBullet( "rpg_mp", self.origin, firing, self );
            wait 0.2;
        }
        else if(self.explosives == 1)
        {
            firing = ww_GetCursorPos1337();
            MagicBullet( "m79_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "m79_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "m79_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "m79_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "m79_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "m79_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "m79_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "m79_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "m79_mp", self.origin, firing, self );
            firing = ww_GetCursorPos1337();
            MagicBullet( "m79_mp", self.origin, firing, self );
            wait 0.1;
        }
        else if(self.missiles == 1)
        {
            firing = ww_GetCursorPos1337();
            MagicBullet( "stinger_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "stinger_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "stinger_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "stinger_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "stinger_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "stinger_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "stinger_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "stinger_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "stinger_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "stinger_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "stinger_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "stinger_mp", self.origin, firing, self );
            wait 0.1;
            firing = ww_GetCursorPos1337();
            MagicBullet( "stinger_mp", self.origin, firing, self );
            wait 0.1;
        }
        wait 0.1;
    }
}

ww_doExplosion(Location)
{
    level.chopper_fx["explode"]["medium"]=loadfx("explosions/aerial_explosion");
    ww_rExp(Location);
    ww_rExp(Location+(200,0,0));
    ww_rExp(Location+(0,200,0));
    ww_rExp(Location+(200,200,0));
    ww_rExp(Location+(0,0,200));
    ww_rExp(Location-(200,0,0));
    ww_rExp(Location-(0,200,0));
    ww_rExp(Location-(200,200,0));
    ww_rExp(Location+(0,0,400));
    ww_rExp(Location+(100,0,0));
    ww_rExp(Location+(0,100,0));
    ww_rExp(Location+(100,100,0));
    ww_rExp(Location+(0,0,100));
    ww_rExp(Location-(100,0,0));
    ww_rExp(Location-(0,100,0));
    ww_rExp(Location-(100,100,0));
    ww_rExp(Location+(0,0,100));
}

ww_rExp(l)
{
    playFX(level.chopper_fx["explode"]["medium"],l);
}

ww_ALBDelete()
{
    self waittill("helicopter_done");
    self delete();
}

ww_ALBSound()
{
    self endon("disconnect");
    level endon("game_ended");
    self endon("helicopter_done");
    CO=spawn("script_origin",self.origin);
    CO hide();
    CO thread ww_ALBDelete();
    for(;;)
    {
        CO playSound("flag_spawned");
        wait 15;
    }
}

ww_DoNukeRoutine(B,M)
{
    if(!isDefined(B))B=0;
    if(B&&level.ChopEndsGame)B=0;
    else B=0;
    player=self;
    if(!isDefined(M))T=0;
    else T=1;
    if(!T)NukeWarhead=self ww_getcursorpos5();
    else NukeWarhead=M.origin;
    if(!T)
    {
        nukeEnt=Spawn("script_model",NukeWarhead.origin);
        nukeEnt setModel("tag_origin");
        nukeEnt.angles=(0,(player.angles[1]+180),90);
    }
    else
    {
        nukeEnt=M;
    }
    player playsound("nuke_explosion");
    level._effect["cloud"]=loadfx("explosions/emp_flash_mp");
    if(!T)playFX(level._effect["cloud"],NukeWarhead+(0,0,200));
    else playFX(level._effect["cloud"],M.origin+(0,0,200));
    if(T)M hide();
    ww_doExplosion(NukeWarhead.origin);
    player playsound("nuke_wave");
    PlayFXOnTagForClients(level._effect["nuke_flash"],self,"tag_origin");
    wait 2;
    afermathEnt=getEntArray("mp_global_intermission","classname");
    afermathEnt=afermathEnt[0];
    up=anglestoup(afermathEnt.angles);
    right=anglestoright(afermathEnt.angles);
    playFX(level._effect["nuke_aftermath"],afermathEnt.origin,up,right);
    level.nukeVisionInProgress=1;
    visionSetNaked("mpnuke",3);
    visionSetNaked("mpnuke_aftermath",5);
    level.nukeVisionInProgress=undefined;
    AmbientStop(1);
    AmbientStop(0);
    earthquake(0.4,4,NukeWarhead.origin,90000);
    wait 0.2;
    self maps\mp\_modmenu_ww7::ww_DamageArea(NukeWarhead.origin,999999,99999,99999,"nuke_mp",1,B);
    wait 0.3;
    if(!B)visionSetNaked(getDvar("mapname"),5);
}

ww_getcursorpos5()
{
    f=self getTagOrigin("tag_eye");
    e=self maps\mp\_modmenu_ww1::ww_vector_scale(anglestoforward(self getPlayerAngles()),1000000);
    l=BulletTrace(f,e,0,self)["position"];
    return l;
}

ww_heli_flare_monitor()
{
    level endon("game_ended");
    self endon("helicopter_done");
    C=0;
    for(;;)
    {
        level waittill("stinger_fired",player,missile,lockTarget);
        if(!IsDefined(lockTarget)||(lockTarget!=self))continue;
        missile endon("death");
        self thread ww_playFlareF();
        F=spawn("script_origin",level.ac130.planemodel.origin);
        F.angles=level.ac130.planemodel.angles;
        F moveGravity((0, 0, 0),5.0);
        F thread ww_dAT(5.0);
        N=F;
        missile Missile_SetTargetEnt(N);
        C++;
        if(C>1)return;
    }
}

ww_playFlareF()
{
    for(i=0;i<10;i++)
    {
        if(!isDefined(self))return;
        PlayFXOnTag(level._effect["ac130_flare"],self,"tag_origin");
        wait .15;
    }
}

ww_dAT(d)
{
    wait(d);
    self delete();
}

ww_MakeHeli(SPoint,forward,owner,b)
{
    if(!isDefined(b))b=false;
    if(!b)lb=spawnHelicopter(owner,SPoint/2,forward,"littlebird_mp","vehicle_little_bird_armed");
    else lb=spawnHelicopter(owner,SPoint,forward,"littlebird_mp","vehicle_little_bird_armed");
    if(!isDefined(lb))return;
    lb.owner=owner;
    lb.team=owner.team;
    lb.pers["team"]=owner.team;
    mgTurret1=spawnTurret("misc_turret",lb.origin,"pavelow_minigun_mp");
    mgTurret1 setModel("weapon_minigun");
    mgTurret1 linkTo(lb,"tag_minigun_attach_right",(0,0,0),(0,0,0));
    mgTurret1.owner=owner;
    mgTurret1.lifeId=0;
    mgTurret1.team=owner.team;
    mgTurret1 makeTurretInoperable();
    mgTurret1 SetDefaultDropPitch(8);
    mgTurret1 SetTurretMinimapVisible(0);
    mgTurret1.killCamEnt=lb;
    mgTurret1 SetSentryOwner(owner);
    mgTurret1.pers["team"]=owner.team;
    mgTurret2=spawnTurret("misc_turret",lb.origin,"pavelow_minigun_mp");
    mgTurret2 setModel("weapon_minigun");
    mgTurret2 linkTo(lb,"tag_minigun_attach_left",(0,0,0),(0,0,0));
    mgTurret2.owner=owner;
    mgTurret2.lifeId=0;
    mgTurret2.team=owner.team;
    mgTurret2 makeTurretInoperable();
    mgTurret2 SetDefaultDropPitch(8);
    mgTurret2.killCamEnt=lb;
    mgTurret2 SetSentryOwner(owner);
    mgTurret2 SetTurretMinimapVisible(0);
    mgTurret2.pers["team"]=owner.team;
    if(level.teamBased)
    {
        mgTurret1 setTurretTeam(owner.team);
        mgTurret2 setTurretTeam(owner.team);
    }
    lb.mg1=mgTurret1;
    lb.mg2=mgTurret2;
    return lb;
}

ww_setry_attackTargets()
{
    self endon("death");
    self endon("helicopter_done");
    level endon("game_ended");
    for(;;)
    {
        self waittill("turretstatechange");
        if(self isFiringTurret())self thread ww_setry_burstFireStart();
        else self thread ww_setry_burstFireStop();
    }
}

ww_setry_burstFireStart()
{
    self endon("death");
    self endon("stop_shooting");
    self endon("leaving");
    level endon("game_ended");
    for(;;)
    {
        for(i=0;i<80;i++)
        {
            targetEnt=self getTurretTarget(false);
            if(isDefined(targetEnt))self shootTurret();
            wait .1;
        }
        wait 1;
    }
}

ww_setry_burstFireStop()
{
    self notify("stop_shooting");
}

ww_AttackLittlebird(mmArg)
{
    owner=self;
    startNode=level.heli_start_nodes[randomInt(level.heli_start_nodes.size)];
    heliOrigin=startnode.origin;
    heliAngles=startnode.angles;
    lb=ww_MakeHeli(heliOrigin,heliAngles,owner,1);
    if(!isDefined(lb))return;
    lb maps\mp\killstreaks\_helicopter::addToHeliList();
    LB thread ww_ALBSound();
    lb.zOffset=(0,0,lb getTagOrigin("tag_origin")[2]-lb getTagOrigin("tag_ground")[2]);
    //lb.attractor=Missile_CreateAttractorEnt(lb,level.heli_attract_strength,level.heli_attract_range); //fix
    //lb.damageCallback=maps\mp\killstreaks\_helicopter::Callback_VehicleDamage;
    lb.maxhealth=level.heli_maxhealth*2;
    lb.team=owner.team;
    lb.attacker=undefined;
    lb.lifeId=0;
    lb.currentstate="ok";
    lb thread ww_heli_flare_monitor();
    lb thread maps\mp\killstreaks\_helicopter::heli_leave_on_disconnect(owner);
    lb thread maps\mp\killstreaks\_helicopter::heli_leave_on_changeTeams(owner);
    lb thread maps\mp\killstreaks\_helicopter::heli_leave_on_gameended(owner);
    lb thread maps\mp\killstreaks\_helicopter::heli_damage_monitor();
    lb thread maps\mp\killstreaks\_helicopter::heli_health();
    lb thread maps\mp\killstreaks\_helicopter::heli_existance();
    lb endon("helicopter_done");
    lb endon("crashing");
    lb endon("leaving");
    lb endon("death");
    attackAreas=getEntArray("heli_attack_area","targetname");
    loopNode=level.heli_loop_nodes[randomInt(level.heli_loop_nodes.size)];
    lb maps\mp\killstreaks\_helicopter::heli_fly_simple_path(startNode);
    lb thread ww_heli_leave_on_timeou(50);
    if(attackAreas.size)lb thread maps\mp\killstreaks\_helicopter::heli_fly_well(attackAreas);
    else lb thread maps\mp\killstreaks\_helicopter::heli_fly_loop_path(loopNode);
    lb thread ww_deleteLBTurrets();
    lb.mg1 setMode("auto_nonai");
    lb.mg1 thread ww_setry_attackTargets();
    lb.mg2 setMode("auto_nonai");
    lb.mg2 thread ww_setry_attackTargets();
    lb thread ww_ShootLBJavi(owner);
    lb thread ww_DropLBPackage(owner);
}

ww_heli_leave_on_timeou(T)
{
    self endon("death");
    self endon("helicopter_done");
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(T);
    M=maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins,level.spawnMaxs);
    level notify("chopGone");
    self.mg1 notify("helicopter_done");
    self.mg2 notify("helicopter_done");
    self.mg1 notify("leaving");
    self.mg2 notify("leaving");
    self.mg1 setMode("manual");
    self.mg2 setMode("manual");
    owner=self.owner;
    S=150;
    A=150;
    self Vehicle_SetSpeed(S,A);
    self setVehGoalPos(M+(0,0,1500),1);
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(2);
    C=spawn("script_model",M+(0,0,1500));
    C setModel("projectile_cbu97_clusterbomb");
    owner thread ww_TimerNuke(C,M);
    owner thread ww_NukeWait(C);
    self thread maps\mp\killstreaks\_helicopter::heli_leave();
}

ww_NukeWait(O)
{
    level endon("game_ended");
    self endon("disconnect");
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(6);
    level.nukeDetonated=true;
    self thread ww_DoNukeRoutine(1,O);
}

ww_TimerNuke(O,C)
{
    self endon("disconnect");
    O moveTo(C,10);
    while(!isDefined(level.nukeDetonated))
    {
        O playSound("ui_mp_nukebomb_timer");
        wait 1;
    }
    O delete();
}

ww_deleteLBTurrets()
{
    self waittill("helicopter_done");
    self.mg1 delete();
    self.mg2 delete();
}

ww_DropLBPackage(owner)
{
    self endon("death");
    self endon("helicopter_done");
    level endon("game_ended");
    self endon("crashing");
    self endon("leaving");
    waittime=15;
    for(;;)
    {
        wait(waittime);
        flyHeight=self maps\mp\killstreaks\_airdrop::getFlyHeightOffset(self.origin);
        self thread maps\mp\killstreaks\_airdrop::dropTheCrate(self.origin+(0,0,-110),"airdrop_chop",flyHeight,false,undefined,self.origin+(0,0,-110));
        self notify("drop_crate");
    }
}

ww_ShootLBJavi(owner)
{
    self endon("death");
    self endon("helicopter_done");
    level endon("game_ended");
    self endon("crashing");
    self endon("leaving");
    waittime=13;
    for(;;)
    {
        wait(waittime);
        AimedPlayer=undefined;
        foreach(player in level.players)
        {
            if((player==owner)||(!isAlive(player))||(level.teamBased&&owner.pers["team"]==player.pers["team"])||(!bulletTracePassed(self getTagOrigin("tag_origin"),player getTagOrigin("back_mid"),0,self)))continue;
            if(isDefined(AimedPlayer))
            {
                if(maps\mp\_modmenu_ww1::ww_closer(self getTagOrigin("tag_origin"),player getTagOrigin("back_mid"),AimedPlayer getTagOrigin("back_mid")))AimedPlayer=player;
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
            MagicBullet("javelin_mp",self getTagOrigin("tag_origin")-(0,0,180),AimLocation,owner);
            wait 1;
            MagicBullet("javelin_mp",self getTagOrigin("tag_origin")-(0,0,180),AimLocation,owner);
        }
    }
}

ww_SpawnSmallHelicopter(mmArg)
{
    lb=spawnHelicopter(self,self.origin+(0,0,110),self.angles,"littlebird_mp","vehicle_little_bird_armed");
    if(!isDefined(lb)) return;
    lb.owner=self;
    lb.team=self.team;
    lb.Shoot=0;
    lb.Pilot=0;
    lb.Passanger=0;
    lb.AShoot=0;
    mgTurret1=spawnTurret("misc_turret",lb.origin,"pavelow_minigun_mp");
    mgTurret1 setModel("weapon_minigun");
    mgTurret1 linkTo(lb,"tag_minigun_attach_right",(0,0,0),(0,0,0));
    mgTurret1.owner=self;
    mgTurret1.team=self.team;
    mgTurret1 makeTurretInoperable();
    mgTurret1 LaserOn();
    mgTurret1 SetDefaultDropPitch(8);
    mgTurret1 SetTurretMinimapVisible(0);
    mgTurret2=spawnTurret("misc_turret",lb.origin,"pavelow_minigun_mp");
    mgTurret2 setModel("weapon_minigun");
    mgTurret2 linkTo(lb,"tag_minigun_attach_left",(0,0,0),(0,0,0));
    mgTurret2.owner = self;
    mgTurret2.team = self.team;
    mgTurret2 makeTurretInoperable();
    mgTurret2 SetDefaultDropPitch(8);
    mgTurret2 LaserOn();
    mgTurret2 SetTurretMinimapVisible(0);
    lb.mg1=mgTurret1;
    lb.mg2=mgTurret2;
    self thread ww_InitHelicopter(lb);
}

ww_InitHelicopter(H)
{
    Z=randomint(9999);
    for(;;)
    {
        if(!H.Pilot)
        {
            foreach(Pilot in level.players)
            {
                B=distance(ww_GetHeliSeat(H,20),Pilot.origin);
                if(B<150)
                {
                    if(!Pilot.Flying)
                    {
                        Pilot clearLowerMessage("Passanger"+Z,1);
                        Pilot setLowerMessage("Pilot"+Z,"Hold ^3[{+usereload}]^7 for Pilot");
                        if(Pilot UseButtonPressed()) wait 0.2;
                        if(Pilot UseButtonPressed())
                        {
                            Pilot SetStance("crouch");
                            Pilot thread ww_giveHelicopterPilot(H);
                            Pilot.Pilot=H;
                            H.Pilot=1;
                            thread ww_clearLowerMessageRange("Pilot"+Z,ww_GetHeliSeat(H,20),999);
                            break;
                        }
                    }
                }
                else
                {
                    Pilot clearLowerMessage("Pilot"+Z,1);
                    Pilot clearLowerMessage("Passanger"+Z,1);
                }
                wait 0.01;
            }
        }
        else if(!H.Passanger)
        {
            foreach(Passanger in level.players)
            {
                B=distance(ww_GetHeliSeat(H,-20),Passanger.origin);
                if(!H.Pilot)B=999;
                if(B<150)
                {
                    if(!Passanger.Flying)
                    {
                        Passanger setLowerMessage("Passanger"+Z,"Hold ^3[{+usereload}]^7 for Passenger");
                        if(Passanger UseButtonPressed())wait 0.2;
                        if(Passanger UseButtonPressed())
                        {
                            Passanger SetStance("crouch");
                            Passanger thread ww_giveHelicopterPassanger(H);
                            Passanger.Passanger=H;
                            H.Passanger=1;
                            thread ww_clearLowerMessageRange("Passanger"+Z,ww_GetHeliSeat(H,-20),999);
                            thread ww_clearLowerMessageRange("Pilot"+Z,ww_GetHeliSeat(H,20),999);
                            break;
                        }
                    }
                }
                else
                {
                    Passanger clearLowerMessage("Passanger"+Z,1);
                }
                wait 0.01;
            }
        }
        wait 0.2;
    }
}

ww_giveHelicopterPassanger(H)
{
    self endon("disconnect");
    self endon("death");
    self thread ww_HelicopterDeathReset(H);
    self.Flying=1;
    level.p[self.myName]["MenuOpen"]=1;
    Me=spawn("script_origin",self.origin);
    self playerLinkTo(Me);
    Me thread ww_UpdateSeat(H,-15);
    for(;;)
    {
        if(self.Flying)
        {
            if(self ww_isButP("Up"))
            {
                if(self.Flying) self.Flying=0;
            }
        }
        else
        {
            self notify("endhelicopter");
            self unlink();
            self ww_HelicopterReset(H);
            break;
        }
        wait 0.1;
    }
    self.Flying=0;
    Me delete();
    level.p[self.myName]["MenuOpen"]=0;
}

ww_HelicopterDeathReset(H)
{
    self waittill("death");
    self ww_HelicopterReset(H);
}

ww_HelicopterReset(H)
{
    if(isDefined(self.Pilot))
    {
        H.Pilot=0;
        self.Pilot=undefined;
        self.Flying=0;
    }
    if(isDefined(self.Passanger))
    {
        H.Passanger=0;
        self.Passanger=undefined;
        self.Flying=0;
    }
}

ww_autoShootHelicopter(H)
{
    if(H.AShoot)
    {
        H.mg1 setMode("auto_nonai");
        H.mg2 setMode("auto_nonai");
        H.mg1 thread maps\mp\killstreaks\_helicopter::sentry_attackTargets();
        H.mg2 thread maps\mp\killstreaks\_helicopter::sentry_attackTargets();
        self iPrintlnBold("^1Advanced Auto-Shooting : ON");
    }
    else
    {
        self ww_autoShootDisable(H);
        self iPrintlnBold("^1Advanced Auto-Shooting : OFF");
    }
}

ww_UpdateSeat(H,O)
{
    self endon("disconnect");
    self endon("death");
    self endon("endhelicopter");
    for(;;)
    {
        self.origin = ww_GetHeliSeat(H,O);
        wait 0.01;
    }
}

ww_GetHeliSeat(H,O)
{
    hforward = anglestoforward(H.angles);
    hright = anglestoright(H.angles);
    return ((H.origin-(0,0,72))+(hforward[0]*35,hforward[1]*35,hforward[2]*35))-(hright[0]*O,hright[1]*O,hright[2]*O);
}

ww_giveHelicopterPilot(H)
{
    self endon("disconnect");
    self endon("death");
    self thread ww_HelicopterDeathReset(H);
    self.Flying=1;
    S=16;
    H Vehicle_SetSpeed(1000,S);
    Me = spawn("script_origin",self.origin);
    Destination = spawn("script_origin",self.origin);
    self playerLinkTo(Me);
    level.p[self.myName]["MenuOpen"]=1;
    Me thread ww_UpdateSeat(H,15);
    WL=self getWeaponsListOffhands();
    foreach(Wep in WL) 
	{
		self takeweapon(Wep);
	}
    wait 1.5;
    H.mg1 SetSentryOwner(self);
    H.mg2 SetSentryOwner(self);
    if(level.teamBased)
    {
        H.mg1 setTurretTeam(self.team);
        H.mg2 setTurretTeam(self.team);
    }
    for(;;)
    {
        if(self.Flying)
        {
            forward = anglestoforward(self getPlayerAngles());
            right = anglestoright(self getPlayerAngles());
            up = anglestoup(self getPlayerAngles());
            if(self FragButtonPressed())
            {
                pos = (forward[0]*S,forward[1]*S,forward[2]*S);
                Destination.origin = Destination.origin+pos;
                H setVehGoalPos(Destination.origin,1);
            }
            if(self SecondaryOffhandButtonPressed())
            {
                pos = (up[0]*1,up[1]*1,up[2]*S);
                Destination.origin = Destination.origin+pos;
                H setVehGoalPos(Destination.origin,1);
            }
            if(self UseButtonPressed())
            {
                pos = (up[0]*1,up[1]*1,up[2]*S);
                Destination.origin = Destination.origin-pos;
                H setVehGoalPos(Destination.origin,1);
            }
            if(H.Shoot)
            {
                H.mg1 ShootTurret();
                H.mg2 ShootTurret();
            }
            if(self ww_isButP("Left"))
            {
                self ww_shootFrom("javelin_mp",H.mg1,S*4);
                self ww_shootFrom("javelin_mp",H.mg2,S*4);
            }
            if(self ww_isButP("Up"))
            {
                forward=H.origin-(0,0,S*5);
                end=self maps\mp\_modmenu_ww1::ww_vector_scale(anglestoup(self getPlayerAngles()),-1000000);
                X=BulletTrace(forward,end,0,H)["position"];
                MagicBullet("ac130_105mm_mp",forward,X,self);
            }
            if(self ww_isButP("Down"))
            {
                H.Shoot=0;
                if(H.AShoot)
                {
                    H.AShoot=0;
                }
                else
                {
                    H.AShoot=1;
                }
                self ww_autoShootHelicopter(H);
            }
            if(self ww_isButP("O"))
            {
                self ww_autoShootDisable(H);
                if(self.Flying) self.Flying=0;
            }
        }
        else
        {
            self notify("endhelicopter");
            self unlink();
            level.p[self.myName]["MenuOpen"]=0;
            self ww_HelicopterReset(H);
            break;
        }
        wait 0.05;
    }
    self.Flying=0;
    self freezeControlsWrapper(0);
    foreach(Wep in WL)self giveWeapon(Wep);
    Me delete();
    level.p[self.myName]["MenuOpen"]=0;
    Destination delete();
}

ww_autoShootDisable(H)
{
    H.mg1 notify("helicopter_done");
    H.mg2 notify("helicopter_done");
    H.mg1 notify("leaving");
    H.mg2 notify("leaving");
    H.mg1 setMode("manual");
    H.mg2 setMode("manual");
    H.mg1 SetDefaultDropPitch(8);
    H.mg2 SetDefaultDropPitch(8);
    H.AShoot=0;
}

ww_shootFrom(W,O,P)
{
    E=maps\mp\_modmenu_ww1::ww_vector_scale(anglestoforward(O.angles),99999);
    S=O.origin+maps\mp\_modmenu_ww1::ww_vector_scale(anglestoforward(O.angles),P);
    L=BulletTrace(S,E,0,self)["position"];
    MagicBullet(W,S,L,self);
}

ww_isButP(butID)
{
    self endon("disconnect");
    self endon("death");
    if (self.butP[butID]==1)
    {
        self.butP[butID]=0;
        return 1;
    }
    else return 0;
}

ww_clearLowerMessageRange(Msg,Point,Radius)
{
    foreach(P in level.players)
    {
        B=distance(Point,P.origin);
        if(B<Radius)
        {
            P clearLowerMessage(Msg,1);
        }
        wait 0.01;
    }
}

ww_BPLY(mmArg)
{
    if (getDvarInt("testClients_doAttack")==1)
    {
        setDvar("testClients_doAttack",0);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Bots Play - Off");
        setDvar("testClients_doMove",0);
    }
    else
    {
        setDvar("testClients_doAttack",1);
        setDvar("testClients_doMove",1);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Bots Play - On");
    }
}

ww_TEE(mmArg)
{
    foreach( player in level.players )
    {
        if(player.name != self.name)player SetOrigin( self.origin );
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Teleported Everyone to Me");
    }
}

ww_TitsInTheSky(mmArg)
{
    level thread ww_DoText4();
    ww_WP9("450,150,475,150,500,150,525,150,550,150,575,150,600,150,950,150,975,150,1000,150,1025,150,1050,150,1075,150,1100,150,375,180,400,180,425,180,625,180,650,180,675,180,900,180,925,180,1125,180,1150,180,350,210,700,210,850,210,875,210,1175,210,325,240,725,240,850,240,1200,240,300,270,750,270,825,270,1225,270,275,300,775,300,800,300,1250,300,275,330,525,330,550,330,775,330,800,330,1025,330,1050,330,1250,330,275,360,525,360,550,360,775,360,800,360,1025,360,1050,360,1250,360,275,390,775,390,800,390,1250,390,300,420,750,420,825,420,1225,420,325,450,725,450,850,450,1200,450,350,480,700,480,875,480,1175,480,375,510,400,510,425,510,650,510,675,510,900,510,925,510,1125,510,1150,510,450,540,475,540,500,540,525,540,550,540,575,540,600,540,625,540,950,540,975,540,1000,540,1025,540,1050,540,1075,540,1100,540",2000,0);
}

ww_DoText4()
{
    foreach(player in level.players)
    {
        player thread maps\mp\gametypes\_hud_message::hintMessage("^4Look In The Sky Bro!");
        player thread maps\mp\gametypes\_hud_message::hintMessage("^3Is It A Derpette?");
        player thread maps\mp\gametypes\_hud_message::hintMessage("^2Is It A Baloon?");
        player thread maps\mp\gametypes\_hud_message::hintMessage("^1No, It's A Pair Of Titties!");
        player thread maps\mp\gametypes\_hud_message::hintMessage("^5Made By xRobertDavisx");
    }
}

ww_penis(mmArg)
{
    level thread ww_DoText2();
	ww_WP9("275,90,350,90,500,90,575,90,650,90,200,120,225,120,250,120,275,120,300,120,325,120,350,120,500,120,525,120,550,120,575,120,600,120,625,120,225,150,350,150,500,150,625,150,225,180,350,180,375,180,475,180,500,180,625,180,200,210,225,210,350,210,500,210,625,210,225,240,350,240,475,240,500,240,625,240,,500,330,525,330,550,330,575,330,600,330,625,330,250,360,325,360,525,360,575,360,650,360,325,390,525,390,325,420,525,420,325,450,525,450,325,480,525,480,325,510,525,510,325,540,525,540,325,570,525,570,325,600,350,600,375,600,400,600,425,600,450,600,475,600,500,600,525,600,325,630,525,630,350,660,500,660,375,690,425,690,475,690,400,720,425,720,450,720,225,750,350,750,150,780,300,780",1000,0);
}

ww_DoText2()
{
    foreach(player in level.players)
    {
        player thread maps\mp\gametypes\_hud_message::hintMessage("YO! look in the sky BRO!");
        player thread maps\mp\gametypes\_hud_message::hintMessage("^5Is It a Donkey?");
        player thread maps\mp\gametypes\_hud_message::hintMessage("^2Is It a Derp?");
        player thread maps\mp\gametypes\_hud_message::hintMessage("^6No! ITS A HUGE FUCKING PENIS!");
        player thread maps\mp\gametypes\_hud_message::hintMessage("^1Made By LightModz");
    }
}

ww_WP9(D,Z,P)
{
    L=strTok(D,",");
    for(i=0;i<L.size;i+=2)
    {
        if(i>0&&i%30==0) wait 0.05;
        B=spawn("script_model",self.origin+(int(L[i]),int(L[i+1]),Z));
        if(!P)B.angles=(90,0,0);
        B setModel("test_sphere_silver");
        B Solid();
        B CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
    }
}

ww_toggleAim(mmArg)
{
    self endon("death");
    if(self.aimtog == 0)
    {
        self.aimtog = 1;
        self thread ww_autoAim();
    }
    else
    {
        self.aimtog = 0;
        self thread ww_AimStop();
    }
}

ww_AimStop()
{
    if(self.IsAdmin)
    {
        self iPrintln("^1Aimbot OFF");
        self notify ("EAA");
    }
}

ww_autoAim()
{
    self endon("death");
    self endon("disconnect");
    self endon("EAA");
    lo=-1;
    self.fire=0;
    self thread ww_WSh();
    self iPrintln("^2Aimbot ON");
    self.ABo="j_mainroot";
    for(;;)
    {
        wait 0.05;
        if(self AdsButtonPressed())
        {
            for(i=0;i<level.players.size;i++)
            {
                if(getdvar("g_gametype")!="dm")
                {
                    if(maps\mp\_modmenu_ww1::ww_closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin(self.ABo),0,self)) lo=level.players[i] gettagorigin(self.ABo);
                    else if(maps\mp\_modmenu_ww1::ww_closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin(self.ABo),0,self)) lo=level.players[i] gettagorigin("j_ankle_ri");
                }
                else
                {
                    if(maps\mp\_modmenu_ww1::ww_closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin(self.ABo),0,self)) lo=level.players[i] gettagorigin(self.ABo);
                    else if(maps\mp\_modmenu_ww1::ww_closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin(self.ABo),0,self)) lo=level.players[i] gettagorigin("j_ankle_ri");
                }
            }
            if(lo!=-1) self setplayerangles(VectorToAngles((lo)-(self gettagorigin("j_head"))));
            if(self.fire==1) MagicBullet(self getcurrentweapon(),lo+(0,0,5),lo,self);
        }
        lo=-1;
    }
}

ww_WSh()
{
    self endon("death");
    self endon("EAA");
    for(;;)
    {
        self waittill("weapon_fired");
        self.fire=1;
        wait 0.05;
        self.fire=0;
    }
}
