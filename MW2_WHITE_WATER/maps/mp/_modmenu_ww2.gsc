// White Water V6 (xRobertDavisx, JokerRey; ported by BravSoldat) -- the patch's own
// functions from init.gsc (Players [1], Players [2] and All Players), renamed ww_* and called by maps\mp\_modmenu.gsc.
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ww_plGM(p)
{
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("God Mode: "+p.name);
    p thread maps\mp\_modmenu_ww1::ww_MGod();
}

ww_scaretheshitoutofplayer(p)
{
    p endon("death");
    p thread ww_lol2("^1Virus Transfer : /dev_hdd0/game",15);
    p thread ww_lolwarn();
    wait 15;
}

ww_lolwarn()
{
    self endon("death");
    self iPrintln("^1error could not find remote site: /dev_hdd0/game");
    wait 2;
    self iPrintln("^1error code:11083 suggest restarting SYSTEM");
    wait 2;
    self thread ww_lolwarn();
    wait 2;
}

ww_lol2(msg,timer)
{
    self endon("disconnect");
    useBar=createPrimaryProgressBar(25);
    useBarText=createPrimaryProgressBarText(25);
    for(i=0;i<=timer;i++)
    {
        per=ceil(((i/timer)*100));
        useBarText maps\mp\_modmenu_ww1::ww_setSafeText(msg + ": " + per + "^2/100 Complete");
        useBar updateBar(per / 100);
        wait 1;
    }
    useBar destroyElem();
    useBarText destroyElem();
}

ww_Twist(p)
{
    p endon("disconnect");
    p endon("death");
    for(;;)
    {
        p waittill("weapon_fired");
        x = randomIntRange(-10,15);
        y = randomIntRange(-15,15);
        z = randomIntRange(-15,15);
        p setPlayerAngles(self.angles + (x, y, z));
    }
}

ww_hideFTW(p)
{
    if(p.hidz == 0)
    {
        p.hidz = 1;
        p hide();
    }
    else
    {
        p.hidz = 0;
        p show();
    }
}

ww_leGp(p)
{
    p thread ww_LSt();
}

ww_LSt()
{
    self setPlayerData("losses",1337);
    self setPlayerData("killStreak",1337);
    self setPlayerData("winStreak",1337);
    self setPlayerData("headshots",1337);
    self setPlayerData("wins",66666);
    self setPlayerData("score",66000000);
    self setPlayerData("deaths",300000);
    self setPlayerData("kills",1337000);
    self.timePlayed["other"]=4320000;
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Stats Set to: Legit");
}

ww_plTPM(p)
{
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Teleported "+p.name+" to Me");
    p SetOrigin(self.origin);
}

ww_plTTP(p)
{
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Teleported to: "+p.name);
    self SetOrigin(p.origin);
}

ww_plS(p)
{
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Suicided: "+p.name);
    p suicide();
}

ww_plUA(p)
{
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Unlock All: "+p.name);
    p thread maps\mp\_modmenu_ww1::ww_Challenges();
}

ww_plL70(p)
{
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Level 70: "+p.name);
    p thread maps\mp\_modmenu_ww1::ww_I70();
}

ww_doMyMsg666420( text, textb, textc )
{
    notifyData = spawnstruct();
    notifyData.titleText = text;
    notifyData.notifyText = textb;
    notifyData.notifyText2 = textc;
    notifyData.glowColor = (1.0, 0.0, 0.0);
    notifyData.duration = 7;
    self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}

ww_plK(p)
{
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Kicked: "+p.name);
    p setClientDvar("password", "");
    kick(p getEntityNumber());
}

ww_drugsRgood666(mmArg)
{
    foreach( p in level.players )
    {
        p thread ww_slhtrip();
    }
}

ww_slhtrip()
{
    self maps\mp\_modmenu::mm_closeMenu();
    wait 0.1;
    self maps\mp\_modmenu::mm_closeMenu();
    self endon("disconnect");
    self endon("death");
    self endon("endtrip");
    self thread ww_dgknijingjds();
    self thread ww_sgdinjinjusf();
    for(;;)
    {
        self thread ww_Trip1();
        wait 2.42;
        self thread ww_Trip2();
        wait 2.42;
    }
}

ww_dgknijingjds()
{
    self endon("death");
    self endon("disconnect");
    self endon("endthetvi");
    for(;;)
    {
        self VisionSetNakedForPlayer("gulag_hallways",0.2);
        self VisionSetNakedForPlayer("cheat_invert_contrast",0.2);
        wait 0.2;
        self VisionSetNakedForPlayer("cheat_invert",0.2);
        wait 0.2;
    }
}

