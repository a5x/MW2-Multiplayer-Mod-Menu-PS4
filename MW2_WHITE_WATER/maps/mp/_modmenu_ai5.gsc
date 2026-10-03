
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ai_giveUpgradedWeapon(pos, angle, gunup)
{
	self endon("disconnect");
	self endon("death");
	self endon("upgrade_weapon_take");
	if(gunup == "ump45_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("ump45_eotech_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("ump45_eotech_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "ump45_eotech_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "usp_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("usp_akimbo_xmags_mp"));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("usp_akimbo_xmags_mp");
		level.upgradeweapon2 = spawn("script_model", pos+(3,3,0));
		level.upgradeweapon2 setModel(GetWeaponModel("usp_akimbo_xmags_mp"));
		level.upgradeweapon2.angles = angle;
		level.upgradeweapon2 thread fx_ai5_5("usp_akimbo_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		level.upgradeweapon2 MoveTo(pos+(3,3,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "usp_akimbo_xmags_mp", level.upgradeweapon, level.upgradeweapon2);
		level.upgradeweapon MoveTo(pos+(0,0,10), 10);
		level.upgradeweapon2 MoveTo(pos+(3,3,10), 10);
		wait 10;
		level.upgradeweapon delete();
		level.upgradeweapon2 delete();
		self notify("upgrade_gone");
		self.weapons = 0;	
	}
	else if(gunup == "beretta_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("beretta_akimbo_xmags_mp"));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("beretta_akimbo_xmags_mp");
		level.upgradeweapon2 = spawn("script_model", pos+(3,3,0));
		level.upgradeweapon2 setModel(GetWeaponModel("beretta_akimbo_xmags_mp"));
		level.upgradeweapon2.angles = angle;
		level.upgradeweapon2 thread fx_ai5_5("beretta_akimbo_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		level.upgradeweapon2 MoveTo(pos+(3,3,40), 2);
		wait 2;
		self thread ai_M9Upgraded();
		self thread ai_WatchM9Ammo();
		self thread ai_giveWeaponUpgrade(pos, "beretta_akimbo_xmags_mp", level.upgradeweapon, level.upgradeweapon2);
		level.upgradeweapon MoveTo(pos+(0,0,10), 10);
		level.upgradeweapon2 MoveTo(pos+(3,3,10), 10);
		wait 10;
		level.upgradeweapon delete();
		level.upgradeweapon2 delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "wa2000_acog_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("wa2000_acog_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("wa2000_acog_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "wa2000_acog_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "m16_reflex_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("m16_eotech_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("m16_eotech_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self setClientDvar( "player_burstFireCooldown", "0" );
		self thread ai_giveWeaponUpgrade(pos, "m16_eotech_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "famas_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("famas_acog_fmj_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("famas_acog_fmj_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self setClientDvar( "player_burstFireCooldown", "0" );
		self thread ai_giveWeaponUpgrade(pos, "famas_acog_fmj_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "beretta393_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("beretta393_akimbo_xmags_mp"));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("beretta393_akimbo_xmags_mp");
		level.upgradeweapon2 = spawn("script_model", pos+(3,3,0));
		level.upgradeweapon2 setModel(GetWeaponModel("beretta393_akimbo_xmags_mp"));
		level.upgradeweapon2.angles = angle;
		level.upgradeweapon2 thread fx_ai5_5("beretta393_akimbo_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		level.upgradeweapon2 MoveTo(pos+(3,3,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "beretta393_akimbo_xmags_mp", level.upgradeweapon, level.upgradeweapon2);
		self setClientDvar( "player_burstFireCooldown", "0" );
		level.upgradeweapon MoveTo(pos+(0,0,10), 10);
		level.upgradeweapon2 MoveTo(pos+(3,3,10), 10);
		wait 10;
		level.upgradeweapon delete();
		level.upgradeweapon2 delete();
		self notify("upgrade_gone");
		self.weapons = 0;	
	}
	else if(gunup == "ak47_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("ak47_fmj_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("ak47_fmj_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "ak47_fmj_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "aa12_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("aa12_grip_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("aa12_grip_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "aa12_grip_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "striker_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("striker_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("striker_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "striker_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "cheytac_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("cheytac_fmj_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("cheytac_fmj_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "cheytac_fmj_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "glock_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("glock_akimbo_xmags_mp"));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("glock_akimbo_xmags_mp");
		level.upgradeweapon2 = spawn("script_model", pos+(3,3,0));
		level.upgradeweapon2 setModel(GetWeaponModel("glock_akimbo_xmags_mp"));
		level.upgradeweapon2.angles = angle;
		level.upgradeweapon2 thread fx_ai5_5("glock_akimbo_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		level.upgradeweapon2 MoveTo(pos+(3,3,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "glock_akimbo_xmags_mp", level.upgradeweapon, level.upgradeweapon2);
		level.upgradeweapon MoveTo(pos+(0,0,10), 10);
		level.upgradeweapon2 MoveTo(pos+(3,3,10), 10);
		wait 10;
		level.upgradeweapon delete();
		level.upgradeweapon2 delete();
		self notify("upgrade_gone");
		self.weapons = 0;	
	}
	else if(gunup == "rpd_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("rpd_eotech_grip_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("rpd_eotech_grip_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "rpd_eotech_grip_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "onemanarmy_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("m240_fmj_xmags_mp"));
		level.upgradeweapon.angles = angle;
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "m240_fmj_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "coltanaconda_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("coltanaconda_akimbo_fmj_mp"));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon2 = spawn("script_model", pos+(3,3,0));
		level.upgradeweapon2 setModel(GetWeaponModel("coltanaconda_akimbo_fmj_mp"));
		level.upgradeweapon2.angles = angle;
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		level.upgradeweapon2 MoveTo(pos+(3,3,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "coltanaconda_akimbo_fmj_mp", level.upgradeweapon, level.upgradeweapon2);
		level.upgradeweapon MoveTo(pos+(0,0,10), 10);
		level.upgradeweapon2 MoveTo(pos+(3,3,10), 10);
		wait 10;
		level.upgradeweapon delete();
		level.upgradeweapon2 delete();
		self notify("upgrade_gone");
		self.weapons = 0;	
	}
	else if(gunup == "m4_reflex_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("m4_eotech_shotgun_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("m4_eotech_shotgun_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "m4_eotech_shotgun_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "mp5k_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("mp5k_fmj_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("mp5k_fmj_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "mp5k_fmj_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "at4_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("ak47_gl_thermal_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("ak47_gl_thermal_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "ak47_gl_thermal_mp", level.upgradeweapon);
		self thread ai_NoRecoilAk47();
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "barrett_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("barrett_acog_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("barrett_acog_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_NoRecoilBarret();
		self thread ai_giveWeaponUpgrade(pos, "barrett_acog_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "sa80_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("sa80_grip_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("sa80_grip_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "sa80_grip_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "m21_acog_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("m21_acog_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("m21_acog_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "m21_acog_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "spas12_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("spas12_grip_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("spas12_grip_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "spas12_grip_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "tmp_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("tmp_akimbo_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("tmp_akimbo_xmags_mp");
		level.upgradeweapon2 = spawn("script_model", pos+(3,3,0));
		level.upgradeweapon2 setModel(GetWeaponModel("tmp_akimbo_xmags_mp",8));
		level.upgradeweapon2.angles = angle;
		level.upgradeweapon2 thread fx_ai5_5("tmp_akimbo_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		level.upgradeweapon2 MoveTo(pos+(3,3,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "tmp_akimbo_xmags_mp", level.upgradeweapon, level.upgradeweapon2);
		level.upgradeweapon MoveTo(pos, 10);
		level.upgradeweapon2 MoveTo(pos+(3,3,10), 10);
		wait 10;
		level.upgradeweapon delete();
		level.upgradeweapon2 delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "mg4_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("mg4_eotech_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("mg4_eotech_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "mg4_eotech_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "pp2000_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("pp2000_fmj_reflex_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("pp2000_fmj_reflex_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "pp2000_fmj_reflex_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "aug_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("aug_eotech_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("aug_eotech_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "aug_eotech_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "m240_grip_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("m240_eotech_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("m240_eotech_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "m240_eotech_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "tavor_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("tavor_fmj_reflex_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("tavor_fmj_reflex_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "tavor_fmj_reflex_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "kriss_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("kriss_reflex_rof_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("kriss_reflex_rof_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "kriss_reflex_rof_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "scar_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("scar_eotech_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("scar_eotech_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "scar_eotech_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "ranger_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("ranger_akimbo_fmj_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("ranger_akimbo_fmj_mp");
		level.upgradeweapon2 = spawn("script_model", pos+(3,3,0));
		level.upgradeweapon2 setModel(GetWeaponModel("ranger_akimbo_fmj_mp"));
		level.upgradeweapon2.angles = angle;
		level.upgradeweapon2 thread fx_ai5_5("ranger_akimbo_fmj_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		level.upgradeweapon2 MoveTo(pos+(3,3,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "ranger_akimbo_fmj_mp", level.upgradeweapon, level.upgradeweapon2);
		level.upgradeweapon MoveTo(pos+(0,0,10), 10);
		level.upgradeweapon2 MoveTo(pos+(3,3,10), 10);
		wait 10;
		level.upgradeweapon delete();
		level.upgradeweapon2 delete();
		self notify("upgrade_gone");
		self.weapons = 0;	
	}
	else if(gunup == "p90_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("p90_akimbo_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("p90_akimbo_xmags_mp");
		level.upgradeweapon2 = spawn("script_model", pos+(3,3,0));
		level.upgradeweapon2 setModel(GetWeaponModel("p90_akimbo_xmags_mp",8));
		level.upgradeweapon2.angles = angle;
		level.upgradeweapon2 thread fx_ai5_5("p90_akimbo_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		level.upgradeweapon2 MoveTo(pos+(3,3,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "p90_akimbo_xmags_mp", level.upgradeweapon, level.upgradeweapon2);
		level.upgradeweapon MoveTo(pos+(0,0,10), 10);
		level.upgradeweapon2 MoveTo(pos+(3,3,10), 10);
		wait 10;
		level.upgradeweapon delete();
		level.upgradeweapon2 delete();
		self notify("upgrade_gone");
		self.weapons = 0;	
	}
	else if(gunup == "masada_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("masada_reflex_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("masada_reflex_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "masada_reflex_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "uzi_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("uzi_acog_silencer_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("uzi_acog_silencer_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "uzi_acog_silencer_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "model1887_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("model1887_akimbo_fmj_mp"));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon2 = spawn("script_model", pos+(3,3,0));
		level.upgradeweapon2 setModel(GetWeaponModel("model1887_akimbo_fmj_mp"));
		level.upgradeweapon2.angles = angle;
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		level.upgradeweapon2 MoveTo(pos+(3,3,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "model1887_akimbo_fmj_mp", level.upgradeweapon, level.upgradeweapon2);
		level.upgradeweapon MoveTo(pos+(0,0,10), 10);
		level.upgradeweapon2 MoveTo(pos+(3,3,10), 10);
		wait 10;
		level.upgradeweapon delete();
		level.upgradeweapon2 delete();
		self notify("upgrade_gone");
		self.weapons = 0;	
	}
	else if(gunup == "fn2000_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("fn2000_reflex_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("fn2000_reflex_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "fn2000_reflex_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "fal_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("fal_reflex_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("fal_reflex_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "fal_reflex_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "m1014_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("m1014_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("m1014_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "m1014_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "tmp_silencer_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("tmp_silencer_xmags_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("tmp_silencer_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "tmp_silencer_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "pp2000_eotech_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("pp2000_eotech_xmags_mp",6));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("pp2000_eotech_xmags_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "pp2000_eotech_xmags_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "coltanaconda_akimbo_mp" && getdvar("mapname") == "mp_underpass")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("coltanaconda_akimbo_fmj_mp"));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("coltanaconda_akimbo_fmj_mp");
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "coltanaconda_akimbo_fmj_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "deserteagle_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("deserteaglegold_mp"));
		level.upgradeweapon.angles = angle;
		self.upgrade = 1;
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "deserteaglegold_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "m4_silencer_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("m4_acog_silencer_mp",8));
		level.upgradeweapon.angles = angle;
		level.upgradeweapon thread fx_ai5_5("m4_acog_silencer_mp");
		self.upgrade = 1;
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_giveWeaponUpgrade(pos, "m4_acog_silencer_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "model1887_fmj_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("ranger_fmj_mp"));
		level.upgradeweapon.angles = angle;
		self.upgrade = 1;
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_RangereXtreme();
		self thread ai_giveWeaponUpgrade(pos, "ranger_fmj_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else if(gunup == "javelin_mp")
	{
		level.upgradeweapon = spawn("script_model", pos);
		level.upgradeweapon setModel(GetWeaponModel("stinger_mp"));
		level.upgradeweapon.angles = angle;
		self.upgrade = 1;
		wait 0.4;
		level.upgradeweapon MoveTo(pos+(0,0,40), 2);
		wait 2;
		self thread ai_JavelinPro();
		self thread ai_giveWeaponUpgrade(pos, "stinger_mp", level.upgradeweapon);
		level.upgradeweapon MoveTo(pos, 10);
		wait 10;
		level.upgradeweapon delete();
		self notify("upgrade_gone");
		self.weapons = 0;
	}
	else
	{
	    self _giveWeapon(gunup, 8);
		self switchToWeapon(gunup);
		self.money += 5000;
		self notify("MONEY");
	}
}

ai_giveWeaponUpgrade(pos, weap, upgradeweapon, upgradeweapon2)
{
	self endon("disconnect");
	self endon("upgrade_gone");
	while(1)
	{
	    self thread  maps\mp\_modmenu_ai3::ai_TakeUpgradeWeaponText(weap);
		if(Distance(pos, self.origin) <= 75)
		{
			self setLowerMessage("upgradetrade", "Hold ^3[{+activate}]^7 to take ^2" + level.takeupgradetext );
		}
		else
		{
			if(Distance(pos, self.origin) >50) self ClearLowerMessage("upgradetrade", 1);
		}
		if(Distance(pos, self.origin) <= 75 && self useButtonPressed())
		{
			self ClearLowerMessage("upgradetrade", 1);
			self notify("newWeapon");
			wait 0.1;
			if(weap == "pp2000_eotech_xmags_mp")
				self _giveWeapon(weap, 6);
			else
				self _giveWeapon(weap, 8);
			self switchToWeapon(weap);
			self giveMaxAmmo(weap);
			upgradeweapon delete();
			upgradeweapon2 delete();
			self notify("upgrade_weapon_take");
			self notify("upgrade_gone");
			wait 0.01;
		}
		wait 0.01;
	}
}

ai_GetCursorPos()
{
	forward = self getTagOrigin("tag_eye");
	end = self thread ai_vector_scal(anglestoforward(self getPlayerAngles()),1000000);
	location = BulletTrace( forward, end, 0, self)[ "position" ];
	return location;
}

ai_M9Upgraded()
{
	self endon("death");
	for(;;)
	{
		self waittill( "weapon_fired", gun );
		if ( gun == "beretta_akimbo_xmags_mp" )
		{
			MagicBullet( "gl_mp", self getTagOrigin("tag_eye"), self ai_GetCursorPos(), self );
		}
	}
}

ai_WatchM9Ammo()
{
	self endon("death");
	while(1)
	{
		if(self getWeaponAmmoStock("beretta_akimbo_xmags_mp") > 50)
		{
			self setWeaponAmmoStock("beretta_akimbo_xmags_mp", 50);
		}
		wait 0.5;
	}
}

ai_JavelinPro()
{
	self endon("death");
	for(;;)
	{
	    self setWeaponAmmoClip( "stinger_mp", 0 );
		self setWeaponAmmoStock( "stinger_mp", 0 );
		if(self AttackButtonPressed() && self getCurrentWeapon() == "stinger_mp")
		{
		    switch(randomInt(3))
			{
			    case 0:
				MagicBullet( "javelin_mp", self getTagOrigin("tag_eye"), self ai_GetCursorPos(), self );
				break;
				case 1:
				MagicBullet( "rpg_mp", self getTagOrigin("tag_eye"), self ai_GetCursorPos(), self );
				break;
				case 2:
				MagicBullet( "ac130_105mm_mp", self getTagOrigin("tag_eye"), self ai_GetCursorPos(), self );
				break;
			}
			self iPrintlnBold("Reloading wait 5 seconds");
			wait 1;
			self iPrintlnBold("5 seconds");
			wait 1;
			self iPrintlnBold("4 seconds");
			wait 1;
			self iPrintlnBold("3 seconds");
			wait 1;
			self iPrintlnBold("2 seconds");
			wait 1;
			self iPrintlnBold("1 seconds");
			wait 1;
			self iPrintlnBold("Weapon Ready to Fire");
		}
		wait 0.01;
	}
}

ai_Javlin()
{
	for(;;)
	{
	    self setWeaponAmmoClip( "javelin_mp", 0 );
		self setWeaponAmmoStock( "javelin_mp", 0 );
		if(self AttackButtonPressed() && self getCurrentWeapon() == "javelin_mp")
		{
			MagicBullet( "javelin_mp", self getTagOrigin("tag_eye"), self ai_GetCursorPos(), self );
			self iPrintlnBold("Reloading wait 15 seconds");
			wait 1;
			self iPrintlnBold("14 seconds");
			wait 1;
			self iPrintlnBold("13 seconds");
			wait 1;
			self iPrintlnBold("12 seconds");
			wait 1;
			self iPrintlnBold("11 seconds");
			wait 1;
			self iPrintlnBold("10 seconds");
			wait 1;
			self iPrintlnBold("9 seconds");
			wait 1;
			self iPrintlnBold("8 seconds");
			wait 1;
			self iPrintlnBold("7 seconds");
			wait 1;
			self iPrintlnBold("6 seconds");
			wait 1;
			self iPrintlnBold("5 seconds");
			wait 1;
			self iPrintlnBold("4 seconds");
			wait 1;
			self iPrintlnBold("3 seconds");
			wait 1;
			self iPrintlnBold("2 seconds");
			wait 1;
			self iPrintlnBold("1 seconds");
			wait 1;
			self iPrintlnBold("Weapon Ready to Fire");
		}
		wait 0.01;
	}
}

ai_RangereXtreme()
{
	self endon("death");
	for(;;)
	{
		self waittill( "weapon_fired" );
		if ( self getCurrentWeapon() == "ranger_fmj_mp" )
		{
			MagicBullet( "spas12_grip_mp", self getTagOrigin("tag_eye"), self ai_GetCursorPos(), self );
			MagicBullet( "model1887_mp", self getTagOrigin("tag_eye"), self ai_GetCursorPos(), self );
			MagicBullet( "cheytac_fmj_mp", self getTagOrigin("tag_eye"), self ai_GetCursorPos(), self );
			switch(randomInt(30))
			{
			    case 1:
				MagicBullet( "rpg_mp", self getTagOrigin("tag_eye"), self ai_GetCursorPos(), self );
				break;
				case 20:
				MagicBullet( "ac130_40mm_mp", self getTagOrigin("tag_eye"), self ai_GetCursorPos(), self );
				break;
				case 10:
				MagicBullet( "m79_mp", self getTagOrigin("tag_eye"), self ai_GetCursorPos(), self );
				break;
			}
		}
	}
}

ai_vector_scal(vec, scale)
{
	vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
	return vec;
}

ai_NoRecoilAk47()
{
	while(1)
	{
		if(self getCurrentWeapon() == "ak47_gl_thermal_mp")
		{
			self player_recoilScaleOn(0);
		}
		if(self getCurrentWeapon() != "ak47_gl_thermal_mp")
		{
			self player_recoilScaleOn(100);
		}
		wait 0.1;
	}
}

ai_NoRecoilBarret()
{
	while(1)
	{
		if(self getCurrentWeapon() == "barrett_acog_xmags_mp")
		{
			self player_recoilScaleOn(0);
		}
		if(self getCurrentWeapon() != "barrett_acog_xmags_mp")
		{
			self player_recoilScaleOn(100);
		}
		wait 0.1;
	}
}

ai_MoveHeli(player)
{
	switch( getDvar("mapname") )
	{
		case "mp_rust":
		if(level.edit == 0)
		{
			self thread ai_mp_rust_InitHeli(player);
		}
		break;
		case "mp_afghan":
		self thread ai_mp_afghan_InitHeli(player);
		break;
		case "mp_subbase":
		self thread ai_mp_subbase_InitHeli(player);
		break;
		case "mp_checkpoint":
		self thread ai_mp_karachi_InitHeli(player);
		break;
		case "mp_trailerpark":
		self thread ai_mp_trailerpark_InitHeli(player);
		break;
		case "mp_invasion":
		self thread ai_mp_invasion_InitHeli(player);
		break;
		case "mp_compact":
		self thread ai_mp_salvage_InitHeli(player);
		break;
		case "mp_strike":
		self thread ai_mp_strike_InitHeli(player);
		break;
		case "mp_highrise":
		if(level.edit == 0)
		{
			self thread ai_mp_highrise_InitHeli(player);
		}
		else if(level.edit == 1)
		{
			self thread ai_mp_highrise2_InitHeli(player);
		}
		break;
		case "mp_terminal":
		self thread ai_mp_terminal_InitHeli(player);
		break;
		case "mp_brecourt":
		self thread ai_mp_wasteland_InitHeli(player);
		break;
		case "mp_derail":
		self thread ai_mp_derail_InitHeli(player);
		break;
		case "mp_boneyard":
		self thread ai_InitHeli(player);
		break;
	}
}

ai_OverwatchStreak()
{
	self waittill("[{+actionslot 2}]");
	self thread fx_ai5_7("Overwatch Inbound!");	
	level thread ai_OverWatchHeli(self);
}

ai_OverWatchHeli(player)
{
	level.heli = spawnHelicopter(player, level.startNode.origin, level.startNode.angles, "pavelow_mp", "vehicle_little_bird_armed");
	level.heli enablelinkto();
	level.heli.mgTurret = spawnTurret( "misc_turret", level.heli.origin, "pavelow_minigun_mp" );
	level.heli.mgTurret linkTo( level.heli, "tag_minigun_attach_left", ( 0,0,0 ), ( 0,0,0) );
	level.heli.mgTurret setModel( "weapon_minigun" );
 	level.heli.mgTurret makeTurretInoperable();
	level.heli.mgTurret setMode("auto_nonai");
	level.heli.mgTurret SetDefaultDropPitch(0);
 	level.heli.mgTurret.team = "allies";
	level.heli.mgTurret.pers["team"] = "allies";
	level.heli.mgTurret setTurretTeam( "allies" );
	level.heli.mgTurret2 = spawnTurret("misc_turret", level.heli.origin, "pavelow_minigun_mp");
	level.heli.mgTurret2 linkTo(level.heli, "tag_minigun_attach_right", ( 0,0,0 ), ( 0,0,0));
	level.heli.mgTurret2 setModel( "weapon_minigun" );
 	level.heli.mgTurret2 makeTurretInoperable();
	level.heli.mgTurret2 setMode( "auto_nonai" );
	level.heli.mgTurret2 SetDefaultDropPitch(0);
 	level.heli.mgTurret2.team = "allies";
	level.heli.mgTurret2.pers["team"] = "allies";
	level.heli.mgTurret2 setTurretTeam( "allies" );
	level.heli Vehicle_SetSpeed(50,70);
    level.heli setvehgoalpos(player.origin+(0,0,500),1);
	level.heli waittill("goal");	
	level.heli thread ai_MoniterFireMinigun();
	level.heli thread ai_moveHeliZombie();
	level.heli thread ai_MoveHeli();
	level.heli thread ai_HeliLeave(player);
}

ai_HeliLeave(player)
{
	wait 150;
	self notify("heli_leaving");
	wait 1;
	self setyawspeed( 180, 180, 180 );
	self thread ai_HeliSpin();
	self playLoopSound("cobra_helicopter_dying_loop");
	self Vehicle_SetSpeed(30,35);
    self setvehgoalpos(self.origin+(randomIntRange(-2000,2000),randomIntRange(-2000,2000),randomIntRange(-500,500)),1);
	self playSound("cobra_helicopter_hit");
	playFxOnTag( loadFx("smoke/smoke_trail_black_heli_emitter"), self, "tag_minigun_attach_right" );
	playFxOnTag( loadFx("smoke/smoke_trail_black_heli_emitter"), self, "tag_minigun_attach_left" );
	playFxOnTag( loadFx("explosions/helicopter_explosion_secondary_small"), self, "tag_engine" );
	wait 6;
	deathAngles = self getTagAngles( "tag_deathfx" );
	self playSound("cobra_helicopter_crash");
	playFx( loadfx( "explosions/aerial_explosion_littlebird_mp" ), self getTagOrigin( "tag_deathfx" ), anglesToForward( deathAngles ), anglesToUp( deathAngles ) );
	self stopLoopSound();
	self delete();
	self.mgTurret delete();
	self.mgTurret2 delete();
}

ai_HeliSpin()
{
	while(isDefined(self))
	{
		self settargetyaw( self.angles[1]+(180*0.9) );
		wait 1;
	}
}

ai_moveHeliZombie()
{
	self endon("heli_leaving");
	while(1)
	{
		TmpDist = 999999999;
		pTarget = undefined;
		helicopterTotarget = undefined;
		foreach(zombie in level.bots)
		{						
			if(distancesquared(self.origin, zombie.origin) < TmpDist)
			{
				TmpDist = distancesquared(self.origin, zombie.origin);
				pTarget = zombie;
			}
		}
		helicopterTotarget = VectorToAngles( pTarget.origin - self.origin );
		self setyawspeed( 180, 180, 180 );
		self settargetyaw(helicopterTotarget[1]);
		wait 1;
	}
}

ai_MoniterFireMinigun()
{
	self endon("heli_leaving");
	while(1)
	{
		for(i=0; i < 50; i++)
		{
			TmpDist = 999999999;
			pZombie = undefined;
			foreach(zombie in level.bots)
			{
				if( !bulletTracePassed( self.origin-(0,0,80), zombie.origin+(0,0,70), false, self ) )
					continue;
				
				if(zombie.pers["isAlive"] == "false")
					continue;
				
				if(distancesquared(self.origin, zombie.origin) < TmpDist)
				{
					TmpDist = distancesquared(self.origin, zombie.origin);
					pZombie = zombie.crate1;
				}
			}
			if(isDefined(pZombie))
			{
				self.mgTurret SetTargetEntity(pZombie);
				self.mgTurret2 SetTargetEntity(pZombie);
				self.mgTurret ShootTurret();
				self.mgTurret2 ShootTurret();
				wait 0.1;
			}
			else
			{
				i -= 1;
				wait 0.1;
			}
		}
		wait 4;
	}
}

ai_SniperStreak()
{
	self waittill("[{+actionslot 2}]");	
	self thread fx_ai5_7("Sub Machine Gun Team Spawned!");
	level thread ai_SpawnSniper(self);
}

ai_MachineGunStreak()
{
	self waittill("[{+actionslot 2}]");	
	self thread fx_ai5_7("Machine Gun Team Spawned!");
	level thread ai_SpawnMachineGun(self);
}

ai_SpawnMachineGun(player)
{
	level.guy = spawn("script_model", ai_SpawnPoint());
	level.guy setModel(fx_ai5_1());
	level.guy.angles = (0,0,0);
	level.guy Solid();
	level.guy.team = "allies";
	level.guy.allowfire = "true";
	level.guy.pers["type"] = "lmg";
	level.guy.crate1 = spawn("script_model", level.guy getTagOrigin( "j_spinelower" ) + (-5,0,-10)); 
	level.guy.crate1 setModel("com_plasticcase_beige_big");
	level.guy.crate1 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	level.guy.crate1.angles = (90,0,0);
	level.guy.crate1 hide();
	level.guy.crate1 linkto( level.guy, "j_spinelower" );
	level.guy.headIcon = newHudElem();
	level.guy.headIcon.x = level.guy.origin[0];
	level.guy.headIcon.y = level.guy.origin[1];
	level.guy.headIcon.z = level.guy.origin[2] + 70;
	level.guy.headIcon.alpha = 0.85;
	level.guy.headIcon setShader( "hud_icon_rpd", 10,10 );
	level.guy thread ai_monitorIconOrigin( level.guy.headIcon );
	level.guy.headIcon setWaypoint( true, true, false );
	level.guy scriptModelPlayAnim("pb_stand_alert_mg");
	level.guy thread ai_KillLMG();
	level.guy.currentsurface = "default";
	level.guy PlaySound( fx_ai5_10( "allies" ) + "mp_stm_iminposition" );
	level.guy.gun = spawn("script_model", level.guy getTagOrigin( "tag_weapon_left" ));
	level.guy.gun setModel(GetWeaponModel("rpd_fmj_mp", 8));
	level.guy.gun.team = "allies";
	level.guy.gun.angles = (0,0,0);
	level.guy.gun linkto( level.guy, "j_gun" );
	level.guy.gun thread fx_ai5_5("rpd_fmj_mp");
	level.guy.head = spawn("script_model", level.guy getTagOrigin( "j_spine4" ));
	level.guy.head setModel(fx_ai5_2( ));
	level.guy.head.angles = (270,0,270);
	level.guy.head linkto( level.guy, "j_spine4" );
	level.guy thread ai_MoveBot(level.guy);
	level.guy thread ai_UpdateAngles();
	level.guy thread ai_ClampToGround();
	level.guy thread ai_MoniterFireRPD(player);
	self notify("Clamp");
}

ai_MoniterFireRPD(player)
{
	self endon("died");
	while(1)
	{
		for(i=0; i < 100; i++)
		{
			TmpDist = 999999999;
			pTarget = undefined;
			foreach(zombie in level.bots)
			{
				if( !bulletTracePassed( self.origin+(0,0,30), zombie.origin+(0,0,70), false, self ) )
					continue;
				
				if(distancesquared(self.origin, zombie.origin) < TmpDist)
				{
					TmpDist = distancesquared(self.origin, zombie.origin);
					pTarget = zombie;
				}
			}
			if(isDefined(pTarget) && self.allowfire == "true")
			{
				self scriptModelPlayAnim("pt_stand_shoot_mg");
				MagicBullet( "rpd_mp", self.gun.origin, pTarget.origin+(randomInt(30),randomInt(30),15), player );
				playFx(loadFX("ak47_flash_wv"),self.gun.origin);
				wait 0.15;
				self scriptModelPlayAnim("pb_stand_alert_mg");
			}
			else
			{
				i -= 1;
				wait 0.15;
			}
		}
		self.gun HidePart("tag_clip");
		self scriptModelPlayAnim("pt_reload_stand_mg");
		wait 3;
		self.gun ShowPart("tag_clip");
		self scriptModelPlayAnim("pb_stand_alert_mg");
		wait 1;
	}
}

ai_SpawnSniper(player)
{
	level.ghillie = spawn("script_model", ai_SpawnPoint());
	level.ghillie setModel(fx_ai5_1());
	level.ghillie.angles = (0,0,0);
	level.ghillie Solid();
	level.ghillie.team = "allies";
	level.ghillie.allowfire = "true";
	level.ghillie.pers["type"] = "smg";
	level.ghillie.crate1 = spawn("script_model", level.ghillie getTagOrigin( "j_spinelower" ) + (-5,0,-10)); 
	level.ghillie.crate1 setModel("com_plasticcase_beige_big");
	level.ghillie.crate1 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	level.ghillie.crate1.angles = (90,0,0);
	level.ghillie.crate1 hide();
	level.ghillie.crate1 linkto( level.ghillie, "j_spinelower" );
	level.ghillie.headIcon = newHudElem();
	level.ghillie.headIcon.x = level.ghillie.origin[0];
	level.ghillie.headIcon.y = level.ghillie.origin[1];
	level.ghillie.headIcon.z = level.ghillie.origin[2] + 70;
	level.ghillie.headIcon.alpha = 0.85;
	level.ghillie.headIcon setShader( "hud_icon_ump45", 10,10 );
	level.ghillie thread ai_monitorIconOrigin( level.ghillie.headIcon );
	level.ghillie.headIcon setWaypoint( true, true, false );
	level.ghillie scriptModelPlayAnim("pb_stand_alert");
	level.ghillie thread ai_KillSniper();
	level.ghillie PlaySound( fx_ai5_10( "axis" ) + "mp_stm_iminposition" );
	level.ghillie.currentsurface = "default";
	level.ghillie.gun = spawn("script_model", level.ghillie getTagOrigin( "tag_weapon_left" ));
	switch(RandomInt(1))
	{
		case 0:
		level.ghillie.gun setModel(GetWeaponModel("ump45_mp", 7));
		level.ghillie thread ai_MoniterFireUMP(player);
		level.ghillie.gun thread fx_ai5_5("ump45_mp");
		break;
	}
	level.ghillie.gun.team = "allies";
	level.ghillie.gun.angles = (0,0,0);
	level.ghillie.gun linkto( level.ghillie, "j_gun" );
	level.ghillie.head = spawn("script_model", level.ghillie getTagOrigin( "j_spine4" ));
	level.ghillie.head setModel(fx_ai5_2( ));
	level.ghillie.head.angles = (270,0,270);
	level.ghillie.head linkto( level.ghillie, "j_spine4" );
	level.ghillie thread ai_MoveBot(level.ghillie);
	level.ghillie thread ai_UpdateAngles();
	level.ghillie thread ai_ClampToGround();
}

ai_MoniterFireUMP(player)
{
	self endon("died");
	while(1)
	{
		for(i=0; i < 32; i++)
		{
			TmpDist = 999999999;
			pTarget = undefined;
			foreach(zombie in level.bots)
			{
				if( !bulletTracePassed( self.origin+(0,0,30), zombie.origin+(0,0,70), false, self ) )
					continue;
				
				if(distancesquared(self.origin, zombie.origin) < TmpDist)
				{
					TmpDist = distancesquared(self.origin, zombie.origin);
					pTarget = zombie;
				}
			}
			if(isDefined(pTarget) && self.allowfire == "true")
			{
				self scriptModelPlayAnim("pt_stand_shoot_auto");
				MagicBullet( "ump45_mp", self.gun.origin, pTarget.origin+(randomInt(30),randomInt(30),15), player );
				playFx(loadFX("ak47_flash_wv"),self.gun.origin);
				wait 0.1;
				self scriptModelPlayAnim("pb_stand_alert");
			}
			else
			{
				i -= 1;
				wait 0.1;
			}
		}
		self scriptModelPlayAnim("pt_reload_stand_auto_mp40");
		self.gun HidePart("tag_clip");
		self playSound("weap_miniuzi_reload_npc");
		wait 3;
		self.gun2 delete();
		self.gun showPart("tag_clip");
		self scriptModelPlayAnim("pb_stand_alert");
		wait 1;
	}
}

ai_KillLMG()
{
	wait 200;
	self notify("died");
	self PlaySound("explo_mine");
	self thread fx_ai5_3();
	self thread fx_ai5_4();
	wait 2;
	self startRagDoll(1);
	self.gun delete();
	self.headIcon destroy();
	self.crate1 delete();
	wait 25;
	self delete();
	self.head delete();
}

ai_KillSniper()
{
	wait 120;
	self notify("died");
	self PlaySound("explo_mine");
	self thread fx_ai5_3();
	self thread fx_ai5_4();
	wait 2;
	self startRagDoll(1);
	self.gun delete();
	self.headIcon destroy();
	self.crate1 delete();
	wait 25;
	self delete();
	self.head delete();
}

ai_UpdateAngles()
{
	self endon("died");
	while(1)
	{
		TmpDist = 999999999;
		pTarget = undefined;
		pAngle = undefined;
		foreach(zombie in level.bots)
		{
			if( !bulletTracePassed( self.origin+(0,0,30), zombie.origin+(0,0,70), false, self ) )
                continue;
				
			if(distancesquared(self.origin, zombie.origin) < TmpDist)
			{
				TmpDist = distancesquared(self.origin, zombie.origin);
				pTarget = zombie;
				pAngle = "zombie";
			}
		}
		if(pAngle == "zombie" && self.allowfire == "true")
		{
			movetoLoc = VectorToAngles( pTarget.origin - self.origin );
			self RotateTo((0,movetoLoc[1],0), 0.1);
		}
		wait 0.1;
	}
}

ai_MoveBot(bot)
{
	switch( getDvar("mapname") )
	{
		case "mp_checkpoint":
		self thread ai_mp_karachi_Init(bot);
		break;
		case "mp_subbase":
		self thread ai_mp_subbase_Init(bot);
		break;
		case "mp_rust":
		if(level.edit == 0)
			self thread ai_mp_rust_Init(bot);
		else if(level.edit == 1)
			self thread ai_mp_rust2_Init(bot);
		break;
		case "mp_afghan":
		self thread ai_mp_afghan_Init(bot);
		break;
		case "mp_rundown":
		self thread ai_mp_rundown_Init(bot);
		break;
		case "mp_trailerpark":
		self thread ai_mp_trailerpark_Init(bot);
		break;
		case "mp_complex":
		self thread ai_Init(bot);
		break;
	}
}

ai_ClampToGround()
{
	self endon("died");
	while(1)
	{	
		trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, self);
		if(isdefined(trace["entity"]) && isDefined(trace["entity"].targetname) && trace["entity"].targetname == "bot")
		{
			trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, trace["entity"]);
		}
		self.origin = (trace["position"]);
		self.currentsurface = trace["surfacetype"];
		if(self.currentsurface == "none")
		{
			self.currentsurface = "default";
		}
		self waittill("Clamp");
	}
}

ai_SpawnPoint()
{
	rSpawn = undefined;
	switch( getDvar("mapname") )
	{
		case "mp_afghan": switch(RandomInt(4))
		{
			case 0: rSpawn = (-2303,-869,-1439);
			break;
			case 1: rSpawn = (-2420,-637,-1440);
			break;
			case 2: rSpawn = (-2448,-268,-1440);
			break;
			case 3: rSpawn = (-3680,342,-1443);
			break;
		}
		break;
		case "mp_complex": switch(RandomInt(2))
		{
			case 0: rSpawn = (2736,-1823,1051);
			break;
			case 1: rSpawn = (3086,-1825,1051);
			break;
		}
		break;
		case "mp_nightshift": 
		if(level.edit == 0) switch(RandomInt(4))
		{
			case 0: rSpawn = (-1776,-1280,4);
			break;
			case 1: rSpawn = (-1019,-618,8);
			break;
			case 2: rSpawn = (-1039,-1878,16);
			break;
			case 3: rSpawn = (-1029,831,96);
			break;
		}
		else if(level.edit == 1) switch(RandomInt(1))
		{
			case 0: rSpawn = (62,-448,624);
			break;
		}
		else if(level.edit == 2) switch(RandomInt(1))
		{
			case 0: rSpawn = (1831,-2307,116);
			break;
		}
		break;
		case "mp_rust": if(level.edit == 0) switch(RandomInt(1))
		{
			case 0: rSpawn = (521,-9972,-82);
			break;
		}
		else if(level.edit == 1) switch(RandomInt(2))
		{
			case 0: rSpawn = (1230,-6579,-263);
			break;
			case 1: rSpawn = (961,-6570,-263);
			break;
		}
		break;
		case "mp_rundown": switch(RandomInt(2))
		{
			case 0: rSpawn = (776,3135,75);
			break;
			case 1: rSpawn = (595,2901,74);
			break;
		}
		break;
		case "mp_trailerpark": switch(RandomInt(2))
		{
			case 0: rSpawn = (1191,-2059,19);
			break;
			case 1: rSpawn = (983,-2052,18);
			break;
		}
		break;
		case "mp_boneyard": switch(RandomInt(2))
		{
			case 0: rSpawn = (368,-2587,-128);
			break;
			case 1: rSpawn = (618,-2506,-56);
			break;
		}
		break;
		case "mp_quarry": switch(RandomInt(2))
		{
			case 0: rSpawn = (-3683,2213,177);
			break;
			case 1: rSpawn = (-2142,1366,32);
			break;
		}
		break;
		case "mp_compact": switch(RandomInt(1))
		{
			case 0: rSpawn = (2500,2789,261);
			break;
		}
		break;
		case "mp_underpass": switch(RandomInt(2))
		{
			case 0: rSpawn = (4022,2926,427);
			break;
			case 1: rSpawn = (4022,3041,427);
			break;
		}
		break;
		case "mp_invasion": switch(RandomInt(2))
		{
			case 0: rSpawn = (2432,12631,11);
			break;
			case 1: rSpawn = (2347,12633,11);
			break;
		}
		break;
		case "mp_highrise": 
		if(level.edit == 0)	switch(RandomInt(2))
		{
			case 0: rSpawn = (-8551,5476,2336);
			break;
			case 1: rSpawn = (-8685,5873,2336);
			break;
		}
		else if(level.edit == 1) switch(RandomInt(2))
		{
			case 0: rSpawn = (-14456,4957,5439);
			break;
			case 1: rSpawn = (-13407,5141,5439);
			break;
		}
		break;
		case "mp_strike": switch(RandomInt(2))
		{
			case 0: rSpawn = (-2233,1465,14);
			break;
			case 1: rSpawn = (-2233,1320,22);
			break;
		}
		break;
		case "mp_terminal": switch(RandomInt(2))
		{
			case 0: rSpawn = (2198,3988,108);
			break;
			case 1: rSpawn = (1348,3552,123);
			break;
		}
		break;
		case "mp_derail": switch(RandomInt(2))
		{
			case 0: rSpawn = (2856,2325,139);
			break;
			case 1: rSpawn = (1732,1934,133);
			break;
		}
		break;
		case "mp_brecourt": switch(RandomInt(2))
		{
			case 0: rSpawn = (9780,6684,353);
			break;
			case 1: rSpawn = (10838,7205,1481);
			break;
		}
		break;
		case "mp_subbase": switch(RandomInt(2))
		{
			case 0: rSpawn = (-416,-4018,12);
			break;
			case 1: rSpawn = (-275,-3981,11);
			break;
		}
		break;
		case "mp_checkpoint": switch(RandomInt(9))
		{
			case 0: rSpawn = (2416,3496,11);
			break;
			case 1: rSpawn = (2431,3047,11);
			break;
			case 2: rSpawn = (2424,2576,11);
			break;
			case 3: rSpawn = (2423,2146,14);
			break;
			case 4: rSpawn = (2681,2722,3);
			break;
			case 5: rSpawn = (2422,1957,3);
			break;
			case 6: rSpawn = (2730,2644,8);
			break;
			case 7: rSpawn = (2257,3660,-10);
			break;
			case 8: rSpawn = (2440,3725,-19);
			break;
		}
		break;
		case "mp_favela": switch(RandomInt(2))
		{
			case 0: rSpawn = (2066,2750,291);
			break;
			case 1: rSpawn = (2123,2668,291);
			break;
		}
		break;
		case "mp_estate": switch(RandomInt(3))
		{
			case 0: rSpawn = (-2697,-1319,-527);
			break;
			case 1: rSpawn = (-3029,-1323,-527);
			break;
			case 2: rSpawn = (-2564,-970,-355);
			break;
			
		}
		break;
		case "mp_abandon": switch(RandomInt(3))
		{
			case 0: rSpawn = (-1594,2536,3);
			break;
			case 1: rSpawn = (-2616,3279,3);
			break;
			case 2: rSpawn = (-1787,3754,3);
			break;
			
		}
		break;
		case "mp_vacant": switch(RandomInt(3))
		{
			case 0: rSpawn = (-974,-785,-103);
			break;
			case 1: rSpawn = (-1024,991,-106);
			break;
			case 2: rSpawn = (-1737,1238,-102);
			break;
			
		}
		break;
		case "mp_storm": switch(RandomInt(3))
		{
			case 0: rSpawn = (4787,-1352,16);
			break;
			case 1: rSpawn = (4938,-1064,-48);
			break;
			case 2: rSpawn = (2980,-1165,-48);
			break;
			
		}
		break;
	}
	return rSpawn;
}

ai_monitorIconOrigin( entity )
{
	self endon("died");
	for(;;)
	{
		entity.x = self.origin[0];
		entity.y = self.origin[1];
		entity.z = self.origin[2] + 70;
		wait 0.05;
	}
}

ai_mp_afghan_Init(bot)
{
	self endon("died");
	nextWaypoint = spawnStruct();
	while(1)
	{
		nextWaypoint.origin = ai_mp_afghan_Waypoints();
		wait 20;
		self.allowfire = "false";
		wait 1;
		movetoLoc = VectorToAngles( nextWaypoint.origin - self.origin );
		self RotateTo((0,movetoLoc[1],0), 0.5);
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_sprint");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_stand_shoot_walk_forward");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_sprint_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_walk_forward_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		while(self.origin != nextWaypoint.origin)
		{
			wait 0.05;
		}
		if(self.pers["type"] == "smg")
			self scriptModelPlayAnim("pb_stand_alert");
		if(self.pers["type"] == "lmg")
			self scriptModelPlayAnim("pb_stand_alert_mg");
		self.allowfire = "true";
		self notify("Clamp");
	}
}

ai_mp_afghan_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_mp_afghan_WaypointsHeli(player),1);
	}
}

ai_mp_afghan_Waypoints()
{
	bWaypoint = undefined;
	switch(randomInt(10))
	{
		case 0:
		bWaypoint = (-2734,-939,-1440);
		break;
		case 1:
		bWaypoint = (-2536,-657,-1440);
		break;
		case 2:
		bWaypoint = (-2114,-981,-1440);
		break;
		case 3:
		bWaypoint = (-3295,-1199,-1406);
		break;
		case 4:
		bWaypoint = (-2834,-392,-1333);
		break;
		case 5:
		bWaypoint = (-3987,583,-1444);
		break;
		case 6:
		bWaypoint = (-3848,239,-1444);
		break;
		case 7:
		bWaypoint = (-3740,1239,-1443);
		break;
		case 8:
		bWaypoint = (-4054,1240,-1440);
		break;
		case 9:
		bWaypoint = (-3147,-291,-1441);
		break;
	}
	return bWaypoint;
}

ai_mp_afghan_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(4))
	{
		case 0:
		hWaypoint = (-2968,-803,-693);
		break;
		case 1:
		hWaypoint = (-3790,89,-926);
		break;
		case 2:
		hWaypoint = (-2518,-1159,-908);
		break;
		case 3:
		hWaypoint = (-4682,2005,-994);
		break;
	}
	return hWaypoint;
}

ai_Init(bot)
{
	self endon("died");
	nextWaypoint = spawnStruct();
	while(1)
	{
		nextWaypoint.origin = ai_Waypoints();
		wait 20;
		self.allowfire = "false";
		wait 1;
		movetoLoc = VectorToAngles( nextWaypoint.origin - self.origin );
		self RotateTo((0,movetoLoc[1],0), 0.5);
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_sprint");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_stand_shoot_walk_forward");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_sprint_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_walk_forward_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		while(self.origin != nextWaypoint.origin)
		{
			wait 0.05;
		}
		if(self.pers["type"] == "smg")
			self scriptModelPlayAnim("pb_stand_alert");
		if(self.pers["type"] == "lmg")
			self scriptModelPlayAnim("pb_stand_alert_mg");
		self.allowfire = "true";
		self notify("Clamp");
	}
}

ai_Waypoints()
{
	bWaypoint = undefined;
	switch(randomInt(8))
	{
		case 0:
		bWaypoint = (2723,-1070,1051);
		break;
		case 1:
		bWaypoint = (3078,-1843,1051);
		break;
		case 2:
		bWaypoint = (2702,-1906,1051);
		break;
		case 3:
		bWaypoint = (2887,-1706,1051);
		break;
		case 4:
		bWaypoint = (2979,-949,1051);
		break;
		case 5:
		bWaypoint = (3038,-1425,1051);
		break;
		case 6:
		bWaypoint = (2772,-1468,1051);
		break;
		case 7:
		bWaypoint = (2664,-1865,1051);
		break;
	}
	return bWaypoint;
}

ai_mp_derail_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_mp_derail_WaypointsHeli(player),1);
	}
}

ai_mp_derail_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(4))
	{
		case 0:
		hWaypoint = (2107,1374,538);
		break;
		case 1:
		hWaypoint = (1793,1484,507);
		break;
		case 2:
		hWaypoint = (2808,1497,521);
		break;
		case 3:
		hWaypoint = (2597,1200,519);
		break;
	}
	return hWaypoint;
}

ai_mp_highrise_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_mp_highrise_WaypointsHeli(player),1);
	}
}

ai_mp_highrise_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(5))
	{
		case 0:
		hWaypoint = (-8259,6216,3061);
		break;
		case 1:
		hWaypoint = (-9149,4843,2801);
		break;
		case 2:
		hWaypoint = (-9742,5183,2819);
		break;
		case 3:
		hWaypoint = (-9938,6095,2783);
		break;
		case 4:
		hWaypoint = (-10276,3995,2696);
		break;
	}
	return hWaypoint;
}

ai_mp_highrise2_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_mp_highrise2_WaypointsHeli(player),1);
	}
}

ai_mp_highrise2_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(5))
	{
		case 0:
		hWaypoint = (-15266,6217,6045);
		break;
		case 1:
		hWaypoint = (-13479,6118,6018);
		break;
		case 2:
		hWaypoint = (-13451,5131,6041);
		break;
		case 3:
		hWaypoint = (-14580,4849,6091);
		break;
		case 4:
		hWaypoint = (-14597,5655,6067);
		break;
	}
	return hWaypoint;
}

ai_mp_invasion_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_mp_invasion_WaypointsHeli(player),1);
	}
}

ai_mp_invasion_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(5))
	{
		case 0:
		hWaypoint = (2849,10326,574);
		break;
		case 1:
		hWaypoint = (3006,11598,520);
		break;
		case 2:
		hWaypoint = (4007,11774,503);
		break;
		case 3:
		hWaypoint = (3434,10723,573);
		break;
		case 4:
		hWaypoint = (2840,10654,684);
		break;
	}
	return hWaypoint;
}

ai_mp_karachi_Init(bot)
{
	self endon("died");
	nextWaypoint = spawnStruct();
	while(1)
	{
		nextWaypoint.origin = ai_mp_karachi_Waypoints();
		wait 20;
		self.allowfire = "false";
		wait 1;
		movetoLoc = VectorToAngles( nextWaypoint.origin - self.origin );
		self RotateTo((0,movetoLoc[1],0), 0.5);
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_sprint");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_stand_shoot_walk_forward");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_sprint_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_walk_forward_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		while(self.origin != nextWaypoint.origin)
		{
			wait 0.05;
		}
		if(self.pers["type"] == "smg")
			self scriptModelPlayAnim("pb_stand_alert");
		if(self.pers["type"] == "lmg")
			self scriptModelPlayAnim("pb_stand_alert_mg");
		self.allowfire = "true";
		self notify("Clamp");
	}
}

ai_mp_karachi_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_mp_karachi_WaypointsHeli(player),1);
	}
}

ai_mp_karachi_Waypoints()
{
	bWaypoint = undefined;
	switch(randomInt(10))
	{
		case 0:
		bWaypoint = (2416,3496,11);
		break;
		case 1:
		bWaypoint = (2431,3047,11);
		break;
		case 2:
		bWaypoint = (2424,2576,11);
		break;
		case 3:
		bWaypoint = (2423,2146,14);
		break;
		case 4:
		bWaypoint = (2681,2722,3);
		break;
		case 5:
		bWaypoint = (2422,1957,3);
		break;
		case 6:
		bWaypoint = (2730,2644,8);
		break;
		case 7:
		bWaypoint = (2257,3660,-10);
		break;
		case 8:
		bWaypoint = (2440,3725,-19);
		break;
		case 9:
		bWaypoint = (2605,2810,3);
		break;
	}
	return bWaypoint;
}

ai_mp_karachi_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(5))
	{
		case 0:
		hWaypoint = (2334,3560,596);
		break;
		case 1:
		hWaypoint = (1316,3101,599);
		break;
		case 2:
		hWaypoint = (3055,2878,512);
		break;
		case 3:
		hWaypoint = (1680,2405,519);
		break;
		case 4:
		hWaypoint = player.origin+(0,0,500);
		break;
	}
	return hWaypoint;
}

ai_mp_rundown_Init(bot)
{
	self endon("died");
	nextWaypoint = spawnStruct();
	while(1)
	{
		nextWaypoint.origin = ai_mp_rundown_Waypoints();
		wait 20;
		self.allowfire = "false";
		wait 1;
		movetoLoc = VectorToAngles( nextWaypoint.origin - self.origin );
		self RotateTo((0,movetoLoc[1],0), 0.5);
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_sprint");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_stand_shoot_walk_forward");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_sprint_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_walk_forward_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		while(self.origin != nextWaypoint.origin)
		{
			wait 0.05;
		}
		if(self.pers["type"] == "smg")
			self scriptModelPlayAnim("pb_stand_alert");
		if(self.pers["type"] == "lmg")
			self scriptModelPlayAnim("pb_stand_alert_mg");
		self.allowfire = "true";
		self notify("Clamp");
	}
}

ai_mp_rundown_Waypoints()
{
	bWaypoint = undefined;
	switch(randomInt(10))
	{
		case 0:
		bWaypoint = (879,2971,75);
		break;
		case 1:
		bWaypoint = (488,3360,123);
		break;
		case 2:
		bWaypoint = (541,2821,76);
		break;
		case 3:
		bWaypoint = (383,2590,114);
		break;
		case 4:
		bWaypoint = (967,2422,70);
		break;
		case 5:
		bWaypoint = (1605,2432,61);
		break;
		case 6:
		bWaypoint = (1638,3284,75);
		break;
		case 7:
		bWaypoint = (1103,3075,75);
		break;
		case 8:
		bWaypoint = (799,3310,74);
		break;
		case 9:
		bWaypoint = (567,3126,72);
		break;
	}
	return bWaypoint;
}

ai_mp_rust_Init(bot)
{
	self endon("died");
	nextWaypoint = spawnStruct();
	while(1)
	{
		nextWaypoint.origin = ai_mp_rust_Waypoints();
		wait 20;
		self.allowfire = "false";
		wait 1;
		movetoLoc = VectorToAngles( nextWaypoint.origin - self.origin );
		self RotateTo((0,movetoLoc[1],0), 0.5);
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_sprint");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_stand_shoot_walk_forward");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_sprint_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_walk_forward_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		while(self.origin != nextWaypoint.origin)
		{
			wait 0.05;
		}
		if(self.pers["type"] == "smg")
			self scriptModelPlayAnim("pb_stand_alert");
		if(self.pers["type"] == "lmg")
			self scriptModelPlayAnim("pb_stand_alert_mg");
		self.allowfire = "true";
		self notify("Clamp");
	}
}

ai_mp_rust_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_mp_rust_WaypointsHeli(player),1);
	}
}

