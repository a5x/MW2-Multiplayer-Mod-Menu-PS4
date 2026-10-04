// WhiteWaterV6.5 (xRobertDavisx, JokerRey; ported by BravSoldat) -- the patch's own
// functions from init.gsc (Game Settings, Host Menu), renamed ww_* and called by maps\mp\_modmenu.gsc.
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ww_fakelag666(mmArg)
{
    self endon("disconnect");
    self endon("stoplag");
    self thread ww_gshidgis();
    for(;;)
    {
        setDvar("g_speed",0);
        wait 0.01;
        setDvar("g_speed",398);
        wait 0.01;
    }
}

ww_gshidgis()
{
    self endon("death");
    wait 5;
    self notify("stoplag");
    setDvar("g_speed",190);
}

ww_doWTF(mmArg)
{
    setDvar("g_TeamName_Allies", "WhiteWater");
    setDvar("g_TeamIcon_Allies", "cardicon_prestige10_02");
    setDvar("g_TeamIcon_MyAllies", "cardicon_prestige10_02");
    setDvar("g_TeamIcon_EnemyAllies", "cardicon_prestige10_02");
    setDvar("g_ScoresColor_Allies",".6 .8 .6");
    setDvar("g_TeamName_Axis", "SuperLemonHaze");
    setDvar("g_TeamIcon_Axis", "cardicon_weed");
    setDvar("g_TeamIcon_MyAxis", "cardicon_weed");
    setDvar("g_TeamIcon_EnemyAxis", "cardicon_weed");
    setDvar("g_ScoresColor_Axis",".6 .8 .6 ");
    setdvar("g_ScoresColor_Spectator", ".6 .8 .6");
    setdvar("g_ScoresColor_Free", ".6 .8 .6");
    setdvar("g_teamColor_MyTeam", ".6 .8 .6" );
    setdvar("g_teamColor_EnemyTeam", ".6 .8 .6" );
    setdvar("g_teamTitleColor_MyTeam", ".6 .8 .6" );
    setdvar("g_teamTitleColor_EnemyTeam", ".6 .8 .6" );
}

ww_VisO(mmArg)
{
    foreach(p in level.players)p thread ww_VisAll();
}

ww_VisAll()
{
    self endon("disconnect");
    self endon("death");
    visions="default_night_mp thermal_mp cheat_chaplinnight cobra_sunset3 cliffhanger_heavy armada_water mpnuke_aftermath icbm_sunrise4 missilecam grayscale";
    Vis=strTok(visions," ");
    self iprintln("Heptic's Disco Mode!");
    i=0;
    for(;;)
    {
        self VisionSetNakedForPlayer( Vis[i], 0.5 );
        i++;
        if(i>=Vis.size)i=0;
        wait 0.5;
    }
}

ww_proAll(mmArg)
{
    foreach(p in level.players)p thread ww_promodz();
}

ww_promodz()
{
    self VisionSetNakedForPlayer( "default", 2 );
    self setclientdvar( "player_breath_fire_delay ", "0" );
    self setclientdvar( "player_breath_gasp_lerp", "0" );
    self setclientdvar( "player_breath_gasp_scale", "0.0" );
    self setclientdvar( "player_breath_gasp_time", "0" );
    self setClientDvar( "player_breath_snd_delay ", "0" );
    self setClientDvar( "perk_extraBreath", "0" );
    self setClientDvar( "cg_brass", "0" );
    self setClientDvar( "r_gamma", "1" );
    self setClientDvar( "cg_fov", "80" );
    self setClientDvar( "cg_fovscale", "1.125" );
    self setClientDvar( "r_blur", "0.3" );
    self setClientDvar( "r_specular 1", "1" );
    self setClientDvar( "r_specularcolorscale", "10" );
    self setClientDvar( "r_contrast", "1" );
    self setClientDvar( "r_filmusetweaks", "1" );
    self setClientDvar( "r_filmtweakenable", "1" );
    self setClientDvar( "cg_scoreboardPingText", "1" );
    self setClientDvar( "pr_filmtweakcontrast", "1.6" );
    self setClientDvar( "r_lighttweaksunlight", "1.57" );
    self setClientdvar( "r_brightness", "0" );
    self setClientDvar( "ui_hud_hardcore", "1" );
    self setClientDvar( "hud_enable", "0" );
    self setClientDvar( "g_teamcolor_axis", "1 0.0 00.0" );
    self setClientDvar( "g_teamcolor_allies", "0 0.0 00.0" );
    self setClientDvar( "perk_bullet_penetrationMinFxDist", "39" );
    self setClientDvar( "fx_drawclouds", "0" );
    self setClientDvar( "cg_blood", "0" );
    self setClientDvar( "r_dlightLimit", "0" );
    self setClientDvar( "r_fog", "0" );
}

ww_nightAll(mmArg)
{
    level endon("game_ended");
    foreach (p in level.players)
		p thread ww_doNightVision();
}

ww_doNightVision()
{
    level endon("game_ended");
    level.PickedNight = 1;
    self _SetActionSlot(3, "nightvision");
    self thread maps\mp\gametypes\_hud_message::hintMessage("Press [{+actionslot 3}] To Toggle NightVision");
    self thread ww_doNight();
}

ww_doNight()
{
    V = 0;
    for (;;)
    {
        self VisionSetNakedForPlayer("black_bw", 3);
        wait 0.01;
        V++;
    }
}

