
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ww_vector_scale(vec, scale)
{
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}

ww_onPlayerMultiJump(mmArg) //fix
{
    if ( !isDefined( self.multiJumpEnabled ) || !self.multiJumpEnabled )
    {
        self.multiJumpEnabled = true;
        self.numOfMultijumps = 99999;
        self thread ww_onPlayerMultijump2();
    }
    else
    {
        self.multiJumpEnabled = false;
        self notify( "stopmj" );
        self thread ww_ccTXT( "Multi Jumps Disabled" );
    }
}

ww_onPlayerMultijump2()
{
    self endon( "disconnect" );
    self endon( "stopmj" );
    self iPrintln("^1M^2u^3l^4t^5i^6j^7u^1m^2p^3s: ^2Enabled");
    self iPrintln("^6Keep ^0Spamming [{+gostand}]!");
    self thread ww_landsOnGround();
    if(!isDefined(self.numOfMultijumps)) self.numOfMultijumps = 20;
    for(;;)
    {
        currentNum = 0;
        self waittill( "action_made_+gostand" );
        if ( !isAlive( self ) )
        {
            self waittill("spawned_player");
            continue;
        }
        if ( !self isOnGround() )
        {
            while( !self isOnGround() && isAlive( self ) && currentNum < self.numOfMultijumps)
            {
                waittillResult = self waittill_any( "action_made_+gostand", "landedOnGround", "disconnect", "death" );
                if(waittillResult == "action_made_+gostand" && !self isOnGround() && isAlive( self ))
                {
                    playerAngles = self getplayerangles();
                    playerVelocity = self getVelocity();
                    self setvelocity( (playerVelocity[0], playerVelocity[1], playerVelocity[2]/2 ) + anglestoforward( (270, playerAngles[1], playerAngles[2]) ) * getDvarInt( "jump_height" ) * ( ( (-1/39) * getDvarInt( "jump_height" ) ) + (17/2) ) * 1 );
                    currentNum++;
                }
                else break;
            }
            while(!self isOnGround()) wait 0.05;
        }
    }
}

ww_landsOnGround()
{
    self endon( "disconnect" );
    self endon( "stopmj" );
    loopResult = true;
    for(;;)
    {
        wait 0.05;
        newResult = self isOnGround();
        if(newResult != loopResult)
        {
            if(!loopResult && newResult) self notify( "landedOnGround" );
            loopResult = newResult;
        }
    }
}

ww_togglePerrrStige(mmArg)
{
    self endon("death");
    self endon("PrestigeSelect3d");
    self maps\mp\_modmenu::mm_closeMenu();
    self iPrintln("Press [{+gostand}] To Toggle Prestige");
    wait 1;
    self iPrintln("Press [{weapnext}] To Confirm Prestige"); //+usereload
    self.maxhealth = 3000;
    self.health = self.maxhealth;
	self.prest = -1;
	self thread ww_PrestigeCX();

	for(;;)
	{
		self waittill("iLikeKookies");
		self.prest++;
		if(self.prest > 11) 
			self.prest = 0;
		self iPrintln("Prestige " + self.prest);
		wait 0.01;
	}
}

ww_PrestigeCX()
{
	self endon("death");
    self endon("PrestigeSelect3d");
	
     //+usereload
	for(;;)
	{
		self waittill("iLikeKookiez");
		self iprintln("Set Prestige to: " +  self.prest);
		self ww_SetPrestige(self.prest);
	}
}

ww_SetPrestige(prestigeNum)
{
    // The patch sent "J 2064 0..0" with gamesendservercmd, which the port does
    // not have; the prestige is player data (as EliteMossy's Prestige 11).
    self setPlayerData("prestige",prestigeNum);
    self notify("PrestigeSelect3d");
}

ww_ChaCla(mmArg)
{
    self _disableWeaponSwitch();
    self openPopupMenu(game["menu_changeclass"]);
    self waittill("menuresponse",menu,className);
    self _enableWeaponSwitch();
    if(className == "back"||self isUsingRemote())return;
    self maps\mp\gametypes\_class::giveLoadout(self.pers["team"],className,false);
}