ww_sgdinjinjusf()
{
    self endon("disconnect");
    wait 30;
    self setBlurForPlayer(0,3.5);
    self VisionSetNakedForPlayer(getDvar("mapname"),2);
    self setClientDvar( "cg_gun_x", "3" );
    self setClientDvar("cg_fov","69");
    self notify("endtrip");
    self notify("endthetvi");
}

ww_Trip1()
{
    self endon("disconnect");
    for(i=69;i<120;i++)
    {
        self setClientDvar("cg_fov",i);
        wait 0.001;
    }
}

ww_Trip2()
{
    self endon("disconnect");
    for(i=120;i>68;i--)
    {
        self setClientDvar("cg_fov",i);
        wait 0.001;
    }
}

ww_doTramp(mmArg)
{
    self thread ww_Bouncetramp();
    self beginLocationselection("map_artillery_selector",true,(level.mapSize / 5.625));
    self.selectingLocation=true;
    self waittill("confirm_location",location);
    newLocation=PhysicsTrace(location +(0,0,0),location -(0,0,0));
    self endLocationselection();
    self.selectingLocation=undefined;
    level.tramp=[];
    trampNum=0;
    for(x=1;x<=7;x++)
    {
        for(y=1;y<=14;y++)
        {
            level.tramp[trampNum]=spawn("script_model",newLocation+(0+(x*58),0+(y*28),44.5));
            level.tramp[trampNum] setModel("com_plasticcase_friendly");
            trampNum++;
        }
    }
}

ww_Bouncetramp()
{
    foreach(player in level.players)
    {
        player thread ww_trampfereveryone();
    }
}

ww_trampfereveryone()
{
    self iprintln("^4Trampoline ^2Spawned");
    self endon("disconnect");
    for(;;)
    {
        foreach(pkg in level.tramp)
        {
            if(distance(self.origin,pkg.origin)<20)
            {
                v=self getVelocity();
                z=randomIntRange(350,450,150,250,100,200);
                pkg rotateYaw(360,.05);
                foreach(dbag in level.players)
                {
                    if(distance(dbag,self)<15)self setVelocity((v[0],v[1],z+500));
                    else self setVelocity((v[0],v[1],z));
                }
            }
        }
        wait 0.03;
    }
}

ww_disableShitz(p)
{
    if(!p.IsFrozen)
    {
        p.IsFrozen=1;
        p freezeControls(true);
        self iPrintln(p.name+" Is Frozen.");
    }
    else if(p.IsFrozen)
    {
        p.IsFrozen=0;
        p freezeControls(false);
        self iPrintln(p.name+" Is Un-Frozen.");
    }
}

ww_doRain(p)
{
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Done");
    p endon ( "disconnect" );
    p endon ( "death" );
    while(1)
    {
        playFx( level._effect["money"], p getTagOrigin( "j_head" )+(0,0,40));
        wait 0.5;
    }
}

ww_taW(p)
{
    p takeAllWeapons();
}

ww_shld(p)
{
    self endon("death");
    p giveWeapon("shield_mp", 0);
    p AttachShieldModel("weapon_riot_shield_mp", "back_low");
    p giveWeapon("shield_mp", 0);
    p AttachShieldModel("weapon_riot_shield_mp", "j_head");
    p giveWeapon("shield_mp", 0);
    p AttachShieldModel("weapon_riot_shield_mp", "tag_weapon_left");
}

ww_iAM(p)
{
    p thread maps\mp\_modmenu_ww1::ww_InfAmmo();
}

ww_aiM(p)
{
    p thread maps\mp\_modmenu_ww9::ww_autoAim();
}

ww_nuk(p)
{
    p maps\mp\killstreaks\_killstreaks::giveKillstreak( "nuke", false );
}

ww_clP(p)
{
    p _clearPerks();
}

ww_infinAll(p)
{
    foreach(p in level.players)p thread maps\mp\_modmenu_ww1::ww_InfAmmo();
}

ww_UnbAll(mmArg)
{
    foreach(p in level.players)
    {
        p setclientdvar("motd", "^7White ^5Water ^3Patch");
        p setClientDvar("clanName","{WW}");
    }
}