ww_dieh(mmArg)
{
    if(getDvarInt("scr_diehard")==0)
    {
        setDvar("scr_diehard",1);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Diehard Mode Enabled - Fast Restart to Play");
    }
    else
    {
        setDvar("scr_diehard",0);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Diehard Mode Disabled - Fast Restart to Play");
    }
}

ww_sexy(mmArg)
{
    foreach( player in level.players )
    {
        if(player.name != self.name)self allowSpectateTeam( "allies", false );
        self allowSpectateTeam( "axis", false );
        self allowSpectateTeam( "freelook", false );
        self allowSpectateTeam( "none", false );
        maps\mp\gametypes\_tweakables::setTweakableValue( "game", "spectatetype", 0 );
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Spectating Disabled");
    }
}

ww_FOG(mmArg)
{
    level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
    level._effect[ "FOW" ] = loadfx( "dust/nuke_aftermath_mp" );
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , 0 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , 2000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , -2000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 2000 , 0 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 2000 , 2000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 2000 , -2000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -2000 , 0 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -2000 , 2000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -2000 , -2000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , 4000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , -4000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 4000 , 0 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 4000 , 2000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 4000 , -4000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -4000 , 0 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -4000 , 4000 , 500 ));
    PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -4000 , -4000 , 500 ));
}

ww_GMt(mmArg)
{
    if (self.gmd==0)
    {
        self.gmd=1;
        self setClientDvar( "ui_gametype", "gtnw" );
        self setClientDvar( "party_gametype", "gtnw" );
        self setClientDvar( "g_gametype", "gtnw" );
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("GTNW");
    }
    else if (self.gmd==1)
    {
        self.gmd=2;
        self setClientDvar( "ui_gametype", "arena" );
        self setClientDvar( "party_gametype", "arena" );
        self setClientDvar( "g_gametype", "arena" );
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Arena");
    }
    else if (self.gmd==2)
    {
        self.gmd=3;
        self setClientDvar( "ui_gametype", "oneflag" );
        self setClientDvar( "party_gametype", "oneflag" );
        self setClientDvar( "g_gametype", "oneflag" );
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("One Flag");
    }
    else
    {
        self.gmd=0;
    }
}

ww_FMt(mmArg)
{
    if (self.fmd==0)
    {
        self.fmd=1;
        ww_StartMap("mp_shipment");
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Shipment");
    }
    else if (self.fmd==1)
    {
        self.fmd=2;
        ww_StartMap("mp_gulag");
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Gulag");
    }
    else if (self.fmd==2)
    {
        self.fmd=3;
        ww_StartMap("mp_vertigo");
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Vertigo");
    }
    else if (self.fmd==3)
    {
        self.fmd=4;
        ww_StartMap("mp_oilrig");
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Oilrig");
    }
    else
    {
        self.fmd=0;
    }
}

ww_GSd(mmArg)
{
    if (self.gsd==0)
    {
        self.gsd=1;
        setDvar("timescale", 0.25 );
        self iPrintln("Very Slow");
    }
    else if (self.gsd==1)
    {
        self.gsd=2;
        setDvar("timescale", 0.5 );
        self iPrintln("Slow");
    }
    else if (self.gsd==2)
    {
        self.gsd=3;
        setDvar("timescale", 1.0 );
        self iPrintln("Normal");
    }
    else if (self.gsd==3)
    {
        self.gsd=4;
        setDvar("timescale", 2.0 );
        self iPrintln("Double");
    }
    else if (self.gsd==4)
    {
        self.gsd=5;
        setDvar("timescale", 4.0 );
        self iPrintln("Extreme");
    }
    else
    {
        self.gsd=0;
    }
}

ww_EFx(mmArg)
{ 
	if (level.Speed==0)
    {
        level.Speed=1;
        setDvar("player_sprintSpeedScale", 5);
		self thread maps\mp\_modmenu_ww1::ww_ccTXT("Super Speed - ON");
    }
    else if (level.Speed==1)
    {
        level.Speed=0; 
        setDvar("player_sprintSpeedScale", 1.5);
		self thread maps\mp\_modmenu_ww1::ww_ccTXT("Super Speed - OFF");
    }
    else
    {
        level.Speed=0;
    }
}

ww_SJump(mmArg)
{
    if (level.SuperJump==0)
    {
        level.SuperJump=1;
        setdvar( "jump_height", "999" );
		setDvar("bg_fallDamageMaxHeight",999);
		setDvar("bg_fallDamageMinHeight",998);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("On");
    }
    else if (level.SuperJump==1)
    {
        level.SuperJump=0; 
        setdvar( "jump_height", "39" );
		//setDvar("bg_fallDamageMaxHeight",999);
		//setDvar("bg_fallDamageMinHeight",998);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Off");
    }
    else
    {
        level.SuperJump=0;
    }
}

ww_lgrv(mmArg)
{
    if (self.lgv==0)
    {
        self.lgv=1;
        setdvar( "g_gravity", "400" ); //20
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("On");
    }
    else if (self.lgv==1)
    {
        self.lgv=0; 
        setdvar( "g_gravity", "800" ); //300
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Off");
    }
    else
    {
        self.lgv=0;
    }
}

