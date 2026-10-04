// WhiteWaterV6.5 (xRobertDavisx, JokerRey; ported by BravSoldat) -- the patch's own
// functions from init.gsc (Weapons Menu and Weapons Menu 2), renamed ww_* and called by maps\mp\_modmenu.gsc.
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ww_ArtilleryDirtGUN(mmArg)
{
    self endon("death");
    self endon("disconnect");
    self iPrintln("^6Artillery Dirt Gun Ready!");
    self iPrintln("^0POW POW!");
    self giveWeapon("coltanaconda_tactical_mp",6);
    self switchtoweapon("coltanaconda_tactical_mp",6);
    for(;;)
    {
        self waittill("weapon_fired");
        if(self getcurrentweapon()== "coltanaconda_tactical_mp")
        {
            my=self gettagorigin("j_head");
            trace=bullettrace(my,my+anglestoforward(self getplayerangles())*100000,true,self)["position"];
            playfx(level._effect["ADGun"],trace);
        }
        wait 0.1;
    }
}

ww_StealthBomberGUN(mmArg)
{
    self endon("death");
    self endon("disconnect");
    self iPrintln("^6Stealth Bomber Gun Ready!");
    self iPrintln("^1Working On Explosions");
    self giveWeapon("p90_silencer_mp",6);
    self switchtoweapon("p90_silencer_mp",6);
    for(;;)
    {
        self waittill("weapon_fired");
        if(self getcurrentweapon()== "p90_silencer_mp")
        {
            my=self gettagorigin("j_head");
            trace=bullettrace(my,my+anglestoforward(self getplayerangles())*100000,true,self)["position"];
            playfx(level._effect["SBGun"],trace);
        }
        wait 0.1;
    }
}

ww_FlashNukeGUN(mmArg)
{
    self endon("death");
    self endon("disconnect");
    self iPrintln("^6Flash Nuke Gun Ready!");
    self iPrintln("^3Looks Like a ^5ForceFeild!");
    self giveWeapon("deserteaglegold_mp",6);
    self switchtoweapon("deserteaglegold_mp",6);
    for(;;)
    {
        self waittill("weapon_fired");
        if(self getcurrentweapon()== "deserteaglegold_mp")
        {
            my=self gettagorigin("j_head");
            trace=bullettrace(my,my+anglestoforward(self getplayerangles())*100000,true,self)["position"];
            playfx(level._effect["FNGun"],trace);
        }
        wait 0.1;
    }
}

ww_nkGun(mmArg)
{
    self endon("death");
    self iPrintln("^2Nuke Gun Aquired");
    self iPrintln("^3Please 1Dont ^6Spam!");
    self takeWeapon(self getCurrentWeapon());
    self giveWeapon("usp_silencer_mp",0,false);
    self switchToWeapon("usp_silencer_mp",0,false);
    for(;;)
    {
        self waittill("weapon_fired");
        foreach(player in level.players)
        {
            self playsound("ui_mp_nukebomb_timer");
        }
        MagicBullet("ac130_40mm_mp",self getTagOrigin("tag_eye"),self ww_GetCursorPos2(),self);
    }
}

ww_GetCursorPos2()
{
    return BulletTrace(self getTagOrigin("tag_eye"),maps\mp\_modmenu_ww1::ww_vector_scale(anglestoforward(self getPlayerAngles()),1000000),0,self)[ "position" ];
}

ww_giveTT(mmArg)
{
    self thread ww_giveTELEPORTER();
    wait 0.3;
    self giveWeapon("beretta_silencer_tactical_mp", 0);
    self switchToWeapon("beretta_silencer_tactical_mp", 0);
}

ww_giveTELEPORTER()
{
    self endon("disconnect");
    while(1)
    {
        self waittill("weapon_fired");
        if(self getCurrentWeapon() == "beretta_silencer_tactical_mp")
        {
            self.maxhp = self.maxhealth;
            self.hp = self.health;
            self.maxhealth = 99999;
            self.health = self.maxhealth;
            playFx( level.chopper_fx["smoke"]["trail"], self.origin );
            playFx( level.chopper_fx["smoke"]["trail"], self.origin );
            playFx( level.chopper_fx["smoke"]["trail"], self.origin );
            forward = self getTagOrigin("j_gun");
            end = self maps\mp\_modmenu_ww1::ww_vector_scale(anglestoforward(self getPlayerAngles()),1000000);
            location = BulletTrace( forward, end, 0, self )[ "position" ];
            self SetOrigin( location );
        }
    }
}

ww_FTH(mmArg)
{
    if(self.IsAdmin)
    {
        self endon("death");
        self endon("disconnect");
        self giveWeapon("defaultweapon_mp", 7, false);
        self switchToWeapon("defaultweapon_mp");
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Activated");
        for(;;)
        {
            if (self attackbuttonpressed())
            {
                if(self getCurrentWeapon()=="defaultweapon_mp")
                {
                    beg2=ww_GCP();
                    beg1=self getTagOrigin("tag_weapon_left");
                    end=distance(beg1,beg2);
                    owner=self;
                    if(end<855)
                    {
                        point=ww_rUp(end/55);
                        X1=beg1[0]-beg2[0];
                        Y1=beg1[1]-beg2[1];
                        Z1=beg1[2]-beg2[2];
                        X2=X1/point;
                        Y2=Y1/point;
                        Z2=Z1/point;
                        RadiusDamage(beg2,40,30,30,owner);
                        for(b=point;b>-1;b--)
                        {
                            playFX(level.fx[1],beg2+(((X2,Y2,Z2)*b)));
                            wait 0.001;
                        }
                    }
                }
            }
            wait 0.05;
        }
    }
}