ai_mp_rust_Waypoints()
{
	bWaypoint = undefined;
	switch(randomInt(8))
	{
		case 0:
		bWaypoint = (1546,-9911,-175);
		break;
		case 1:
		bWaypoint = (2344,-9757,-253);
		break;
		case 2:
		bWaypoint = (1629,-9450,-185);
		break;
		case 3:
		bWaypoint = (768,-9298,-235);
		break;
		case 4:
		bWaypoint = (-192,-9774,-218);
		break;
		case 5:
		bWaypoint = (-457,-9619,-244);
		break;
		case 6:
		bWaypoint = (2322,-10359,-202);
		break;
		case 7:
		bWaypoint = (3108,-10669,-175);
		break;
	}
	return bWaypoint;
}

ai_mp_rust_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(4))
	{
		case 0:
		hWaypoint = (191,-9724,445);
		break;
		case 1:
		hWaypoint = player.origin+(0,0,500);
		break;
		case 2:
		hWaypoint = (2237,-10500,497);
		break;
		case 3:
		hWaypoint = (2872,-9792,490);
		break;
	}
	return hWaypoint;
}

ai_mp_rust2_Init(bot)
{
	self endon("died");
	nextWaypoint = spawnStruct();
	while(1)
	{
		nextWaypoint.origin = ai_mp_rust2_Waypoints();
		wait 20;
		self.allowfire = "false";
		wait 1;
		movetoLoc = VectorToAngles( nextWaypoint.origin - self.origin );
		self RotateTo((0,movetoLoc[1],0), 0.5);
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_sprint");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_stand_shoot_walk_forward");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_sprint_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_walk_forward_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		while(self.origin != nextWaypoint.origin)
		{
			wait 0.05;
		}
		if(self.pers["type"] == "smg")
			self scriptModelPlayAnim("pb_stand_alert");
		if(self.pers["type"] == "lmg")
			self scriptModelPlayAnim("pb_stand_alert_mg");
		self.allowfire = "true";
		self notify("Clamp");
	}
}