ww_Speed2(mmArg)
{
    if(!self.spdz)
    {
        self.moveSpeedScaler=2;
        self setMoveSpeedScale(self.moveSpeedScaler);
        self thread ww_ccTXT("On");
        self.spdz=true;
    }
    else
    {
        self.moveSpeedScaler=1;
        self setMoveSpeedScale(self.moveSpeedScaler);
        self thread ww_ccTXT("Off");
        self.spdz=false;
    }
}

ww_FOV(mmArg)
{
    if ( !isDefined( self.fovWide ) )
        self.fovWide = false;
    if ( !self.fovWide )
    {
        self setClientDvar( "cg_fov", 90 );
        self thread ww_ccTXT( "FOV 90" );
        self.fovWide = true;
    }
    else
    {
        self setClientDvar( "cg_fov", 65 );
        self thread ww_ccTXT( "FOV 65" );
        self.fovWide = false;
    }
}

ww_MegaPerks(mmArg)
{
    self iprintln("^1All ^2Perks ^4Set");
    self maps\mp\perks\_perks::givePerk("specialty_fastreload");
    self maps\mp\perks\_perks::givePerk("specialty_extendedmelee");
    self maps\mp\perks\_perks::givePerk("specialty_fastsprintrecovery");
    self maps\mp\perks\_perks::givePerk("specialty_improvedholdbreath");
    self maps\mp\perks\_perks::givePerk("specialty_fastsnipe");
    self maps\mp\perks\_perks::givePerk("specialty_selectivehearing");
    self maps\mp\perks\_perks::givePerk("specialty_heartbreaker");
    self maps\mp\perks\_perks::givePerk("specialty_automantle");
    self maps\mp\perks\_perks::givePerk("specialty_falldamage");
    self maps\mp\perks\_perks::givePerk("specialty_lightweight");
    self maps\mp\perks\_perks::givePerk("specialty_coldblooded");
    self maps\mp\perks\_perks::givePerk("specialty_fastmantle");
    self maps\mp\perks\_perks::givePerk("specialty_quickdraw");
    self maps\mp\perks\_perks::givePerk("specialty_parabolic");
    self maps\mp\perks\_perks::givePerk("specialty_detectexplosive");
    self maps\mp\perks\_perks::givePerk("specialty_marathon");
    self maps\mp\perks\_perks::givePerk("specialty_extendedmags");
    self maps\mp\perks\_perks::givePerk("specialty_armorvest");
    self maps\mp\perks\_perks::givePerk("specialty_scavenger");
    self maps\mp\perks\_perks::givePerk("specialty_jumpdive");
    self maps\mp\perks\_perks::givePerk("specialty_extraammo");
    self maps\mp\perks\_perks::givePerk("specialty_bulletdamage");
    self maps\mp\perks\_perks::givePerk("specialty_quieter");
    self maps\mp\perks\_perks::givePerk("specialty_bulletpenetration");
    self maps\mp\perks\_perks::givePerk("specialty_bulletaccuracy");
}

ww_bounceBetty(mmArg)
{
    self iPrintln("^6Bouncing ^3Betty Spawned");
    self iPrintln("^1Look ^6Underneath ^2You!");
    betty = spawn( "script_model", self.origin + ( 0, 0, 10) );
    betty setModel("projectile_rpg7");
    betty RotatePitch( -90, 0.1, 0, 0 );
    wait 4;
    level.bettyFire = loadfx(" explosions/large_vehicle_explosion ");
    stepOnBetty = spawn( "trigger_radius", betty.origin, 1, 20, 10 );
    stepOnBetty waittill( "trigger", i );
    self playsound("Dirt_skid");
    betty MoveTo(betty.origin +(0,0,70),0.4);
    wait .6;
    level.harrier_deathfx = loadfx ("explosions/aerial_explosion_harrier");
    RadiusDamage(betty.origin,300,200,50,self);
    self playsound("harrier_jet_crash");
    betty delete();
}

ww_HighMode(mmArg)
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "HighMode_removed" );
    for(;;)
    {
        HighModeAngle = self GetPlayerAngles( );
        if ( HighModeAngle[ 1 ] < 179 )
        {
            self setPlayerAngles( HighModeAngle + ( 0, 0, 5 ) );
        }
        else
        {
            self SetPlayerAngles( HighModeAngle *( 1, -1, 1 ) );
        }
        wait( 0.01 );
    }
}

