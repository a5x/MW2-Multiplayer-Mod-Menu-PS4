// WhiteWaterV6.5 (xRobertDavisx, JokerRey; ported by BravSoldat) -- the patch's own
// functions from init.gsc (Prestige & Stats, Infection Menu, Message Menu), renamed ww_* and called by maps\mp\_modmenu.gsc.
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ww_iCmdx(cx,i)
{
    notifyData=spawnstruct();
    notifyData.notifyText=""+cx;
    notifyData.notifyText2=""+i;
    notifyData.glowColor =(0.0,0.0,1.0);
    notifyData.duration=5;
    notifyData.font="DAStacks";
    self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}

ww_cxm1(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","^2WhiteWaterV6.5!");
    }
}

ww_cxm2(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","^7Yes");
    }
}

ww_cxm3(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","^1No");
    }
}

ww_cxm4(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","^7Maybe...");
    }
}

ww_cxm5(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","^7No Problem");
    }
}

ww_cxm6(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","^7Are You Gay?");
    }
}

ww_cxm7(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","^7Wanna Get Deranked?");
    }
}

ww_cxm8(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","^7Okay");
    }
}

ww_cxm9(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","^7STOP ASKING FOR ADMIN!");
    }
}

ww_cxm10(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","^7"+level.hostis+" Is God!");
    }
}

ww_cxm12(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","^1Back Out NOW!!");
    }
}

ww_cxm13(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","^7Who the fuck is hacking?");
    }
}

ww_cxm14(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","^7Shut the fuck up!");
    }
}

ww_cxm15(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","This Is ^9WhiteWaterV6.5 <3");
    }
}

ww_cxm20(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","Stop Shooting & Killing!");
    }
}

ww_cxm21(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","Please Donate: jokerreyhd@gmail.com");
    }
}

ww_cxm22(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","PlayStation ^1FTW");
    }
}

ww_cxm23(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","Did I Rustle Your Jimmies?");
    }
}

ww_cxm24(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","Fuck You!!");
    }
}

ww_cxm25(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","You're A Cunt. You Cunt.. Cunt.");
    }
}

ww_cxm26(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","Sign Up At: www.nextgen.x10.mx");
    }
}

ww_cxm27(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","Thanks 01cedric for this port !");
    }
}

ww_cxm28(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","Fuck Israel");
    }
}

ww_cxm29(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","Free Palestine");
    }
}

ww_cxm30(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_iCmdx("^0"+self.name+"^7:","PS4 Port Menu By @ZERTY & @UrBaZz");
    }
}

ww_doStats(pick)
{
	if(pick == "Reset Stats")
	{
		self ww_setStats(0,0,0,0,0,0,0,0,0,0,0,0);
        self.timePlayed["other"] = (-1)*(self getPlayerData( "timePlayedTotal"));
        self iPrintln( "Stats Reset" );
	}
	else if(pick == "Legit Stats")
	{
		self ww_setStats(1000,133337,200000,1000,5000,1250,100,50,160000,1337,0,-1);
        self iPrintln( "Legit Stats Set" );
	}
	else if(pick == "Moderate Stats")
	{
		self ww_setStats(0,21474800,21470000,21474800,21474800,21474800,1337,1337,2147483647,1337,0,-10);
        self iPrintln( "Moderate Stats Set" );
	}
	else if(pick == "Insane Stats")
	{
		self ww_setStats(0,2147480000,2147000000,2147480000,2147480000,2147480000,1337,1337,2147483647,1337,0,-10);
        self iPrintln( "Insane Stats Set" );
	}
}

ww_setStats(deaths, kills, score, assists, headshots, wins, winStreak, killStreak, accuracy, hits, misses, losses)
{
    self setPlayerData( "deaths" , deaths );
    self setPlayerData( "kills" , kills );
    self setPlayerData( "score" , score );
    self setPlayerData( "assists" , assists );
    self setPlayerData( "headshots" , headshots );
    self setPlayerData( "wins" , wins );
    self setPlayerData( "winStreak" , winStreak );
    self setPlayerData( "killStreak" , killStreak );
    self setPlayerData( "accuracy" , accuracy );
    self setPlayerData( "hits" , hits );
    self setPlayerData( "misses" , misses );
    self setPlayerData( "losses" , losses );
}