ai_mp_rust2_Waypoints()
{
	bWaypoint = undefined;
	switch(randomInt(5))
	{
		case 0:
		bWaypoint = (1180,-6663,-263);
		break;
		case 1:
		bWaypoint = (1010,-6400,-263);
		break;
		case 2:
		bWaypoint = (1231,-6182,-263);
		break;
		case 3:
		bWaypoint = (920,-6125,-263);
		break;
		case 4:
		bWaypoint = (1199,-6600,-263);
		break;
	}
	return bWaypoint;
}

ai_mp_salvage_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_mp_salvage_WaypointsHeli(player),1);
	}
}

ai_mp_salvage_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(5))
	{
		case 0:
		hWaypoint = (1285,2956,660);
		break;
		case 1:
		hWaypoint = (2324,2787,551);
		break;
		case 2:
		hWaypoint = (2000,2770,558);
		break;
		case 3:
		hWaypoint = (1656,2971,583);
		break;
		case 4:
		hWaypoint = (2716,2586,550);
		break;
	}
	return hWaypoint;
}

ai_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_WaypointsHeli(player),1);
	}
}

ai_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(4))
	{
		case 0:
		hWaypoint = (892,-3240,538);
		break;
		case 1:
		hWaypoint = (810,-2197,384);
		break;
		case 2:
		hWaypoint = (-91,-2229,509);
		break;
		case 3:
		hWaypoint = (-600,-2416,433);
		break;
	}
	return hWaypoint;
}