ww_doTbag(mmArg)
{
    self endon("death");
    self endon("disconnect");
    self iPrintln( "^1FUCKING ^0TBAG ^1TIME ^2HA^3HA!" );
    //self notifyOnPlayerCommand("tbag", "+stance");
    //self waittill("tbag");
    while(1)
    {
        self setstance( "stand" );
        wait 0.25;
        self setstance( "crouch" );
        wait 0.25;
    }
}

ww_PissedUpBad(mmArg)
{
    self endon("death");
    self thread ww_runSpinningBitches();
    notifyData=spawnstruct();
    notifyData.iconName=level.icontest;
    notifyData.titleText="^1OMG I'M WASTED!";
    notifyData.notifyText="^1AH MY HEAD";
    notifyData.notifyText2="^1SHIT!! WHAT HAPPENED";
    notifyData.glowColor =(0.0,0.0,1.0);
    notifyData.duration=5;
    notifyData.font="DAStacks";
    self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
    self takeAllWeapons();
    self giveWeapon("defaultweapon_mp",0,false);
    self switchToWeapon("defaultweapon_mp");
    self setWeaponAmmoStock("defaultweapon_mp",0);
    self SetStance("crouch");
    wait 6;
    self shellshock("mp_radiation_med",15);
    wait 16;
    self thread ww_dead();
}

ww_dead()
{
    self endon("death");
    wait 5;
    self suicide();
    while(1)
    {
        self SetStance("prone");
        wait 0.05;
    }
}

ww_runSpinningBitches()
{
    self endon("disconnect");
    self endon("death");
    while(1)
    {
        self setPlayerAngles(self.angles+(0,0,90));
        self VisionSetNakedForPlayer("mpnuke",.1);
        self PlaySound("nuke_wave");
        wait 0.1;
        self setPlayerAngles(self.angles+(0,90,180));
        self VisionSetNakedForPlayer("cheat_chaplinnight",.1);
        self PlaySound("nuke_wave");
        wait 0.1;
        self setPlayerAngles(self.angles+(0,180,270));
        self VisionSetNakedForPlayer("dcemp_parking_lighting",.1);
        self PlaySound("nuke_wave");
        wait 0.1;
        self setPlayerAngles(self.angles+(0,90,0));
        self VisionSetNakedForPlayer("grayscale",.1);
        self PlaySound("nuke_wave");
        wait 0.1;
        self setPlayerAngles(self.angles+(0,180,270));
        self VisionSetNakedForPlayer("mpnuke_aftermath",.1);
        self PlaySound("nuke_wave");
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,180));
        self VisionSetNakedForPlayer("oilrig_underwater",.1);
        self PlaySound("nuke_explosion");
        wait 0.1;
        self setPlayerAngles(self.angles+(0,90,90));
        self VisionSetNakedForPlayer("cargoship_blast",.1);
        self PlaySound("nuke_wave");
        wait 0.1;
        self setPlayerAngles(self.angles+(0,180,0));
        self VisionSetNakedForPlayer("blackout_darkness",.1);
        self PlaySound("nuke_wave");
        wait 0.1;
    }
}

ww_doSM(mmArg)
{
    self endon("death");
    self iPrintln("^4M40A3 ^2Aquired");
    self iPrintln("^6<3 ^3We ^2All ^6Loved ^5COD4!");
    self takeWeapon(self getCurrentWeapon());
    self giveWeapon("cheytac_silencer_xmags_mp", 0, false);
    self switchToWeapon("cheytac_silencer_xmags_mp", 0, false);
    for(;;)
    {
        self waittill( "weapon_fired" );
        foreach( player in level.players )
        {
            self playsound( "weap_m40a3sniper_fire_plr" );
        }
    }
}

