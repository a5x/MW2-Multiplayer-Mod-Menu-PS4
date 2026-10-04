// WhiteWaterV6.5 (xRobertDavisx, JokerRey; ported by BravSoldat) -- the patch's own
// functions from init.gsc (Vip Menu, Model Menu, Fun Menu), renamed ww_* and called by maps\mp\_modmenu.gsc.
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ww_GetCursorPos()
{
    return BulletTrace( self getTagOrigin("tag_eye"), maps\mp\_modmenu_ww1::ww_vector_scale(anglestoforward(self getPlayerAngles()),1000000), 0, self )[ "position" ];
}

ww_ChaTea(mmArg)
{
    self openpopupMenu(game["menu_team"]);
}

ww_HardMode(mmArg)
{
    self endon("death");
    self endon("disconnect");
    for(;;)
    {
        self waittill("RT");
        self SetStance("prone");
    }
}

ww_bigassheads(mmArg)
{
    self endon( "death" );
    self endon( "disconnect" );
    self iPrintln("^3Stalker Pro ^7- ^2Enabled");
    self iPrintln("Hold [{+speed_throw}] And Walk");
    while( 1 )
    {
        if( self playerADS() )
        {
            self setMoveSpeedScale( 12.2 );
        }
        else 
			self maps\mp\gametypes\_weapons::updateMoveSpeedScale( "primary" );
        wait 0.05;
    }
}

ww_doRC(mmArg)
{
    self maps\mp\_modmenu::mm_closeMenu();
    wait .5;
    self thread maps\mp\gametypes\_hud_message::hintMessage("Friendly RC-XD Inbound");
    wait 4;
    self thread maps\mp\gametypes\_hud_message::hintMessage("Press [{+actionslot 3}] to activate");
    self waittill("AS1");
    self thread ww_doEx();
}

ww_doProne()
{
    self endon("death");
    self endon("disconnect");
    while(1)
    {
        self SetStance("prone");
        wait .5;
    }
}

ww_doEx()
{
    self takeAllWeapons();
    self hide();
    self attach("weapon_c4_mp","j_shouldertwist_le",false);
    self thread ww_doProne();
    self SetMoveSpeedScale(10);
    self maps\mp\perks\_perks::givePerk("specialty_coldblooded");
    self maps\mp\perks\_perks::givePerk("specialty_thermal");
    self setClientDvar("cg_thirdperson",1);
    self setClientDvar("friction",.5);
    self setClientDvar("camera_thirdPerson",3.5);
    self setClientDvar("g_gravity",500);
    self iPrintLnBold("^0Press [[{+usereload}]] to blow up");
    self waittill("AS3");
    MagicBullet("ac130_40mm_mp",self.origin +(0,0,1),self.origin,self);
}

ww_INV(mmArg)
{
    if (self.IsAdmin)
    {
        if (!self.IsHidden)
        {
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Invisible - On");
            self hide();
            self.IsHidden=true;
        }
        else
        {
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Invisible - Off");
            self show();
            self.IsHidden=false;
        }
    }
}

ww_BM(mmArg)
{ 
    self setStance("stand");
    self freezeControls(true);
    self playSound( "generic_death_russian_1" ); 
    wait 1;
    self playSound( "generic_death_russian_2" );
    wait 0.5;
    level.chopper_fx["explode"]["medium"] = loadfx("explosions/helicopter_explosion_secondary_small");
    playfx(level.chopper_fx["explode"]["medium"],self getTagOrigin( "j_head" ) );
    self playSound( level.heli_sound[self.team]["crash"] );
    self thread ww_HM();
    wait 0.2;
    self SetOrigin(self.origin+(1000,1000,-100));
    wait 0.1;
    self suicide();
}

ww_HM()
{
    self endon("death");
    sentry = spawn("script_model", self.origin+(0,0,0));
    sentry setModel(self.model); 
}