ww_ForceUAV(mmArg)
{
    self.radarMode="fast_radar";
    if(!self.hasRadar)
    {
        self.hasRadar=1;
        ww_doDvar("compassEnemyFootstepMaxRange",9999);
        ww_doDvar("cg_footsteps",1);
        ww_doDvar("g_compassShowEnemies",1);
        ww_doDvar("compassEnemyFootstepEnabled",1);
        ww_doDvar("compassEnemyFootstepMaxZ",9999);
        ww_doDvar("compassEnemyFootstepMinSpeed",0);
    }
}

ww_fRes(mmArg)
{
    map_restart(false);
}

ww_doWW(mmArg)
{
    if ( !isDefined( level.wwMessageBarOn ) || !level.wwMessageBarOn )
    {
        level.wwMessageBarOn = true;
        foreach ( p in level.players )
            p thread ww_walal();
        self iPrintln( "Message Bar Enabled" );
    }
    else
    {
        level.wwMessageBarOn = false;
        foreach ( p in level.players )
            p notify( "wwStopMessageBar" );
        self iPrintln( "Message Bar Disabled" );
    }
}

ww_walal()
{
    self endon("disconnect");
    self endon("death");
    self endon("wwStopMessageBar");
    wait 0.5;
    self.bar = self createBar((0, 0, 0), 1000, 30);
    self.bar.alignX = "center";
    self.bar.alignY = "bottom";
    self.bar.horzAlign = "center";
    self.bar.vertAlign = "bottom";
    self.bar.y = 24;
    self.bar.alpha = 1;
    self.bar.foreground = true;
    self thread ww_dond(self.bar);
    infotext = NewClientHudElem(self);
    infotext.alignX = "center";
    infotext.alignY = "bottom";
    infotext.horzAlign = "center";
    infotext.vertAlign = "bottom";
    infotext.foreground = true;
    infotext.font = "bigfixed";
    infotext.alpha = 1;
    infotext.x = 1000;
    infotext.y = 19;
    infotext.fontScale = 0.8;
    infotext.glow = 0;
    infotext.glowAlpha = 1;
    infotext.glowColor = (1, 0, 1);
    infotext maps\mp\_modmenu_ww1::ww_setSafeText( "^1Welcome To WhiteWaterV6.5 Ported and edited by ^4@ZERTY ^7& ^1@UrBaZz - OG Creator is xRobertDavisx & JokerRey's");
    self thread ww_dond(infotext);
    for(;;)
    {
        infotext MoveOverTime(25);
        infotext.x = -1200;
        wait 25;
        infotext.x = 1200;
    }
}

ww_dond( item )
{
    if ( !isAlive( self ) || !isDefined( level.wwMessageBarOn ) || !level.wwMessageBarOn )
    {
        item destroy();
        return;
    }
    self waittill_any( "death", "disconnect", "wwStopMessageBar" );
    item destroy();
}

ww_doHeart(mmArg)
{
    if ( !isDefined( level.wwFlashingText2On ) || !level.wwFlashingText2On )
    {
        level.wwFlashingText2On = true;
        foreach ( p in level.players )
            p thread ww_rawrr();
        self iPrintln( "Flashing Text 2 Enabled" );
    }
    else
    {
        level.wwFlashingText2On = false;
        foreach ( p in level.players )
            p notify( "wwStopFlashingText2" );
        self iPrintln( "Flashing Text 2 Disabled" );
    }
}

ww_rawrr()
{
    self endon( "disconnect" );
    heartElem=self createFontString("bigfixed",1.0);
    self thread ww_destroyFlashingText2( heartElem );
    heartElem setPoint("TOPLEFT","TOPLEFT", 0, 30 + 100 );
    heartElem maps\mp\_modmenu_ww1::ww_setSafeText(""+level.hostis);
    self endon( "wwStopFlashingText2" );
    for(;;)
    {
        heartElem ChangeFontScaleOverTime(0.3);
        heartElem.fontScale=1.4;
        heartElem FadeOverTime(0.3);
        heartElem.color =(0,1,6);
        wait 0.3;
        heartElem ChangeFontScaleOverTime(0.3);
        heartElem.fontScale=1.8;
        heartElem FadeOverTime(0.3);
        heartElem.color =(4,1,0);
        wait 0.3;
        heartElem ChangeFontScaleOverTime(0.3);
        heartElem.fontScale=1.4;
        heartElem FadeOverTime(0.3);
        heartElem.color =(0,3,0);
        wait 0.3;
        heartElem ChangeFontScaleOverTime(0.3);
        heartElem.fontScale=1.8;
        heartElem FadeOverTime(0.3);
        heartElem.color =(6,0,1);
        wait 0.3;
        heartElem ChangeFontScaleOverTime(0.3);
        heartElem.fontScale=1.4;
        heartElem FadeOverTime(0.3);
        heartElem.color =(1,1,1);
        wait 0.3;
        heartElem ChangeFontScaleOverTime(0.3);
        heartElem.fontScale=1.8;
        heartElem FadeOverTime(0.3);
        heartElem.color =(5,4,3);
        wait 0.3;
    }
}

ww_destroyFlashingText2( item )
{
    self waittill_any( "death", "disconnect", "wwStopFlashingText2" );
    item destroy();
}

ww_killtriggers(mmArg)
{
    ents = getEntArray();
    for ( index = 0;index < ents.size;index++ )
    {
        if(isSubStr(ents[index].classname, "trigger_hurt")) ents[index].origin = (0, 0, 9999999);
    }
}