ww_GCP()
{
    f=self getTagOrigin("tag_eye");
    e=self maps\mp\_modmenu_ww1::ww_vector_scale(anglestoforward(self getPlayerAngles()),1000000);
    l=BulletTrace(f,e,0,self)["position"];
    return l;
}

ww_rUp(f)
{
    if(int(f)!=f) return int(f+1);
    else return int(f);
}

ww_nukeAT4(mmArg)
{
    self endon ( "disconnect" );
    self endon ( "death" );
    self iPrintln( "^3Le ^1AT-4 ^3Nuke Ready!" );
    self giveWeapon("at4_mp", 6, false);
    self switchToWeapon("at4_mp", 6, false);
    for(;;)
    {
        self waittill ( "weapon_fired" );
        if ( self getCurrentWeapon() == "at4_mp" )
        {
            //if ( level.teambased ) 
				//thread teamPlayerCardSplash( "used_nuke", self, self.team );
            //else 
				//self iprintlnbold(&"MP_FRIENDLY_TACTICAL_NUKE");
            wait 1;
            me2 = self;
            level thread ww_funcNukeSoundIncoming();
            level thread ww_funcNukeEffects(me2);
            level thread ww_funcNukeSlowMo();
            wait 1.5;
            foreach( player in level.players )
            {
                if (player.name != me2.name) if ( isAlive( player ) ) player thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper( me2, me2, 999999, 0, "MOD_EXPLOSIVE", "nuke_mp", player.origin, player.origin, "none", 0, 0 );
            }
            wait .1;
            level notify ( "done_nuke2" );
            self suicide();
        }
    }
}

ww_funcNukeSlowMo()
{
    level endon ( "done_nuke2" );
    setSlowMotion( 1.0, 0.25, 0.5 );
}

ww_funcNukeEffects(me2)
{
    level endon ( "done_nuke2" );
    foreach( player in level.players )
    {
        player thread ww_FixSlowMo(player);
        playerForward = anglestoforward( player.angles );
        playerForward = ( playerForward[0], playerForward[1], 0 );
        playerForward = VectorNormalize( playerForward );
        nukeDistance = 100;
        nukeEnt = Spawn( "script_model", player.origin + maps\mp\_modmenu_ww1::ww_vector_scale( playerForward, nukeDistance ) );
        nukeEnt setModel( "tag_origin" );
        nukeEnt.angles = ( 0, (player.angles[1] + 180), 90 );
        nukeEnt thread ww_funcNukeEffect( player );
        player.nuked = true;
    }
}

ww_FixSlowMo(player)
{
    player endon("disconnect");
    player waittill("death");
    setSlowMotion( 0.25, 1, 2.0 );
}

ww_funcNukeEffect( player )
{
    player endon( "death" );
    //waitframe(); //fix
	wait 0.1;
    PlayFXOnTagForClients( level._effect[ "nuke_flash" ], self, "tag_origin", player );
}

ww_funcNukeSoundIncoming()
{
    level endon ( "done_nuke2" );
    foreach( player in level.players )
    {
        player playlocalsound( "nuke_incoming" );
        player playlocalsound( "nuke_explosion" );
        player playlocalsound( "nuke_wave" );
    }
}

ww_CPgun(mmArg)
{
    self endon("death");
    for(;;)
    {
        self TakeAllWeapons();
        self giveWeapon( "deserteaglegold_mp", 0, false );
        self SwitchToWeapon( "deserteaglegold_mp", 0, false );
        self waittill( "weapon_fired" );
        n=BulletTrace( self getTagOrigin("tag_eye"),anglestoforward(self getPlayerAngles())*100000,0,self)["position"];
        dropCrate =maps\mp\killstreaks\_airdrop::createAirDropCrate( self.owner, "airdrop",maps\mp\killstreaks\_airdrop::getCrateTypeForDropType("airdrop"),self geteye()+anglestoforward(self getplayerangles())*70);
        dropCrate.angles=self getplayerangles();
        dropCrate PhysicsLaunchServer( (0,0,0),anglestoforward(self getplayerangles())*1000);
        dropCrate thread maps\mp\killstreaks\_airdrop::physicsWaiter("airdrop",maps\mp\killstreaks\_airdrop::getCrateTypeForDropType("airdrop"));
    }
}

ww_dobullet(mmArg)
{
    self endon("death");
    self thread ww_ShootVader("test_sphere_silver");
}

ww_ShootVader(model)
{
    self endon("death");
    self endon("sex");
    self endon("disconnect");
    self takeAllWeapons();
    wait 0.01;
    self giveWeapon("spas12_silencer_mp", 0, false);
    self switchToWeapon("spas12_silencer_mp");
    self iPrintln("^3Death Balls ^2Ready");
    for(;;)
    {
        self waittill("weapon_fired");
        l=self getTagOrigin("tag_eye");
        lb=spawnHelicopter(self,l,self.angles+(0,90,0),"cobra_mp",model);
        if(!isDefined(lb))return;
        lb.owner=self;
        lb.team=self.team;
        lb CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
        lb setCanDamage(true);
        self thread ww_x_DaftVader_xxx(lb);
        n=BulletTrace(self getTagOrigin("tag_eye"),anglestoforward(self getPlayerAngles())* 100000,0,self)["position"];
        lb Vehicle_SetSpeed(1500,80);
        lb setVehGoalPos(n);
        wait 0.05;
    }
}