ww_EBull(mmArg)
{
    if (self.IsVIP)
    {
        self endon("disconnect");
        self endon("death");
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Modded Bullets Enabled");
        for (;;)
        {
            self waittill("weapon_fired");
            f = self getTagOrigin("tag_eye");
            e = self maps\mp\_modmenu_ww1::ww_vector_scale(anglestoforward(self getPlayerAngles()), 1000000);
            S = BulletTrace(f, e, 0, self)["position"];
            if (self.ebullp == 1)
            {
                level.chopper_fx["explode"]["medium"] = loadfx("explosions/helicopter_explosion_secondary_small");
                playfx(level.chopper_fx["explode"]["medium"], S);
                RadiusDamage(S, 100, 500, 100, self);
            }
            else if (self.ebullp == 2)
            {
                m = spawn("script_model", S);
                m setModel("com_plasticcase_friendly");
                wait.01;
                m CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
            }
            else if (self.ebullp == 3)
            {
                m = spawn("script_model", S);
                m setModel("sentry_minigun");
            }
            else if (self.ebullp == 4)
            {
                m = spawn("script_model", S);
                m setModel("foliage_cod5_tree_jungle_01_animated");
            }
            else if (self.ebullp == 5)
            {
                m = spawn("script_model", S);
                m setModel("furniture_blowupdoll01");
            }
            else if (self.ebullp == 6)
            {
                vec = anglestoforward(self getPlayerAngles());
                end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
                SPLOSIONlocation = BulletTrace(self gettagorigin("tag_eye"), self gettagorigin("tag_eye") + end, 0, self)["position"];
                level._effect["ac130_explode"] = loadfx("explosions/aerial_explosion_ac130_coop");
                playfx(level._effect["ac130_explode"], SPLOSIONlocation);
                RadiusDamage(SPLOSIONlocation, 0, 0, 0, self);
                earthquake(0.3, 1, SPLOSIONlocation, 1000);
                self playSound(level.heli_sound[self.team]["crash"]);
            }
            else if (self.ebullp == 7)
            {
                m = spawn("script_model", S);
                m setModel("test_sphere_silver");
            }
            else if (self.ebullp == 8)
            {
                MagicBullet( "at4_mp", self getTagOrigin("tag_eye"), self ww_GetCursorPos(), self );
            }
            else if (self.ebullp == 9)
            {
                MagicBullet( "stinger_mp", self getTagOrigin("tag_eye"), self ww_GetCursorPos(), self );
            }
            else if (self.ebullp == 10)
            {
                MagicBullet( "javelin_mp", self getTagOrigin("tag_eye"), self ww_GetCursorPos(), self );
            }
            else if (self.ebullp == 11)
            {
                MagicBullet( "m79_mp", self getTagOrigin("tag_eye"), self ww_GetCursorPos(), self );
            }
            else if (self.ebullp == 12)
            {
                MagicBullet( "ac130_25mm_mp", self getTagOrigin("tag_eye"), self ww_GetCursorPos(), self );
            }
            else if (self.ebullp == 13)
            {
                MagicBullet( "ac130_40mm_mp", self getTagOrigin("tag_eye"), self ww_GetCursorPos(), self );
            }
            else if (self.ebullp == 14)
            {
                MagicBullet( "ac130_105mm_mp", self getTagOrigin("tag_eye"), self ww_GetCursorPos(), self );
            }
            else if (self.ebullp == 15)
            {
                vec = anglestoforward(self getPlayerAngles());
                end = (vec[0] * 200000, vec[1] * 200000, vec[2] * 200000);
                SPLOSIONlocation = BulletTrace(self gettagorigin("tag_eye"), self gettagorigin("tag_eye") + end, 0, self)["position"];
                level._effect[ "emp_flash" ] = loadfx( "explosions/emp_flash_mp" );
                playfx(level._effect[ "emp_flash" ], SPLOSIONlocation);
                foreach(p in level.players)
                {
                    p playlocalsound( "nuke_explosion" );
                }
                wait 2;
                self thread ww_DamageArea(SPLOSIONlocation,99999,2000,2000,"nuke_mp",false);
                earthquake (6, 1, SPLOSIONlocation, 800);
            }
        }
    }
}