ai_mp_strike_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_mp_strike_WaypointsHeli(player),1);
	}
}

ai_mp_strike_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(5))
	{
		case 0:
		hWaypoint = (-2431,1494,355);
		break;
		case 1:
		hWaypoint = (-3524,1425,377);
		break;
		case 2:
		hWaypoint = (-3115,1292,349);
		break;
		case 3:
		hWaypoint = (-3874,1380,499);
		break;
		case 4:
		hWaypoint = (-3172,1446,390);
		break;
	}
	return hWaypoint;
}

ai_mp_subbase_Init(bot)
{
	self endon("died");
	nextWaypoint = spawnStruct();
	while(1)
	{
		nextWaypoint.origin = ai_mp_subbase_Waypoints();
		wait 20;
		self.allowfire = "false";
		wait 1;
		movetoLoc = VectorToAngles( nextWaypoint.origin - self.origin );
		self RotateTo((0,movetoLoc[1],0), 0.5);
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_sprint");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_stand_shoot_walk_forward");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_sprint_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_walk_forward_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		while(self.origin != nextWaypoint.origin)
		{
			wait 0.05;
		}
		if(self.pers["type"] == "smg")
			self scriptModelPlayAnim("pb_stand_alert");
		if(self.pers["type"] == "lmg")
			self scriptModelPlayAnim("pb_stand_alert_mg");
		self.allowfire = "true";
		self notify("Clamp");
	}
}

ai_mp_subbase_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_mp_subbase_WaypointsHeli(player),1);
	}
}

ai_mp_subbase_Waypoints()
{
	bWaypoint = undefined;
	switch(randomInt(10))
	{
		case 0:
		bWaypoint = (-412,-4849,16);
		break;
		case 1:
		bWaypoint = (-259,-4838,16);
		break;
		case 2:
		bWaypoint = (-364,-5308,16);
		break;
		case 3:
		bWaypoint = (-427,-3898,16);
		break;
		case 4:
		bWaypoint = (-252,-3914,16);
		break;
		case 5:
		bWaypoint = (-196,-4394,76);
		break;
		case 6:
		bWaypoint = (-375,-4316,16);
		break;
		case 7:
		bWaypoint = (-339,-6460,48);
		break;
		case 8:
		bWaypoint = (-259,-6458,48);
		break;
		case 9:
		bWaypoint = (-335,-5448,16);
		break;
	}
	return bWaypoint;
}

ai_mp_subbase_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(5))
	{
		case 0:
		hWaypoint = (157,-5876,698);
		break;
		case 1:
		hWaypoint = (-975,-5241,582);
		break;
		case 2:
		hWaypoint = (-391,-4247,385);
		break;
		case 3:
		hWaypoint = (-412,-5241,502);
		break;
		case 4:
		hWaypoint = player.origin+(0,0,500);
		break;
	}
	return hWaypoint;
}

ai_mp_terminal_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_mp_terminal_WaypointsHeli(player),1);
	}
}

ai_mp_terminal_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(5))
	{
		case 0:
		hWaypoint = (1546,2887,344);
		break;
		case 1:
		hWaypoint = (874,3624,867);
		break;
		case 2:
		hWaypoint = (1381,3708,599);
		break;
		case 3:
		hWaypoint = (1176,4093,575);
		break;
		case 4:
		hWaypoint = (1181,3582,843);
		break;
	}
	return hWaypoint;
}