ww_lawll2(mmArg)
{
    self iprintln("^1This Isnt An Option Retard!");
}

ww_I702(mmArg)
{
    self maps\mp\_modmenu_ww1::ww_SetPrestige(0);
}

ww_doPrestige300(mmArg)
{
    self maps\mp\_modmenu_ww1::ww_SetPrestige(11);
}

ww_shotguncl(mmArg)
{
    self setPlayerData( "customClasses", 0, "weaponSetups", 1, "weapon", "m1014" );
    self setPlayerData( "customClasses", 0, "weaponSetups", 1, "camo", "orange_fall" );
    self setPlayerData( "customClasses", 1, "weaponSetups", 1, "weapon", "m1014" );
    self setPlayerData( "customClasses", 1, "weaponSetups", 1, "camo", "red_tiger" );
    self setPlayerData( "customClasses", 2, "weaponSetups", 1, "weapon", "m1014" );
    self setPlayerData( "customClasses", 2, "weaponSetups", 1, "camo", "blue_tiger" );
    self setPlayerData( "customClasses", 3, "weaponSetups", 1, "weapon", "aa12" );
    self setPlayerData( "customClasses", 3, "weaponSetups", 1, "camo", "orange_fall" );
    self setPlayerData( "customClasses", 4, "weaponSetups", 1, "weapon", "aa12" );
    self setPlayerData( "customClasses", 4, "weaponSetups", 1, "camo", "red_tiger" );
    self setPlayerData( "customClasses", 5, "weaponSetups", 1, "weapon", "aa12" );
    self setPlayerData( "customClasses", 5, "weaponSetups", 1, "camo", "blue_tiger" );
    self setPlayerData( "customClasses", 6, "weaponSetups", 1, "weapon", "spas12" );
    self setPlayerData( "customClasses", 6, "weaponSetups", 1, "camo", "orange_fall" );
    self setPlayerData( "customClasses", 7, "weaponSetups", 1, "weapon", "spas12" );
    self setPlayerData( "customClasses", 7, "weaponSetups", 1, "camo", "red_tiger" );
    self setPlayerData( "customClasses", 8, "weaponSetups", 1, "weapon", "spas12" );
    self setPlayerData( "customClasses", 8, "weaponSetups", 1, "camo", "blue_tiger" );
    self iPrintln( "^3Shotgun Camo Classes Set!" );
}

ww_GoldDeagleClasses(mmArg)
{
    self setPlayerData( "customClasses", 0, "specialGrenade", "deserteaglegold" );
    self setPlayerData( "customClasses", 1, "specialGrenade", "deserteaglegold" );
    self setPlayerData( "customClasses", 2, "specialGrenade", "deserteaglegold" );
    self setPlayerData( "customClasses", 3, "specialGrenade", "deserteaglegold" );
    self setPlayerData( "customClasses", 4, "specialGrenade", "deserteaglegold" );
    self setPlayerData( "customClasses", 5, "specialGrenade", "deserteaglegold" );
    self setPlayerData( "customClasses", 6, "specialGrenade", "deserteaglegold" );
    self setPlayerData( "customClasses", 7, "specialGrenade", "deserteaglegold" );
    self setPlayerData( "customClasses", 8, "specialGrenade", "deserteaglegold" );
    self setPlayerData( "customClasses", 9, "specialGrenade", "deserteaglegold" );
    self iPrintln( "^3Gold Deagle Classes Set!" );
}