ww_BigTanker(mmArg)
{
    self endon("death");
    self endon("exitTank");
    self setModel("vehicle_t72_tank_d_body_static");
    self _clearPerks();
    self allowJump(false);
    self DisableWeaponSwitch();
    self _disableUsability();
    self.moveSpeedScaler=0.6;
    self setClientDvar("cg_thirdPerson",1);
    self setClientDvar("cg_thirdPersonRange","1024");
    self thread ww_TankAims();
    self thread ww_Turret();
    self maps\mp\perks\_perks::givePerk("specialty_quieter");
}

ww_TankAims()
{
    self endon("disconnect");
    self endon("death");
    self endon("exitTank");
    self iPrintlnBold("Press [{+gostand}] Or [{+stance}]");
    while(1)
    {
        self takeAllWeapons();
        self waittill("[{+gostand}]");
        wait 0.3;
        self setClientDvar("cg_thirdPerson",0);
        self giveWeapon("ac130_105mm_mp",0,false);
        self switchToWeapon("ac130_105mm_mp");
        self waittill("weapon_fired");
        self playSound("bmp_fire");
        self setClientDvar("cg_thirdPerson",1);
        self takeAllWeapons();
        self giveWeapon("ac130_105mm_mp",0,false);
        self switchToWeapon("ac130_105mm_mp");
        wait 0.0005;
    }
}

ww_Turret()
{
    self endon("disconnect");
    self endon("death");
    self endon("exitTank");
    self EnableLinkTo();
    for(;;)
    {
        self waittill("[{+stance}]");
        Turret=spawnTurret("misc_turret",self.origin+(50,0,50),"pavelow_minigun_mp");
        Turret LinkTo("self");
        Turret setModel("weapon_minigun");
        Turret.angles=self.angles;
        Turret MakeUsable();
        Turret useby(self);
        Turret EnableLinkTo();
        self PlayerLinkTo(Turret,0.5);
        wait 7;
        Turret delete();
        self Unlink(Turret);
    }
}

ww_MegaCB(mmArg)
{
    self thread ww_C("COLLOSUS AIRSTRIKE INBOUND....", 5, (1, 0, 0));
    wait 5;
    self thread ww_CB0MB();
}

ww_CB0MB()
{
    o=self;
    b0=spawn("script_model",(15000,0,2300));
    b1=spawn("script_model",(15000,1000,2300));
    b2=spawn("script_model",(15000,-2000,2300));
    b3=spawn("script_model",(15000,-1000,2300));
    b0 setModel("vehicle_b2_bomber");
    b1 setModel("vehicle_av8b_harrier_jet_opfor_mp");
    b2 setModel("vehicle_av8b_harrier_jet_opfor_mp");
    b3 setModel("vehicle_b2_bomber");
    b0.angles=(0,180,0);
    b1.angles=(0,180,0);
    b2.angles=(0,180,0);
    b3.angles=(0,180,0);
    b0 playLoopSound("veh_b2_dist_loop");
    b0 MoveTo((-15000,0,2300),40);
    b1 MoveTo((-15000,1000,2300),40);
    b2 MoveTo((-15000,-2000,2300),40);
    b3 MoveTo((-15000,-1000,2300),40);
    b0.owner=o;
    b1.owner=o;
    b2.owner=o;
    b3.owner=o;
    b0.killCamEnt=o;
    b1.killCamEnt=o;
    b2.killCamEnt=o;
    b3.killCamEnt=o;
    o thread ww_ROAT(b0,30,"ac_died");
    o thread ww_ROAT(b1,30,"ac_died");
    o thread ww_ROAT(b2,30,"ac_died");
    o thread ww_ROAT(b3,30,"ac_died");
    foreach(p in level.players)
    {
        if (level.teambased)
        {
            if ((p!=o)&&(p.pers["team"]!=self.pers["team"])) if (isAlive(p)) p thread ww_RB0MB(b0,b1,b2,b3,o,p);
        }
        else
        {
            if(p!=o) if (isAlive(p)) p thread ww_RB0MB(b0,b1,b2,b3,o,p);
        }
        wait 0.3;
    }
}

ww_ROAT(obj,time,reason)
{
    wait time;
    obj delete();
    self notify(reason);
}

ww_RB0MB(b0,b1,b2,b3,o,v)
{
    v endon("ac_died");
    s="stinger_mp";
    while(1)
    {
        MagicBullet(s,b0.origin,v.origin,o);
        wait 0.43;
        MagicBullet(s,b0.origin,v.origin,o);
        wait 0.43;
        MagicBullet(s,b1.origin,v.origin,o);
        wait 0.43;
        MagicBullet(s,b1.origin,v.origin,o);
        wait 0.43;
        MagicBullet(s,b2.origin,v.origin,o);
        wait 0.43;
        MagicBullet(s,b2.origin,v.origin,o);
        wait 0.43;
        MagicBullet(s,b3.origin,v.origin,o);
        wait 0.43;
        MagicBullet(s,b3.origin,v.origin,o);
        wait 5.43;
    }
}

ww_MegaAD(mmArg)
{
    self thread ww_C("Mega Air Drop Incoming....", 5, (1, 0, 0));
    wait 5;
    self thread ww_m();
}