ai_mp_trailerpark_Init(bot)
{
	self endon("died");
	nextWaypoint = spawnStruct();
	while(1)
	{
		nextWaypoint.origin = ai_mp_trailerpark_Waypoints();
		wait 20;
		self.allowfire = "false";
		wait 1;
		movetoLoc = VectorToAngles( nextWaypoint.origin - self.origin );
		self RotateTo((0,movetoLoc[1],0), 0.5);
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_sprint");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "smg")
		{
			self scriptModelPlayAnim("pb_stand_shoot_walk_forward");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		if(distance(self.origin, nextWaypoint.origin) >= 300 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_sprint_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 150));
		}
		else if(distance(self.origin, nextWaypoint.origin) <= 299 && self.pers["type"] == "lmg")
		{
			self scriptModelPlayAnim("pb_walk_forward_mg");
			self MoveTo(nextWaypoint.origin, (distance(self.origin, nextWaypoint.origin) / 50));
		}
		while(self.origin != nextWaypoint.origin)
		{
			wait 0.05;
		}
		if(self.pers["type"] == "smg")
			self scriptModelPlayAnim("pb_stand_alert");
		if(self.pers["type"] == "lmg")
			self scriptModelPlayAnim("pb_stand_alert_mg");
		self.allowfire = "true";
		self notify("Clamp");
	}
}

ai_mp_trailerpark_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_mp_trailerpark_WaypointsHeli(player),1);
	}
}

ai_mp_trailerpark_Waypoints()
{
	bWaypoint = undefined;
	switch(randomInt(10))
	{
		case 0:
		bWaypoint = (1882,-2589,19);
		break;
		case 1:
		bWaypoint = (1853,-1710,12);
		break;
		case 2:
		bWaypoint = (1553,-2027,18);
		break;
		case 3:
		bWaypoint = (595,-2204,11);
		break;
		case 4:
		bWaypoint = (448,-2064,14);
		break;
		case 5:
		bWaypoint = (17,-1960,11);
		break;
		case 6:
		bWaypoint = (2464,-2345,11);
		break;
		case 7:
		bWaypoint = (2360,-1846,22);
		break;
		case 8:
		bWaypoint = (535,-1868,20);
		break;
		case 9:
		bWaypoint = (-531,-1543,11);
		break;
	}
	return bWaypoint;
}

ai_mp_trailerpark_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(5))
	{
		case 0:
		hWaypoint = (2734,-2099,618);
		break;
		case 1:
		hWaypoint = (743,-2109,499);
		break;
		case 2:
		hWaypoint = (1640,-2632,540);
		break;
		case 3:
		hWaypoint = (672,-2379,843);
		break;
		case 4:
		hWaypoint = player.origin+(0,0,500);
		break;
	}
	return hWaypoint;
}

ai_mp_wasteland_InitHeli(player)
{
	self endon("heli_leaving");
	while(1)
	{
		wait 15;
		self Vehicle_SetSpeed(50,70);
		self setvehgoalpos(ai_mp_wasteland_WaypointsHeli(player),1);
	}
}

ai_mp_wasteland_WaypointsHeli(player)
{
	hWaypoint = undefined;
	switch(randomInt(4))
	{
		case 0:
		hWaypoint = (9855,6719,808);
		break;
		case 1:
		hWaypoint = (10366,6509,826);
		break;
		case 2:
		hWaypoint = (10448,6747,2227);
		break;
		case 3:
		hWaypoint = (9788,7139,2150);
		break;
	}
	return hWaypoint;
}

ai_KillerHeli()
{
	wait 1;
	if(getDvarInt("z_dedicated") == 0)
	{
		foreach(player in level.players)
		{
			player playLocalSound("mp_killstreak_pavelow");
		}
	}
	player = level.players[RandomInt(level.players.size)];
	level.heli = spawnHelicopter(player, ai_SpawnHeli(), (0,0,0), "pavelow_mp", "vehicle_apache_mp");
	level.players[RandomInt(level.players.size)] sayAll("^1Oh Shit What is That");
	level.players[RandomInt(level.players.size)] playSound(fx_ai5_10( "allies" ) + "mp_stm_enemyspotted");
	level.heli Vehicle_SetSpeed(40,50);
    level.heli setvehgoalpos(ai_helicrash_MoveHeli(),1);
	level.heli waittill("goal");
	level.heli playLoopSound("cobra_helicopter_dying_loop");
	level.heli thread ai_PlayHeliFall();
	level.heli thread ai_helicrash_HeliSpin();
	level.heli playSound("cobra_helicopter_hit");
	level.players[RandomInt(level.players.size)] sayAll("^1Shit Get Down");
	playFxOnTag( loadFx("explosions/helicopter_explosion_secondary_small"), level.heli, "tag_engine_left" );
	level.heli Vehicle_SetSpeed(40,50);
    level.heli setvehgoalpos(ai_MoveGround(),1);
	level.heli waittill("goal");
	level.heli thread ai_KillAllPlayersAndHelicoperExplode();
}

ai_helicrash_HeliSpin()
{
	self setyawspeed( 180, 180, 180 );
	while(isDefined(self))
	{
		self settargetyaw( self.angles[1]+(180*0.9) );
		wait 1;
	}
}

ai_KillAllPlayersAndHelicoperExplode()
{
	self.headIcon destroy();
	self playSound("cobra_helicopter_crash");
	playFx( loadfx( "explosions/helicopter_explosion_mi28_flying" ), self getTagOrigin( "tag_deathfx" ), anglesToForward( self getTagAngles( "tag_deathfx" ) ), anglesToUp( self getTagAngles( "tag_deathfx" ) ) );
	self delete();
	foreach(player in level.players)
	{
		earthquake(1.3,1.1, player.origin, 3000);
		player setStance("prone");
		player.moveSpeedScaler = 0.35;
		player fx_ai5_11( "primary" );
		player VisionSetNakedForPlayer("mpnuke_aftermath", 2);		
	}
	level.BotsForWave = 0;
	level thread maps\mp\killstreaks\_nuke::nukeDeath();
	wait 10;
	foreach(player in level.players)
	{
		player thread fx_ai5_8(20000, 0, (1,1,0.5));
		player thread fx_ai5_6( "20000 Rank XP!" );
		player thread maps\mp\gametypes\_rank::giveRankXP("kill", 20000 );
	}
	if(getDvarInt("z_dedicated") == 0)
		wait 55;
	thread maps\mp\gametypes\_gamelogic::endGame( "allies", level.zombieDeath[randomInt(level.zombieDeath.size)] );
}

ai_PlayHeliFall()
{
	while(isDefined(self))
	{
		PlayFXOnTag( loadFx("smoke/smoke_trail_black_heli_emitter"), self, "tag_engine_left" );
		PlayFXOnTag( loadFx("fire/fire_smoke_trail_L_emitter"), self, "tag_engine_left" );
		wait 4;
	}
}

ai_SpawnHeli()
{
	rSpawn = undefined;
	switch(getDvar("mapname"))
	{
		case "mp_abandon":
		rSpawn = (-5684,8503,939);
		break;
		case "mp_estate":
		rSpawn = (-7669,-2787,-156);
		break;
		case "mp_derail":
		rSpawn = (-420,2083,773);
		break;
		case "mp_favela":
		rSpawn = (-3605,1028,1949);
		break;
		case "mp_underpass":
		rSpawn = (6952,4630,1375);
		break;
		case "mp_brecourt":
		rSpawn = (4147,3381,1862);
		break;
		case "mp_afghan":
		rSpawn = (-2259,-4580,2);
		break;
		case "mp_highrise":
		if(level.edit == 0)
			rSpawn = (-3874,6463,4113);
		if(level.edit == 1)
			rSpawn = (-11171,243,6486);
		break;
		case "mp_nightshift":
		if(level.edit == 0)
			rSpawn = (-1814,-3775,748);
		if(level.edit == 1)
			rSpawn = (4628,-1204,1234);
		if(level.edit == 2)
			rSpawn = (1902,-5880,840);
		break;
		case "mp_terminal":
		rSpawn = (-5862,2653,830);
		break;
		case "mp_strike":
		rSpawn = (-9493,1494,594);
		break;
		case "mp_subbase":
		rSpawn = (-86,-861,854);
		break;
		case "mp_boneyard":
		rSpawn = (1909,-5738,610);
		break;
		case "mp_invasion":
		rSpawn = (3064,1670,955);
		break;
		case "mp_checkpoint":
		rSpawn = (2104,324,508);
		break;
		case "mp_rust":
		rSpawn = (67,-141,513);
		break;
		case "mp_quarry":
		rSpawn = (-3023,5275,633);
		break;
		case "mp_compact":
		rSpawn = (2648,602,523);
		break;
		case "mp_complex":
		rSpawn = (2841,-1277,3980);
		break;
		case "mp_trailerpark":
		rSpawn = (1194,721,632);
		break;
		case "mp_rundown":
		rSpawn = (340,-846,1349);
		break;
		case "mp_vacant":
		rSpawn = (-9843,1186,632);
		break;
		case "mp_storm":
		rSpawn = (-6699,-2555,741);
		break;
	}
	return rSpawn;
}

ai_helicrash_MoveHeli()
{
	rMove = undefined;
	switch(getDvar("mapname"))
	{
		case "mp_abandon":
		rMove = (-3576,5414,791);
		break;
		case "mp_estate":
		rMove = (-4679,-1266,-196);
		break;
		case "mp_derail":
		rMove = (1395,1638,700);
		break;
		case "mp_favela":
		rMove = (236,1929,1082);
		break;
		case "mp_underpass":
		rMove = (4090,3206,935);
		break;
		case "mp_brecourt":
		rMove = (8288,5790,1332);
		break;
		case "mp_afghan":
		rMove = (-3650,-1148,-696);
		break;
		case "mp_highrise":
		if(level.edit == 0)
			rMove = (-8484,5812,3144);
		if(level.edit == 1)
			rMove = (-13348,4425,6139);
		break;
		case "mp_nightshift":
		if(level.edit == 0)
			rMove = (-1751,-1309,533);
		if(level.edit == 1)
			rMove = (2033,-1011,708);
		if(level.edit == 2)
			rMove = (1925,-1992,375);
		break;
		case "mp_terminal":
		rMove = (859,3444,693);
		break;
		case "mp_strike":
		rMove = (-3947,1422,414);
		break;
		case "mp_subbase":
		rMove = (-345,-3844,368);
		break;
		case "mp_boneyard":
		rMove = (820,-3232,450);
		break;
		case "mp_invasion":
		rMove = (3007,8854,543);
		break;
		case "mp_checkpoint":
		rMove = (2355,2210,318);
		break;
		case "mp_rust":
		rMove = (760,-3910,523);
		break;
		case "mp_quarry":
		rMove = (-3396,3564,566);
		break;
		case "mp_compact":
		rMove = (2257,2353,414);
		break;
		case "mp_complex":
		rMove = (2841,-1277,3980);
		break;
		case "mp_trailerpark":
		rMove = (1095,-1611,501);
		break;
		case "mp_rundown":
		rMove = (607,2084,541);
		break;
		case "mp_vacant":
		rMove = (-2936,762,528);
		break;
		case "mp_storm":
		rMove = (4977,-1931,644);
		break;
	}
	return rMove;
}

ai_MoveGround()
{
	rMove = undefined;
	switch(getDvar("mapname"))
	{
		case "mp_abandon":
		switch(randomInt(2))
		{
			case 0:
			rMove = (-2017,1769,150);
			break;
			case 1:
			rMove = (-440,4724,150);
			break;
		}
		break;
		case "mp_estate":
		switch(randomInt(2))
		{
			case 0:
			rMove = (-2546,-1719,-470);
			break;
			case 1:
			rMove = (-2487,-433,-139);
			break;
		}
		break;
		case "mp_derail":
		switch(randomInt(2))
		{
			case 0:
			rMove = (2538,1697,311);
			break;
			case 1:
			rMove = (2634,1310,366);
			break;
		}
		break;
		case "mp_favela":
		switch(randomInt(2))
		{
			case 0:
			rMove = (1319,2378,616);
			break;
			case 1:
			rMove = (1984,2641,489);
			break;
		}
		break;
		case "mp_underpass":
		switch(randomInt(2))
		{
			case 0:
			rMove = (3305,3091,594);
			break;
			case 1:
			rMove = (3851,2178,559);
			break;
		}
		break;
		case "mp_brecourt":
		switch(randomInt(2))
		{
			case 0:
			rMove = (10712,6558,610);
			break;
			case 1:
			rMove = (9774,8120,553);
			break;
		}
		break;
		case "mp_afghan":
		switch(randomInt(2))
		{
			case 0:
			rMove = (-3985,443,-1200);
			break;
			case 1:
			rMove = (-2399,-689,-1174);
			break;
		}
		break;
		case "mp_highrise":
		if(level.edit == 0)
		{
			switch(randomInt(2))
			{
				case 0:
				rMove = (-10052,6446,2508);
				break;
				case 1:
				rMove = (-9711,4265,2485);
				break;
			}
		}
		if(level.edit == 1)
		{
			switch(randomInt(2))
			{
				case 0:
				rMove = (-13113,6384,5925);
				break;
				case 1:
				rMove = (-14940,5617,5619);
				break;
			}
		}
		break;
		case "mp_nightshift":
		if(level.edit == 0)
		{
			switch(randomInt(2))
			{
				case 0:
				rMove = (-1255,-584,150);
				break;
				case 1:
				rMove = (-1732,-506,139);
				break;
			}
		}
		if(level.edit == 1)
		{
			switch(randomInt(2))
			{
				case 0:
				rMove = (824,-1328,149);
				break;
				case 1:
				rMove = (871,-1038,126);
				break;
			}
		}
		if(level.edit == 2)
		{
			switch(randomInt(2))
			{
				case 0:
				rMove = (1935,-1020,141);
				break;
				case 1:
				rMove = (1740,-1411,115);
				break;
			}
		}
		break;
		case "mp_terminal":
		switch(randomInt(2))
		{
			case 0:
			rMove = (1889,2971,287);
			break;
			case 1:
			rMove = (1535,4026,586);
			break;
		}
		break;
		case "mp_strike":
		switch(randomInt(2))
		{
			case 0:
			rMove = (-2425,1349,113);
			break;
			case 1:
			rMove = (-2907,1486,112);
			break;
		}
		break;
		case "mp_subbase":
		switch(randomInt(2))
		{
			case 0:
			rMove = (-428,-4978,93);
			break;
			case 1:
			rMove = (-275,-5067,81);
			break;
		}
		break;
		case "mp_boneyard":
		switch(randomInt(2))
		{
			case 0:
			rMove = (731,-1752,27);
			break;
			case 1:
			rMove = (-443,-1863,46);
			break;
		}
		break;
		case "mp_invasion":
		switch(randomInt(2))
		{
			case 0:
			rMove = (4507,11332,103);
			break;
			case 1:
			rMove = (2926,12053,62);
			break;
		}
		break;
		case "mp_checkpoint":
		switch(randomInt(2))
		{
			case 0:
			rMove = (2418,3331,87);
			break;
			case 1:
			rMove = (1507,3083,48);
			break;
		}
		break;
		case "mp_rust":
		switch(randomInt(2))
		{
			case 0:
			rMove = (168,-9587,-20);
			break;
			case 1:
			rMove = (2028,-9862,-47);
			break;
		}
		break;
		case "mp_quarry":
		switch(randomInt(2))
		{
			case 0:
			rMove = (-3269,2260,140);
			break;
			case 1:
			rMove = (-3138,2910,115);
			break;
		}
		break;
		case "mp_compact":
		switch(randomInt(2))
		{
			case 0:
			rMove = (2320,3011,138);
			break;
			case 1:
			rMove = (1789,2975,161);
			break;
		}
		break;
		case "mp_complex":
		switch(randomInt(2))
		{
			case 0:
			rMove = (2908,-1439,1162);
			break;
			case 1:
			rMove = (2908,-1439,1162);
			break;
		}
		break;
		case "mp_trailerpark":
		switch(randomInt(2))
		{
			case 0:
			rMove = (1823,-2807,278);
			break;
			case 1:
			rMove = (533,-2391,73);
			break;
		}
		break;
		case "mp_rundown":
		switch(randomInt(2))
		{
			case 0:
			rMove = (411,2902,164);
			break;
			case 1:
			rMove = (962,2588,168);
			break;
		}
		break;
		case "mp_vacant":
		switch(randomInt(2))
		{
			case 0:
			rMove = (-260,1045,133);
			break;
			case 1:
			rMove = (-993,-105,76);
			break;
		}
		break;
		case "mp_storm":
		switch(randomInt(2))
		{
			case 0:
			rMove = (2947,-1911,255);
			break;
			case 1:
			rMove = (4930,-622,158);
			break;
		}
		break;
	}
	return rMove;
}