ww_BoostXP(mmArg)
{
    self setClientDvar( "scr_game_suicidepointloss", 1 );
    self setClientDvar( "scr_game_deathpointloss", 1 );
    self setClientDvar( "scr_team_teamkillpointloss", 1 );
    self setClientDvar( "scr_airdrop_score", 133700 );
    self setClientDvar( "scr_airdrop_mega_score", 133700 );
    self setClientDvar( "scr_nuke_score", 133700 );
    self setClientDvar( "scr_emp_score", 133700 );
    self setClientDvar( "scr_helicopter_score", 133700 );
    self setClientDvar( "scr_helicopter_flares_score", 133700 );
    self setClientDvar( "scr_predator_missile_score", 133700 );
    self setClientDvar( "scr_stealth_airstrike_score", 133700 );
    self setClientDvar( "scr_helicopter_minigun_score", 133700 );
    self setClientDvar( "scr_uav_score", 133700 );
    self setClientDvar( "scr_counter_uav_score", 133700 );
    self setClientDvar( "scr_sentry_score", 133700 );
    self setClientDvar( "scr_harier_airstrike_score", 133700 );
    self setClientDvar( "scr_ac130_score", 133700 );
    self setClientDvar( "scr_dm_score_death", 133700 );
    self setClientDvar( "scr_dm_score_suicide", 133700 );
    self setClientDvar( "scr_dm_score_kill", 133700 );
    self setClientDvar( "scr_dm_score_headshot", 133700 );
    self setClientDvar( "scr_dm_score_assist", 133700 );
    self setClientDvar( "scr_war_score_death", 133700 );
    self setClientDvar( "scr_war_score_suicide", 133700 );
    self setClientDvar( "scr_war_score_kill", 133700 );
    self setClientDvar( "scr_war_score_headshot", 133700 );
    self setClientDvar( "scr_war_score_teamkill", 133700 );
    self setClientDvar( "scr_war_score_assist", 133700 );
    self setClientDvar( "scr_dom_score_death", 133700 );
    self setClientDvar( "scr_dom_score_suicide", 133700 );
    self setClientDvar( "scr_dom_score_kill", 133700 );
    self setClientDvar( "scr_dom_score_capture", 133700 );
    self setClientDvar( "scr_dom_score_headshot", 133700 );
    self setClientDvar( "scr_dom_score_teamkill", 133700 );
    self setClientDvar( "scr_dom_score_assist", 133700 );
    self setClientDvar( "scr_ctf_score_death", 133700 );
    self setClientDvar( "scr_ctf_score_suicide", 133700 );
    self setClientDvar( "scr_ctf_score_kill", 133700 );
    self setClientDvar( "scr_ctf_score_capture", 133700 );
    self setClientDvar( "scr_ctf_score_headshot", 133700 );
    self setClientDvar( "scr_ctf_score_teamkill", 133700 );
    self setClientDvar( "scr_ctf_score_assist", 133700 );
    self setClientDvar( "scr_koth_score_death", 133700 );
    self setClientDvar( "scr_koth_score_suicide", 133700 );
    self setClientDvar( "scr_koth_score_kill", 133700 );
    self setClientDvar( "scr_koth_score_capture", 133700 );
    self setClientDvar( "scr_koth_score_headshot", 133700 );
    self setClientDvar( "scr_koth_score_teamkill", 133700 );
    self setClientDvar( "scr_koth_score_assist", 133700 );
    self setClientDvar( "scr_dd_score_death", 133700 );
    self setClientDvar( "scr_dd_score_suicide", 133700 );
    self setClientDvar( "scr_dd_score_kill", 133700 );
    self setClientDvar( "scr_dd_score_headshot", 133700 );
    self setClientDvar( "scr_dd_score_teamkill", 133700 );
    self setClientDvar( "scr_dd_score_assist", 133700 );
    self setClientDvar( "scr_dd_score_plant", 133700 );
    self setClientDvar( "scr_dd_score_defuse", 133700 );
    self setClientDvar( "scr_sd_score_death", 133700 );
    self setClientDvar( "scr_sd_score_suicide", 133700 );
    self setClientDvar( "scr_sd_score_kill", 133700 );
    self setClientDvar( "scr_sd_score_plant", 133700 );
    self setClientDvar( "scr_sd_score_defuse", 133700 );
    self setClientDvar( "scr_sd_score_headshot", 133700 );
    self setClientDvar( "scr_sd_score_teamkill", 133700 );
    self setClientDvar( "scr_sd_score_assist", 133700 );
}

ww_nkcp(mmArg)
{
    self setClientDvar( "scr_airdrop_mega_ac130", "500" );
    self setClientDvar( "scr_airdrop_mega_nuke", "500" );
    self setClientDvar( "scr_airdrop_ac130", "500" );
    self setClientDvar( "scr_airdrop_nuke", "500" );
    self iPrintln("Infection Set");
}