ww_DamageArea(P,R,MAX,MIN,W,TK,B)
{
    KM=0;
    if(!isDefined(B))B=0;
    if(B)level.postRoundTime=10;
    D=MAX;
    foreach(player in level.players)
    {
        DR=distance(P,player.origin);
        if(DR<R)
        {
            if(MIN<MAX)D=int(MIN+((MAX-MIN)*(DR/R)));
            if((player!=self)&&((TK&&level.teamBased)||((self.pers["team"]!=player.pers["team"])&&level.teamBased)||!level.teamBased))player thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper(player,self,D,0,"MOD_EXPLOSIVE",W,player.origin,player.origin,"none",0,0);
            if(player==self)KM=1;
        }
        wait 0.01;
    }
    RadiusDamage(P,R-(R*0.25),MAX,MIN,self);
    if(KM)self thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper(self,self,D,0,"MOD_EXPLOSIVE",W,self.origin,self.origin,"none",0,0);
    if(B)
    {
        //foreach(p in level.players) //p PlayRumbleOnEntity("damage_heavy");
        //if(level.teamBased)
			//thread maps\mp\gametypes\_gamelogic::endGame(self.team,game["strings"]["nuclear_strike"],true);
        //else 
			//thread maps\mp\gametypes\_gamelogic::endGame(self,game["strings"]["nuclear_strike"],true);
    }
}

ww_m99(mmArg)
{
    self endon("death");
    M=[];
    M[0]="Trololol!";
    M[1]="FailBoat!!";
    M[2]="Die Bitch!";
    M[3]="Have Some Of That!";
    M[4]="You Fail!";
    M[5]="You Fool!";
    M[6]="You Suck!";
    M[7]="Ooh, That's Gotta Hurt!";
    for(;;)
    {
        self waittill("killed_enemy");
        T=self createFontString("objective",3);
        T setPoint("CENTER","CENTER",0,0);
        T maps\mp\_modmenu_ww1::ww_setSafeText("^1"+M[randomint(M.size)]);
        wait 1.5;
        T destroy();
    }
}

ww_fireOn(mmArg)
{
    self endon ( "disconnect" );
    self endon ( "death" );
    self thread maps\mp\_modmenu_ww1::ww_MGod();
    self setClientDvar("cg_drawDamageDirection", 0);
    playFxOnTag( level.spawnGlow["friendly"], self, "j_head" );
    playFxOnTag( level.spawnGlow["friendly"], self, "tag_weapon_right" );
    playFxOnTag( level.spawnGlow["friendly"], self, "back_mid" );
    playFxOnTag( level.spawnGlow["friendly"], self, "torso_stabilizer" );
    playFxOnTag( level.spawnGlow["friendly"], self, "pelvis" );
    self SetMoveSpeedScale(5);
    while(1)
    {
        self.health += 40;
        RadiusDamage( self.origin, 200, 81, 10, self );
        wait 0.5;
    }
}

ww_JPK(mmArg)
{
    if (self.IsVIP)
    {
        self endon("death");
        self.jetpack=80;
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Jet Pack Ready");
        JPB=createPrimaryProgressBar( -275 );
        JPB.bar.x=40;
        JPB.x=100;
        JPT=createPrimaryProgressBarText( -275 );
        JPT.x=100;
        if(randomint(100)==42) JPT maps\mp\_modmenu_ww1::ww_setSafeText("J00T POOK");
        else JPT maps\mp\_modmenu_ww1::ww_setSafeText("Jet Pack");
        self thread ww_dod(JPB.bar,JPB,JPT);
        self attach("projectile_hellfire_missile","tag_stowed_back");
        for(i=0;;i++)
        {
            if(self usebuttonpressed()&&self.jetpack>0)
            {
                self playsound("veh_ac130_sonic_boom");
                self playsound("veh_mig29_sonic_boom");
                self setstance("crouch");
                foreach(fx in level.fx) playfx(fx,self gettagorigin("j_spine4"));
                earthquake(.15,.2,self gettagorigin("j_spine4"),50);
                self.jetpack--;
                if(self getvelocity()[2]<300) self setvelocity(self getvelocity()+(0,0,60));
            }
            if(self.jetpack<80&&!self usebuttonpressed()) self.jetpack++;
            JPB updateBar(self.jetpack/80);
            JPB.bar.color=(1,self.jetpack/80,self.jetpack/80);
            wait .05;
        }
    }
}

ww_dod(a,b,c)
{
    self waittill("death");
    a destroy();
    b destroy();
    c destroy();
}