ww_x_DaftVader_xxx(lb)
{
    self endon("disconnect");
    self endon("sex");
    wait 1.22;
    level.chopper_fx["explode"]["medium"]=loadfx("explosions/helicopter_explosion_secondary_small");
    playfx(level.chopper_fx["explode"]["medium"],lb.origin);
    lb playSound(level.heli_sound[self.team]["crash"]);
    RadiusDamage(lb.origin,300,300,1500,self);
    wait 0.1;
    lb delete();
}

ww_bubblegun(mmArg)
{
    self endon("death");
    self iPrintln("^6FX ^2Gun ^3Acquired!");
    self iPrintln("^3Please ^5Dont ^1Spam!");
    self.shaker = 1;
    self giveWeapon("aa12_xmags_mp", 0, false);
    self GiveMaxAmmo( "aa12_xmags_mp" );
    self switchToWeapon("aa12_xmags_mp");
    for(;;)
    {
        self waittill( "weapon_fired", weaponName );
        if( self getCurrentWeapon() != "aa12_xmags_mp" ) continue;
        start = self getTagOrigin( "tag_eye" );
        end = self getTagOrigin( "tag_eye" ) + maps\mp\_modmenu_ww1::ww_vector_scale( anglestoforward( self getPlayerAngles() ), 100000 );
        trace = bulletTrace( start, end, true, self );
        thread ww_doLaserFX2( self getTagOrigin( "tag_eye" ), anglestoforward( self getPlayerAngles() ), trace["position"] );
        if(self.shaker > 212)
        {
            self.shaker = 0;
            self takeWeapon( "aa12_xmags_mp" );
            break;
        }
        self.shaker++;
    }
}

ww_doLaserFX2( startPos, direction, endPos )
{
    doDamage = 1;
    for( i = 1;;i ++ )
    {
        pos = startPos + maps\mp\_modmenu_ww1::ww_vector_scale( direction, i * 150 );
        if( distance( startPos, pos ) > 9000 )
        {
            doDamage = 0;
            break;
        }
        trace = bulletTrace( startPos, pos, true, self );
        if( !bulletTracePassed( startPos, pos, true, self ) )
        {
            impactFX = spawnFX( level.shakeFX["impact"], bulletTrace( startPos, pos, true, self )["position"] );
            level.FX_count ++;
            triggerFX( impactFX );
            wait( 0.2 );
            impactFX delete();
            level.FX_count --;
            break;
        }
        laserFX = spawnFX( level.shakeFX["laser"], pos );
        level.FX_count ++;
        triggerFX( laserFX );
        laserFX thread ww_deleteAfterTime( 0.1 );
        if( level.FX_count < 200 )
        {
            for( j = 0;j < 3;j ++ )
            {
                laserFX = spawnFX( level.shakeFX["laser"], pos + (randomInt( 50 ) / 10, randomInt( 50 ) / 10, randomInt( 50 ) / 10) - maps\mp\_modmenu_ww1::ww_vector_scale( direction, i * randomInt( 10 ) * 3 ) );
                level.FX_count ++;
                triggerFX( laserFX );
                laserFX thread ww_deleteAfterTime( 0.05 + randomInt( 3 ) * 0.05 );
            }
        }
        wait( 0.05 );
    }
    if( doDamage ) earthquake( endPos, 300, 150, 20, self );
}

ww_deleteAfterTime( time )
{
    wait time;
    self delete();
}

ww_airgun(mmArg)
{
    self takeAllWeapons();
    self giveWeapon("rpg_mp",6,false);
    self SetWeaponAmmoStock("rpg_mp",0);
    self setweaponammoclip("rpg_mp",0);
    self switchToWeapon("rpg_mp");
    self thread ww_AirPop();
    self thread ww_CheckKey();
    if(!isDefined(self.AirPropHud)) self ww_HudElem();
    self thread ww_CheckMode();
}

ww_CheckKey()
{
    self endon("death");
    self endon("disconnect");
    for(;;)
    {
        self waittill("noattack");
        self.isAir = false;
    }
}

ww_AirPop()
{
    self endon("death");
    self endon("disconnect");
    self iPrintln("^5Air Gun ^3Acquired!");
    self iPrintln("^6Have ^3Fun ^1Bro's!");
    for(;;)
    {
        self waittill("attack");
        self.isAir = true;
        self.stingerStage = 2;
        if(self getCurrentWeapon()!="rpg_mp") continue;
        while(self.isAir)
        {
            if(self getCurrentWeapon()!="rpg_mp")
            {
                self.isAir = false;
                break;
            }
            ForwardTrace = Bullettrace(self getEye(),self getEye()+anglestoforward(self getplayerangles())*100000,true,self);
            playerAngles = self GetPlayerAngles();
            AtF = AnglesToForward(playerAngles);
            self playLoopSound("oxygen_tank_leak_loop");
            foreach(player in level.players)
            {
                if(player==self) continue;
                enemyToSelf = distance(self.origin,player.origin);
                if(enemyToSelf>512) continue;
                if(ForwardTrace["entity"]!=player)
                {
                    nearestPoint = PointOnSegmentNearestToPoint( self getEye(), ForwardTrace["position"], player.origin );
                    PtoO = distance(player.origin,nearestPoint);
                    co = (cos(35)*512);
                    TopLine = sqrt((512*512)-(co*co));
                    Multi = 512/TopLine;
                    if(enemyToSelf<PtoO*Multi) continue;
                }
                dist = distance(self.origin,player.origin);
                multi = 300/dist;
                if(multi<1) multi = 1;
                if(self.AirPropSuction) player setVelocity(player getVelocity() - (AtF[0]*(300*(multi)),AtF[1]*(300*(multi)),(AtF[2]+0.25)*(300*(multi))));
                else player setVelocity(player getVelocity() + (AtF[0]*(200*(multi)),AtF[1]*(200*(multi)),(AtF[2]+0.25)*(200*(multi))));
                player ViewKick(100,self.origin);
            }
            wait 0.15;
        }
        self stopLoopSound("oxygen_tank_leak_loop");
    }
}