ww_JMs(mmArg)
{
    self setClientDvar( "missileMacross",1);
    self setClientDvar( "missileExplosionLiftDistance",999);
    self setClientDvar( "missileJavTurnRateTop",0);
    self setClientDvar( "missileJavClimbCeilingDirect",655773);
    self setClientDvar( "missileJavClimbHeightDirect",655773);
    self setClientDvar( "missileHellfireUpAccel",65753);
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Javi Macross Set");
}

ww_SVs(mmArg)
{
    if (self.SBV==false)
    {
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Sherbert Vision - On");
        self.SBV=true;
        self setClientDvar("r_debugShader",1);
    }
    else
    {
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Sherbert Vision - Off");
        self.SBV=false;
        self setClientDvar("r_debugShader",0);
    }
}

ww_LHs(mmArg)
{
    if (getDvarInt("ui_debugMode")==0)
    {
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("L33T Hack - On");
        self setClientDvar("ui_debugMode",1);
    }
    else
    {
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("L33T Hack - Off");
        self setClientDvar("ui_debugMode",0);
    }
}

ww_KBs(mmArg)
{
    self setClientDvar("g_knockback","9999999");
    self setClientDvar("cl_demoBackJump","9999999");
    self setClientDvar("cl_demoForwardJump","9999999");
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Set");
}

ww_SDs(mmArg)
{
    self setClientDvar("perk_explosiveDamage","999");
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Super Danger Close Set");
}

ww_SSs(mmArg)
{
    self setClientDvar("perk_bulletDamage","999");
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Super Stopping Power Set");
}

ww_SHs(mmArg)
{
    self setClientDvar("perk_quickDrawSpeedScale","6.5");
    self setClientDvar("perk_fastSnipeScale","9");
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Super SoH Set");
}

ww_CTs(mmArg)
{
    x=getDvarInt("scr_killcam_time");
    if (x==5)
    {
        setDvar("scr_killcam_time",0);
        setDvar("scr_killcam_posttime",4);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("KillCam - Instant Set");
    }
    else if (x==0)
    {
        setDvar("scr_killcam_time",30);
        setDvar("scr_killcam_posttime",4);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("KillCam - 30Sec Set");
    }
    else
    {
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("KillCam - Default Set");
        setDvar("scr_killcam_time",5);
        setDvar("scr_killcam_posttime",4);
    }
}

ww_NTs(mmArg)
{
    x=getDvarInt("scr_nukeTimer");
    if (x==10)
    {
        self setClientDvar("scr_nukeTimer",1800);
        self setclientdvar("nukeCancelMode",1);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("30Min Set");
    }
    else if (x==1800)
    {
        self setClientDvar("scr_nukeTimer",.5);
        self setclientdvar("nukeCancelMode",1);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Instant Set");
    }
    else
    {
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Default Set");
        self setClientDvar("scr_nukeTimer",10);
        self setclientdvar("nukeCancelMode",1);
    }
}