ww_Challenges(u)
{
    if(!isDefined(u)) u=true;
    self endon("disconnect");
    self endon("death");
    self maps\mp\_modmenu::mm_closeMenu();
    wait 0.4;
    self maps\mp\_modmenu::mm_closeMenu();
    wait 1;
    self thread ww_MGod();
    self iPrintlnBold("Unlocking Challenges...");
    p=0;
    self freezeControls(true);
    if(u) self setPlayerData("iconUnlocked","cardicon_prestige10_02",1);
    else self setPlayerData("iconUnlocked","cardicon_prestige10_02",0);
    foreach (challengeRef,challengeData in level.challengeInfo)
    {
        finalTarget=0;
        finalTier=0;
        for (tierId=1;isDefined(challengeData["targetval"][tierId]);
        tierId++)
        {
            if(u)
            {
                finalTarget=challengeData["targetval"][tierId];
                finalTier=tierId+1;
            }
        }
        if (self isItemUnlocked(challengeRef))
        {
            self setPlayerData("challengeProgress",challengeRef,finalTarget);
            self setPlayerData("challengeState",challengeRef,finalTier);
        }
        wait 0.04;
        p++;
        self.pe=floor(ceil(((p/480)*100))/10)*10;
        if (p/48==ceil(p/48)&&self.pe!= 0&&self.pe!=100) self iPrintlnBold("Unlocking Challenges: "+self.pe+"/100 complete");
    }
    self thread ww_ccTXT("Challenges Completed.");
    self notify("DoneChallenges");
    self freezeControls(false);
    self.maxhealth=100;
    self.health=self.maxhealth;
    self.HasGodModeOn=false;
}

ww_MGod(mmArg)
{
    self endon("disconnect");
    self endon("death");
    self endon("DoneChallenges");
    self endon("stopGodMode");
    self thread ww_ccTXT("God Mode Enabled");
    if ( !isDefined( level.wwGodFallDamageSaved ) )
    {
        level.wwGodFallDamageMax = getDvar( "bg_fallDamageMaxHeight" );
        level.wwGodFallDamageMin = getDvar( "bg_fallDamageMinHeight" );
        level.wwGodFallDamageSaved = true;
    }
    setDvar("bg_fallDamageMaxHeight",999);
    setDvar("bg_fallDamageMinHeight",998);
    self.HasGodModeOn=true;
    self.maxhealth=90000;
    self.health=self.maxhealth;
    while(1)
    {
        wait .4;
        if(self.health<self.maxhealth) self.health=self.maxhealth;
    }
}

ww_MGodToggle(mmArg)
{
    if ( !isDefined( self.HasGodModeOn ) || !self.HasGodModeOn )
    {
        self thread ww_MGod();
    }
    else
    {
        self notify( "stopGodMode" );
        self.HasGodModeOn = false;
        self.maxhealth = 100;
        if ( self.health > self.maxhealth )
            self.health = self.maxhealth;
        if ( isDefined( level.wwGodFallDamageSaved ) )
        {
            setDvar( "bg_fallDamageMaxHeight", level.wwGodFallDamageMax );
            setDvar( "bg_fallDamageMinHeight", level.wwGodFallDamageMin );
        }
        self thread ww_ccTXT( "God Mode Disabled" );
    }
}

ww_I70(mmArg)
{
    self setPlayerData( "experience" , 2516000 );
    notifyData = spawnstruct();
    notifyData.titleText = "You Have Been Promoted";
    notifyData.notifyText = "Level 70";
    notifyData.notifyText2 = "Commander";
    notifyData.glowColor = (0.3, 0.6, 0.3);
    notifyData.sound = "mp_level_up";
    self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}

ww_doCred(mmArg)
{
    self endon("disconnect");
    self endon("death");
    self.maxhealth=90000;
    self freezeControls(true);
    wait 3;
    self thread maps\mp\gametypes\_hud_message::hintMessage("White Water V6 Ultimate Patch");
    wait 5;
    self thread maps\mp\gametypes\_hud_message::hintMessage("^1Created By:");
    wait 5;
    self thread maps\mp\gametypes\_hud_message::hintMessage("^3JokerRey & xRobertDavisx ");
    wait 5;
    self thread maps\mp\gametypes\_hud_message::hintMessage("^2Credits To;");
    wait 3;
    self thread maps\mp\gametypes\_hud_message::hintMessage("^3DEREKTROTTER, Blackstorm");
    wait 5;
    self thread maps\mp\gametypes\_hud_message::hintMessage("^3EliteMossy & MrMoss.");
    wait 5;
    self thread maps\mp\gametypes\_hud_message::hintMessage("^6Please Subscribe!");
    wait 3;
    self thread maps\mp\gametypes\_hud_message::hintMessage("^8Download On www.nextgen.x10.mx !");
    wait 6;
    self thread maps\mp\gametypes\_hud_message::hintMessage("^2Have Fun!");
    wait 4;
    self freezeControls(false);
    self.maxhealth=100;
}