ww_HudElem()
{
    self.AirPropHud = self createFontString("default",2);
    self.AirPropHud setPoint("center","right",300,90);
    self.AirPropSuction = false;
    self.AirPropHud maps\mp\_modmenu_ww1::ww_setSafeText("Propulsion");
    self thread ww_DestroyOnDeath(self.AirPropHud);
}

ww_DestroyOnDeath(elem)
{
    self waittill("death");
    elem destroy();
    self stopLoopSound("oxygen_tank_leak_loop");
}

ww_CheckMode()
{
    self endon("death");
    self endon("disconnect");
    for(;;)
    {
        self waittill("useButton");
        if(self getCurrentWeapon()!="rpg_mp") continue;
        self.AirPropSuction = !self.AirPropSuction;
        self disableWeapons();
        if(self.AirPropSuction) self.AirPropHud maps\mp\_modmenu_ww1::ww_setSafeText("Suction");
        else self.AirPropHud maps\mp\_modmenu_ww1::ww_setSafeText("Propulsion");
        self playSound("elev_run_end");
        self playSound("elev_door_interupt");
        self playSound("elev_run_start");
        wait 1.5;
        self EnableWeapons();
    }
}

ww_MustandSal(mmArg)
{
    self endon("death");
    self takeWeapon(self getCurrentWeapon());
    self giveWeapon("usp_akimbo_mp",0,true);
    self switchToWeapon("usp_akimbo_mp",0,true);
    for(;;)
    {
        self waittill("weapon_fired");
        if(self getCurrentWeapon()== "usp_akimbo_mp")
        {
            MagicBullet("gl_mp",self getTagOrigin("tag_eye"),self maps\mp\_modmenu_ww7::ww_GetCursorPos(),self);
        }
    }
}

ww_NukeGUN(mmArg)
{
    self endon("death");
    self endon("disconnect");
    self iPrintln("^2Nuke ^1Gun ^3Ready!");
    self iPrintln("^0Watch ^7for ^0Smoke!");
    self giveWeapon("beretta_silencer_mp",6);
    self switchtoweapon("beretta_silencer_mp",6);
    for(;;)
    {
        self waittill("weapon_fired");
        if(self getcurrentweapon()== "beretta_silencer_mp")
        {
            my=self gettagorigin("j_head");
            trace=bullettrace(my,my+anglestoforward(self getplayerangles())*100000,true,self)["position"];
            playfx(level._effect["NGun"],trace);
        }
        wait 0.1;
    }
}

ww_TazerMadeByCmdX(mmArg)
{
    self iPrintln("^2Lightning Gun ^4Ready^7!");
    self iPrintln("^2Dont ^7Shock ^3Yourself!");
    self giveWeapon("uzi_silencer_xmags_mp",1,false);
    self giveWeapon("uzi_silencer_xmags_mp",1,false);
    self switchToWeapon("uzi_silencer_xmags_mp");
    level._effect["mine_explosion"]=loadfx("explosions/sentry_gun_explosion");
    level._effect["tv_explosion"]=loadfx( "explosions/tv_flatscreen_explosion" );
    for(;;)
    {
        self waittill("weapon_fired");
        if(self getCurrentWeapon() == "uzi_silencer_xmags_mp")
        {
            vec2=anglestoforward(self getPlayerAngles());
            e1nd =(vec2[0] * 200000,vec2[1] * 200000,vec2[2] * 200000);
            SPLOSIONlocation1=BulletTrace(self gettagorigin("tag_eye"),self gettagorigin("tag_eye")+ e1nd,0,self)["position"];
            playfx(level._effect["mine_explosion"],SPLOSIONlocation1);
            playfx(level._effect["tv_explosion"],SPLOSIONlocation1+(0,0,8));
            RadiusDamage(SPLOSIONlocation1,100,90,90,self);
            earthquake(0.3,1,SPLOSIONlocation1,1000);
        }
        wait 0.001;
    }
}

ww_SonicBoom666(mmArg)
{
    self endon("disconnect");
    self endon("WentBoom");
    self iPrintln("^1Sonic Boom ^7Ready!");
    self iPrintln("^2Prepare to Go ^1Blind!");
    self giveWeapon("usp_fmj_silencer_mp",1,false);
    wait 0.1;
    self switchToWeapon("usp_fmj_silencer_mp");
    self setWeaponAmmoClip("usp_fmj_silencer_mp", 1);
    self setWeaponAmmoStock("usp_fmj_silencer_mp", 0);
    setDvar("cg_laserForceOn",1);
    self iPrintlnBold("Shoot For Bomb Location!");
    for(;;)
    {
        self waittill("weapon_fired");
        if( self getCurrentWeapon() == "usp_fmj_silencer_mp" )
        {
            setDvar("cg_laserForceOn",0);
            self takeweapon( "usp_fmj_silencer_mp" );
            fff2=self getTagOrigin("tag_eye");
            eee2=self maps\mp\_modmenu_ww1::ww_vector_scale(anglestoforward(self getPlayerAngles()),10000);
            ss2=BulletTrace(fff2,eee2,0,self)["position"];
            self thread ww_HooblaJoobla2();
            SBcmdx = spawn("script_model",ss2);
            SBcmdx setModel("projectile_cbu97_clusterbomb");
            SBcmdx.angles=(270,270,270);
            SBcmdx MoveTo(ss2+(0,0,200),5);
            self thread ww_SpinzX(SBcmdx);
            wait 5;
            self thread ww_HooblaJoobla();
            wait 1;
            playfx(level.stealthbombfx,ss2);
            RadiusDamage(ss2,900,900,900,self);
            SBcmdx delete();
            self notify("WentBoom");
            wait 4;
        }
    }
}