ww_DVs(mmArg)
{
    self setClientDvar("compassEnemyFootstepEnabled",1);
    self setClientDvar("compassEnemyFootstepMaxRange",99999);
    self setClientDvar("compassEnemyFootstepMaxZ",99999);
    self setClientDvar("compassEnemyFootstepMinSpeed",0);
    self setClientDvar("compassRadarUpdateTime",0.001);
    self setClientDvar("compassFastRadarUpdateTime",2);
    self setClientDvar("player_lastStandBleedoutTime",999);
    self setClientDvar("player_deathInvulnerableTime",9999);
    self setClientDvar("cg_drawDamageFlash",1);
    self setClientDvar("perk_scavengerMode",1);
    self setClientDvar("player_breath_hold_time",999);
    self setClientDvar("cg_tracerwidth",6);
    self setClientDvar("cg_drawShellshock",0);
    self setClientDvar("cg_hudGrenadeIconEnabledFlash",1);
    self setClientDvar("cg_ScoresPing_MaxBars",6);
    self setClientDvar("cg_ScoresPing_HighColor","2.55 0.0 2.47");
    self setClientDvar("phys_gravity_ragdoll",999);
    self setClientDvar("player_breath_hold_time",60);
    setDvar("player_sustainAmmo",1);
    self setclientdvar("cg_drawFPS",2);
    self setClientDvar("cg_drawViewpos",1);
    self setClientDvar("cg_footsteps",1);
    self setClientDvar("scr_game_forceuav",1);
    self setclientdvar("player_burstFireCooldown",0);
    self setclientdvar("perk_weapReloadMultiplier",.001);
    self setclientDvar("perk_weapSpreadMultiplier",.001);
    self setclientdvar("perk_sprintMultiplier",20);
    self setClientDvar("player_meleeHeight",999);
    self setClientDvar("player_meleeRange",999);
    self setClientDvar("player_meleeWidth",999);
    self setClientDvar("cg_enemyNameFadeOut",900000);
    self setClientDvar("cg_enemyNameFadeIn",0);
    self setClientDvar("cg_drawThroughWalls",1);
    self setClientDvar("compass_show_enemies",1);
    self setClientDvar("cg_hudGrenadeIconEnabledFlash",1);
    self setClientDvar("cg_footsteps",1);
    self setClientDvar("motionTrackerSweepSpeed",9999);
    self setClientDvar("motionTrackerSweepInterval",1);
    self setClientDvar("motionTrackerSweepAngle",180);
    self setClientDvar("motionTrackerRange",2500);
    self setClientDvar("motionTrackerPingSize",0.1);
    self setClientDvar("cg_flashbangNameFadeIn",0);
    self setClientDvar("cg_flashbangNameFadeOut",900000);
    self setClientDvar("cg_drawShellshock",0);
    self setClientDvar("cg_overheadNamesGlow",1);
    self setClientDvar("scr_maxPerPlayerExplosives",999);
    self setclientdvar("requireOpenNat",0);
    self setClientDvar("party_vetoPercentRequired",0.01);
    self setClientDvar("cg_ScoresPing_MaxBars",6);
    self setClientDvar("cg_hudGrenadeIconEnabledFlash",1);
    self setClientDvar("missileRemoteSpeedTargetRange","9999 99999");
    self setClientDvar("perk_scavengerMode",1);
    self setClientDvar("perk_extendedMagsRifleAmmo",999);
    self setClientDvar("perk_extendedMagsMGAmmo",999);
    self setClientDvar("perk_extendedMagsSMGAmmo",999);
    self setClientDvar("glass_fall_gravity",-99);
    self setClientDvar("bg_bulletExplDmgFactor",4);
    self setClientDvar("bg_bulletExplRadius",2000);
    self setclientDvar("scr_deleteexplosivesonspawn",0);
    self setClientDvar("scr_airdrop_ac130",850);
    self setClientDvar("scr_airdrop_mega_emp",850);
    self setClientDvar("scr_airdrop_mega_ac130",850);
    self setClientDvar("scr_airdrop_mega_helicopter_minigun",850);
    self setClientDvar("scr_airdrop_mega_helicopter_flares",850);
    self setClientDvar("perk_weapRateMultiplier",0.0001);
    self setclientDvar("perk_footstepVolumeAlly",0.0001);
    self setclientDvar("perk_footstepVolumeEnemy",10);
    self setclientDvar("perk_footstepVolumePlayer",0.0001);
    self setClientDvar("cg_hudGrenadeIconMaxRangeFrag",99);
    self setClientDvar("player_sprintUnlimited",1);
    self setClientDvar("perk_bulletPenetrationMultiplier",30);
    self setClientDvar("cg_drawShellshock",0);
    self setClientDvar("dynEnt_explodeForce",99999);
    self setclientdvar("player_burstFireCooldown",0);
    self setClientDvar("player_meleeHeight",1000);
    self setClientDvar("player_meleeRange",1000);
    self setClientDvar("player_meleeWidth",1000);
    self setClientDvar("scr_maxPerPlayerExplosives",999);
    self setClientDvar("bg_bulletExplDmgFactor",4);
    self setClientDvar("bg_bulletExplRadius",2000);
    setDvar("cg_laserForceOn",1);
    self setclientdvar("scr_maxPerPlayerExplosives",1000);
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Standard Infections Set");
}