ai_mp_afghan_WaypointInit()
{
}

ai_mp_carnival_WaypointInit()
{
	level.botwaypoints[0] = SpawnStruct();
	level.botwaypoints[0].origin = (-3454,-3475,1);
	level.botwaypoints[1] = SpawnStruct();
	level.botwaypoints[1].origin = (-2954,3136,1);
	level.botwaypoints[2] = SpawnStruct();
	level.botwaypoints[2].origin = (-2087,1759,1);
	level.botwaypoints[3] = SpawnStruct();
	level.botwaypoints[3].origin = (-1268,1108,1);
	level.botwaypoints[4] = SpawnStruct();
	level.botwaypoints[4].origin = (-1092,1825,5);
	level.botwaypoints[5] = SpawnStruct();
	level.botwaypoints[5].origin = (-401,2349,1);
	level.botwaypoints[6] = SpawnStruct();
	level.botwaypoints[6].origin = (-579,2781,1);
	level.botwaypoints[7] = SpawnStruct();
	level.botwaypoints[7].origin = (-359,3336,1);
	level.botwaypoints[8] = SpawnStruct();
	level.botwaypoints[8].origin = (-1302,4566,1);
	level.botwaypoints[9] = SpawnStruct();
	level.botwaypoints[9].origin = (-2586,5430,1);
	level.botwaypoints[10] = SpawnStruct();
	level.botwaypoints[10].origin = (-3442,4566,1);
	level.botwaypoints[11] = SpawnStruct();
	level.botwaypoints[11].origin = (-4097,4079,1);
	level.botwaypoints[12] = SpawnStruct();
	level.botwaypoints[12].origin = (-2971,3461,-4);
	level.botwaypoints[13] = SpawnStruct();
	level.botwaypoints[13].origin = (-3761,1983,6);
	level.botwaypoints[14] = SpawnStruct();
	level.botwaypoints[14].origin = (-3194,1270,6);
	level.botwaypoints[15] = SpawnStruct();
	level.botwaypoints[15].origin = (-3289,206,6);
	level.botwaypoints[16] = SpawnStruct();
	level.botwaypoints[16].origin = (-4456,1214,6);
	level.botwaypoints[17] = SpawnStruct();
	level.botwaypoints[17].origin = (-4620,2052,6);
	level.botwaypoints[18] = SpawnStruct();
	level.botwaypoints[18].origin = (-4466,2611,6);
	level.botwaypoints[19] = SpawnStruct();
	level.botwaypoints[19].origin = (-4494,3190,6);
	level.botwaypoints[20] = SpawnStruct();
	level.botwaypoints[20].origin = (-3952,2975,6);
	level.botwaypoints[21] = SpawnStruct();
	level.botwaypoints[21].origin = (-3434,2581,6);
}

ai_mp_derail_WaypointInit()
{
	level.botwaypoints[0] = SpawnStruct();
	level.botwaypoints[0].origin = (1685,2654,130);
	level.botwaypoints[1] = SpawnStruct();
	level.botwaypoints[1].origin = (1736,1901,139);
	level.botwaypoints[2] = SpawnStruct();
	level.botwaypoints[2].origin = (2021,1458,144);
	level.botwaypoints[3] = SpawnStruct();
	level.botwaypoints[3].origin = (2253,1239,144);
	level.botwaypoints[4] = SpawnStruct();
	level.botwaypoints[4].origin = (2774,1221,144);
	level.botwaypoints[5] = SpawnStruct();
	level.botwaypoints[5].origin = (2715,1686,144);
	level.botwaypoints[6] = SpawnStruct();
	level.botwaypoints[6].origin = (2373,1630,144);
	level.botwaypoints[7] = SpawnStruct();
	level.botwaypoints[7].origin = (2861,2018,144);
	level.botwaypoints[8] = SpawnStruct();
	level.botwaypoints[8].origin = (2856,2620,144);
	level.botwaypoints[9] = SpawnStruct();
	level.botwaypoints[9].origin = (2367,2265,158);
	level.botwaypoints[10] = SpawnStruct();
	level.botwaypoints[10].origin = (2371,2702,158);
	level.botwaypoints[11] = SpawnStruct();
	level.botwaypoints[11].origin = (2580,2701,160);
	level.botwaypoints[12] = SpawnStruct();
	level.botwaypoints[12].origin = (1896,2368,158);
	level.botwaypoints[13] = SpawnStruct();
	level.botwaypoints[13].origin = (1905,2736,294);
	level.botwaypoints[14] = SpawnStruct();
	level.botwaypoints[14].origin = (1981,2994,294);
	level.botwaypoints[15] = SpawnStruct();
	level.botwaypoints[15].origin = (2428,2952,294);
	level.botwaypoints[16] = SpawnStruct();
	level.botwaypoints[16].origin = (2361,3383,294);
	level.botwaypoints[17] = SpawnStruct();
	level.botwaypoints[17].origin = (1963,3291,294);
	level.botwaypoints[18] = SpawnStruct();
	level.botwaypoints[18].origin = (2157,3412,294);
	level.botwaypoints[19] = SpawnStruct();
	level.botwaypoints[19].origin = (1927,3414,430);
	level.botwaypoints[20] = SpawnStruct();
	level.botwaypoints[20].origin = (2061,3113,158);
	level.botwaypoints[21] = SpawnStruct();
	level.botwaypoints[21].origin = (1850,2699,294);
	level.botwaypoints[22] = SpawnStruct();
	level.botwaypoints[22].origin = (1816,3217,158);
}

ai_maps_mp_rundown_Init()
{
    level thread ai_PrecacheRundown();
	level thread ai_mp_rundown_SpawnObjects();
}

ai_PrecacheRundown()
{
    precacheModel("foliage_tree_palm_bushy_1");
	PrecacheMpAnim( level.anim_prop_models[ "foliage_tree_palm_bushy_1" ][ "strong" ] );
	PrecacheMpAnim( level.anim_prop_models[ "foliage_pacific_fern01_animated" ][ "strong" ] );
}

ai_Tree1(pos, angle)
{
	foliage = spawn("script_model", pos );
	foliage setModel("foliage_tree_palm_bushy_1");
	foliage.angles = angle;
	foliage ScriptModelPlayAnim( level.anim_prop_models[ "foliage_tree_palm_bushy_1" ][ "strong" ] );
	foliage setContents(1);
}

ai_Tree2(pos, angle)
{
	foliage = spawn("script_model", pos );
	foliage setModel("foliage_pacific_fern01_animated");
	foliage.angles = angle;
	foliage ScriptModelPlayAnim( level.anim_prop_models[ "foliage_pacific_fern01_animated" ][ "strong" ] );
	foliage setContents(1);
}

ai_mp_rundown_ZipLine(pos, angle, pos1, pos2, pos3, pos4, pos5)
{
	level.zipline = spawn("script_model", pos );
	level.zipline setModel("com_plasticcase_friendly");
	level.zipline.angles = angle;
	level.zipline Solid();
	level.zipline CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_mp_rundown_ZipLineThink(pos, angle, pos1, pos2, pos3, pos4, pos5);
	wait 0.01;
}