ww_HooblaJoobla2()
{
    self endon("disconnect");
    foreach(player in level.players)
    {
        player thread ww_MoreScreenFX2();
    }
}

ww_HooblaJoobla()
{
    self endon("disconnect");
    foreach(player in level.players)
    {
        player thread ww_MoreScreenFX();
    }
}

ww_MoreScreenFX2()
{
    self iPrintlnBold("^3Sonic Boom Incoming!");
}

ww_MoreScreenFX()
{
    self playLocalSound("mp_killstreak_emp");
    self VisionSetNakedForPlayer("cheat_contrast",1);
    wait 1;
    self playLocalSound("nuke_explosion");
    self VisionSetNakedForPlayer("cargoship_blast",0.1);
    wait 1;
    self VisionSetNakedForPlayer("mpnuke_aftermath",2);
    wait 3;
    self VisionSetNakedForPlayer(getDvar("mapname"),1);
}

ww_SpinzX(Val)
{
    self endon("disconnect");
    for(;;)
    {
        Val rotateyaw(-360,0.3);
        wait 0.3;
    }
}

ww_effecttest666420(mmArg)
{
    self endon("death");
    self iPrintln("^5Blizzard Gun ^7Ready!");
    self iPrintln("^2Have Fun! ^6Dont ^1Blow ^3Away!");
    self giveWeapon("sa80_silencer_mp",1,false);
    wait 0.1;
    self switchToWeapon("sa80_silencer_mp");
    level.chopper_fx["smoke"]["trail"] = loadfx ("smoke/smoke_trail_white_heli");
    level.fx_heli_dust = loadfx ("treadfx/heli_dust_default");
    level._effect["moto_smokee"]=loadfx( "smoke/motorcycle_damage_blacksmoke_fire" );
    level.chopper_fx["damage"]["heavy_smoke"] = loadfx ("smoke/smoke_trail_black_heli_emitter");
    for(;;)
    {
        self waittill("weapon_fired");
        if( self getCurrentWeapon() == "sa80_silencer_mp" )
        {
            vet = anglestoforward(self getPlayerAngles());
            endt5 = (vet[0] * 1000, vet[1] * 1000, vet[2] * 1000);
            origin = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+endt5, 0, self )[ "position" ];
            playfx(level.fx_heli_dust,origin);
            playfx(level.chopper_fx["smoke"]["trail"],origin);
            playfx(level._effect["moto_smokee"],origin);
            playfx(level._effect["moto_smokee"],origin+(0,0,24));
            playfx(level._effect["moto_smokee"],origin+(0,3,44));
            playfx(level._effect["moto_smokee"],origin+(0,-3,34));
            playfx(level.chopper_fx["damage"]["heavy_smoke"],origin);
            playfx(level.chopper_fx["damage"]["heavy_smoke"],origin+(0,3,24));
            playfx(level.chopper_fx["smoke"]["trail"],origin+(0,0,30));
            playfx(level.chopper_fx["smoke"]["trail"],origin+(5,-15,70));
            playfx(level.chopper_fx["smoke"]["trail"],origin+(-5,15,40));
            playfx(level.chopper_fx["smoke"]["trail"],origin+(0,0,80));
            playfx(level.chopper_fx["smoke"]["trail"],origin+(0,0,90));
            playfx(level.chopper_fx["smoke"]["trail"],origin+(0,20,30));
            playfx(level.chopper_fx["smoke"]["trail"],origin+(0,-20,30));
            playfx(level.chopper_fx["smoke"]["trail"],origin+(0,0,90));
            wait 0.001;
        }
    }
}

ww_BloodyTampon(mmArg)
{
    self endon("death");
    self endon("disconnect");
    self iPrintln("^5Water ^1Gun ^3Ready!");
    self iPrintln("^6Dont ^3get to ^6W^0E^6T!");
    self giveWeapon("kriss_fmj_mp",0,true);
    self switchtoweapon("kriss_fmj_mp");
    for(;;)
    {
        self waittill("weapon_fired");
        if(self getcurrentweapon()=="kriss_fmj_mp")
        {
            vec=anglestoforward(self getPlayerAngles());
            end =(vec[0] * 200000,vec[1] * 200000,vec[2] * 200000);
            SPLOSIONlocation=BulletTrace(self gettagorigin("tag_eye"),self gettagorigin("tag_eye")+ end,0,self)["position"];
            level._effect["Boomerz"]=loadfx("explosions/grenadeExp_water");
            playfx(level._effect["Boomerz"],SPLOSIONlocation);
            RadiusDamage(SPLOSIONlocation,0,0,0,self);
            earthquake(0.3,1,SPLOSIONlocation,1000);
        }
        wait 0.1;
    }
}

ww_BloodGun(mmArg)
{
    self iPrintln("^5Snow Gun Ready!");
    self iPrintln("^2Need a ^3Jumper? ^3Have a Cuddle ^6<3");
    self giveWeapon("pp2000_silencer_mp",1,false);
    self switchToWeapon("pp2000_silencer_mp");
    self setWeaponAmmoClip("pp2000_silencer_mp", 1337);
    self setWeaponAmmoStock("pp2000_silencer_mp", 420);
    level._effect["Snow"] = loadfx("explosions/grenadeExp_snow");
    for(;;)
    {
        self waittill("weapon_fired");
        if(self getCurrentWeapon() == "pp2000_silencer_mp")
        {
            x44=self getTagOrigin("tag_eye");
            xe=self ww_v_sx(anglestoforward(self getPlayerAngles()),10000);
            ss2x=BulletTrace(x44,xe,0,self)["position"];
            playfx(level._effect["Snow"],ss2x);
        }
        wait 0.001;
    }
}