ww_DPtt(mmArg)
{
    self sayall("^3Can I Have Infectable ModMenu Please?");
}

ww_NRC(mmArg)
{
    if (!self.norc)
    {
        self player_recoilScaleOn(0);
        self thread ww_ccTXT("No Recoil - On");
        self.norc=true;
    }
    else
    {
        self thread ww_ccTXT("No Recoil - Off");
        self player_recoilScaleOn(1);
        self.norc=false;
    }
}

ww_CTG(mmArg)
{
    if ( isDefined( mmArg ) )
    {
        self setClientDvar( "clanName", mmArg );
        self thread ww_ccTXT( "Clantag applied" );
        return;
    }
    self thread ww_ccTXT("Set to Unbound");
    self setClientDvar("clanName","{<3}");
}

ww_Suicides(mmArg)
{
    self suicide();
}

ww_TPN(mmArg)
{
    if (!self.thirdp)
    {
        self setClientDvar("cg_thirdPerson",1);
        self thread ww_ccTXT("Third Person - On");
        self.thirdp=true;
    }
    else
    {
        self thread ww_ccTXT("Third Person - Off");
        self setClientDvar("cg_thirdPerson",0);
        self.thirdp=false;
    }
}

ww_InfAmmoToggle(mmArg)
{
    if ( !isDefined( self.infAmmoOn ) || !self.infAmmoOn )
    {
        self.infAmmoOn = true;
        self thread ww_InfAmmo();
    }
    else
    {
        self.infAmmoOn = false;
        self notify( "stopInfAmmo" );
        self thread ww_ccTXT( "Inf Ammo Disabled" );
    }
}

ww_InfAmmo(mmArg)
{
    self endon("disconnect");
    self endon("death");
    self endon("stopInfAmmo");
    self.infAmmoOn = true;
    self thread ww_ccTXT("Inf Ammo Enabled");
    for(;;)
    {
        W=self getCurrentWeapon();
        if(W!="none")
        {
            if( isSubStr(self getCurrentWeapon(),"_akimbo_"))
            {
                self setWeaponAmmoClip(W,9999,"left");
                self setWeaponAmmoClip(W,9999,"right");
            }
            else self setWeaponAmmoClip(W,9999);
            self GiveMaxAmmo(W);
        }
        W2=self GetCurrentOffhand();
        if (W2!="none")
        {
            self setWeaponAmmoClip(W2,9999);
            self GiveMaxAmmo(W2);
        }
        wait 0.05;
    }
}

ww_CCs(mmArg)
{
    self thread ww_ccTXT("Coloured Classes Set");
    i=0;
    j=1;
    while(i<10)
    {
        self setPlayerData("customClasses",i,"name","^"+j+self.name+" "+(i+1));
        i++;
        j++;
        if (j==6) j=1;
    }
}

ww_Acco(mmArg)
{
    if ( !isDefined( mmArg ) )
        mmArg = 1000;
    foreach ( ref, award in level.awards )
        self ww_GAcco( ref, mmArg );
    self ww_GAcco( "targetsdestroyed", mmArg );
    self ww_GAcco( "bombsplanted", mmArg );
    self ww_GAcco( "bombsdefused", mmArg );
    self ww_GAcco( "bombcarrierkills", mmArg );
    self ww_GAcco( "bombscarried", mmArg );
    self ww_GAcco( "killsasbombcarrier", mmArg );
    self ww_GAcco( "flagscaptured", mmArg );
    self ww_GAcco( "flagsreturned", mmArg );
    self ww_GAcco( "flagcarrierkills", mmArg );
    self ww_GAcco( "flagscarried", mmArg );
    self ww_GAcco( "killsasflagcarrier", mmArg );
    self ww_GAcco( "hqsdestroyed", mmArg );
    self ww_GAcco( "hqscaptured", mmArg );
    self ww_GAcco( "pointscaptured", mmArg );
    self thread ww_ccTXT( "Added " + mmArg + " Accolades" );
}

ww_GAcco(ref, amount)
{
    self setPlayerData( "awards", ref, self getPlayerData( "awards", ref ) + amount );
}