ai_mp_rundown_ZipLineThink(pos, angle, pos1, pos2, pos3, pos4, pos5)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 to use Zipline[^2$^35000^7]" );
		}
		if(Distance(pos, Player.origin) > 50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 5000 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player thread ai_mp_rundown_ZiplineNoMove();
			if(player.maxhealth >= 200)
			{
			    player.maxhealth = 999991;
				player.health = player.maxhealth;
			}
			else
			{
			    player.maxhealth = 999999;
				player.health = player.maxhealth;
			}
			player.health = player.maxhealth;
			player.money -= 5000;
			player notify("MONEY");
			player thread fx_ai5_8( -5000, 0, (1,0,0), 1 );
			player thread fx_ai5_6( "ZipLine!" );
			player setorigin(level.zipline.origin+(0,0,10));
			level.zipline MoveTo(pos1, 5);
			wait 5;
			level.zipline MoveTo(pos2, 10);
			wait 10;
			level.zipline MoveTo(pos3, 10);
			wait 10;
			level.zipline MoveTo(pos4, 10);
			wait 10;
			level.zipline MoveTo(pos5, 10);
			wait 10;
			level.zipline MoveTo(pos, 5);
			wait 5;
			player notify("zipline_off");
			if ( player _hasPerk( "specialty_lightweight" ) )
			{
				player.moveSpeedScaler = 1.1;
				player fx_ai5_11( "primary" );
			}
			else
			{
				player.moveSpeedScaler = 1.0;
				player fx_ai5_11( "primary" );
			}
			if(player.maxhealth == 999991)
			{
			    player.maxhealth = 200;
				player.health = player.maxhealth;
			}
			else if(player.maxhealth == 999999)
			{
				player.maxhealth = 100;
				player.health = player.maxhealth;
			}
			level notify("boxend");
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 5000 && player useButtonPressed())
		{
			player iPrintln("^1Not enough money for ZipLine Need $5000!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_mp_rundown_ZiplineNoMove()
{
    self endon("disconnect");
    self endon("death");
    self endon("zipline_off");
	while(1)
	{
		self.moveSpeedScaler = 0;
		self fx_ai5_11( "primary" );
		wait 0.1;
	}
}

ai_mp_rundown_SpawnObjects()
{
    ai_Tree1((984,2536,75),(0,90,0));
	ai_mp_rundown_ZipLine((1403,3316,75),(0,0,0),(1638, 3308,252),(1630, 2414,252),(1052, 2402,130),(1047, 2902,96),(1009, 3261,130));
	ai_Tree2((356,2381,128),(0,90,0));
}

ai_mp_rust_WaypointInit()
{
	level.botwaypoints[0] = SpawnStruct();
	level.botwaypoints[0].origin = (3002,-9871,-244);
	level.botwaypoints[1] = SpawnStruct();
	level.botwaypoints[1].origin = (2630,-10112,-225);
	level.botwaypoints[2] = SpawnStruct();
	level.botwaypoints[2].origin = (2368,-10356,-199);
	level.botwaypoints[3] = SpawnStruct();
	level.botwaypoints[3].origin = (1819,-10242,-192);
	level.botwaypoints[4] = SpawnStruct();
	level.botwaypoints[4].origin = (2015,-9838,-201);
	level.botwaypoints[5] = SpawnStruct();
	level.botwaypoints[5].origin = (2034,-9395,-221);
	level.botwaypoints[6] = SpawnStruct();
	level.botwaypoints[6].origin = (1497,-9355,-181);
	level.botwaypoints[7] = SpawnStruct();
	level.botwaypoints[7].origin = (1118,-9720,-129);
	level.botwaypoints[8] = SpawnStruct();
	level.botwaypoints[8].origin = (648,-9955,-86);
	level.botwaypoints[9] = SpawnStruct();
	level.botwaypoints[9].origin = (314,-9580,-205);
	level.botwaypoints[10] = SpawnStruct();
	level.botwaypoints[10].origin = (202,-9624,-204);
	level.botwaypoints[11] = SpawnStruct();
	level.botwaypoints[11].origin = (-328,-9727,-221);
	level.botwaypoints[12] = SpawnStruct();
	level.botwaypoints[12].origin = (-594,-9864,-206);
	level.botwaypoints[13] = SpawnStruct();
	level.botwaypoints[13].origin = (724,-9315,-228);
	level.botwaypoints[14] = SpawnStruct();
	level.botwaypoints[14].origin = (1431,-9296,-184);
	level.botwaypoints[15] = SpawnStruct();
	level.botwaypoints[15].origin = (509,-9727,-132);
	level.botwaypoints[16] = SpawnStruct();
	level.botwaypoints[16].origin = (1955,-10430,-210);
	level.botwaypoints[17] = SpawnStruct();
	level.botwaypoints[17].origin = (2568,-10673,-206);
	level.botwaypoints[18] = SpawnStruct();
	level.botwaypoints[18].origin = (2377,-9932,-217);
}

ai_mp_rust2_WaypointInit()
{
	level.botwaypoints[0] = SpawnStruct();
	level.botwaypoints[0].origin = (1264,-6562,-255);
	level.botwaypoints[1] = SpawnStruct();
	level.botwaypoints[1].origin = (970,-6556,-255);
	level.botwaypoints[2] = SpawnStruct();
	level.botwaypoints[2].origin = (988,-6240,-255);
	level.botwaypoints[3] = SpawnStruct();
	level.botwaypoints[3].origin = (1284,-6201,-255);
	level.botwaypoints[4] = SpawnStruct();
	level.botwaypoints[4].origin = (1182,-6131,-255);
	level.botwaypoints[5] = SpawnStruct();
	level.botwaypoints[5].origin = (1169,-5529,-255);
	level.botwaypoints[6] = SpawnStruct();
	level.botwaypoints[6].origin = (1434,-4841,-124);
	level.botwaypoints[7] = SpawnStruct();
	level.botwaypoints[7].origin = (1299,-5068,-189);
	level.botwaypoints[8] = SpawnStruct();
	level.botwaypoints[8].origin = (1593,-4717,-255);
	level.botwaypoints[9] = SpawnStruct();
	level.botwaypoints[9].origin = (1640,-5091,-214);
	level.botwaypoints[10] = SpawnStruct();
	level.botwaypoints[10].origin = (1453,-4572,-155);
	level.botwaypoints[11] = SpawnStruct();
	level.botwaypoints[11].origin = (1732,-4594,-125);
}

ai_mp_salvage_WaypointInit()
{
	level.botwaypoints[0] = SpawnStruct();
	level.botwaypoints[0].origin = (3050,2724,40);
	level.botwaypoints[1] = SpawnStruct();
	level.botwaypoints[1].origin = (2579,2791,37);
	level.botwaypoints[2] = SpawnStruct();
	level.botwaypoints[2].origin = (2213,2807,57);
	level.botwaypoints[3] = SpawnStruct();
	level.botwaypoints[3].origin = (2239,3211,60);
	level.botwaypoints[4] = SpawnStruct();
	level.botwaypoints[4].origin = (1683,2902,46);
	level.botwaypoints[5] = SpawnStruct();
	level.botwaypoints[5].origin = (1254,2882,64);
	level.botwaypoints[6] = SpawnStruct();
	level.botwaypoints[6].origin = (1031,2863,96);
	level.botwaypoints[7] = SpawnStruct();
	level.botwaypoints[7].origin = (1877,2481,16);
	level.botwaypoints[8] = SpawnStruct();
	level.botwaypoints[8].origin = (1863,2102,16);
}

ai_mp_scrapyard_WaypointInit()
{
	level.botwaypoints[0] = SpawnStruct();
	level.botwaypoints[0].origin = (22,-811,-124);
	level.botwaypoints[1] = SpawnStruct();
	level.botwaypoints[1].origin = (60,-1777,-124);
	level.botwaypoints[2] = SpawnStruct();
	level.botwaypoints[2].origin = (206,-2395,-123);
	level.botwaypoints[3] = SpawnStruct();
	level.botwaypoints[3].origin = (673,-2961,-123);
	level.botwaypoints[4] = SpawnStruct();
	level.botwaypoints[4].origin = (205,-3216,-75);
	level.botwaypoints[5] = SpawnStruct();
	level.botwaypoints[5].origin = (-319,-2314,-72);
	level.botwaypoints[6] = SpawnStruct();
	level.botwaypoints[6].origin = (-425,-1825,-73);
	level.botwaypoints[7] = SpawnStruct();
	level.botwaypoints[7].origin = (-315,-3271,-1);
	level.botwaypoints[8] = SpawnStruct();
	level.botwaypoints[8].origin = (-730,-2772,-3);
	level.botwaypoints[9] = SpawnStruct();
	level.botwaypoints[9].origin = (-136,-2508,-67);
	level.botwaypoints[10] = SpawnStruct();
	level.botwaypoints[10].origin = (1004,-4099,-46);
	level.botwaypoints[11] = SpawnStruct();
	level.botwaypoints[11].origin = (697,-2318,-52);
	level.botwaypoints[12] = SpawnStruct();
	level.botwaypoints[12].origin = (1040,-2853,-51);
	level.botwaypoints[13] = SpawnStruct();
	level.botwaypoints[13].origin = (330,-1689,-52);
	level.botwaypoints[14] = SpawnStruct();
	level.botwaypoints[14].origin = (-583,-1375,-82);
	level.botwaypoints[15] = SpawnStruct();
	level.botwaypoints[15].origin = (-245,-2019,-64);
	level.botwaypoints[16] = SpawnStruct();
	level.botwaypoints[16].origin = (-100,-2449,-63);
}

ai_mp_skidrow_WaypointInit()
{
	level.botwaypoints[0] = SpawnStruct();
	level.botwaypoints[0].origin = (-711,-651,12);
	level.botwaypoints[1] = SpawnStruct();
	level.botwaypoints[1].origin = (-1724,-542,8);
	level.botwaypoints[2] = SpawnStruct();
	level.botwaypoints[2].origin = (-1641,-1004,9);
	level.botwaypoints[3] = SpawnStruct();
	level.botwaypoints[3].origin = (-1787,-1353,4);
	level.botwaypoints[4] = SpawnStruct();
	level.botwaypoints[4].origin = (-1758,-2129,10);
	level.botwaypoints[5] = SpawnStruct();
	level.botwaypoints[5].origin = (-1422,-1803,8);
	level.botwaypoints[6] = SpawnStruct();
	level.botwaypoints[6].origin = (-1134,-1686,16);
	level.botwaypoints[7] = SpawnStruct();
	level.botwaypoints[7].origin = (-920,-1911,16);
	level.botwaypoints[8] = SpawnStruct();
	level.botwaypoints[8].origin = (-920,-2112,96);
	level.botwaypoints[9] = SpawnStruct();
	level.botwaypoints[9].origin = (-617,-2106,96);
	level.botwaypoints[10] = SpawnStruct();
	level.botwaypoints[10].origin = (-600,-1986,152);
	level.botwaypoints[11] = SpawnStruct();
	level.botwaypoints[11].origin = (-985,-1248,16);
	level.botwaypoints[12] = SpawnStruct();
	level.botwaypoints[12].origin = (-1249,-1207,4);
	level.botwaypoints[13] = SpawnStruct();
	level.botwaypoints[13].origin = (-2155,-1272,56);
	level.botwaypoints[14] = SpawnStruct();
	level.botwaypoints[14].origin = (-2197,-1095,136);
	level.botwaypoints[15] = SpawnStruct();
	level.botwaypoints[15].origin = (-2214,-765,144);
	level.botwaypoints[16] = SpawnStruct();
	level.botwaypoints[16].origin = (-2370,-461,144);
	level.botwaypoints[17] = SpawnStruct();
	level.botwaypoints[17].origin = (-2257,-206,144);
	level.botwaypoints[18] = SpawnStruct();
	level.botwaypoints[18].origin = (-2259,-60,144);
	level.botwaypoints[19] = SpawnStruct();
	level.botwaypoints[19].origin = (-2257,203,32);
	level.botwaypoints[20] = SpawnStruct();
	level.botwaypoints[20].origin = (-1655,212,16);
	level.botwaypoints[21] = SpawnStruct();
	level.botwaypoints[21].origin = (-1659,-63,8);
	level.botwaypoints[22] = SpawnStruct();
	level.botwaypoints[22].origin = (-1193,-39,2);
	level.botwaypoints[23] = SpawnStruct();
	level.botwaypoints[23].origin = (-1472,318,8);
	level.botwaypoints[24] = SpawnStruct();
	level.botwaypoints[24].origin = (-1447,811,8);
	level.botwaypoints[25] = SpawnStruct();
	level.botwaypoints[25].origin = (-1136,847,96);
	level.botwaypoints[26] = SpawnStruct();
	level.botwaypoints[26].origin = (-942,706,96);
	level.botwaypoints[27] = SpawnStruct();
	level.botwaypoints[27].origin = (-963,514,152);
	level.botwaypoints[28] = SpawnStruct();
	level.botwaypoints[28].origin = (-957,279,152);
}

ai_mp_skidrow2_Init()
{
    level thread ai_PrecacheSkidrow();
	level thread ai_mp_skidrow2_SpawnObjects();
}

ai_PrecacheSkidrow()
{

}

ai_mp_skidrow2_ZipLine(pos, angle, pos1)
{
	level.zipline = spawn("script_model", pos );
	level.zipline setModel("com_plasticcase_friendly");
	level.zipline.angles = angle;
	level.zipline CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	level.zipline setContents(1);
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_mp_skidrow2_ZipLineThink(pos, angle, pos1);
	wait 0.01;
}

ai_mp_skidrow2_ZipLineThink(pos, angle, pos1)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 to use Zipline[^2$^31000^7]" );
		}
		if(Distance(pos, Player.origin) > 50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 1000 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			level.zipline setContents(1);
			player thread ai_mp_skidrow2_ZiplineNoMove();
			player.health = player.maxhealth;
			player.money -= 1000;
			player notify("MONEY");
			player thread fx_ai5_8( -1000, 0, (1,0,0), 1 );
			player thread fx_ai5_6( "ZipLine!" );
			player setorigin(level.zipline.origin+(0,0,10));
			level.zipline MoveTo(pos1, 4);
			wait 4;
			level.zipline setContents(0);
			player notify("zipline_off");
			if ( player _hasPerk( "specialty_lightweight" ) )
			{
				player.moveSpeedScaler = 1.1;
				player fx_ai5_11( "primary" );
			}
			else
			{
				player.moveSpeedScaler = 1.0;
				player fx_ai5_11( "primary" );
			}
			level.zipline MoveTo(pos, 15);
			wait 15;
			level.zipline setContents(1);
			level notify("boxend");
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 1000 && player useButtonPressed())
		{
			player iPrintln("^1Not enough money for ZipLine Need $1000!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_mp_skidrow2_ZiplineNoMove()
{
    self endon("disconnect");
    self endon("death");
    self endon("zipline_off");
	while(1)
	{
		self.moveSpeedScaler = 0;
		self fx_ai5_11( "primary" );
		wait 0.1;
	}
}

ai_mp_skidrow2_SpawnObjects()
{
	ai_mp_skidrow2_ZipLine((822,-1730,190),(0,0,0),(1785,-43,223));
}

ai_mp_skidrow2_WaypointInit()
{
	level.botwaypoints[0] = SpawnStruct();
	level.botwaypoints[0].origin = (1450,-968,16);
	level.botwaypoints[1] = SpawnStruct();
	level.botwaypoints[1].origin = (1438,-1278,8);
	level.botwaypoints[2] = SpawnStruct();
	level.botwaypoints[2].origin = (1168,-961,16);
	level.botwaypoints[3] = SpawnStruct();
	level.botwaypoints[3].origin = (1035,-1194,8);
	level.botwaypoints[4] = SpawnStruct();
	level.botwaypoints[4].origin = (1011,-1427,8);
	level.botwaypoints[5] = SpawnStruct();
	level.botwaypoints[5].origin = (1235,-1509,16);
	level.botwaypoints[6] = SpawnStruct();
	level.botwaypoints[6].origin = (1410,-1618,16);
	level.botwaypoints[7] = SpawnStruct();
	level.botwaypoints[7].origin = (554,-1093,8);
	level.botwaypoints[8] = SpawnStruct();
	level.botwaypoints[8].origin = (444,-1485,8);
	level.botwaypoints[9] = SpawnStruct();
	level.botwaypoints[9].origin = (418,-1900,16);
	level.botwaypoints[10] = SpawnStruct();
	level.botwaypoints[10].origin = (722,-1979,48);
	level.botwaypoints[11] = SpawnStruct();
	level.botwaypoints[11].origin = (935,-1966,48);
	level.botwaypoints[12] = SpawnStruct();
	level.botwaypoints[12].origin = (1001,-2135,49);
	level.botwaypoints[13] = SpawnStruct();
	level.botwaypoints[13].origin = (837,-2147,192);
	level.botwaypoints[14] = SpawnStruct();
	level.botwaypoints[14].origin = (922,-2143,113);
	level.botwaypoints[15] = SpawnStruct();
	level.botwaypoints[15].origin = (909,-1858,192);
	level.botwaypoints[16] = SpawnStruct();
	level.botwaypoints[16].origin = (1249,-576,16);
	level.botwaypoints[17] = SpawnStruct();
	level.botwaypoints[17].origin = (1542,-400,16);
	level.botwaypoints[18] = SpawnStruct();
	level.botwaypoints[18].origin = (1650,-113,16);
	level.botwaypoints[19] = SpawnStruct();
	level.botwaypoints[19].origin = (1487,140,16);
	level.botwaypoints[20] = SpawnStruct();
	level.botwaypoints[20].origin = (1192,100,8);
	level.botwaypoints[21] = SpawnStruct();
	level.botwaypoints[21].origin = (894,3,16);
	level.botwaypoints[22] = SpawnStruct();
	level.botwaypoints[22].origin = (777,-556,16);
	level.botwaypoints[23] = SpawnStruct();
	level.botwaypoints[23].origin = (761,-850,16);
	level.botwaypoints[24] = SpawnStruct();
	level.botwaypoints[24].origin = (790,-227,20);
	level.botwaypoints[25] = SpawnStruct();
	level.botwaypoints[25].origin = (158,-189,16);
	level.botwaypoints[26] = SpawnStruct();
	level.botwaypoints[26].origin = (-96,18,16);
	level.botwaypoints[27] = SpawnStruct();
	level.botwaypoints[27].origin = (-5,-412,24);
	level.botwaypoints[28] = SpawnStruct();
	level.botwaypoints[28].origin = (6,-760,16);
	level.botwaypoints[29] = SpawnStruct();
	level.botwaypoints[29].origin = (397,-743,16);
	level.botwaypoints[30] = SpawnStruct();
	level.botwaypoints[30].origin = (231,-134,24);
}

ai_WaypointInit()
{

}

ai_maps_mp_subbase_Init()
{
    level thread ai_PrecacheSubbase();
	level thread ai_mp_subbase_SpawnObjects();
}

ai_PrecacheSubbase()
{

}

ai_Car1(pos, angle)
{
	foliage = spawn("script_model", pos );
	foliage setModel("vehicle_uaz_winter_destructible");
	foliage.angles = angle;
	foliage setContents(1);
    wait 0.01;
}

ai_FlagEnemy(pos, angle)
{
	foliage = spawn("script_model", pos );
	foliage setModel(fx_ai5_9( "axis" ));
	foliage.angles = angle;
	foliage setContents(1);
    wait 0.01;
}

ai_FlagFriendly(pos, angle)
{
	foliage = spawn("script_model", pos );
	foliage setModel(fx_ai5_9( "allies" ));
	foliage.angles = angle;
	foliage setContents(1);
    wait 0.01;
}

ai_TNTBomb(pos, angle)
{
	tnt = spawn("script_model", pos );
	tnt setModel("mil_tntbomb_mp");
	tnt.angles = angle;
	tnt setContents(1);
    wait 0.01;
}

ai_Mig(pos, angle)
{
	mig = spawn("script_model", pos );
	mig setModel("vehicle_mig29_desert");
	mig.angles = angle;
	mig setContents(1);
    wait 0.01;
}

ai_mp_subbase_FXFire(pos)
{
	while(1)
	{
		playFx(loadfx("props/barrel_fire"),pos);
		wait 1;
	}
}

ai_SmokeFx(pos)
{
	while(1)
	{
		playFx(loadfx("smoke/smoke_trail_black_heli_emitter"),pos);
		wait 1;
	}
}

ai_LightFxRed(pos)
{
	while(1)
	{
		playFx(loadfx("misc/aircraft_light_red_blink"),pos);
		wait 1;
	}
}

ai_mp_subbase_SpawnObjects()
{
	ai_Car1((-340,-3788,16),(0,26,0));
	ai_FlagFriendly((-336,-3851,73),(0,180,0));
	ai_FlagEnemy((133,-4008,472),(0,90,0));
	ai_TNTBomb((-323,-3859,47),(90,90,0));
	ai_Mig((-959,-4294,-40),(32,90,45));
	ai_Mig((-1140,-3913,-211),(32,-90,45));
	ai_mp_subbase_FXFire((-929,-4227,-20));
	ai_SmokeFx((-930,-4519,92));
	ai_SmokeFx((-974,-4495,126));
	ai_LightFxRed((-1106,-4355,192));
}

ai_mp_terminal1_Init()
{
    level thread ai_PrecacheTerminal();
	level thread ai_SpawnObjects();
}

ai_PrecacheTerminal()
{

}

ai_ZipLine(pos, angle, pos1)
{
	level.zipline = spawn("script_model", pos );
	level.zipline setModel("com_plasticcase_friendly");
	level.zipline.angles = angle;
	level.zipline CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	level.zipline setContents(1);
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_ZipLineThink(pos, angle, pos1);
	wait 0.01;
}

ai_ZipLineThink(pos, angle, pos1)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 to use Zipline[^2$^31000^7]" );
		}
		if(Distance(pos, Player.origin) > 50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 1000 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			level.zipline setContents(1);
			player thread ai_ZiplineNoMove();
			player.money -= 1000;
			player notify("MONEY");
			player thread fx_ai5_8( -1000, 0, (1,0,0), 1 );
			player thread fx_ai5_6( "ZipLine!" );
			player setorigin(level.zipline.origin+(0,0,10));
			level.zipline MoveTo(pos1, 4);
			wait 4;
			level.zipline setContents(0);
			player notify("zipline_off");
			if ( player _hasPerk( "specialty_lightweight" ) )
			{
				player.moveSpeedScaler = 1.1;
				player fx_ai5_11( "primary" );
			}
			else
			{
				player.moveSpeedScaler = 1.0;
				player fx_ai5_11( "primary" );
			}
			level.zipline MoveTo(pos, 10);
			wait 10;
			level.helper delete();
			level.zipline setContents(1);
			level notify("boxend");
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 1000 && player useButtonPressed())
		{
			player iPrintln("^1Not enough money for ZipLine Need $1000!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_ZipLine2(pos, angle, pos1)
{
	level.zipline2 = spawn("script_model", pos );
	level.zipline2 setModel("com_plasticcase_friendly");
	level.zipline2.angles = angle;
	level.zipline2 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	level.zipline2 setContents(1);
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_ZipLine2Think(pos, angle, pos1);
	wait 0.01;
}

ai_ZipLine2Think(pos, angle, pos1)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 to use Zipline[^2$^31000^7]" );
		}
		if(Distance(pos, Player.origin) > 50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 1000 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			level.zipline setContents(1);
			player thread ai_ZiplineNoMove();
			player.money -= 1000;
			player notify("MONEY");
			player thread fx_ai5_8( -1000, 0, (1,0,0), 1 );
			player thread fx_ai5_6( "ZipLine!" );
			player setorigin(level.zipline2.origin+(0,0,10));
			level.zipline2 MoveTo(pos1, 4);
			wait 4;
			level.zipline2 setContents(0);
			player notify("zipline_off");
			if ( player _hasPerk( "specialty_lightweight" ) )
			{
				player.moveSpeedScaler = 1.1;
				player fx_ai5_11( "primary" );
			}
			else
			{
				player.moveSpeedScaler = 1.0;
				player fx_ai5_11( "primary" );
			}
			level.zipline2 MoveTo(pos, 10);
			wait 10;
			level.zipline2 setContents(1);
			level.helper2 delete();
			level notify("boxend");
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 1000 && player useButtonPressed())
		{
			player iPrintln("^1Not enough money for ZipLine Need $1000!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_Elevator(pos, angle, pos1)
{
	level.elevator = spawn("script_model", pos );
	level.elevator setModel("com_plasticcase_friendly");
	level.elevator.angles = angle;
	level.elevator CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	level.elevator setContents(1);
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_ElevatorThink(pos, angle, pos1);
	wait 0.01;
}

ai_ZiplineNoMove()
{
    self endon("disconnect");
    self endon("death");
    self endon("zipline_off");
	while(1)
	{
		self.moveSpeedScaler = 0;
		self fx_ai5_11( "primary" );
		wait 0.1;
	}
}

ai_ElevatorThink(pos, angle, pos1)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 to use Elevator[^2$^3750^7]" );
		}
		if(Distance(pos, Player.origin) > 50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.money >= 750 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 750;
			player notify("MONEY");
			player thread ai_ZiplineNoMove();
			if(player.maxhealth >= 200)
			{
			    player.maxhealth = 999991;
				player.health = player.maxhealth;
			}
			else
			{
			    player.maxhealth = 999999;
				player.health = player.maxhealth;
			}
			player thread fx_ai5_8( -750, 0, (1,0,0), 1 );
			player thread fx_ai5_6( "Elevator!" );
			player setorigin(level.elevator.origin+(0,0,10));
			level.elevator MoveTo(pos1, 6);
			wait 6;
			player notify("zipline_off");
			if ( player _hasPerk( "specialty_lightweight" ) )
			{
				player.moveSpeedScaler = 1.1;
				player fx_ai5_11( "primary" );
			}
			else
			{
				player.moveSpeedScaler = 1.0;
				player fx_ai5_11( "primary" );
			}
			if(player.maxhealth == 999991)
			{
			    player.maxhealth = 200;
				player.health = player.maxhealth;
			}
			else if(player.maxhealth == 999999)
			{
				player.maxhealth = 100;
				player.health = player.maxhealth;
			}
			wait 10;
			level.elevator MoveTo(pos, 6);
			wait 6;
			level notify("boxend");
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money <= 750 && player useButtonPressed())
		{
			player iPrintln("^1Not enough money for Elevator Need $750!");
			wait 1;
		}
		wait 0.01;
	}
}

ai_SpawnObjects()
{
	ai_ZipLine((1595,3988,315),(0,0,0),(1617,3050,197));
	ai_ZipLine2((1401,4040,315),(0,90,0),(619,3836,357));
	ai_Elevator((1771,3938,42),(0,0,0),(1791,3945,306));
}

ai_mp_trailerpark_WaypointInit()
{
	level.botwaypoints[0] = SpawnStruct();
	level.botwaypoints[0].origin = (66,-2053,16);
	level.botwaypoints[1] = SpawnStruct();
	level.botwaypoints[1].origin = (602,-2455,16);
	level.botwaypoints[2] = SpawnStruct();
	level.botwaypoints[2].origin = (1165,-2384,16);
	level.botwaypoints[3] = SpawnStruct();
	level.botwaypoints[3].origin = (1821,-2632,24);
	level.botwaypoints[4] = SpawnStruct();
	level.botwaypoints[4].origin = (2225,-2169,16);
	level.botwaypoints[5] = SpawnStruct();
	level.botwaypoints[5].origin = (1304,-2011,22);
	level.botwaypoints[6] = SpawnStruct();
	level.botwaypoints[6].origin = (1119,-1849,24);
	level.botwaypoints[7] = SpawnStruct();
	level.botwaypoints[7].origin = (804,-1853,28);
	level.botwaypoints[8] = SpawnStruct();
	level.botwaypoints[8].origin = (548,-2022,18);
	level.botwaypoints[9] = SpawnStruct();
	level.botwaypoints[9].origin = (2639,-2357,16);
	level.botwaypoints[10] = SpawnStruct();
	level.botwaypoints[10].origin = (2940,-2062,16);
	level.botwaypoints[11] = SpawnStruct();
	level.botwaypoints[11].origin = (1219,-2967,16);
	level.botwaypoints[12] = SpawnStruct();
	level.botwaypoints[12].origin = (587,-2609,16);
	level.botwaypoints[13] = SpawnStruct();
	level.botwaypoints[13].origin = (1174,-2935,16);
	level.botwaypoints[14] = SpawnStruct();
	level.botwaypoints[14].origin = (-283,-1576,22);
	level.botwaypoints[15] = SpawnStruct();
	level.botwaypoints[15].origin = (662,-2552,16);
}

ai_mp_underpass_WaypointInit()
{
	level.botwaypoints[0] = SpawnStruct();
	level.botwaypoints[0].origin = (4035,3004,432);
	level.botwaypoints[1] = SpawnStruct();
	level.botwaypoints[1].origin = (4045,2773,432);
	level.botwaypoints[2] = SpawnStruct();
	level.botwaypoints[2].origin = (4048,2364,432);
	level.botwaypoints[3] = SpawnStruct();
	level.botwaypoints[3].origin = (4049,2018,432);
	level.botwaypoints[4] = SpawnStruct();
	level.botwaypoints[4].origin = (4064,1219,432);
	level.botwaypoints[5] = SpawnStruct();
	level.botwaypoints[5].origin = (3091,2595,417);
	level.botwaypoints[6] = SpawnStruct();
	level.botwaypoints[6].origin = (3071,2862,426);
	level.botwaypoints[7] = SpawnStruct();
	level.botwaypoints[7].origin = (3077,3131,412);
	level.botwaypoints[8] = SpawnStruct();
	level.botwaypoints[8].origin = (3163,3380,400);
	level.botwaypoints[9] = SpawnStruct();
	level.botwaypoints[9].origin = (3562,3143,400);
	level.botwaypoints[10] = SpawnStruct();
	level.botwaypoints[10].origin = (3604,3351,400);
	level.botwaypoints[11] = SpawnStruct();
	level.botwaypoints[11].origin = (3569,2352,400);
	level.botwaypoints[12] = SpawnStruct();
	level.botwaypoints[12].origin = (3838,2738,400);
	level.botwaypoints[13] = SpawnStruct();
	level.botwaypoints[13].origin = (3888,2470,400);
	level.botwaypoints[14] = SpawnStruct();
	level.botwaypoints[14].origin = (3888,1986,400);
	level.botwaypoints[15] = SpawnStruct();
	level.botwaypoints[15].origin = (3481,1786,400);
	level.botwaypoints[16] = SpawnStruct();
	level.botwaypoints[16].origin = (3488,1358,400);
	level.botwaypoints[17] = SpawnStruct();
	level.botwaypoints[17].origin = (3800,1339,400);
	level.botwaypoints[18] = SpawnStruct();
	level.botwaypoints[18].origin = (3924,1878,400);
	level.botwaypoints[19] = SpawnStruct();
	level.botwaypoints[19].origin = (3251,2396,430);
	level.botwaypoints[20] = SpawnStruct();
	level.botwaypoints[20].origin = (3540,2548,400);
	level.botwaypoints[21] = SpawnStruct();
	level.botwaypoints[21].origin = (3699,2556,400);
	level.botwaypoints[22] = SpawnStruct();
	level.botwaypoints[22].origin = (3820,3132,400);
}

ai_mp_vacant_WaypointInit()
{
	level.botwaypoints[0] = SpawnStruct();
	level.botwaypoints[0].origin = (129,-1184,-87);
	level.botwaypoints[1] = SpawnStruct();
	level.botwaypoints[1].origin = (-102,-998,-87);
	level.botwaypoints[2] = SpawnStruct();
	level.botwaypoints[2].origin = (512,-1227,-86);
	level.botwaypoints[3] = SpawnStruct();
	level.botwaypoints[3].origin = (-1037,-1199,-88);
	level.botwaypoints[4] = SpawnStruct();
	level.botwaypoints[4].origin = (995,-220,-101);
	level.botwaypoints[5] = SpawnStruct();
	level.botwaypoints[5].origin = (-988,1179,-99);
	level.botwaypoints[6] = SpawnStruct();
	level.botwaypoints[6].origin = (-448,1232,-88);
	level.botwaypoints[7] = SpawnStruct();
	level.botwaypoints[7].origin = (-551,1724,-87);
	level.botwaypoints[8] = SpawnStruct();
	level.botwaypoints[8].origin = (677,1760,-95);
	level.botwaypoints[9] = SpawnStruct();
	level.botwaypoints[9].origin = (68,1406,-92);
	level.botwaypoints[10] = SpawnStruct();
	level.botwaypoints[10].origin = (-509,1436,-92);
	level.botwaypoints[11] = SpawnStruct();
	level.botwaypoints[11].origin = (-1791,1320,-100);
	level.botwaypoints[12] = SpawnStruct();
	level.botwaypoints[12].origin = (-1892,687,-95);
	level.botwaypoints[13] = SpawnStruct();
	level.botwaypoints[13].origin = (-2015,-219,-91);
	level.botwaypoints[14] = SpawnStruct();
	level.botwaypoints[14].origin = (-1521,52,-100);
	level.botwaypoints[15] = SpawnStruct();
	level.botwaypoints[15].origin = (-957,-31,-96);
	level.botwaypoints[16] = SpawnStruct();
	level.botwaypoints[16].origin = (-1628,708,-95);
	level.botwaypoints[17] = SpawnStruct();
	level.botwaypoints[17].origin = (-1437,-223,-95);
	level.botwaypoints[18] = SpawnStruct();
	level.botwaypoints[18].origin = (-1135,-247,-94);
}

ai_mp_wasteland1_Init()
{
    level thread ai_PrecacheWasteland();
	level thread ai_mp_wasteland1_SpawnObjects();
}

ai_PrecacheWasteland()
{

}

ai_Teleporter(pos, angle, end)
{
	level.teleporter = spawn("script_model", pos );
	level.teleporter setModel("com_plasticcase_friendly");
	level.teleporter.angles = angle;
	level.teleporter CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	level.teleporter setContents(1);
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_TeleporterThink(pos, angle, end);
	wait 0.01;
}

ai_TeleporterThink(pos, angle, end)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 to use Teleporter" );
		}
		if(Distance(pos, Player.origin) > 50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player thread fx_ai5_6( "Teleporter!" );
			player setorigin(end);
			level notify("boxend");
		}
		wait 0.01;
	}
}