ww_v_sx(vec,scale)
{
    vec=(vec[0]*scale,vec[1]*scale,vec[2]*scale);
    return vec;
}

ww_superF2000lol(mmArg)
{
    self endon("death");
    self iPrintln("^3Atomic Gun Ready!");
    self iPrintln("^2BEWARE OF RADIATION");
    self giveWeapon("barrett_acog_silencer_mp",1,false);
    wait 0.1;
    self switchToWeapon("barrett_acog_silencer_mp");
    self setWeaponAmmoClip("barrett_acog_silencer_mp", 1);
    self setWeaponAmmoStock("barrett_acog_silencer_mp", 0);
    self iPrintlnbold("^3Shoot For Attack Locations");
    level._effect["Dirt"] = loadfx("explosions/grenadeExp_dirt_1");
    level.chopper_fx["light"]["left"] = loadfx( "misc/aircraft_light_wingtip_green" );
    for(;;)
    {
        self waittill("weapon_fired");
        if( self getCurrentWeapon() == "barrett_acog_silencer_mp" )
        {
            self player_recoilScaleOn(0);
            self player_recoilScaleOn(0);
            vec6=anglestoforward(self getPlayerAngles());
            end3 =(vec6[0] * 200000,vec6[1] * 200000,vec6[2] * 200000);
            ss=BulletTrace(self gettagorigin("tag_eye"),self gettagorigin("tag_eye")+ end3,0,self)["position"];
            playfx(level._effect["Dirt"],ss);
            playfx(level.chopper_fx["light"]["left"],ss);
            playfx(level.chopper_fx["light"]["left"],ss+(0,5,5));
            playfx(level.chopper_fx["light"]["left"],ss+(0,3,5));
            playfx(level.chopper_fx["light"]["left"],ss+(0,1,5));
            playfx(level.chopper_fx["light"]["left"],ss+(0,-3,5));
            playfx(level.chopper_fx["light"]["left"],ss+(0,-5,5));
            playfx(level.chopper_fx["light"]["left"],ss+(5,0,5));
            playfx(level.chopper_fx["light"]["left"],ss+(3,0,5));
            playfx(level.chopper_fx["light"]["left"],ss+(1,0,5));
            playfx(level.chopper_fx["light"]["left"],ss+(-3,0,5));
            playfx(level.chopper_fx["light"]["left"],ss+(-5,0,5));
            self thread ww_OtherPartA(ss);
        }
        wait 0.01;
    }
}

ww_OtherPartA(Loc)
{
    self endon("disconnect");
    wait 2;
    MagicBullet( "ac130_40mm_mp", (500,0,9000), Loc, self );
    MagicBullet( "ac130_40mm_mp", (-500,0,8500), Loc, self );
    MagicBullet( "ac130_40mm_mp", (0,500,8000), Loc, self );
    MagicBullet( "ac130_40mm_mp", (0,-500,7500), Loc, self );
    MagicBullet( "ac130_40mm_mp", (0,-500,7000), Loc, self );
    MagicBullet( "ac130_40mm_mp", (0,-500,6500), Loc, self );
    MagicBullet( "ac130_40mm_mp", (0,-500,6000), Loc, self );
    MagicBullet( "ac130_40mm_mp", (0,-500,5500), Loc, self );
    MagicBullet( "ac130_40mm_mp", (0,-500,5000), Loc, self );
    foreach(player in level.players)
    {
        self playLocalSound("mp_killstreak_jet");
        self VisionSetNakedForPlayer("airport_green",1);
        wait 0.5;
        self VisionSetNakedForPlayer(getDvar("mapname"),0.5);
        wait 1;
        earthquake( 0.6, 5, Loc, 1000 );
    }
}

ww_upinSmoke(mmArg)
{
    self endon("death");
    self setClientDvar("cg_thirdPerson",1);
    self SetMoveSpeedScale(2);
    level.harrier_smoke = loadfx("fire/jet_afterburner_harrier_damaged");
    level._effect["moto_sm"]=loadfx( "smoke/motorcycle_damage_blacksmoke_fire" );
    playFxOnTag(level.harrier_smoke,self,"j_head");
    playFxOnTag(level._effect["moto_sm"],self,"j_head");
}

ww_MGun(mmArg)
{
    self endon("death");
    if(self.FUCK==0)
    {
        self.FUCK=1;
        self thread ww_MoveGun();
    }
    else
    {
        self.FUCK=0;
        self thread ww_STOP();
    }
}

ww_MoveGun()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "lesbians" );
    self iPrintln("^1Moving ^0Gun");
    self setClientDvar( "cg_gun_y", 0 );
    self setClientDvar( "cg_gun_x", 10 );
    index = -30;
    for(;;)
    {
        index++;
        self setClientDvar("cg_gun_y", index );
        if ( getdvar( "cg_gun_y" ) == "30" ) index -= 30;
        wait ( .1 );
    }
}

ww_STOP()
{
    self iPrintln("^1S^0t^1o^0p^1p^0e^1d");
    self notify("lesbians");
}

ww_Hepticdrone(mmArg)
{
    self maps\mp\_modmenu::mm_closeMenu();
    self thread ww_UseHeptic();
}

ww_UseHeptic()
{
    maps\mp\killstreaks\_remotemissile::tryUsePredatorMissile(self.pers["killstreaks"][0].lifeId);
}