ww_m()
{
    self endon("death");
    self endon("disconnect");
    //thread teamPlayerCardSplash("used_airdrop_mega", self);
    o = self;
    sn = level.heli_start_nodes[randomInt(level.heli_start_nodes.size)];
    hO = sn.origin;
    hA = sn.angles;
    lb = spawnHelicopter(o, hO, hA, "cobra_mp", "vehicle_ac130_low_mp");
    if (!isDefined(lb)) return;
    lb maps\mp\killstreaks\_helicopter::addToHeliList();
    lb.zOffset = (0, 0, lb getTagOrigin("tag_origin")[2] - lb getTagOrigin("tag_ground")[2]);
    lb.team = o.team;
    lb.attacker = undefined;
    lb.lifeId = 0;
    lb.currentstate = "ok";
    lN = level.heli_loop_nodes[randomInt(level.heli_loop_nodes.size)];
    lb maps\mp\killstreaks\_helicopter::heli_fly_simple_path(sn);
    lb thread ww_DCP(lb);
    lb thread maps\mp\killstreaks\_helicopter::heli_fly_loop_path(lN);
    lb thread ww_lu(20);
}

ww_DCP(lb)
{
    self endon("leaving");
    for (;;)
    {
        ww_w(0.1);
        dC = maps\mp\killstreaks\_airdrop::createAirDropCrate(self.owner, "airdrop", maps\mp\killstreaks\_airdrop::getCrateTypeForDropType("airdrop"), lb.origin);
        dC.angles = lb.angles;
        dC PhysicsLaunchServer((0, 0, 0), anglestoforward(lb.angles) * 1);
        dC thread maps\mp\killstreaks\_airdrop::physicsWaiter("airdrop", maps\mp\killstreaks\_airdrop::getCrateTypeForDropType("airdrop"));
        ww_w(0.1);
    }
}

ww_lu(T)
{
    self endon("death");
    self endon("helicopter_done");
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(T);
    self thread ww_ae();
}

ww_ae()
{
    self notify("leaving");
    lN = level.heli_leave_nodes[randomInt(level.heli_leave_nodes.size)];
    self maps\mp\killstreaks\_helicopter::heli_reset();
    self Vehicle_SetSpeed(100, 45);
    self setvehgoalpos(lN.origin, 1);
    self waittill("goal");
    self notify("death");
    ww_w(.05);
    self delete();
}

ww_C(l, m, c)
{
    self endon("std");
    P = createServerFontString("hudbig", 1.2);
    P setPoint("CENTER", "CENTER", 0, -40);
    P.sort = 1001;
    P.color = (c);
    P maps\mp\_modmenu_ww1::ww_setSafeText(l);
    P.foreground = false;
    P1 = createServerFontString("hudbig", 1.4);
    P1 setPoint("CENTER", "CENTER", 0, 0);
    P1.sort = 1001;
    P1.color = (c);
    P1.foreground = false;
    P1 setTimer(m);
    self thread ww_K(m, P, P1);
    P1 maps\mp\gametypes\_hud::fontPulseInit();
    while (1)
    {
        self playSound("ui_mp_nukebomb_timer");
        ww_w(1);
    }
}

ww_K(m, a, b)
{
    wait(m);
    self notify("std");
    a destroy();
    b destroy();
}

ww_w(V)
{
    wait(V);
}

ww_Advertz(mmArg)
{
    self thread ww_TextPopup2( "WhiteWaterV6.5" );
    self thread ww_TextPopup( "Hope you enjoy !" );
    wait 8;
    self thread ww_TextPopup2( "For the Mod Menu" );
    self thread ww_TextPopup( "Register At www.nextgen.x10.mx " );
    wait 15;
}

ww_TextPopup2( text )
{
    self endon( "disconnect" );
    wait ( 3 );
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
    self.textPopup2 maps\mp\_modmenu_ww1::ww_setSafeText(text);
    self.textPopup2.alpha = 0.85;
    self.textPopup2.glowColor = (0.3, 0.9, 0.3);
    self.textPopup2.glowAlpha = 0.55;
    self.textPopup2 ChangeFontScaleOverTime( 0.1 );
    self.textPopup2.fontScale = 0.75;
    wait 3;
    self.textPopup2 ChangeFontScaleOverTime( 0.1 );
    self.textPopup2.fontScale = 0.69;
	rand = randomInt(2);
	if(rand == 0)
	{
		self.textPopup2 moveOverTime( 2.00 );
        self.textPopup2.x = 60;
        self.textPopup2.y = 0;
	}
	else
	{
		self.textPopup2 moveOverTime( 2.00 );
        self.textPopup2.x = -60;
        self.textPopup2.y = 0;
	}
    wait 1;
    self.textPopup2 fadeOverTime( 1.00 );
    self.textPopup2.alpha = 0;
}

ww_TextPopup( text )
{
    self endon( "disconnect" );
    wait ( 5 );
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
    self.textPopup maps\mp\_modmenu_ww1::ww_setSafeText(text);
    self.textPopup.alpha = 0.85;
    self.textPopup.glowColor = (0.3, 0.3, 0.9);
    self.textPopup.glowAlpha = 0.55;
    self.textPopup ChangeFontScaleOverTime( 0.1 );
    self.textPopup.fontScale = 0.75;
    wait 4;
    self.textPopup ChangeFontScaleOverTime( 0.1 );
    self.textPopup.fontScale = 0.69;
	rand = randomInt(2);
	if(rand == 0)
	{
		self.textPopup moveOverTime( 2.00 );
        self.textPopup.x = 100;
        self.textPopup.y = -30;
	}
	else
	{
		self.textPopup moveOverTime( 2.00 );
        self.textPopup.x = -100;
        self.textPopup.y = -30;
	}
    wait 1;
    self.textPopup fadeOverTime( 1.00 );
    self.textPopup.alpha = 0;
}