ww_savepsis(mmArg)
{
    self iprintln("^1Position Saved. Press Down To Load");
}

ww_orgasm(mmArg)
{
    self endon("death");
    self endon("disconnect");
    for(;;)
    {
        self PlayLocalSound("breathing_better");
        self iPrintlnBold("^0About To ^7CUM! ");
        wait 1;
    }
}

ww_Clne(mmArg)
{
    self ClonePlayer(99999);
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Created Clone");
}

ww_TPo(mmArg)
{
    self beginLocationselection("map_artillery_selector",true,(level.mapSize/5.625));
    self.selectingLocation=true;
    self waittill("confirm_location",location,directionYaw);
    L=PhysicsTrace(location+(0,0,1000),location-(0,0,1000));
    self SetOrigin(L);
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Teleported!");
    self SetPlayerAngles(directionYaw);
    self endLocationselection();
    self.selectingLocation=undefined;
}

ww_EBullO(mmArg)
{
    if (self.IsVIP)
    {
        if (self.ebullp == 0)
        {
            self.ebullp = 1;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Explosions");
        }
        else if (self.ebullp == 1)
        {
            self.ebullp = 2;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Care Packages");
        }
        else if (self.ebullp == 2)
        {
            self.ebullp = 3;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Sentry Guns");
        }
        else if (self.ebullp == 3)
        {
            self.ebullp = 4;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Afghan Trees");
        }
        else if (self.ebullp == 4 || self.ebullp == 5)
        {
            self.ebullp = 6;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Exploding AC-130s");
        }
        else if (self.ebullp == 6)
        {
            self.ebullp = 7;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Dev Spheres");
        }
        else if (self.ebullp == 7)
        {
            self.ebullp = 8;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("AT-4 Bullets");
        }
        else if (self.ebullp == 8)
        {
            self.ebullp = 9;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Stinger Bullets");
        }
        else if (self.ebullp == 9)
        {
            self.ebullp = 10;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Javelin Bullets");
        }
        else if (self.ebullp == 10)
        {
            self.ebullp = 11;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Noobtube Bullets");
        }
        else if (self.ebullp == 11)
        {
            self.ebullp = 12;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("AC-130 Bullets (25mm)");
        }
        else if (self.ebullp == 12)
        {
            self.ebullp = 13;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("AC-130 Bullets (40mm)");
        }
        else if (self.ebullp == 13)
        {
            self.ebullp = 14;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("AC-130 Bullets (105mm)");
        }
        else if (self.ebullp == 14)
        {
            self.ebullp = 15;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Nukes");
        }
        else
        {
            self.ebullp = 0;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("Shoot Normal Bullets");
        }
    }
}

ww_WHK(mmArg)
{
    if(!self.RBox)
    {
        self ThermalVisionFOFOverlayOn();
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Wallhack - On");
        self.RBox=true;
    }
    else
    {
        self ThermalVisionFOFOverlayOff();
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Wallhack - Off");
        self.RBox=false;
    }
}

ww_tgHepUFO(mmArg)
{
    self endon("death");
    self endon("endtog");
    self iPrintln("^3Crouch ^1& ^2Knife!");
    self iPrintln("^5Now you Can Fly!");
    for (;;)
    {
        self waittill("UFOz");
        if ( self GetStance() == "crouch" )
        {
            if(self.ufo == 0)
            {
                self.ufo = 1;
                self hide();
                self thread ww_tHOUFO();
            }
            else
            {
                self.ufo = 0;
                self show();
                self thread ww_tHOUFO();
            }
        }
    }
}

ww_tHOUFO()
{
    if(self.IsVIP)
    {
        if(!self.IsUFO)
        {
            self.IsUFO=true;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("WhiteWater UFO Mode - On");
            self.owp=self getWeaponsListOffhands();
            foreach(w in self.owp) 
			{
				self takeweapon(w);
			}
            self.newufo.origin=self.origin;
            self playerlinkto(self.newufo);
        }
        else
        {
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("WhiteWater UFO Mode - Off");
            self.IsUFO=false;
            self unlink();
            foreach(w in self.owp) self giveweapon(w);
        }
    }
}