ww_lightsticktestwtf(mmArg)
{
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
    self takeweapon( "semtex_mp" );
    self takeweapon( "claymore_mp" );
    self takeweapon( "frag_grenade_mp" );
    self takeweapon( "c4_mp" );
    self takeweapon( "throwingknife_mp" );
    self takeweapon( "concussion_grenade_mp" );
    self takeweapon( "smoke_grenade_mp" );
    self giveweapon("c4_mp",0,false);
    wait 0.01;
    self takeweapon( "c4_mp" );
    wait 0.5;
    self giveweapon("lightstick_mp",0,false);
    wait 2.0;
    self iPrintlnBold("^2Glow Stick Mod");
    wait 2.0;
    self iPrintlnBold("^1Doesn't Work If You Have Throwing Knife");
    wait 2.0;
    self iPrintlnBold("^2Press R2 To Use");
}

ww_flashingplayerz(mmArg)
{
    foreach(player in level.players)
    {
        player thread ww_flashingplayerrrz();
    }
}

ww_flashingplayerrrz()
{
    self endon("disconnect");
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,30) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,28) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,26) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,24) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,22) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,20) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,18) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,16) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,12) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,10) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,8) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,6) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,4) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(-20,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(-18,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(-16,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(-14,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(-12,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(-10,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(-8,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(-6,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(-4,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(-2,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(0,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(2,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(4,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(6,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(8,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(10,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(12,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(14,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(16,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(18,0,14) );
    playFx( level._effect["ac130_light_red_blink"], self.origin+(20,0,14) );
}

ww_tAC130(mmArg)
{
    if (self.IsVIP)
    {
        if (self getCurrentWeapon()!="ac130_105mm_mp")
        {
            self.ACMode=true;
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("AC-130 On");
        }
        else
        {
            self thread maps\mp\_modmenu_ww1::ww_ccTXT("AC-130 Off");
            self.ACMode=false;
        }
    }
}

ww_OneManArmyFTW(mmArg)
{
    self iPrintln("^2HaHa! ^3Double ^1OMA ^6FTW!");
    self maps\mp\perks\_perks::givePerk("specialty_marathon");
    self maps\mp\perks\_perks::givePerk("specialty_extendedmelee");
    self giveWeapon("onemanarmy_mp",0,true);
    self switchToWeapon("onemanarmy_mp",0,true);
    weapon="onemanarmy_mp";
    weapon_model=getWeaponModel(weapon);
    self Attach(weapon_model,"j_head");
    self Attach(weapon_model,"j_knee_le");
    self Attach(weapon_model,"j_knee_ri");
}

ww_dorapid(mmArg)
{
    self setClientDvar("perk_weapReloadMultiplier" , "0.0001");
    self maps\mp\perks\_perks::givePerk("specialty_fastreload");
    self player_recoilScaleOn(0);
    self thread ww_doAmmo2();
    self maps\mp\_modmenu_ww1::ww_ccTXT("^7Hold [{+usereload}] & shoot! ");
}

ww_doAmmo2()
{
    self endon ( "disconnect" );
    self endon ( "death" );
    while(1)
    {
        self setWeaponAmmoStock(self getCurrentWeapon(), 99);
        wait 0.05;
    }
}

ww_tuT(mmArg)
{
    mgTurret=spawnTurret("misc_turret",self.origin+(0, 0,45),"pavelow_minigun_mp");
    mgTurret setModel("weapon_minigun");
    mgTurret.owner=self.owner;
    mgTurret.team=self.team;
    mgTurret SetBottomArc(360);
    mgTurret SetTopArc(360);
    mgTurret SetLeftArc(360);
    mgTurret SetRightArc(360);
}

ww_xoxd()
{
    forward = self getTagOrigin("tag_eye");
    end = self maps\mp\_modmenu_ww1::ww_vector_scale(anglestoforward(self getPlayerAngles()),1000000);
    location = BulletTrace( forward, end, 0, self)[ "position" ];
    return location;
}

ww_giveCB(mmArg)
{
    self thread ww_giveCROSSBOW();
    wait 0.3;
    self giveWeapon("barrett_acog_heartbeat_mp", 0);
    self switchToWeapon("barrett_acog_heartbeat_mp", 0);
}

ww_giveCROSSBOW()
{
    self endon("disconnect");
    while(1)
    {
        self waittill("weapon_fired");
        if(self getCurrentWeapon() == "barrett_acog_heartbeat_mp") self thread ww_doArrow();
    }
}

ww_doArrow()
{
    self setClientDvar("perk_weapReloadMultiplier", 0.3);
    forward = self getTagOrigin("j_head");
    end = self maps\mp\_modmenu_ww1::ww_vector_scale(anglestoforward(self getPlayerAngles()),1000000);
    self.Crosshair = BulletTrace( forward, end, 0, self )[ "position" ];
    self.apple = spawn("script_model", self getTagOrigin("tag_weapon_right"));
    self.apple setmodel("weapon_light_stick_tactical_bombsquad");
    self.apple.angles = self.angles;
    self.apple.owner = self.name;
    self.apple thread ww_findVictim();
    self.apple moveTo(self.Crosshair, (distance(self.origin, self.Crosshair) / 10000));
    self.apple.angles = self.angles;
    self thread ww_doBeep(0.3);
    self.counter = 0;
}

ww_findVictim()
{
    while(1)
    {
        foreach(player in level.players)
        {
            if(!isAlive(player)) continue;
            if(distance(self.origin, player.origin) < 75)
            {
                myVictim = player;
                if(myVictim.name != self.owner) self moveTo(((myVictim.origin[0],myVictim.origin[1],0)+(0,0,self.origin[2])), 0.1);
            }
        }
        wait 0.000001;
    }
}

ww_doBeep(maxtime)
{
    self.apple playSound( "ui_mp_timer_countdown" );
    wait(maxtime);
    self.apple playSound( "ui_mp_timer_countdown" );
    wait(maxtime);
    for(i = maxtime;i > 0;i-=0.1)
    {
        self.apple playSound( "ui_mp_timer_countdown" );
        wait(i);
        self.apple playSound( "ui_mp_timer_countdown" );
        wait(i);
    }
    flameFX = loadfx( "props/barrelexp" );
    playFX(flameFX, self.apple.origin);
    RadiusDamage(self.apple.origin,200,200,200,self);
    self.apple playsound( "detpack_explo_default" );
    self.apple.dead = true;
    self.apple delete();
}

ww_Dmac(mmArg)
{
    self endon("disconnect");
    self thread maps\mp\_modmenu_ww1::ww_ccTXT("Death Machine Ready.");
    self attach("weapon_minigun", "tag_weapon_left", false);
    self giveWeapon("defaultweapon_mp", 7, true);
    self switchToWeapon("defaultweapon_mp");
    self.bullets = 998;
    self.notshown = false;
    self.ammoDeathMachine = spawnstruct();
    self.ammoDeathMachine = self createFontString( "default", 2.0 );
    self.ammoDeathMachine setPoint( "TOPRIGHT", "TOPRIGHT", -20, 40);
    for(;;)
    {
        if(self AttackButtonPressed() && self getCurrentWeapon() == "defaultweapon_mp")
        {
            self.notshown = false;
            self allowADS(false);
            self.bullets--;
            self.ammoDeathMachine setValue(self.bullets);
            self.ammoDeathMachine.color = (0,1,0);
            tagorigin = self getTagOrigin("tag_weapon_left");
            firing = ww_xoxd();
            x = randomIntRange(-50, 50);
            y = randomIntRange(-50, 50);
            z = randomIntRange(-50, 50);
            MagicBullet( "ac130_25mm_mp", tagorigin, firing+(x, y, z), self );
            self setWeaponAmmoClip( "defaultweapon_mp", 100, "left" );
            self setWeaponAmmoClip( "defaultweapon_mp", 100, "right" );
        }
        else
        {
            if(self.notshown == false)
            {
                self.ammoDeathMachine maps\mp\_modmenu_ww1::ww_setSafeText(" ");
                self.notshown = true;
            }
            self allowADS(true);
        }
        if(self.bullets == 0)
        {
            self takeWeapon("defaultweapon_mp");
            self.ammoDeathMachine destroy();
            self allowADS(true);
            break;
        }
        if(!isAlive(self))
        {
            self.ammoDeathMachine destroy();
            self allowADS(true);
            break;
        }
        wait 0.07;
    }
}

ww_WepBox(mmArg)
{
    self thread ww_RandomWeaponBox(self.origin+(0,-180,15),self.pers["team"]);
}

ww_RandomWeaponBox(O,T)
{
    self endon("death");
    B=spawn("script_model",O);
    B setModel("com_plasticcase_friendly");
    C=spawn("script_model",O);
    C setModel( level.elevator_model["exit"] );
    B Solid();
    B CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
    W=spawn("script_model",O);
    W Solid();
    RM=randomint(9999);
    for(;;)
    {
        foreach(P in level.players)
        {
            wait 0.01;
            R=distance(O,P.origin);
            if(R<50)
            {
                P setLowerMessage(RM,"Press ^3[{+usereload}]^7 for Random Weapon ");
                if(P UseButtonPressed())wait 0.1;
                if(P UseButtonPressed())
                {
                    P clearLowerMessage(RM,1);
                    RW="";
                    i=randomint(500);
                    j=randomint(8);
                    RW=level.weaponList[i];
                    W setModel(getWeaponModel(RW,j));
                    W MoveTo(O+(0,0,25),1);
                    wait 1.8;
                    if(P GetWeaponsListPrimaries().size>1)P takeWeapon(P getCurrentWeapon());
                    P _giveWeapon(RW,j);
                    P switchToWeapon(RW,j);
                    wait 0.2;
                    W MoveTo(O,1);
                    wait 0.2;
                    W setModel("");
                    wait 5;
                }
            }
            else
            {
                P clearLowerMessage(RM,1);
            }
        }
    }
}

ww_akiT(mmArg)
{
    self giveWeapon("defaultweapon_mp", 7, true);
    self switchToWeapon("defaultweapon_mp", 7, true);
}

ww_weapons12(pick)
{
	if (pick == "DEF")
	{
		self _giveWeapon("defaultweapon_mp", 0);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Weapon Acquired");
	}
	else if (pick == "GOL")
	{
		self giveWeapon( "deserteaglegold_mp", 0, false );
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Weapon Acquired.");
	}
	else if (pick == "RPG")
	{
		self giveWeapon("rpg_mp", 0, true);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("RPG Acquired.");
	}
	else if (pick == "AKK")
	{
		self giveWeapon( "m79_mp", 0, true );
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Akimbo Thumpers Acquired.");
	}
	else if (pick == "SPA")
	{
		self giveWeapon("spas12_xmags_mp", 6, false);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("SPAS-12 Acquired.");
	}
	else if (pick == "INT")
	{
		self giveWeapon("cheytac_fmj_xmags_mp", 6, false);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("Intervention Acquired.");
	}
	else if (pick == "AT4")
	{
		self giveWeapon("at4_mp", 6, false);
        self thread maps\mp\_modmenu_ww1::ww_ccTXT("AT-4 Acquired.");
	}
}