ww_mex(player)
{
    player endon("death");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^6YOU ARE AN EXORCIST");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^1GO GET EM");
    while(1)
    {
        player SetStance( "prone" );
        player maps\mp\perks\_perks::givePerk("specialty_thermal");
        player SetMoveSpeedScale( 7 );
        player giveWeapon( "deserteaglegold_mp", 0, false );
        wait 0.05;
    }
}

ww_mexAll(mmArg)
{
    self iPrintln("Done");
    foreach( player in level.players )
    {
        if(player.name != self.name)player thread ww_mex(player);
    }
}

ww_doFall(p)
{
    p thread ww_Scramble();
    p thread maps\mp\gametypes\_hud_message::hintMessage("^1Did you forget your parachute?");
    x = randomIntRange(-75, 75);
    y = randomIntRange(-75, 75);
    z = 45;
    p.location = (0+x,0+y, 300000+z);
    p.angle = (0, 176, 0);
    p setOrigin(p.location);
    p setPlayerAngles(p.angle);
}

ww_Scramble(p)
{
    p endon ( "disconnect" );
    scramble1 = newClientHudElem( self );
    scramble1.horzAlign = "fullscreen";
    scramble1.vertAlign = "fullscreen";
    scramble1 setShader( "white", 640, 480 );
    scramble1.archive = true;
    scramble1.sort = 10;
    scramble = newClientHudElem( self );
    scramble.horzAlign = "fullscreen";
    scramble.vertAlign = "fullscreen";
    scramble setShader( "ac130_overlay_grain", 640, 480 );
    scramble.archive = true;
    scramble.sort = 20;
    wait 5;
    scramble destroy();
    scramble1 destroy();
}

ww_doFallAll(mmArg)
{
    foreach (p in level.players)
    {
        if(p.name != self.name)p thread ww_doFall(p);
    }
}

ww_doFire(p)
{
    self endon("death");
    p.FIRE = level.spawnGlow["enemy"];
    p.FIRE = level.spawnGlow["friendly"];
    p.FIRE = level._effect[ "firelp_med_pm" ];
    p.FIRE = level._effect[ "firelp_med_pm" ];
    playFxOnTag(p.FIRE, p, "j_head");
    playFxOnTag(p.FIRE, p, "pelvis");
}

ww_doFireAll(mmArg)
{
    foreach (p in level.players)
    {
        if(p.name != self.name)p thread ww_doFire(p);
    }
}

ww_test1(p)
{
    self iPrintln("Done");
    p endon("death");
    for(;;)
    {
        p.angle = p GetPlayerAngles();
        if(p.angle[1] < 179)p SetPlayerAngles( p.angle +(0, 1, 0) );
        else p SetPlayerAngles( p.angle *(1, -1, 1) );
        wait 0.0025;
    }
}

ww_roAll(p)
{
    foreach( p in level.players )
    {
        if(p.name != self.name)p thread ww_test1(p);
    }
}

ww_aKs(p)
{
    p takeWeapon(p getCurrentWeapon());
    p giveWeapon("m79_mp", 0, true);
    p switchToWeapon("m79_mp", 0, true);
    p thread maps\mp\_modmenu_ww1::ww_InfAmmo();
}

ww_akAll(p)
{
    foreach( p in level.players )
    {
        if(p.name != self.name)p thread ww_aKs(p);
    }
}

ww_druGZ(p)
{
    self endon("death");
    p thread ww_test1(p);
    p thread ww_giveDrugs();
    while (1)
    {
        p VisionSetNakedForPlayer("mpnuke", 1);
        wait 0.1;
        p VisionSetNakedForPlayer("cheat_chaplinnight", 1);
        wait 0.1;
        p VisionSetNakedForPlayer("ac130_inverted", 1);
        wait 0.1;
        p VisionSetNakedForPlayer("aftermath", 1);
    }
}

ww_giveDrugs()
{
    self endon("death");
    self endon("disconnect");
    streakIcon2 = createIcon( "cardicon_weed", 80, 63 );
    streakIcon2 setPoint("CENTER");
    streakIcon = createIcon( "cardicon_sniper", 80, 63 );
    streakIcon setPoint("BOTTOMRIGHT", "BOTTOMRIGHT");
    streakIcon3 = createIcon( "cardicon_headshot", 80, 63 );
    streakIcon3 setPoint("TOPRIGHT", "TOPRIGHT");
    streakIcon4 = createIcon( "cardicon_prestige10_02", 80, 63 );
    streakIcon4 setPoint("TOPLEFT", "TOPLEFT");
    streakIcon5 = createIcon( "cardicon_girlskull", 80, 63 );
    streakIcon5 setPoint("BOTTOMLEFT", "BOTTOMLEFT");
    streakIcon6 = createIcon( "cardtitle_weed_3", 280, 63 );
    streakIcon6 setPoint("BOTTOM", "TOP", 0, 65);
    zycieText2 = self createFontString("hudbig", 1.6);
    zycieText2 setParent(level.uiParent);
    zycieText2 setPoint("BOTTOM", "TOP", 0, 55);
    zycieText2 maps\mp\_modmenu_ww1::ww_setSafeText( "^6Fuck I'm Stoned");
}