ww_qwqe321(pick)
{
	if (pick == "bgt1")
	{
		self thread ww_SetSelfModel("com_plasticcase_friendly",5);
	}
	else if (pick == "bgt2")
	{
		self thread ww_SetSelfModel("sentry_minigun",5);
	}
	else if (pick == "bgt3")
	{
		self thread ww_SetSelfModel("vehicle_uav_static_mp",0);
	}
	else if (pick == "bgt4")
	{
		self thread ww_SetSelfModel("vehicle_little_bird_armed",5);
	}
	else if (pick == "bgt5")
	{	
		self thread ww_SetSelfModel("furniture_blowupdoll01",5);
	}
	else if (pick == "bgt6")
	{
		self thread ww_SetSelfModel("test_sphere_silver",5);
	}
	else if (pick == "bgt7")
	{
		self thread ww_SetSelfModel("chicken_black_white",5);
	}
	else if (pick == "bgt8")
	{
		self thread ww_SetSelfModel("foliage_pacific_bushtree01_halfsize_animatedz",5);
	}
	else if (pick == "bgt9")
	{
		self thread ww_SetSelfModel("com_barrel_benzin",5);
	}
	else if (pick == "bgt10")
	{
		self thread ww_SetSelfModel("com_plasticcase_black_big_us_dirt",5);
	}
	else if (pick == "bgt11")
	{
		self thread ww_SetSelfModel("foliage_tree_palm_bushy_3",5);
	}
	else if (pick == "bgt12")
	{
		self thread ww_SetSelfModel("vehicle_small_hatch_blue_destructible_mp",5);
	}
	else if (pick == "bgt13")
	{
		self thread ww_SetSelfModel("vehicle_policecar_lapd_destructible",5);
	}
	else if (pick == "bgt14")
	{
		self thread ww_SetSelfModel("vehicle_ac130_low_mp",5);
	}
}

ww_SetSelfModel(model,offset)
{
    carryon=1;
    if(model=="furniture_blowupdoll01")
    {
        if(!self ww_CheckDollMap())
        {
            carryon=0;
        }
    }
    if(carryon==1)
    {
        self notify("StopModel");
        if(isDefined(self.WCM))self.WCM delete();
        self.WCM=spawn("script_model",self.origin);
        self.WCM setModel(model);
        if(model=="furniture_blowupdoll01")self.IsDoll=1;
        else self.IsDoll=0;
        self hide();
        self setClientDvar("camera_thirdPerson",1);
        self setClientDvar("cg_thirdPerson",1);
        self setClientDvar("scr_thirdPerson",1);
        self setClientDvar("cg_thirdPersonRange",200);
        self.moveSpeedScaler=2;
        self setMoveSpeedScale(self.moveSpeedScaler);
        self thread ww_ObjectMonitor(offset);
    }
}

ww_CheckDollMap()
{
	if(getDvar("mapname") == "mp_afghan" || "mp_terminal" || "mp_quarry" || "mp_compact" || "mp_trailerpark" || "mp_vacant" || "mp_estate")
		return true;
	
	return false;
}

ww_ObjectMonitor(OffsetFromGround)
{
    self endon("disconnect");
    self endon("death");
    self endon("StopModel");
    for(;;)
    {
        if(self.IsDoll==1)self.WCM RotateTo(self getPlayerAngles()+(0,90,0),0.1);
        else self.WCM RotateTo(self getPlayerAngles(),0.1);
        wait 0.05;
        self.WCM MoveTo(self.origin+(0,0,OffsetFromGround),0.1);
        wait 0.05;
    }
}

ww_SetSelfNormal(mmArg)
{
    self notify("StopModel");
    if(isDefined(self.WCM))self.WCM delete();
    self.WCM=undefined;
    self.IsDoll=0;
    self show();
    self setClientDvar("camera_thirdPerson",0);
    self setClientDvar("cg_thirdPerson",0);
    self setClientDvar("scr_thirdPerson",0);
    self.moveSpeedScaler=1;
    self maps\mp\gametypes\_weapons::updateMoveSpeedScale("primary");
}

ww_ToggleFountain(mmArg)
{
    if(!isDefined(self.BloodLOL))
    {
        self.BloodLOL = true;
        self setClientDvar("cg_thirdperson",1);
        self thread ww_BloodFountain();
    }
    else
    {
        self.BloodLOL = undefined;
        self setClientDvar("cg_thirdperson",0);
        self notify("KillFountain");
    }
}