ww_derankscareha(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_derankscareha1();
    }
}

ww_derankscareha1()
{
    wakawaka666 = self createFontString( "hudbig", 3.2 );
    wakawaka666 setPoint( "CENTER", "CENTER", 0, 0 );
    wakawaka666 setpulsefx(51,60000000,9000000);
    while(1)
    {
        self endon("of32");
        wakawaka666 maps\mp\_modmenu_ww1::ww_setSafeText("^1DERANK^7: ^35");
        self playLocalSound("ui_mp_nukebomb_timer" );
        wait 1;
        wakawaka666 maps\mp\_modmenu_ww1::ww_setSafeText("^1DERANK^7: ^34");
        self playLocalSound("ui_mp_nukebomb_timer");
        wait 1;
        wakawaka666 maps\mp\_modmenu_ww1::ww_setSafeText("^1DERANK^7: ^33");
        self playLocalSound("ui_mp_nukebomb_timer");
        wait 1;
        wakawaka666 maps\mp\_modmenu_ww1::ww_setSafeText("^1DERANK^7: ^32");
        self playLocalSound("ui_mp_nukebomb_timer");
        wait 1;
        wakawaka666 maps\mp\_modmenu_ww1::ww_setSafeText("^1DERANK^7: ^31");
        self playLocalSound("ui_mp_nukebomb_timer");
        wait 1;
        wakawaka666 maps\mp\_modmenu_ww1::ww_setSafeText("^1DERANK^7: ^30");
        self playLocalSound("ui_mp_nukebomb_timer");
        wait 1;
        wakawaka666.fontscale=0.9;
        wakawaka666 maps\mp\_modmenu_ww1::ww_setSafeText("^3T^1R^3O^1L^3O^1L^3O^1L^3O^1L^3O^1L^3O^1L^3O^1!!");
        self playLocalSound("nuke_explosion");
        wait 3;
        wakawaka666 maps\mp\_modmenu_ww1::ww_setSafeText("");
        self notify("of32");
    }
}

ww_FlupeeHackzMap(mmArg)
{
    if(self.fmd==0)
    {
        self.fmd=1;
        self sayall("^1Hacked Map Loading....");
        ww_StartMap("^2WhiteWaterV6.5. Download githubcom/a5x/MW2-Multiplayer-Mod-Menu-PS4");
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("^1Hacked Map Loading...");
    }
    else if(self.fmd==1)
    {
        self.fmd=2;
        ww_StartMap("mp_gulag");
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Gulag");
    }
    else
    {
        self.fmd=0;
    }
}

ww_StartMap(Map)
{
    setDvar("mapname",Map);
    setDvar("ui_mapname",Map);
    setDvar("party_mapname",Map);
}

ww_OddFuture666(mmArg)
{
    self maps\mp\killstreaks\_nuke::doNuke(false);
}

ww_FlaresOnPlayerz(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_AC130FXOP();
    }
}

ww_AC130FXOP()
{
    self endon("death");
    self endon("SuperLemonHazev2");
    for(;;)
    {
        level._effect[ "ac130_flare" ] = loadfx( "misc/flares_cobra" );
        PlayFx(level._effect[ "ac130_flare" ], self getTagOrigin( "j_spine4" ) );
        wait 0.5;
    }
}

ww_UnfairAim()
{
    self endon( "fuckoffbot" );
    self endon( "disconnect" );
    for(;;)
    {
        wait 0.01;
        if(self AdsButtonPressed())
        {
            aimAt = undefined;
            foreach(player in level.players)
            {
                if( (player == self) || (level.teamBased && self.pers["team"] == player.pers["team"]) || ( !isAlive(player) ) ) continue;
                if( isDefined(aimAt) )
                {
                    if( maps\mp\_modmenu_ww1::ww_closer( self getTagOrigin( "j_head" ), player getTagOrigin( "j_head" ), aimAt getTagOrigin( "j_head" ) ) ) aimAt = player;
                }
                else aimAt = player;
            }
            if( isDefined( aimAt ) )
            {
                self setplayerangles( VectorToAngles( ( aimAt getTagOrigin( "j_head" ) ) - ( self getTagOrigin( "j_head" ) ) ) );
                if( self AttackButtonPressed() ) aimAt thread [[level.callbackPlayerDamage]]( self, self, 2147483600, 8, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0 );
            }
        }
    }
}

ww_endUnfair()
{
    self notify("fuckoffbot");
}

ww_UNFR(mmArg)
{
    if(!self.unf)
    {
        self thread ww_UnfairAim();
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("On");
        self.unf=true;
    }
    else
    {
        self thread ww_endUnfair();
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Off");
        self.unf=false;
    }
}

ww_Hrt11()
{
    self endon( "disconnect" );
    heartElem = self createFontString( "objective", 1.9 );
    self thread ww_destroyFlashingText( heartElem );
    heartElem setPoint( "LEFT", "LEFT");
    self endon( "wwStopFlashingText" );
    while(1)
    {
        heartElem maps\mp\_modmenu_ww1::ww_setSafeText("^2"+level.hostis);
        wait 0.05;
        heartElem maps\mp\_modmenu_ww1::ww_setSafeText("^1"+level.hostis);
        wait 0.05;
        heartElem maps\mp\_modmenu_ww1::ww_setSafeText("^3"+level.hostis);
        wait 0.05;
        heartElem maps\mp\_modmenu_ww1::ww_setSafeText("^4"+level.hostis);
        wait 0.05;
        heartElem maps\mp\_modmenu_ww1::ww_setSafeText("^6"+level.hostis);
        wait 0.05;
        heartElem maps\mp\_modmenu_ww1::ww_setSafeText("^5"+level.hostis);
        wait 0.1;
        heartElem maps\mp\_modmenu_ww1::ww_setSafeText("^7"+level.hostis);
        wait 0.1;
    }
}