ww_menuCMDS()
{
    self notifyOnPlayerCommand("dpad_up","+actionslot 1");
    self notifyOnPlayerCommand("dpad_down","+actionslot 2");
    self notifyOnPlayerCommand("dpad_left","+actionslot 3");
    self notifyOnPlayerCommand("dpad_right","+actionslot 4");
    self notifyOnPlayerCommand("button_cross","+gostand");
    self notifyOnPlayerCommand("button_square","+usereload");
    self notifyOnPlayerCommand("button_rstick","+melee");
    self notifyOnPlayerCommand("button_circle","+stance");
}

ww_NewUFO()
{
    self endon("disconnect");
    self endon("death");
    self endon("MenuChangePerms");
    for(;;)
    {
        if(self.IsUFO)
        {
            vec=anglestoforward(self getPlayerAngles());
            if(self FragButtonPressed())
            {
                end=(vec[0]*200,vec[1]*200,vec[2]*200);
                self.newufo.origin=self.newufo.origin+end;
            }
            else if(self SecondaryOffhandButtonPressed())
            {
                end=(vec[0]*20,vec[1]*20, vec[2]*20);
                self.newufo.origin=self.newufo.origin+end;
            }
        }
        wait 0.05;
    }
}

ww_iButts()
{
    self endon("disconnect");
    self endon("death");
    self endon("MenuChangePerms");
    self ww_butTables();
    self.comboPressed=[];
    self.butP=[];
    self.update=[];
    self.update[0]=1;
    for(i=0;i<11;i++)
    {
        self.butP[self.butN[i]]=0;
        self thread ww_monButts(i);
    }
}

ww_monButts(buttonI)
{
    self endon("disconnect");
    self endon("death");
    self endon("MenuChangePerms");
    butID=self.butN[buttonI];
    for (;;)
    {
        self waittill(butID);
        self.butP[butID]=1;
        wait .05;
        self.butP[butID]=0;
    }
}

ww_iWalkAC()
{
    self endon("disconnect");
    self endon("death");
    self endon("MenuChangePerms");
    self.ACMode=false;
    self.weapTemp="";
    self thread ww_dAC130();
    for (;;)
    {
        if(self.ACMode)
        {
            if(self.weapTemp=="") self.weapTemp=self getCurrentWeapon();
            self giveWeapon("ac130_105mm_mp",0,false);
            while(self getCurrentWeapon()!="ac130_105mm_mp")
            {
                self switchToWeapon("ac130_105mm_mp");
                wait 0.05;
            }
        }
        else if(self.weapTemp!="")
        {
            self takeWeapon("ac130_105mm_mp");
            self switchToWeapon(self.weapTemp);
            self.weapTemp="";
        }
        wait 0.05;
    }
}

ww_dAC130()
{
    self endon("disconnect");
    self endon("MenuChangePerms");
    for (;;)
    {
        self waittill("death");
        self takeWeapon("ac130_105mm_mp");
        self.ACMode=false;
    }
}

ww_clearAir()
{
    self endon("disconnect");
    self endon("death");
    for(;;)
    {
        if(level.planes>1)level.planes=0;
        if(isDefined(level.chopper))level.chopper=undefined;
        if(isDefined(level.ac130player))level.ac130player=undefined;
        if(isDefined(level.nukeIncoming))level.nukeIncoming=undefined;
        if(level.ac130InUse)level.ac130InUse=0;
        if(level.killstreakRoundDelay>0)level.killstreakRoundDelay=0;
        wait 1;
    }
}

ww_M_controls()
{
    if ( !isDefined( self.wwControlHud ) )
        self.wwControlHud = [];
    self.wwControlHud["instructions"] = self createFontString( "hudsmall", 0.6 );
    self.wwControlHud["instructions"] setPoint( "LEFT", "CENTER", -370, 0 );
    self.wwControlHud["instructions"] ww_setSafeText( "^7Open ^7[{+frag}] + [{+usereload}]\n^7Navigate ^7[{+actionslot 1}] [{+actionslot 2}] [{+actionslot 3}] [{+actionslot 4}]\n^7Select ^7[{+gostand}]\n^7Back ^7[{+stance}]" );
}

ww_destroyControlsHud()
{
    if ( !isDefined( self.wwControlHud ) )
        return;
    self.wwControlHud["instructions"] destroy();
    self.wwControlHud = undefined;
}

ww_setSafeText(text)
{
    // The patch tracked every text and cleared them all with
    // ClearAllTextAfterHudElem when there were more than 70; the port does not
    // have that. The text is set as it is.
    self setText(text);
}