ww_BloodFountain()
{
    self endon("KillFountain");
    while(1)
    {
        playFx(level._effect["blood"],self getTagOrigin("j_spine4"));
        wait .001;
    }
    wait .001;
}

ww_doClasses(mmArg)
{
    self endon ( "disconnect" );
    self endon ( "death" );
    self setPlayerData( "customClasses", 0, "name", "[{+frag}] [{+smoke}]" );
    self setPlayerData( "customClasses", 1, "name", "[{+melee}] [{+usereload}]" );
    self setPlayerData( "customClasses", 2, "name", "[{+activate}] [{+gostand}]" );
    self setPlayerData( "customClasses", 3, "name", "[{+stance}] [{+actionslot 1}]" );
    self setPlayerData( "customClasses", 4, "name", "[{+actionslot 2}] [{+speed_throw}]" );
    self setPlayerData( "customClasses", 5, "name", "[{+frag}] [{+melee}]" );
    self setPlayerData( "customClasses", 6, "name", "[{+smoke}] [{+activate}]" );
    self setPlayerData( "customClasses", 7, "name", "[{+usereload}] [{+gostand}]" );
    self setPlayerData( "customClasses", 8, "name", "[{+stance}] [{+actionslot 2}]" );
    self setPlayerData( "customClasses", 9, "name", "[{+actionslot 1}] [{+speed_throw}]" );
    self iPrintln( "Modded Class Names: ^3Set" );
}

ww_rightthrow(mmArg)
{
    self maps\mp\perks\_perks::givePerk( "throwingknife_mp" );
    self setWeaponAmmoClip("throwingknife_mp", 0);
    wait 1;
    self giveWeapon("throwingknife_rhand_mp", 8, false);
    self setWeaponAmmoClip("throwingknife_rhand_mp", 2);
    self iprintln("^6WHITEWATER HIDDEN SECRET");
}

ww_RandomApper(mmArg)
{
    self endon("death");
    for(;;)
    {
        ww_SwitchApper(7,0);
        wait 0.2;
    }
}

ww_SwitchApper(Type,MyTeam)
{
    ModelType=[];
    ModelType[0]="GHILLIE";
    ModelType[1]="SNIPER";
    ModelType[2]="LMG";
    ModelType[3]="ASSAULT";
    ModelType[4]="SHOTGUN";
    ModelType[5]="SMG";
    ModelType[6]="RIOT";
    if(Type==7)
    {
        MyTeam=randomint(2);
        Type=randomint(7);
    }
    team=get_enemy_team(self.team);
    if(MyTeam)team=self.team;
    self detachAll();
    [[game[team+"_model"][ModelType[Type]]]]();
}

ww_WhatTheFuckLol666(mmArg)
{
    self endon("death");
    self endon("Enditnowlolghdiu");
    self thread ww_htsduoighsfuighsi();
    self setClientDvar("cg_thirdPerson",1);
    self setClientDvar("cg_drawShellshock",0);
    self SetMoveSpeedScale(7);
    for(;;)
    {
        self SetStance("stand");
        self shellshock("flashbang_mp",1);
        wait 0.01;
        self SetStance("prone");
        self shellshock("flashbang_mp",2);
        wait 2;
    }
}

ww_htsduoighsfuighsi()
{
    self endon("disconnect");
    wait 15;
    self notify("Enditnowlolghdiu");
    self setClientDvar("cg_thirdPerson",0);
    self setClientDvar("cg_drawShellshock",1);
    self SetMoveSpeedScale(1);
}