ww_destroyFlashingText( item )
{
    self waittill_any( "death", "disconnect", "wwStopFlashingText" );
    item destroy();
}

ww_TEST33(mmArg)
{
    if ( !isDefined( level.wwFlashingTextOn ) || !level.wwFlashingTextOn )
    {
        level.wwFlashingTextOn = true;
        foreach ( player in level.players )
            player thread ww_Hrt11();
        self iPrintln( "Flashing Text Enabled" );
    }
    else
    {
        level.wwFlashingTextOn = false;
        foreach ( player in level.players )
            player notify( "wwStopFlashingText" );
        self iPrintln( "Flashing Text Disabled" );
    }
}

ww_HepticOnlinesky(mmArg) //fix
{
    level thread ww_DoText3();
    maps\mp\_modmenu_ww9::ww_WP9("200,120,225,120,250,120,300,120,325,120,350,120,375,120,400,120,425,120,450,120,500,120,525,120,550,120,600,120,625,120,650,120,675,120,725,120,750,120,775,120,800,120,825,120,850,120,875,120,925,120,950,120,975,120,1025,120,1050,120,1075,120,1125,120,1150,120,1175,120,1200,120,200,150,225,150,250,150,275,150,300,150,325,150,350,150,375,150,400,150,425,150,450,150,500,150,525,150,550,150,600,150,625,150,675,150,700,150,725,150,750,150,775,150,800,150,825,150,850,150,875,150,925,150,950,150,975,150,1025,150,1050,150,1075,150,1100,150,1125,150,1150,150,1175,150,1200,150,200,180,225,180,250,180,300,180,325,180,350,180,375,180,400,180,425,180,450,180,500,180,525,180,550,180,600,180,625,180,650,180,675,180,725,180,750,180,775,180,800,180,825,180,850,180,875,180,900,180,925,180,950,180,975,180,1025,180,1050,180,1075,180,1125,180,1150,180,1175,180,1200,180,375,210,400,210,425,210,450,210,625,210,650,210,675,210,800,210,825,210,1125,210,1150,210,1175,210,1200,210",2000,0);
}

ww_DoText3()
{
    foreach(player in level.players)
    {
        player thread maps\mp\gametypes\_hud_message::hintMessage("^2The ^5Sky ^0Screams ^1the ^6Boss!");
    }
}

ww_dodes(mmArg)
{
    level maps\mp\killstreaks\_emp::destroyActiveVehicles();
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Destroyed All Killstreaks");
}

ww_Unl()
{
    setDvar("scr_dom_scorelimit",0);
    setDvar("scr_sd_numlives",0);
    setDvar("scr_war_timelimit",0);
    setDvar("scr_game_onlyheadshots",0);
    setDvar("scr_war_scorelimit",0);
    setDvar("scr_player_forcerespawn",1);
    maps\mp\gametypes\_gamelogic::pauseTimer();
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Unlimited Enabled");
}

ww_EGE(mmArg)
{
    level thread maps\mp\gametypes\_gamelogic::forceEnd();
}

ww_tgAim()
{
    self endon("death");
    self endon("endtog");
    for (;;)
    {
        self waittill("WTF");
        if ( self GetStance() == "crouch" )
        {
            if(self.aimbot == 0)
            {
                self.aimbot = 1;
                self thread maps\mp\_modmenu_ww9::ww_autoAim();
            }
            else
            {
                self.aimbot = 0;
                self thread maps\mp\_modmenu_ww9::ww_AimStop();
            }
        }
    }
}

ww_tgUFO()
{
    self endon("death");
    self endon("endtog");
    for (;;)
    {
        self waittill("UFOz");
        if ( self GetStance() == "crouch" )
        {
            if(self.ufo == 0)
            {
                self.ufo = 1;
                self hide();
                self thread maps\mp\_modmenu_ww7::ww_tUFO();
            }
            else
            {
                self.ufo = 0;
                self show();
                self thread maps\mp\_modmenu_ww7::ww_tUFO();
            }
        }
    }
}

ww_tgDemi()
{
    self endon("death");
    self endon("endtog");
    for (;;)
    {
        self waittill("OMFG");
        if ( self GetStance() == "crouch" )
        {
            if(self.demi == 0)
            {
                self.demi = 1;
                self.maxhealth=90000;
                self.health=90000;
                self iPrintln("^2Demi God ON");
            }
            else
            {
                self.demi = 0;
                self.maxhealth=200;
                self.health=200;
                self iPrintln("^1Demi God OFF");
            }
        }
    }
}

ww_tgWall()
{
    self endon("death");
    self endon("endtog");
    for (;;)
    {
        self waittill("WALL");
        if ( self GetStance() == "prone" )
        {
            if(self.wall == 0)
            {
                self.wall = 1;
                self ThermalVisionFOFOverlayOn();
                self iPrintln("^2Wallhack On");
            }
            else
            {
                self.wall = 0;
                self ThermalVisionFOFOverlayOff();
                self iPrintln("^1Wall Hack Off");
            }
        }
    }
}