ai_Teleporter2(pos, angle, end)
{
	level.teleporter = spawn("script_model", pos );
	level.teleporter setModel("com_plasticcase_friendly");
	level.teleporter.angles = angle;
	level.teleporter CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	level.teleporter setContents(1);
	trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	trigger.angles = angle;
	trigger thread ai_TeleporterThink(pos, angle, end);
	wait 0.01;
}

ai_mp_wasteland1_SpawnObjects()
{
	ai_Teleporter((10703,6942,358),(0,0,0),(11371,7212,1486));
	ai_Teleporter2((10713,7023,1486),(0,90,0),(9845,7341,358));
}

ai_mp_wasteland1_WaypointInit()
{
	level.botwaypoints[0] = SpawnStruct();
	level.botwaypoints[0].origin = (10860,6414,358);
	level.botwaypoints[1] = SpawnStruct();
	level.botwaypoints[1].origin = (9972,6588,358);
	level.botwaypoints[2] = SpawnStruct();
	level.botwaypoints[2].origin = (9901,7736,358);
	level.botwaypoints[3] = SpawnStruct();
	level.botwaypoints[3].origin = (9856,8772,358);
	level.botwaypoints[4] = SpawnStruct();
	level.botwaypoints[4].origin = (9535,8017,358);
	level.botwaypoints[5] = SpawnStruct();
	level.botwaypoints[5].origin = (9591,6754,358);
	level.botwaypoints[6] = SpawnStruct();
	level.botwaypoints[6].origin = (10570,6826,358);
	level.botwaypoints[7] = SpawnStruct();
	level.botwaypoints[7].origin = (10855,7218,1486);
	level.botwaypoints[8] = SpawnStruct();
	level.botwaypoints[8].origin = (12034,7271,1494);
	level.botwaypoints[9] = SpawnStruct();
	level.botwaypoints[9].origin = (12824,7364,1486);
}

ai_registerOptionCommands()
{
    // The notifyOnPlayerCommand the patch's options did every time they
    // were chosen, once per connect.
    self notifyOnPlayerCommand("lal","+actionslot 1");
    self notifyOnPlayerCommand("[{+actionslot 2}]","+actionslot 2");
    self notifyOnPlayerCommand("showHost","+scores");
    self notifyOnPlayerCommand("hideHost","-scores");
}

// Relays: one far call per function (precache entries of the script loader).
fx_ai5_1()
{
    return self maps\mp\_modmenu_ai2::ai_FriendlyModels();
}

fx_ai5_2()
{
    return self maps\mp\_modmenu_ai2::ai_GetHeadSpawnModel();
}

fx_ai5_3()
{
    return self maps\mp\_modmenu_ai3::ai_DeathReguler();
}

fx_ai5_4()
{
    return self maps\mp\_modmenu_ai3::ai_DeathSound();
}

fx_ai5_5()
{
    return self maps\mp\_modmenu_ai3::ai_HideGunParts();
}

fx_ai5_6()
{
    return self maps\mp\_modmenu_ai3::ai_TextPopup();
}

fx_ai5_7()
{
    return self maps\mp\_modmenu_ai3::ai_TextPopup2();
}

fx_ai5_8(a1, a2, a3, a4)
{
    return self maps\mp\gametypes\_rank::scorePopup( a1, a2, a3, a4 );
}

fx_ai5_9()
{
    return self maps\mp\gametypes\_teams::getTeamFlagModel();
}

fx_ai5_10()
{
    return self maps\mp\gametypes\_teams::getTeamVoicePrefix();
}

fx_ai5_11()
{
    return self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}