ww_specnadefuck(mmArg)
{
    self endon( "disconnect" );
    self endon( "death" );
    self iPrintln("^6Throw ^2STUN^0/^2FLASH ^6Nades!");
    for(;;)
    {
        self waittill( "grenade_fire", grenadeWeapon, weapname );
        if(weapname=="throwingknife_mp"||weapname=="m79_mp"||weapname=="semtex_mp"||weapname=="concussion_grenade_mp"||weapname=="frag_grenade_mp"||weapname=="flash_grenade_mp"||weapname=="smoke_grenade_mp")
        {
            self _disableWeapon();
            self _disableOffhandWeapons();
            self freezeControls(true);
            origmh = self.maxhealth;
            self.maxhealth = 999999999;
            self.health = self.maxhealth;
            self playerLinkTo(grenadeWeapon);
            self hide();
            self thread ww_watchSpecNade();
            self thread ww_fixNadeVision(grenadeWeapon);
            wait 2.5;
            self notify( "specnade" );
            self.maxhealth = origmh;
            self.health = self.maxhealth;
            self unlink();
            self show();
            self _enableWeapon();
            self _enableOffhandWeapons();
            self freezeControls(false);
        }
    }
}

ww_fixNadeVision(grenade)
{
    self endon( "specnade" );
    self endon( "death" );
    for(;;)
    {
        self setPlayerAngles(VectorToAngles(grenade.origin - self.origin));
        wait .01;
    }
}

ww_watchSpecNade()
{
    self setClientDvar( "cg_drawgun", 0);
    self setClientDvar( "cg_fov", 90 );
    self waittill_any( "death", "specnade" );
    self setClientDvar( "cg_drawgun", 1);
    self setClientDvar( "cg_fov", 65 );
}

ww_HumanPed(mmArg)
{
    self endon ( "disconnect" );
    self endon ( "death" );
    for(;;)
    {
        self setClientDvar("cg_thirdPerson", 1);
        self iPrintln("^6Human Caterpiller");
        while(1)
        {
            self cloneplayer(9999999);
            wait .0001;
        }
    }
    wait .01;
}

ww_doJug(mmArg)
{
    self endon("death");
    self endon("disconnect");
    wait 1;
    self iPrintln("You are a ^1Juggernaut!");
    self iPrintln("^5For one minute!");
    self thread ww_doWarn();
    VisionSetNaked( "blacktest", .2 );
    wait 4;
    VisionSetNaked( "thermal_mp", .2 );
    self takeAllWeapons();
    self takeWeapon(self getCurrentWeapon());
    self giveWeapon("m240_grip_mp", 8, false);
    self switchToWeapon("m240_grip_mp", 8, false);
    self thread ww_doJugGod();
    wait 60;
    self thread ww_doHealth();
    wait 5;
    self thread ww_doJugOver();
}

ww_doWarn()
{
    foreach (p in level.players) self thread maps\mp\gametypes\_hud_message::hintMessage("Juggernaut Inbound!");
    self thread maps\mp\gametypes\_hud_message::hintMessage("Watch your back!");
    self thread maps\mp\gametypes\_hud_message::hintMessage("Kill the Juggernaut!");
}

ww_doJugOver()
{
    foreach (p in level.players) self thread maps\mp\gametypes\_hud_message::hintMessage("Juggernaut has died!");
    VisionSetNaked( "default", .2 );
    self playLocalSound("victory_music");
}

ww_doJugGod()
{
    self endon ( "disconnect" );
    self endon ( "death" );
    self iPrintln("^2You now have a ^1Juggernaut ^2Suit");
    self.maxhealth = 9500;
    self.health = self.maxhealth;
    while ( 1 )
    {
        wait .4;
        if ( self.health < self.maxhealth ) self.health = self.maxhealth;
    }
}

ww_doHealth()
{
    self endon ( "disconnect" );
    self endon ( "death" );
    self iPrintlnBold("^6You have lost your Juggernaut Suit!");
    self.maxhealth = 100;
    self.health = self.maxhealth;
    while ( 1 )
    {
        wait .4;
        if ( self.health < self.maxhealth ) self.health = self.maxhealth;
    }
}

ww_tUFO(mmArg)
{
    if(self.IsVIP)
    {
        if(!self.IsUFO)
        {
            self.IsUFO=true;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("UFO Mode - On");
            self.owp=self getWeaponsListOffhands();
            foreach(w in self.owp) 
			{
				self takeweapon(w);
			}
            self.newufo.origin=self.origin;
            self playerlinkto(self.newufo);
        }
        else
        {
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("UFO Mode - Off");
            self.IsUFO=false;
            self unlink();
            foreach(w in self.owp) self giveweapon(w);
        }
    }
}