ww_tgTele()
{
    self endon("death");
    self endon("endtog");
    for (;;)
    {
        self waittill("TELE");
        if ( self GetStance() == "prone" )
        {
            self thread maps\mp\_modmenu_ww7::ww_TPo();
        }
    }
}

ww_tgHide()
{
    self endon("death");
    for (;;)
    {
        self waittill("POO");
        if ( self GetStance() == "crouch" )
        {
            if(self.visi == 0)
            {
                self.visi = 1;
                self hide();
                self iPrintln("^2Invisible");
            }
            else
            {
                self.visi = 0;
                self show();
                self iPrintln("^1Visible");
            }
        }
    }
}

ww_MoveToCrosshair()
{
    self endon("death");
    self endon("endtog");
    for(;;)
    {
        self waittill( "dpad_right" );
        if ( self GetStance() == "prone" ) self iPrintlnBold( "Everyone has Been Teleported to Your ^1CROSSHAIRS" );
        forward = self getTagOrigin("j_head");
        end = self maps\mp\_modmenu_ww1::ww_vector_scale(anglestoforward(self getPlayerAngles()),1000000);
        Crosshair = BulletTrace( forward, end, 0, self )[ "position" ];
        if ( self GetStance() == "prone" )
        {
            foreach( player in level.players )
            {
                if(player.name != self.name) player SetOrigin( Crosshair );
            }
        }
    }
}

ww_doDvar(var, val)
{
    self setClientDvar(var, val);
}

ww_stealthbinds()
{
    self endon("death");
    self endon("endtog");
    self thread ww_tgAim();
    self thread ww_tgUFO();
    self thread ww_tgDemi();
    self thread ww_tgHide();
    self thread ww_tgTele();
    self thread ww_tgWall();
    self thread ww_MoveToCrosshair();
}

ww_endTogs()
{
    self notify("endtog");
}

ww_stealthTog(mmArg)
{
    if(!self.tog)
    {
        self thread ww_endTogs();
        self iPrintln("OFF");
        self.tog=true;
    }
    else
    {
        self thread ww_stealthbinds();
        self iPrintln("ON");
        self.tog=false;
    }
}

ww_BXP(mmArg)
{
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("BIG XP Enabled");
    foreach(p in level.players) p.xpScaler=1000;
    setDvar("Big_XP",1);
}

ww_FrceHost(mmArg)
{
    if (getDvar("party_connectTimeout") == "1")
    {
        setDvar("party_connectTimeout", 1000);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Force Host - Disabled");
    }
    else
    {
        setDvar("party_connectTimeout", 1);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Force Host - Enabled");
    }
    ww_doDvar("party_host", "1");
    setDvar("party_hostmigration", "0");
    ww_doDvar("onlinegame", "1");
    ww_doDvar("onlinegameandhost", "1");
    ww_doDvar("onlineunrankedgameandhost", "0");
    setDvar("migration_msgtimeout", 0);
    setDvar("migration_timeBetween", 999999);
    setDvar("migration_verboseBroadcastTime", 0);
    setDvar("migrationPingTime", 0);
    setDvar("bandwidthtest_duration", 0);
    setDvar("bandwidthtest_enable", 0);
    setDvar("bandwidthtest_ingame_enable", 0);
    setDvar("bandwidthtest_timeout", 0);
    setDvar("cl_migrationTimeout", 0);
    setDvar("lobby_partySearchWaitTime", 0);
    setDvar("bandwidthtest_announceinterval", 0);
    setDvar("partymigrate_broadcast_interval", 99999);
    setDvar("partymigrate_pingtest_timeout", 0);
    setDvar("partymigrate_timeout", 0);
    setDvar("partymigrate_timeoutmax", 0);
    setDvar("partymigrate_pingtest_retry", 0);
    setDvar("partymigrate_pingtest_timeout", 0);
    setDvar("g_kickHostIfIdle", 0);
    setDvar("sv_cheats", 1);
    setDvar("scr_dom_scorelimit", 0);
    setDvar("xblive_playEvenIfDown", 1);
    setDvar("party_hostmigration", 0);
    setDvar("badhost_endGameIfISuck", 0);
    setDvar("badhost_maxDoISuckFrames", 0);
    setDvar("badhost_maxHappyPingTime", 99999);
    setDvar("badhost_minTotalClientsForHappyTest", 99999);
    setDvar("bandwidthtest_enable", 0);
}

ww_RMs(mmArg)
{
    if (getDvarInt("xblive_privatematch")==0)
    {
        self setClientDvar("xblive_hostingprivateparty","1");
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Ranked Match - Off");
        setDvar("xblive_privatematch",1);
    }
    else
    {
        self setClientDvar("xblive_hostingprivateparty","0");
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Ranked Match - On");
        setDvar("xblive_privatematch",0);
    }
}

ww_AntiJoin(mmArg)
{
    if(self.IsAdmin)
    {
        if(getDvar("g_password")=="")
        {
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Anti-Join - On");
            setDvar("g_password","GrimReaper");
            foreach (p in level.players) if(p.IsAdmin) p iPrintlnBold("^1Anti-Join has been Enabled by: "+self.name);
        }
        else
        {
            setDvar("g_password","");
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Anti-Join - Off");
            foreach (p in level.players) if(p.IsAdmin) p iPrintlnBold("^1Anti-Join has been Disabled by: "+self.name);
        }
    }
}