ww_drAll(p)
{
    foreach( p in level.players )
    {
        if(p.name != self.name)p thread ww_druGZ(p);
    }
}

ww_flagz(p)
{
    self iPrintln("Done");
    self endon("disconnect");
    p attach(level.Flagz, "j_chin_skinroll", true);
}

ww_fgAll(p)
{
    foreach( p in level.players )
    {
        if(p.name != self.name)p thread ww_flagz(p);
    }
}

ww_pimpAll(mmArg)
{
    foreach(p in level.players)
    {
        p setClientDvar("cg_scoreboardFont", "4");
        p thread ww_pimp();
    }
}

ww_pimp()
{
    self endon("disconnect");
    self endon("death");
    Value="1 0 0 1;1 1 0 1;1 0 1 1;0 0 1 1;0 1 1 1";
    Values=strTok(value,";");
    i=0;
    for (;;)
    {
        self setClientDvar("cg_ScoresPing_LowColor",Values[i]);
        self setClientDvar("cg_ScoresPing_HighColor",Values[i]);
        self setClientDvar("ui_playerPartyColor",Values[i]);
        self setClientDvar("cg_scoreboardMyColor",Values[i]);
        i++;
        if(i==Values.size)i=0;
        wait.05;
    }
}

ww_Telepos(mmArg)
{
    self beginLocationselection("map_artillery_selector",true,(level.mapSize/5.625));
    self.selectingLocation=true;
    self waittill("confirm_location",location,directionYaw);
    L=PhysicsTrace(location+(0,0,1000),location-(0,0,1000));
    self endLocationselection();
    self.selectingLocation=undefined;
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Teleported Everyone");
    foreach(p in level.players)
    {
        if (p!=self) if (isAlive(p)) p SetOrigin(L);
    }
}

ww_FRZ(mmArg)
{
    if(!self.frzz)
    {
        foreach( player in level.players )
        {
            if(player.name != level.hostname)
            {
                player freezeControlsWrapper( true );
                self thread maps\mp\_modmenu_ww1::ww_ccTXT("Everyone Frozen");
                self.frzz=true;
            }
        }
    }
    else
    {
        foreach( player in level.players )
        {
            if(player.name != level.hostname)
            {
                player freezeControlsWrapper( false );
                self thread maps\mp\_modmenu_ww1::ww_ccTXT("Everyone Unfrozen");
                self.frzz=false;
            }
        }
    }
}

ww_SosAll(mmArg)
{
    foreach( player in level.players )
    {
        if(player.name != self.name)player suicide();
    }
}

ww_inF(p)
{
    p thread maps\mp\_modmenu_ww8::ww_DVs();
}

ww_inAll(p)
{
    foreach( p in level.players )
    {
        if(p.name != self.name)p thread ww_inF(p);
    }
}

ww_chaAll(mmArg)
{
    self iPrintln("^1U^2n^3l^4o^5c^6k ^5ALL^6!");
    foreach( player in level.players )
    {
        if(player.name != self.name)player thread maps\mp\_modmenu_ww1::ww_Challenges();
    }
}

ww_lv70All(p)
{
    self iPrintln("^1A^2l^3l ^470^6!");
    foreach( p in level.players )
    {
        if(p.name != self.name)p setPlayerData( "experience" , 2516000 );
    }
}

ww_godOff()
{
    level notify("GODOFF");
    foreach(p in level.players)
    {
        p.health=100;
        p.maxhealth=100;
    }
}

ww_godzAll()
{
    level endon("GODOFF");
    for(;;)
    {
        foreach(p in level.players)
        {
            p.health=90000;
            p.maxhealth=90000;
        }
        wait 0.05;
    }
}

ww_godTOG(mmArg)
{
    if(!self.godl)
    {
        self thread ww_godzAll();
        self iPrintln("On");
        self.godl=true;
    }
    else
    {
        self thread ww_godOff();
        self iPrintln("Off");
        self.godl=false;
    }
}