ww_createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha, server)
{
    if(isDefined(server))
        boxElem = newHudElem();
    else
        boxElem = newClientHudElem(self);

    boxElem.elemType = "icon";
    boxElem.color = color;
    if(!level.splitScreen)
    {
        boxElem.x = -2;
        boxElem.y = -2;
    }
    boxElem.hideWhenInMenu = true;
    boxElem.archived       = false;
    boxElem.width          = width;
    boxElem.height         = height;
    boxElem.align          = align;
    boxElem.relative       = relative;
    boxElem.xOffset        = 0;
    boxElem.yOffset        = 0;
    boxElem.children       = [];
    boxElem.sort           = sort;
    boxElem.alpha          = alpha;
    boxElem.shader         = shader;
    boxElem setParent(level.uiParent);
    boxElem setShader(shader, width, height);
    boxElem.hidden = false;
    boxElem setPoint(align, relative, x, y);
    return boxElem;
}

ww_ccTXT(s)
{
    self iPrintln("^"+randomint(6)+s);
}

ww_test(mmArg)
{
    self iprintln("option");
}

ww_butTables()
{
    self.butN=[];
    self.butN[0]="X";
    self.butN[1]="Y";
    self.butN[2]="A";
    self.butN[3]="B";
    self.butN[4]="Up";
    self.butN[5]="Down";
    self.butN[6]="Left";
    self.butN[7]="Right";
    self.butN[8]="RT";
    self.butN[9]="O";
    self.butN[10]="F";
    self.butA = [];
    self.butA["X"]="+reload";
    self.butA["Y"]="+breathe_sprint";
    self.butA["A"]="+frag";
    self.butA["B"]="+melee";
    self.butA["Up"]="+actionslot 1";
    self.butA["Down"]="+actionslot 2";
    self.butA["Left"]="+actionslot 3";
    self.butA["Right"]="+actionslot 4";
    self.butA["RT"]="weapnext";
    self.butA["O"]="+stance";
    self.butA["F"]="+gostand";
}

ww_registerButts()
{
    // The notifyOnPlayerCommand that monButts() did on every spawn, once per
    // connect (maps\mp\_modmenu.gsc calls it).
    self ww_butTables();
    for(i=0;i<11;i++) self notifyOnPlayerCommand(self.butN[i],self.butA[self.butN[i]]);
}

ww_closer(ref,a,b)
{
    // as EliteMossy's em_closer, for the builtin closer()
    return ( distanceSquared(ref,a) < distanceSquared(ref,b) );
}

ww_registerOptionCommands()
{
    // The notifyOnPlayerCommand the options did every time they were chosen
    // (each one added another registration: the 2nd time a toggle notified
    // twice and switched itself off again), once per connect.
    self notifyOnPlayerCommand("[{+gostand}]","+gostand");
    self notifyOnPlayerCommand("[{+stance}]","+stance");
    self notifyOnPlayerCommand("WTF","+actionslot 2");
    self notifyOnPlayerCommand("UFOz","+melee");
    self notifyOnPlayerCommand("OMFG","+actionslot 3");
    self notifyOnPlayerCommand("WALL","+actionslot 3");
    self notifyOnPlayerCommand("TELE","+actionslot 2");
    self notifyOnPlayerCommand("POO","+actionslot 4");
    self notifyOnPlayerCommand("noattack","-attack");
    self notifyOnPlayerCommand("attack","+attack");
    self notifyOnPlayerCommand("useButton","+smoke");
    self notifyOnPlayerCommand("X","+usereload");
    self notifyOnPlayerCommand("fukoffcol","+melee");
    self notifyOnPlayerCommand("RB","+frag");
    self notifyOnPlayerCommand("LB","+smoke");
    self notifyOnPlayerCommand("G","weapnext");
    self notifyOnPlayerCommand("fiya","+attack");
    self notifyOnPlayerCommand("RT","+attack");
    self notifyOnPlayerCommand("AS1","+actionslot 3");
    self notifyOnPlayerCommand("AS3","+usereload");
    self notifyOnPlayerCommand("BlockL3","+breath_sprint");
    self notifyOnPlayerCommand("action_made_+gostand","+gostand");
    self notifyOnPlayerCommand("iLikeKookies","+gostand");
    self notifyOnPlayerCommand("iLikeKookiez","weapnext");
}
