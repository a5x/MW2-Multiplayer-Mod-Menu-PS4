
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

ai_FriendlyModels()
{
	fModel = "";
	switch( getDvar("mapname") )
	{
		case "mp_afghan":
		switch(randomInt(5))
		{
			case 0:
			fModel = "mp_body_desert_tf141_assault_a";
			break;
			case 1:
			fModel = "mp_body_desert_tf141_lmg";
			break;
			case 2:
			fModel = "mp_body_desert_tf141_smg";
			break;
			case 3:
			fModel = "mp_body_desert_tf141_shotgun";
			break;
			case 4:
			fModel = "mp_body_desert_tf141_assault_b";
			break;
		}
		break;
		case "mp_boneyard":
		switch(randomInt(5))
		{
			case 0:
			fModel = "mp_body_desert_tf141_assault_b";
			break;
			case 1:
			fModel = "mp_body_desert_tf141_lmg";
			break;
			case 2:
			fModel = "mp_body_desert_tf141_smg";
			break;
			case 3:
			fModel = "mp_body_desert_tf141_shotgun";
			break;
			case 4:
			fModel = "mp_body_desert_tf141_assault_a";
			break;
		}
		break;
		case "mp_derail":
		switch(randomInt(5))
		{
			case 0:
			fModel = "mp_body_tf141_assault_a";
			break;
			case 1:
			fModel = "mp_body_tf141_assault_b";
			break;
			case 2:
			fModel = "mp_body_tf141_lmg";
			break;
			case 3:
			fModel = "mp_body_tf141_smg";
			break;
			case 4:
			fModel = "mp_body_tf141_shotgun";
			break;
		}
		break;
		case "mp_estate":
		switch(randomInt(5))
		{
			case 0:
			fModel = "mp_body_forest_tf141_assault_a";
			break;
			case 1:
			fModel = "mp_body_forest_tf141_assault_b";
			break;
			case 2:
			fModel = "mp_body_forest_tf141_lmg";
			break;
			case 3:
			fModel = "mp_body_forest_tf141_smg";
			break;
			case 4:
			fModel = "mp_body_forest_tf141_shotgun";
			break;
		}
		break;
		case "mp_favela":
		switch(randomInt(5))
		{
			case 0:
			fModel = "mp_body_desert_tf141_assault_b";
			break;
			case 1:
			fModel = "mp_body_desert_tf141_lmg";
			break;
			case 2:
			fModel = "mp_body_desert_tf141_smg";
			break;
			case 3:
			fModel = "mp_body_desert_tf141_shotgun";
			break;
			case 4:
			fModel = "mp_body_desert_tf141_assault_a";
			break;
		}
		break;
		case "mp_highrise":
		switch(randomInt(13))
		{
			case 0:
			fModel = "mp_body_us_army_lmg";
			break;
			case 1:
			fModel = "mp_body_us_army_lmg_b";
			break;
			case 2:
			fModel = "mp_body_us_army_lmg_c";
			break;
			case 3:
			fModel = "mp_body_us_army_assault_a";
			break;
			case 4:
			fModel = "mp_body_us_army_assault_b";
			break;
			case 5:
			fModel = "mp_body_us_army_assault_c";
			break;
			case 6:
			fModel = "mp_body_us_army_shotgun";
			break;
			case 7:
			fModel = "mp_body_us_army_shotgun_b";
			break;
			case 8:
			fModel = "mp_body_us_army_shotgun_c";
			break;
			case 9:
			fModel = "mp_body_us_army_smg";
			break;
			case 10:
			fModel = "mp_body_us_army_smg_b";
			break;
			case 11:
			fModel = "mp_body_us_army_smg_c";
			break;
		}
		break;
		case "mp_invasion":
		switch(randomInt(13))
		{
			case 0:
			fModel = "mp_body_us_army_lmg";
			break;
			case 1:
			fModel = "mp_body_us_army_lmg_b";
			break;
			case 2:
			fModel = "mp_body_us_army_lmg_c";
			break;
			case 3:
			fModel = "mp_body_us_army_assault_a";
			break;
			case 4:
			fModel = "mp_body_us_army_assault_b";
			break;
			case 5:
			fModel = "mp_body_us_army_assault_c";
			break;
			case 6:
			fModel = "mp_body_us_army_shotgun";
			break;
			case 7:
			fModel = "mp_body_us_army_shotgun_b";
			break;
			case 8:
			fModel = "mp_body_us_army_shotgun_c";
			break;
			case 9:
			fModel = "mp_body_us_army_smg";
			break;
			case 10:
			fModel = "mp_body_us_army_smg_b";
			break;
			case 11:
			fModel = "mp_body_us_army_smg_c";
			break;
		}
		break;
		case "mp_checkpoint":
		switch(randomInt(4))
		{
			case 0:
			fModel = "mp_body_seal_udt_lmg";
			break;
			case 1:
			fModel = "mp_body_seal_udt_assault_a";
			break;
			case 2:
			fModel = "mp_body_seal_udt_assault_b";
			break;
			case 3:
			fModel = "mp_body_seal_udt_smg";
			break;
		}
		break;
		case "mp_quarry":
		switch(randomInt(5))
		{
			case 0:
			fModel = "mp_body_desert_tf141_assault_a";
			break;
			case 1:
			fModel = "mp_body_desert_tf141_lmg";
			break;
			case 2:
			fModel = "mp_body_desert_tf141_smg";
			break;
			case 3:
			fModel = "mp_body_desert_tf141_shotgun";
			break;
			case 4:
			fModel = "mp_body_desert_tf141_assault_b";
			break;
		}
		break;
		case "mp_rundown":
		switch(randomInt(5))
		{
			case 0:
			fModel = "mp_body_desert_tf141_assault_a";
			break;
			case 1:
			fModel = "mp_body_desert_tf141_lmg";
			break;
			case 2:
			fModel = "mp_body_desert_tf141_smg";
			break;
			case 3:
			fModel = "mp_body_desert_tf141_shotgun";
			break;
			case 4:
			fModel = "mp_body_riot_tf141_desert";
			break;
		}
		break;
		case "mp_rust":
		switch(randomInt(5))
		{
			case 0:
			fModel = "mp_body_desert_tf141_assault_a";
			break;
			case 1:
			fModel = "mp_body_desert_tf141_lmg";
			break;
			case 2:
			fModel = "mp_body_desert_tf141_smg";
			break;
			case 3:
			fModel = "mp_body_desert_tf141_shotgun";
			break;
			case 4:
			fModel = "mp_body_riot_tf141_desert";
			break;
		}
		break;
		case "mp_nightshift": //Skidrow
		switch(randomInt(13))
		{
			case 0:
			fModel = "mp_body_us_army_lmg";
			break;
			case 1:
			fModel = "mp_body_us_army_lmg_b";
			break;
			case 2:
			fModel = "mp_body_us_army_lmg_c";
			break;
			case 3:
			fModel = "mp_body_us_army_assault_a";
			break;
			case 4:
			fModel = "mp_body_us_army_assault_b";
			break;
			case 5:
			fModel = "mp_body_us_army_assault_c";
			break;
			case 6:
			fModel = "mp_body_us_army_shotgun";
			break;
			case 7:
			fModel = "mp_body_us_army_shotgun_b";
			break;
			case 8:
			fModel = "mp_body_us_army_shotgun_c";
			break;
			case 9:
			fModel = "mp_body_us_army_smg";
			break;
			case 10:
			fModel = "mp_body_us_army_smg_b";
			break;
			case 11:
			fModel = "mp_body_us_army_smg_c";
			break;
		}
		break;
		case "mp_subbase":
		switch(randomInt(4))
		{
			case 0:
			fModel = "mp_body_seal_udt_lmg";
			break;
			case 1:
			fModel = "mp_body_seal_udt_assault_a";
			break;
			case 2:
			fModel = "mp_body_seal_udt_assault_b";
			break;
			case 3:
			fModel = "mp_body_seal_udt_smg";
			break;
		}
		break;
		case "mp_terminal":
		switch(randomInt(13))
		{
			case 0:
			fModel = "mp_body_us_army_lmg";
			break;
			case 1:
			fModel = "mp_body_us_army_lmg_b";
			break;
			case 2:
			fModel = "mp_body_us_army_lmg_c";
			break;
			case 3:
			fModel = "mp_body_us_army_assault_a";
			break;
			case 4:
			fModel = "mp_body_us_army_assault_b";
			break;
			case 5:
			fModel = "mp_body_us_army_assault_c";
			break;
			case 6:
			fModel = "mp_body_us_army_shotgun";
			break;
			case 7:
			fModel = "mp_body_us_army_shotgun_b";
			break;
			case 8:
			fModel = "mp_body_us_army_shotgun_c";
			break;
			case 9:
			fModel = "mp_body_us_army_smg";
			break;
			case 10:
			fModel = "mp_body_us_army_smg_b";
			break;
			case 11:
			fModel = "mp_body_us_army_smg_c";
			break;
		}
		break;
		case "mp_underpass":
		switch(randomInt(5))
		{
			case 0:
			fModel = "mp_body_forest_tf141_assault_a";
			break;
			case 1:
			fModel = "mp_body_forest_tf141_assault_b";
			break;
			case 2:
			fModel = "mp_body_forest_tf141_lmg";
			break;
			case 3:
			fModel = "mp_body_forest_tf141_smg";
			break;
			case 4:
			fModel = "mp_body_forest_tf141_shotgun";
			break;
		}
		break;
		case "mp_brecourt":
		switch(randomInt(5))
		{
			case 0:
			fModel = "mp_body_forest_tf141_assault_a";
			break;
			case 1:
			fModel = "mp_body_forest_tf141_assault_b";
			break;
			case 2:
			fModel = "mp_body_forest_tf141_lmg";
			break;
			case 3:
			fModel = "mp_body_forest_tf141_smg";
			break;
			case 4:
			fModel = "mp_body_forest_tf141_shotgun";
			break;
		}
		break;
		case "mp_trailerpark":
		switch(randomInt(13))
		{
			case 0:
			fModel = "mp_body_us_army_lmg";
			break;
			case 1:
			fModel = "mp_body_us_army_lmg_b";
			break;
			case 2:
			fModel = "mp_body_us_army_lmg_c";
			break;
			case 3:
			fModel = "mp_body_us_army_assault_a";
			break;
			case 4:
			fModel = "mp_body_us_army_assault_b";
			break;
			case 5:
			fModel = "mp_body_us_army_assault_c";
			break;
			case 6:
			fModel = "mp_body_us_army_shotgun";
			break;
			case 7:
			fModel = "mp_body_us_army_shotgun_b";
			break;
			case 8:
			fModel = "mp_body_us_army_shotgun_c";
			break;
			case 9:
			fModel = "mp_body_us_army_smg";
			break;
			case 10:
			fModel = "mp_body_us_army_smg_b";
			break;
			case 11:
			fModel = "mp_body_us_army_smg_c";
			break;
		}
		break;
		case "mp_compact":
		switch(randomInt(5))
		{
			case 0:
			fModel = "mp_body_tf141_assault_a";
			break;
			case 1:
			fModel = "mp_body_tf141_assault_b";
			break;
			case 2:
			fModel = "mp_body_tf141_lmg";
			break;
			case 3:
			fModel = "mp_body_tf141_smg";
			break;
			case 4:
			fModel = "mp_body_tf141_shotgun";
			break;
		}
		break;
		case "mp_complex":
		switch(randomInt(13))
		{
			case 0:
			fModel = "mp_body_us_army_lmg";
			break;
			case 1:
			fModel = "mp_body_us_army_lmg_b";
			break;
			case 2:
			fModel = "mp_body_us_army_lmg_c";
			break;
			case 3:
			fModel = "mp_body_us_army_assault_a";
			break;
			case 4:
			fModel = "mp_body_us_army_assault_b";
			break;
			case 5:
			fModel = "mp_body_us_army_assault_c";
			break;
			case 6:
			fModel = "mp_body_us_army_shotgun";
			break;
			case 7:
			fModel = "mp_body_us_army_shotgun_b";
			break;
			case 8:
			fModel = "mp_body_us_army_shotgun_c";
			break;
			case 9:
			fModel = "mp_body_us_army_smg";
			break;
			case 10:
			fModel = "mp_body_us_army_smg_b";
			break;
			case 11:
			fModel = "mp_body_us_army_smg_c";
			break;
		}
		break;
		case "mp_strike":
		switch(randomInt(13))
		{
			case 0:
			fModel = "mp_body_us_army_lmg";
			break;
			case 1:
			fModel = "mp_body_us_army_lmg_b";
			break;
			case 2:
			fModel = "mp_body_us_army_lmg_c";
			break;
			case 3:
			fModel = "mp_body_us_army_assault_a";
			break;
			case 4:
			fModel = "mp_body_us_army_assault_b";
			break;
			case 5:
			fModel = "mp_body_us_army_assault_c";
			break;
			case 6:
			fModel = "mp_body_us_army_shotgun";
			break;
			case 7:
			fModel = "mp_body_us_army_shotgun_b";
			break;
			case 8:
			fModel = "mp_body_us_army_shotgun_c";
			break;
			case 9:
			fModel = "mp_body_us_army_smg";
			break;
			case 10:
			fModel = "mp_body_us_army_smg_b";
			break;
			case 11:
			fModel = "mp_body_us_army_smg_c";
			break;
		}
		break;
		case "mp_abandon":
		switch(randomInt(13))
		{
			case 0:
			fModel = "mp_body_us_army_lmg";
			break;
			case 1:
			fModel = "mp_body_us_army_lmg_b";
			break;
			case 2:
			fModel = "mp_body_us_army_lmg_c";
			break;
			case 3:
			fModel = "mp_body_us_army_assault_a";
			break;
			case 4:
			fModel = "mp_body_us_army_assault_b";
			break;
			case 5:
			fModel = "mp_body_us_army_assault_c";
			break;
			case 6:
			fModel = "mp_body_us_army_shotgun";
			break;
			case 7:
			fModel = "mp_body_us_army_shotgun_b";
			break;
			case 8:
			fModel = "mp_body_us_army_shotgun_c";
			break;
			case 9:
			fModel = "mp_body_us_army_smg";
			break;
			case 10:
			fModel = "mp_body_us_army_smg_b";
			break;
			case 11:
			fModel = "mp_body_us_army_smg_c";
			break;
		}
		break;
		case "mp_vacant":
		switch(randomInt(13))
		{
			case 0:
			fModel = "mp_body_us_army_lmg";
			break;
			case 1:
			fModel = "mp_body_us_army_lmg_b";
			break;
			case 2:
			fModel = "mp_body_us_army_lmg_c";
			break;
			case 3:
			fModel = "mp_body_us_army_assault_a";
			break;
			case 4:
			fModel = "mp_body_us_army_assault_b";
			break;
			case 5:
			fModel = "mp_body_us_army_assault_c";
			break;
			case 6:
			fModel = "mp_body_us_army_shotgun";
			break;
			case 7:
			fModel = "mp_body_us_army_shotgun_b";
			break;
			case 8:
			fModel = "mp_body_us_army_shotgun_c";
			break;
			case 9:
			fModel = "mp_body_us_army_smg";
			break;
			case 10:
			fModel = "mp_body_us_army_smg_b";
			break;
			case 11:
			fModel = "mp_body_us_army_smg_c";
			break;
		}
		break;
		case "mp_storm":
		switch(randomInt(5))
		{
			case 0:
			fModel = "mp_body_desert_tf141_assault_a";
			break;
			case 1:
			fModel = "mp_body_desert_tf141_lmg";
			break;
			case 2:
			fModel = "mp_body_desert_tf141_smg";
			break;
			case 3:
			fModel = "mp_body_desert_tf141_shotgun";
			break;
			case 4:
			fModel = "mp_body_riot_tf141_desert";
			break;
		}
		break;
	}
	return fModel;
}

ai_GetHeadSpawnModel( )
{
	level endon("game_ended");
	rModel = "";
	switch( getDvar("mapname") )
	{
		case "mp_afghan": switch( randomInt(4) )
		{
			case 0: rModel = "head_tf141_desert_a";
			break;
			case 1: rModel = "head_tf141_desert_b";
			break;
			case 2: rModel = "head_tf141_desert_c";
			break;
			case 3: rModel = "head_tf141_desert_d";
			break;
		}
		break;
		case "mp_derail": switch( randomInt(4) )
		{
			case 0: rModel = "head_tf141_arctic_a";
			break;
			case 1: rModel = "head_tf141_arctic_b";
			break;
			case 2: rModel = "head_tf141_arctic_c";
			break;
			case 3: rModel = "head_tf141_arctic_d";
			break;
		}
		break;
		case "mp_estate": switch( randomInt(4) )
		{
			case 0: rModel = "head_tf141_forest_a";
			break;
			case 1: rModel = "head_tf141_forest_b";
			break;
			case 2: rModel = "head_tf141_forest_c";
			break;
			case 3: rModel = "head_tf141_forest_d";
			break;
		}
		break;
		case "mp_favela": switch( randomInt(4) )
		{
			case 0: rModel = "head_tf141_desert_a";
			break;
			case 1: rModel = "head_tf141_desert_b";
			break;
			case 2: rModel = "head_tf141_desert_c";
			break;
			case 3: rModel = "head_tf141_desert_d";
			break;
		}
		break;
		case "mp_highrise": switch( randomInt(4) )
		{
			case 0: rModel = "head_us_army_a";
			break;
			case 1: rModel = "head_us_army_b";
			break;
			case 2: rModel = "head_us_army_c";
			break;
			case 3: rModel = "head_us_army_d";
			break;
			case 4: rModel = "head_us_army_f";
			break;
		}
		break;
		case "mp_invasion": switch( randomInt(4) )
		{
			case 0: rModel = "head_us_army_a";
			break;
			case 1: rModel = "head_us_army_b";
			break;
			case 2: rModel = "head_us_army_c";
			break;
			case 3: rModel = "head_us_army_d";
			break;
			case 4: rModel = "head_us_army_f";
			break;
		}
		break;
		case "mp_checkpoint": switch( randomInt(4) )
		{
			case 0: rModel = "head_seal_udt_a";
			break;
			case 1: rModel = "head_seal_udt_c";
			break;
			case 2: rModel = "head_seal_udt_d";
			break;
			case 3: rModel = "head_seal_udt_e";
			break;
		}
		break;
		case "mp_quarry": switch( randomInt(4) )
		{
			case 0: rModel = "head_tf141_desert_a";
			break;
			case 1: rModel = "head_tf141_desert_b";
			break;
			case 2: rModel = "head_tf141_desert_c";
			break;
			case 3: rModel = "head_tf141_desert_d";
			break;
		}
		break;
		case "mp_rundown": switch( randomInt(4) )
		{
			case 0: rModel = "head_tf141_desert_a";
			break;
			case 1: rModel = "head_tf141_desert_b";
			break;
			case 2: rModel = "head_tf141_desert_c";
			break;
			case 3: rModel = "head_tf141_desert_d";
			break;
		}
		break;
		case "mp_rust": switch( randomInt(4) )
		{
			case 0: rModel = "head_tf141_desert_a";
			break;
			case 1: rModel = "head_tf141_desert_b";
			break;
			case 2: rModel = "head_tf141_desert_c";
			break;
			case 3: rModel = "head_tf141_desert_d";
			break;
		}
		break;
		case "mp_boneyard": switch( randomInt(4) )
		{
			case 0: rModel = "head_tf141_desert_a";
			break;
			case 1: rModel = "head_tf141_desert_b";
			break;
			case 2: rModel = "head_tf141_desert_c";
			break;
			case 3: rModel = "head_tf141_desert_d";
			break;
		}
		break;
		case "mp_nightshift": switch( randomInt(4) )
		{
			case 0: rModel = "head_us_army_a";
			break;
			case 1: rModel = "head_us_army_b";
			break;
			case 2: rModel = "head_us_army_c";
			break;
			case 3: rModel = "head_us_army_d";
			break;
			case 4: rModel = "head_us_army_f";
			break;
		}
		break;
		case "mp_subbase": switch( randomInt(4) )
		{
			case 0: rModel = "head_seal_udt_a";
			break;
			case 1: rModel = "head_seal_udt_c";
			break;
			case 2: rModel = "head_seal_udt_d";
			break;
			case 3: rModel = "head_seal_udt_e";
			break;
		}
		break;
		case "mp_terminal": switch( randomInt(4) )
		{
			case 0: rModel = "head_us_army_a";
			break;
			case 1: rModel = "head_us_army_b";
			break;
			case 2: rModel = "head_us_army_c";
			break;
			case 3: rModel = "head_us_army_d";
			break;
			case 4: rModel = "head_us_army_f";
			break;
		}
		break;
		case "mp_brecourt": switch( randomInt(4) )
		{
			case 0: rModel = "head_tf141_forest_a";
			break;
			case 1: rModel = "head_tf141_forest_b";
			break;
			case 2: rModel = "head_tf141_forest_c";
			break;
			case 3: rModel = "head_tf141_forest_d";
			break;
		}
		break;
		case "mp_trailerpark": switch( randomInt(4) )
		{
			case 0: rModel = "head_us_army_a";
			break;
			case 1: rModel = "head_us_army_b";
			break;
			case 2: rModel = "head_us_army_c";
			break;
			case 3: rModel = "head_us_army_d";
			break;
			case 4: rModel = "head_us_army_f";
			break;
		}
		break;
		case "mp_complex": switch( randomInt(5) )
		{
			case 0: rModel = "head_us_army_a";
			break;
			case 1: rModel = "head_us_army_b";
			break;
			case 2: rModel = "head_us_army_c";
			break;
			case 3: rModel = "head_us_army_d";
			break;
			case 4: rModel = "head_us_army_f";
			break;
		}
		break;
		case "mp_abandon": switch( randomInt(5) )
		{
			case 0: rModel = "head_us_army_a";
			break;
			case 1: rModel = "head_us_army_b";
			break;
			case 2: rModel = "head_us_army_c";
			break;
			case 3: rModel = "head_us_army_d";
			break;
			case 4: rModel = "head_us_army_f";
			break;
		}
		break;
		case "mp_vacant": switch( randomInt(5) )
		{
			case 0: rModel = "head_us_army_a";
			break;
			case 1: rModel = "head_us_army_b";
			break;
			case 2: rModel = "head_us_army_c";
			break;
			case 3: rModel = "head_us_army_d";
			break;
			case 4: rModel = "head_us_army_f";
			break;
		}
		break;
		case "mp_compact": switch( randomInt(4) )
		{
			case 0: rModel = "head_tf141_arctic_a";
			break;
			case 1: rModel = "head_tf141_arctic_b";
			break;
			case 2: rModel = "head_tf141_arctic_c";
			break;
			case 3: rModel = "head_tf141_arctic_d";
			break;
		}
		break;
		case "mp_storm": switch( randomInt(4) )
		{
			case 0: rModel = "head_tf141_desert_a";
			break;
			case 1: rModel = "head_tf141_desert_b";
			break;
			case 2: rModel = "head_tf141_desert_c";
			break;
			case 3: rModel = "head_tf141_desert_d";
			break;
		}
		break;
	}
	return rModel;
}

ai_SpawnWeapon(weapName, coords, angles)
{
	point = spawn("script_origin", coords);
	weap = ai_SpawnWeap(weapName, point.origin);
	if(isDefined(angles))
	{
		weap.angles = angles;
	}
	weap linkto( point );
	return point;
}

ai_SpawnWeap(weapName, coords)
{
	return spawn( "weapon_" + weapName, coords + (0,0,5) );
}

ai_IntermissionCountdown()
{
	level endon("disconnect");
	// Exactly IntermissionTimeStart seconds: shown from the first second, the
	// players move again at 0 (it used to wait 1 s more and show nothing first).
	for(count = level.IntermissionTimeStart;count > 0;count--)
	{
		level.IntermissionTime = count;
		wait 1;
	}
	level.IntermissionTime = 0;
	wait 5;
	level thread maps\mp\killstreaks\_uav::launchUAV();
	//TODO: add timer [Intermission Time]
	for(i=0;i < level.MaxWaves;i++)
	{
		level thread maps\mp\_modmenu_ai1::ai_BotMain();
		level waittill("round_ended");
		level.IntermissionTime = 20;
		wait 1;
		level.IntermissionTime = 19;
		wait 1;
		level.IntermissionTime = 18;
		wait 1;
		level.IntermissionTime = 17;
		wait 1;
		level.IntermissionTime = 16;
		wait 1;
		level.IntermissionTime = 15;
		wait 1;
		level.IntermissionTime = 14;
		wait 1;
		level.IntermissionTime = 13;
		wait 1;
		level.IntermissionTime = 12;
		wait 1;
		level.IntermissionTime = 11;
		wait 1;
		level.IntermissionTime = 10;
		wait 1;
		level.IntermissionTime = 9;
		wait 1;
		level.IntermissionTime = 8;
		wait 1;
		level.IntermissionTime = 7;
		wait 1;
		level.IntermissionTime = 6;
		wait 1;
		level.IntermissionTime = 5;
		wait 1;
		level.IntermissionTime = 4;
		wait 1;
		level.IntermissionTime = 3;
		wait 1;
		level.IntermissionTime = 2;
		wait 1;
		level.IntermissionTime = 1;
		wait 1;
		level.IntermissionTime = 0;
		wait 2;
	}
}

ai_HudMain()
{
	level endon("disconnect");
	numzomsx = 228;
	numzoms2x = 228;
	currentwavex = 426;
	currentwaveslashx = 228;
	level.numzombies = newhudelem();
	level.numzombies.alignX = "left";
	level.numzombies.alignY = "middle";
	level.numzombies.horzAlign = "fullscreen";
	level.numzombies.vertAlign = "fullscreen";
	level.numzombies.x = numzoms2x - 220;
	level.numzombies.y = 20;
	level.numzombies.alpha = 1;
	level.numzombies.sort = 2;
	level.numzombies.fontscale = 2.3;
	level.numzombies.color = (1,0,0);
	level.numzombies.HideWhenInMenu = true;
	level.numzombies.glowColor = (1,0,0);
	level.numzombies.glowAlpha = 1;
	oldwidth = 1;
	scaletime = 0.5;
	for(;;)
	{
		level.numzombies setValue(maps\mp\_modmenu_ai1::ai_ZombieCount());
		level.zombiesleft setValue(level.BotsForWave - level.RealSpawnedBots);
		totalhealth = 0;
		maxhealth = level.BotsForWave * level.ZombieHealth;
		for(i=0;i < level.BotsForWave;i++)
		{
			if(isDefined(level.bots[i])) totalhealth += level.bots[i].crate1.health;
		}
		width = int(totalhealth/maxhealth * (level.wave_barsize + 4));
		if(width <= 0)
		{
			width = 1;
		}
		if(width != oldwidth)
		{
			level.zombiewavelife scaleOverTime(scaletime,width,8);
		}
		oldwidth = width;
		wait 0.1;
	}
}

ai_HudMain2()
{
	level endon("disconnect");
	numzomsx = 228;
	numzoms2x = 228;
	currentwavex = 426;
	currentwaveslashx = 228;
	level.currentwavenum = newhudelem();
	level.currentwavenum.HideWhenInMenu = true;
	level.currentwavenum.alignX = "right";
	level.currentwavenum.alignY = "bottom";
	level.currentwavenum.horzAlign = "fullscreen";
	level.currentwavenum.vertAlign = "fullscreen";
	level.currentwavenum.x = currentwavex - 400;
	level.currentwavenum.y = 470;
	level.currentwavenum.alpha = 1;
	level.currentwavenum.sort = 2;
	level.currentwavenum.fontscale = 3.0;
	level.currentwavenum.color = (1,0,0);
	level.currentwavenum.glowColor = (1,0,0);
	level.currentwavenum.glowAlpha = 1;
	oldwidth = 1;
	scaletime = 0.5;
	for(;;)
	{
		if(level.zState != "intermission")
		{
			level.currentwavenum fadeOverTime( 2.00 );
			level.currentwavenum.alpha = 0;
			wait 2;
			level.currentwavenum.x = currentwavex - 400;
			level.currentwavenum.y = 470;
			level.currentwavenum setValue(level.Wave);
			level.currentwavenum.color = (1,0,0);
			level.currentwavenum.fontscale = 3.0;
			level.currentwavenum.glowColor = (1,0,0);
			level.currentwavenum.glowAlpha = 1;
			level.currentwavenum fadeOverTime( 2.00 );
			level.currentwavenum.alpha = 1;
			wait 1;
			level.currentwavenum ChangeFontScaleOverTime( 0.1 );
			level.currentwavenum.fontScale = 3.5;
			wait 0.1;
			level.currentwavenum ChangeFontScaleOverTime( 0.1 );
			level.currentwavenum.fontScale = 3.0;
		}
		else if(level.zState == "intermission")
		{
			level.currentwavenum fadeOverTime( 2.00 );
			level.currentwavenum.alpha = 0;
			wait 2;
			level.currentwavenum.x = currentwavex - 350;
			level.currentwavenum.y = 470;
			level.currentwavenum setText("Intermission");
			level.currentwavenum.fontscale = 2.0;
			level.currentwavenum.color = (0,1,0);
			level.currentwavenum.glowColor = (0,1,0);
			level.currentwavenum.glowAlpha = 1;
			level.currentwavenum fadeOverTime( 2.00 );
			level.currentwavenum.alpha = 1;
			wait 2;
			level.currentwavenum ChangeFontScaleOverTime( 0.1 );
			level.currentwavenum.fontScale = 2.2;
			wait 0.1;
			level.currentwavenum ChangeFontScaleOverTime( 0.1 );
			level.currentwavenum.fontScale = 2.0;
			level.currentwavenum fadeOverTime( 0.50 );
			level.currentwavenum.alpha = 0;
			wait 0.50;
			level.currentwavenum fadeOverTime( 0.50 );
			level.currentwavenum.alpha = 1;
			wait 0.50;
			level.currentwavenum fadeOverTime( 0.50 );
			level.currentwavenum.alpha = 0;
			wait 0.50;
			level.currentwavenum fadeOverTime( 0.50 );
			level.currentwavenum.alpha = 1;
		}
		level waittill("zombie_round_started_end");
	}
}

ai_Money()
{
	self endon("disconnect");
	self endon("death");
		self.moneyS2 destroy();
		self.moneyS2 = NewClientHudElem( self );
		self.moneyS2.alignX = "right";
		self.moneyS2.horzAlign = "right";
		self.moneyS2.vertAlign = "top";
		self.moneyS2.x = -20;
		self.moneyS2.y = -33;
		self.moneyS2.foreground = true;
		self.moneyS2.font = "hudbig";
		self.moneyS2.alpha = 1;
		self.moneyS2.fontscale = 0.75;
		self.moneyS2.HideWhenInMenu = true;
		self.moneyS2 setText(game["strings"]["MONEYTEXT"]);
	while(1)
	{
		self.moneyS destroy();
		self.moneyS = NewClientHudElem( self );
		self.moneyS.alignX = "right";
		self.moneyS.horzAlign = "right";
		self.moneyS.vertAlign = "top";
		self.moneyS.x = 30;
		self.moneyS.y = -33;
		self.moneyS.foreground = true;
		self.moneyS.font = "hudbig";
		self.moneyS.alpha = 1;
		self.moneyS.fontscale = 0.75;
		self.moneyS.HideWhenInMenu = true;
		if(self.money <= 500)
		{
			self.moneyS setValue(self.money);
			self.moneyS.color = (1,1,1);
			self.moneyS.glowColor = (0.9,0.3,0.3);
			self.moneyS.glowAlpha = 0.85;
			self.moneyS2.color = (1,1,1);
			self.moneyS2.glowColor = (0.9,0.3,0.3);
			self.moneyS2.glowAlpha = 0.85;
		}
		else if(self.money <= 1000)
		{
			self.moneyS setValue(self.money);
			self.moneyS.color = (1,1,1);
			self.moneyS.glowColor = (1,1,0.5);
			self.moneyS.glowAlpha = 0.85;
			self.moneyS2.color = (1,1,1);
			self.moneyS2.glowColor = (1,1,0.5);
			self.moneyS2.glowAlpha = 0.85;
		}
		else
		{
			self.moneyS setValue(self.money);
			self.moneyS.color = (1,1,1);
			self.moneyS.glowColor = (0.3,0.9,0.3);
			self.moneyS.glowAlpha = 0.85;
			self.moneyS2.color = (1,1,1);
			self.moneyS2.glowColor = (0.3,0.9,0.3);
			self.moneyS2.glowAlpha = 0.85;
		}
		self.moneyS ChangeFontScaleOverTime( 0.1 );
		self.moneyS.fontScale = 0.850;
		wait 0.1;
		self.moneyS ChangeFontScaleOverTime( 0.1 );
		self.moneyS.fontScale = 0.750;
		self waittill("MONEY");
	}
}

ai_IntermissionHud()
{
	self endon("disconnect");
	self.intermissionTimer = self createFontString( "objective", 1.3 );
	self.intermissionTimer setPoint( "TOP", "TOP", 0, 0 );
	self.intermissionTimer.color = (1, 0, 0);
	self.intermissionTimer.alpha = 1;
	self.intermissionTimer2 = self createFontString( "hudbig", 0.9 );
	self.intermissionTimer2 setPoint( "TOP", "TOP", 0, 15 );
	self.intermissionTimer2.color = (1, 1, 0);
	self.intermissionTimer2.alpha = 1;
	while(1)
	{
		if(level.IntermissionTime > 0)
		{
			self.intermissionTimer setText(game["strings"]["MP_HORDE_BEGINS_IN"]);
			self.intermissionTimer.alpha = 1;
			self.intermissionTimer2 setValue(level.IntermissionTime);
			self.intermissionTimer2.alpha = 1;
			self.intermissionTimer2 ChangeFontScaleOverTime( 0.1 );
			self.intermissionTimer2.fontScale = 1.2;
			wait 0.1;
			self.intermissionTimer2 ChangeFontScaleOverTime( 0.1 );
			self.intermissionTimer2.fontScale = 0.9;
		}
		else
		{
			self.intermissionTimer2 fadeOverTime( 1.00 );
			self.intermissionTimer2.alpha = 0;
			wait 1;
			self.intermissionTimer fadeOverTime( 1.00 );
			self.intermissionTimer.alpha = 0;
			wait 1;
			self.intermissionTimer setText("");
			self.intermissionTimer2 setText("");
		}
		wait 0.9;
	}
}

ai_BonusPoints()
{
    self endon("disconnect");
	self endon("death");
	self.bonusS2 destroy();
		self.bonusS2 = NewClientHudElem( self );
		self.bonusS2.alignX = "right";
		self.bonusS2.horzAlign = "right";
		self.bonusS2.vertAlign = "top";
		self.bonusS2.x = -20;
		self.bonusS2.y = -17;
		self.bonusS2.foreground = true;
		self.bonusS2.font = "hudbig";
		self.bonusS2.alpha = 1;
		self.bonusS2.fontscale = 0.75;
		self.bonusS2.glowColor = (0.3,1,1);
		self.bonusS2.glowAlpha = 0.85;
		self.bonusS2.HideWhenInMenu = true;
		self.bonusS2 setText(game["strings"]["BONUSTEXT"]);
	while(1)
	{
	    self.bonusS destroy();
		self.bonusS = NewClientHudElem( self );
		self.bonusS.alignX = "right";
		self.bonusS.horzAlign = "right";
		self.bonusS.vertAlign = "top";
		self.bonusS.x = 30;
		self.bonusS.y = - 17;
		self.bonusS.foreground = true;
		self.bonusS.font = "hudbig";
		self.bonusS.alpha = 1;	
		self.bonusS.HideWhenInMenu = true;
		self.bonusS setValue(self.bonus);
		self.bonusS.color = (1,1,1);
		self.bonusS.glowColor = (0.3,1,1);
		self.bonusS.glowAlpha = 0.85;
		self.bonusS ChangeFontScaleOverTime( 0.1 );
	    self.bonusS.fontScale = 0.850;	
		wait 0.1;
	    self.bonusS ChangeFontScaleOverTime( 0.1 );
	    self.bonusS.fontScale = 0.750;
		self waittill("BONUS");
	}
}

ai_GrenadeHud()
{
	self endon("disconnect");
	self endon("death");
	self.GrenadeIcon = NewClientHudElem( self );
	self.GrenadeIcon.alignX = "RIGHT";
	self.GrenadeIcon.alignY = "TOP";
	self.GrenadeIcon.horzAlign = "RIGHT";
	self.GrenadeIcon.vertAlign = "TOP";
	self.GrenadeIcon.x = 60;
	self.GrenadeIcon.y = 365;
	self.GrenadeIcon.HideWhenInMenu = true;
	self.GrenadeIcon.foreground = true;
	self.GrenadeIcon setIconShader( "equipment_frag" );
	self.GrenadeIcon setIconSize( 40, 40 );
	self.GrenadeIcon.alpha = 1;
	while(1)
	{
		self.GrenadeClip = self getWeaponAmmoClip("frag_grenade_mp");
		if(self getWeaponAmmoClip("frag_grenade_mp") >= 1)
		{
			self.GrenadeIcon setIconShader("equipment_frag");
			self.GrenadeIcon setIconSize( 40, 40 );
			self.GrenadeIcon.alpha = 1;
			wait 1;
		}
		else
		{
			self.GrenadeIcon.alpha = 0;
			wait 0.001;
		}
		wait 0.1;
	}
}

ai_AkimboWeapons()
{
    self.akimbo = undefined;
	switch(self getCurrentWeapon())
	{
		case "beretta_akimbo_xmags_mp":
		self.akimbogun = "true";
		break;
		case "coltanaconda_akimbo_fmj_mp":
		self.akimbogun = "true";
		break;
		case "p90_akimbo_xmags_mp":
		self.akimbogun = "true";
		break;
		case "model1887_akimbo_fmj_mp":
		self.akimbogun = "true";
		break;
		case "deserteagle_akimbo_mp":
		self.akimbogun = "true";
		break;
		case "usp_akimbo_xmags_mp":
		self.akimbogun = "true";
		break;
		case "beretta393_akimbo_xmags_mp":
		self.akimbogun = "true";
		break;
		case "glock_akimbo_xmags_mp":
		self.akimbogun = "true";
		break;
		case "tmp_akimbo_xmags_mp":
		self.akimbogun = "true";
		break;
		case "ranger_akimbo_fmj_mp":
		self.akimbogun = "true";
		break;
		default:
		self.akimbogun = "false";
		break;
	}
}

ai_AmmoHud()
{
	self endon("disconnect");
	self endon("death");
	if(!isDefined(self.ammoBoard))
	{
		self.ammoBoard = self createFontString( "default", 2 );
		self.ammoBoard setPoint( "TOPRIGHT", "TOPRIGHT", -60, 450);
		self.ammoBoard.HideWhenInMenu = true;
	}
	if(!isDefined(self.stockBoard))
	{
		self.stockBoard = self createFontString( "default", 2 );
		self.stockBoard setPoint( "TOPRIGHT", "TOPRIGHT", -20, 450);
		self.stockBoard.HideWhenInMenu = true;
	}
	if(!isDefined(self.stockBoard2))
	{
		self.stockBoard2 = self createFontString( "default", 2 );
		self.stockBoard2 setPoint( "TOPRIGHT", "TOPRIGHT", -90, 450);
		self.stockBoard2.HideWhenInMenu = true;
	}
	if(!isDefined(self.slash))
	{
		self.slash = self createFontString( "default", 1.9 );
		self.slash setPoint( "TOPRIGHT", "TOPRIGHT", -84, 450);
		self.slash.HideWhenInMenu = true;
	}
	while(1)
	{
		self.Clip = self getWeaponAmmoClip(self getCurrentWeapon());
		self.Clip2 = self getWeaponAmmoClip(self getCurrentWeapon(), "left");
		self.Stock = self getWeaponAmmoStock(self getCurrentWeapon());
		self.ammoBoard setValue(self.Clip);
		self.stockBoard setValue(self.Stock);
		self thread ai_AkimboWeapons();
		if(self.akimbogun == "true")
		{
			self.slash setText("|");
		}
		else
		{
			self.slash setText("");
		}
		if(self getWeaponAmmoClip(self getCurrentWeapon()) <= 5)
		{
			self.ammoBoard.color = (1,0,0);
			self.ammoBoard.fontScale = 2.0;
			self.ammoBoard.glowColor = (0.9,0.3,0.3);
			self.ammoBoard.glowAlpha = 0.85;
		}
		else if(self getWeaponAmmoClip(self getCurrentWeapon()) <= 10)
		{
			self.ammoBoard.color = (1,1,0);
			self.ammoBoard.fontScale = 2.0;
			self.ammoBoard.glowColor = (0.9,0.9,0.3);
			self.ammoBoard.glowAlpha = 0.85;
		}
		else
		{
			self.ammoBoard.color = (0,1,0);
			self.ammoBoard.fontScale = 2.0;
			self.ammoBoard.glowColor = (0.3,0.9,0.3);
			self.ammoBoard.glowAlpha = 0.85;
		}
		if(self getCurrentWeapon() == "onemanarmy_mp")
		{
			self.ammoBoard setText("");
		}
		else if(self getCurrentWeapon() == "riotshield_mp")
		{
			self.ammoBoard setText("");
		}
		else if(self getCurrentWeapon() == "defaultweapon_mp")
		{
			self.ammoBoard setText("");
		}
		else if(self getCurrentWeapon() == "m240_xmags_mp")
		{
			self.ammoBoard setText("");
		}
		if(self getWeaponAmmoStock(self getCurrentWeapon()) <= 5)
		{
			self.stockBoard.color = (1,0,0);
			self.stockBoard.fontScale = 1.7;
			self.stockBoard.glowColor = (0.9,0.3,0.3);
			self.stockBoard.glowAlpha = 0.85;
		}
		else if(self getWeaponAmmoStock(self getCurrentWeapon()) <= 10)
		{
			self.stockBoard.color = (1,1,0);
			self.stockBoard.fontScale = 1.7;
			self.stockBoard.glowColor = (0.9,0.9,0.3);
			self.stockBoard.glowAlpha = 0.85;
		}
		else
		{
			self.stockBoard.color = (0,1,0);
			self.stockBoard.fontScale = 1.7;
			self.stockBoard.glowColor = (0.3,0.9,0.3);
			self.stockBoard.glowAlpha = 0.85;
		}
		if(self.akimbogun == "true" && self getWeaponAmmoClip(self getCurrentWeapon(), "left") <= 5)
		{
		    self.stockBoard2.color = (1,0,0);
			self.stockBoard2.fontScale = 2;
			self.stockBoard2.glowColor = (0.9,0.3,0.3);
			self.stockBoard2.glowAlpha = 0.85;
			self.stockBoard2 setValue(self.Clip2);
		}
		else if(self.akimbogun == "true" && self getWeaponAmmoClip(self getCurrentWeapon(), "left") <= 10)
		{
		    self.stockBoard2.color = (1,1,0);
			self.stockBoard2.fontScale = 2;
			self.stockBoard2.glowColor = (0.9,0.9,0.3);
			self.stockBoard2.glowAlpha = 0.85;
			self.stockBoard2 setValue(self.Clip2);
		}
		else if(self.akimbogun == "true" && self getWeaponAmmoClip(self getCurrentWeapon(), "left") >= 10)
		{
			self.stockBoard2.color = (0,1,0);
			self.stockBoard2.fontScale = 2;
			self.stockBoard2.glowColor = (0.3,0.9,0.3);
			self.stockBoard2.glowAlpha = 0.85;
			self.stockBoard2 setValue(self.Clip2);
		}
		else
		{
			self.stockBoard2 setText("");
		}
		if(self getCurrentWeapon() == "onemanarmy_mp")
		{
			self.stockBoard setText("");
		}
		if(self getCurrentWeapon() == "riotshield_mp")
		{
			self.stockBoard setText("");
		}
		if(self getCurrentWeapon() == "defaultweapon_mp")
		{
			self.stockBoard setText("");
		}
		if(self getCurrentWeapon() == "m240_xmags_mp")
		{
			self.stockBoard setText("");
		}
		wait 0.1;
	}
}

ai_WeaponIcon() //New version of showing weapon
{
	self endon("disconnect");
	self endon("death");
	
	self.weaponicon destroy();
	self.weaponicon = NewClientHudElem( self );
	self.weaponicon.alignX = "12";
	self.weaponicon.alignY = "76";
	self.weaponicon.horzAlign = "right";
	self.weaponicon.vertAlign = "top";
	self.weaponicon.x = -30;
	self.weaponicon.y = 363;
	self.weaponicon.HideWhenInMenu = true;
	self.weaponicon.foreground = true;
	self.weaponicon.alpha = 1;
	while(1)
	{
		self.weaponicon scaleOverTime( 0.05, 0.1, 0.1 );
		self.weaponicon.color = (1,1,1);
		wait 0.05;
		switch( self getCurrentWeapon() )
		{
			case "usp_mp":
			self.weaponicon setIconShader("hud_icon_usp_45");
			self.weaponicon scaleOverTime( 0.05, 40, 40 );
			break;
			case "beretta_mp":
			self.weaponicon setIconShader("hud_icon_m9beretta");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "coltanaconda_mp":
			self.weaponicon setIconShader("hud_icon_colt_anaconda");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "deserteagle_mp":
			self.weaponicon setIconShader("hud_icon_desert_eagle");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "glock_mp":
			self.weaponicon setIconShader("hud_icon_glock");
			self.weaponicon scaleOverTime( 0.05, 40, 40 );
			break;
			case "beretta393_mp":
			self.weaponicon setIconShader("hud_icon_beretta393");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "mp5k_mp":
			self.weaponicon setIconShader("hud_icon_mp5k");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "pp2000_mp":
			self.weaponicon setIconShader("hud_icon_pp2000");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "pp2000_eotech_mp":
			self.weaponicon.color = (0.3,0.9,0.3);
			self.weaponicon setIconShader("hud_icon_pp2000");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "uzi_mp":
			self.weaponicon setIconShader("hud_icon_mini_uzi");
			self.weaponicon scaleOverTime( 0.05, 40, 40 );
			break;
			case "p90_mp":
			self.weaponicon setIconShader("hud_icon_p90");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "kriss_mp":
			self.weaponicon setIconShader("hud_icon_kriss");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "ump45_mp":
			self.weaponicon setIconShader("hud_icon_ump45");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "tmp_mp":
			self.weaponicon setIconShader("hud_icon_mp9");
			self.weaponicon scaleOverTime( 0.05, 40, 40 );
			break;
			case "ak47_mp":
			self.weaponicon setIconShader("hud_icon_ak47");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m16_reflex_mp":
			self.weaponicon setIconShader("hud_icon_m16a4");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m4_reflex_mp":
			self.weaponicon setIconShader("hud_icon_m4carbine");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "fn2000_mp":
			self.weaponicon setIconShader("hud_icon_fn2000");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "masada_mp":
			self.weaponicon setIconShader("hud_icon_masada");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "famas_mp":
			self.weaponicon setIconShader("hud_icon_famas");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "fal_mp":
			self.weaponicon setIconShader("hud_icon_fnfal");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "scar_mp":
			self.weaponicon setIconShader("hud_icon_scar_h");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "tavor_mp":
			self.weaponicon setIconShader("hud_icon_tavor");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m79_mp":
			self.weaponicon setIconShader("hud_icon_m79");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "barrett_mp":
			self.weaponicon setIconShader("hud_icon_barrett50cal");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "rpg_mp":
			self.weaponicon setIconShader("hud_icon_rpg");
			self.weaponicon scaleOverTime( 0.05, 80, 40 );
			break;
			case "at4_mp":
			self.weaponicon setIconShader("hud_icon_at4");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "javelin_mp":
			self.weaponicon setIconShader("hud_icon_javelin");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "wa2000_acog_mp":
			self.weaponicon setIconShader("hud_icon_wa2000");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m21_acog_mp":
			self.weaponicon setIconShader("hud_icon_m14ebr");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "cheytac_mp":
			self.weaponicon setIconShader("hud_icon_cheytac");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "ranger_mp":
			self.weaponicon setIconShader("hud_icon_sawed_off");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "model1887_mp":
			self.weaponicon setIconShader("hud_icon_model1887");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "model1887_fmj_mp":
			self.weaponicon setIconShader("hud_icon_model1887");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "striker_mp":
			self.weaponicon setIconShader("hud_icon_striker");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "aa12_mp":
			self.weaponicon setIconShader("hud_icon_aa12");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m1014_mp":
			self.weaponicon setIconShader("hud_icon_benelli_m4");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "spas12_mp":
			self.weaponicon setIconShader("hud_icon_spas12");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "rpd_mp":
			self.weaponicon setIconShader("hud_icon_rpd");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "sa80_mp":
			self.weaponicon setIconShader("hud_icon_sa80");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "mg4_mp":
			self.weaponicon setIconShader("hud_icon_mg4");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m240_grip_mp":
			self.weaponicon setIconShader("hud_icon_m240");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m240_fmj_xmags_mp":
			self.weaponicon setIconShader("hud_icon_m240");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "aug_mp":
			self.weaponicon setIconShader("hud_icon_steyr");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "onemanarmy_mp":
			self.weaponicon setIconShader("hud_icon_m9beretta");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "defaultweapon_mp":
			self.weaponicon setIconShader("hud_icon_m240");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m4_silencer_mp":
			self.weaponicon setIconShader("hud_icon_m4carbine");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "deserteaglegold_mp":
			self.weaponicon.color = (1,1,0.5);
			self.weaponicon setIconShader("hud_icon_desert_eagle");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "tmp_silencer_mp":
			self.weaponicon.color = (1,1,0.5);
			self.weaponicon setIconShader("hud_icon_mp9");
			self.weaponicon scaleOverTime( 0.05, 40, 40 );
			break;
			case "usp_akimbo_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_usp_45");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "ump45_eotech_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_ump45");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "beretta_akimbo_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_m9beretta");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "wa2000_acog_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_wa2000");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m16_eotech_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_m16a4");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "famas_acog_fmj_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_famas");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "beretta393_akimbo_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_beretta393");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "ak47_fmj_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_ak47");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "aa12_grip_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_aa12");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "striker_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_striker");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "cheytac_fmj_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_cheytac");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "glock_akimbo_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_glock");
			self.weaponicon scaleOverTime( 0.05, 40, 40 );
			break;
			case "rpd_eotech_grip_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_rpd");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "ac130_25mm_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_m240");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "coltanaconda_akimbo_fmj_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_colt_anaconda");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m4_eotech_shotgun_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_m4carbine");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "mp5k_fmj_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_mp5k");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "ak47_gl_thermal_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_ak47");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "gl_ak47_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_40mm_grenade");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "barrett_acog_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_barrett50cal");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "sa80_grip_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_sa80");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m21_acog_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_m14ebr");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "spas12_grip_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_spas12");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "tmp_akimbo_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_mp9");
			self.weaponicon scaleOverTime( 0.05, 40, 40 );
			break;
			case "mg4_eotech_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_mg4");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "pp2000_fmj_reflex_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_pp2000");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "aug_eotech_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_steyr");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m240_eotech_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_m240");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m240_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_m240");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "tavor_fmj_reflex_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_tavor");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "kriss_reflex_rof_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_kriss");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "scar_eotech_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_scar_h");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "ranger_akimbo_fmj_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_sawed_off");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "p90_akimbo_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_p90");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "masada_reflex_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_masada");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "uzi_acog_silencer_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_mini_uzi");
			self.weaponicon scaleOverTime( 0.05, 40, 40 );
			break;
			case "model1887_akimbo_fmj_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_model1887");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "fn2000_reflex_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_fn2000");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "fal_reflex_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_fnfal");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m1014_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_benelli_m4");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "tmp_silencer_xmags_mp":
			self.weaponicon.color = (1,1,0.5);
			self.weaponicon setIconShader("hud_icon_mp9");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "pp2000_eotech_xmags_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_pp2000");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "m4_acog_silencer_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_m4carbine");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "ranger_fmj_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_sawed_off");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
			case "stinger_mp":
			self.weaponicon.color = (0.9,0.3,0.3);
			self.weaponicon setIconShader("hud_icon_stinger");
			self.weaponicon scaleOverTime( 0.05, 60, 40 );
			break;
		}
		self waittill( "weapon_change" );
	}
}

ai_WeaponText() //Old version of showing weapons
{
	self endon("disconnect");
	self endon("death");
	self.weapontext destroy();
	self.weapontext = self createFontString( "default", 2 );
	self.weapontext setPoint( "TOPRIGHT", "TOPRIGHT", -24, 430);
	self.weapontext.HideWhenInMenu = true;
	for(;;)
	{
		switch( self getCurrentWeapon() )
		{
			case "usp_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("USP.45");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "ump45_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("UMP-45");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "onemanarmy_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("OMA");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "beretta_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("M9");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "wa2000_acog_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("WA-2000 Acog Scope");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m16_reflex_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("M16A4 Red Dot Sight");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "famas_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Famas");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "beretta393_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("M93 Raffica");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "ak47_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("AK-47");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "aa12_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("AA-12");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "striker_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Striker");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "cheytac_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Intervention Explosive Bullets");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "glock_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Glock-18");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "rpd_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("RPD");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "coltanaconda_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText(".44 Magnum");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m4_reflex_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("M4A1 Red Dot Sight");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "mp5k_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("MP5K");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "at4_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("AT4-HS");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "barrett_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Barrett M82");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "sa80_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("L86");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m21_acog_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("M14 EBR Acog Scope");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "spas12_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Spas-12");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "tmp_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("TMP");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "mg4_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("MG-4");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "pp2000_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("PP2000");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "aug_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("AUG LMG");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m240_grip_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("M240 Grip");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m240_fmj_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("M240 Grip+FMJ+Damage");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 0.9, 0.3,0.3 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "tavor_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("TAR-21");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "kriss_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Vector");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "scar_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("SCAR-L");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "ranger_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Double Barrel Shotgun");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "p90_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("P-90");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "masada_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Assault Combat Rifle");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "uzi_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Uzi");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "model1887_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Model 1887");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "fn2000_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("F2000");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "fal_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("FN-FAL");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m1014_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("M1014");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "tmp_silencer_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^3M2A1-7 Flamethrower");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (2,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "pp2000_eotech_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Raygun");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "deserteagle_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Desert Eagle");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m4_silencer_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("M4A1 Silencer");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "ump45_eotech_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2UMPE-100 Holographic Sight");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "usp_akimbo_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2USP.50 Akimbo");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "deserteagle_akimbo_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Mustang & Sally");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "wa2000_acog_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2WAZOO 65");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m16_eotech_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2M16A10 Fully Auto Holo Sight");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "famas_acog_fmj_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Famas Fully Auto Acog Sight");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "beretta393_akimbo_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2FM93 Super Raffica Akimbo");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "ak47_fmj_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2AK-47 Extended Mags+FMJ");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "aa12_grip_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2AAA121 Grip Xmags");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "striker_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Killer Extended Mags");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "cheytac_fmj_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Intervention Super Bullets");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "glock_akimbo_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Noob 18 Akimbo");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "rpd_eotech_grip_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2RPDK Holographic Sight");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "coltanaconda_akimbo_fmj_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Python Akimbo");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m4_eotech_shotgun_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2M4A4 Holographic With Shotgun");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "mp5k_fmj_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2MP5 Extreme Bullets");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "gl_ak47_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Grenade Launcher AK-84");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "barrett_acog_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Barrett M92 Extreme");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "sa80_grip_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2The Grappler");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m21_acog_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2M14 Jakmle");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "spas12_grip_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Titanic Shotgun");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "tmp_akimbo_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2KMP Akimbo Extended Mags");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "mg4_eotech_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2MG-8 Holographic Sight");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "pp2000_fmj_reflex_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2PP4000");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "aug_eotech_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2ASG LMG Holographic Sight");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m240_eotech_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Makarov");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "tavor_fmj_reflex_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2TAR-21 Mars Sight");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "kriss_reflex_rof_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Hector");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "scar_eotech_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2SCAR-BBQ Hologrpahic Sight");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "ranger_akimbo_fmj_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^1Double Barrel Shotgun Akimbo");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (1,0,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "p90_akimbo_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Akimbo Madness");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "masada_reflex_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2GaYCR");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "uzi_acog_silencer_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Super UZI ACOG");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "model1887_akimbo_fmj_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Arnold PW?NS");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "fn2000_reflex_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2F4000");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "fal_reflex_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Ep!c Win");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m1014_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2M2028");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "tmp_silencer_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^3Flamethrower");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "pp2000_eotech_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^1Porters X2 Raygun");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (1,0,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "deserteaglegold_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^3Golden Ownage");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (1,2,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m4_acog_silencer_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2M4A6 ACOG Silencer");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (1,2,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "ac130_105mm_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^1AC-130 105MM");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (1,0,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "rpg_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("RPG-7");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m79_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Thumper");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "ranger_fmj_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Spaz+^1Model+^3Ranger");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = ( 25.5, 25.5, 3.6 );
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "ak47_gl_thermal_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2AK-47 Thermal No Recoil");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "riotshield_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2RiotShield");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "defaultweapon_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Hand Gun");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (1,1,1);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "m240_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^0Death Machine");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,0,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "ac130_25mm_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^1Machine Gun");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (1,0,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "wa2000_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2WA2000 Acog");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "airdrop_marker_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Airdrop Marker");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "airdrop_mega_marker_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Large Airdrop Marker");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "model1887_fmj_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Model 1887 FMJ");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "beretta_akimbo_xmags_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^1Mustang&Sally");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "killstreak_uav_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Morter Team");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "killstreak_ac130_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2AC-130");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "killstreak_predator_missile_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Predator Missile");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "killstreak_nuke_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Tactical Nuke");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "killstreak_counter_uav_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2Morter Team");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "killstreak_emp_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^2EMP");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (0,1,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "javelin_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("Javelin");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (1,1,1);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
			case "stinger_mp": self.weapontext.alpha = 1.0;
			self.weapontext setText("^1Javlin Pro");
			self.weapontext.fontScale = 1.650;
			self.weapontext.glowColor = (1,0,0);
			self.weapontext.glowAlpha = 1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.900;
			wait 0.1;
			self.weapontext ChangeFontScaleOverTime( 0.1 );
			self.weapontext.fontScale = 1.650;
			self.weapontext fadeOverTime( 3.00 );
			self.weapontext.alpha = 0;
			break;
		}
		self waittill( "weapon_change" );
	}
}

ai_TextMap( intensity, color, glow, glowintensity, text )
{
	self endon( "disconnect" );
	wait ( 0.05 );
	self.textmap destroy();
	self notify( "textmaps" );
	self endon( "textmaps" );
	self.textmap = newClientHudElem( self );
	self.textmap.horzAlign = "center";
	self.textmap.vertAlign = "middle";
	self.textmap.alignX = "center";
	self.textmap.alignY = "middle";
	self.textmap.x = 0;
	self.textmap.y = -700;
	self.textmap.font = "hudbig";
	self.textmap.fontscale = 2;
	self.textmap.color = color;
	self.textmap setText(text);
	self.textmap.alpha = intensity;
	self.textmap.glowColor = glow;
	self.textmap.glowAlpha = glowintensity;
	self.textmap moveOverTime( 0.50 );
	self.textmap.x = 0;
	self.textmap.y = 0;
	wait 3;
	self.textmap moveOverTime( 0.50 );
	self.textmap.x = -700;
	self.textmap.y = 0;
	wait 0.60;
	self.textmap destroy();
}

ai_TextMap2( text, intensity, color, glow, glowintensity )
{
	self endon( "disconnect" );
	wait ( 0.05 );
	self.textmap2 destroy();
	self notify( "textmaps2" );
	self endon( "textmaps2" );
	self.textmap2 = newClientHudElem( self );
	self.textmap2.horzAlign = "center";
	self.textmap2.vertAlign = "middle";
	self.textmap2.alignX = "center";
	self.textmap2.alignY = "middle";
	self.textmap2.x = 0;
	self.textmap2.y = 770;
	self.textmap2.font = "hudbig";
	self.textmap2.fontscale = 2;
	self.textmap2.color = color;
	self.textmap2 setText(text);
	self.textmap2.alpha = intensity;
	self.textmap2.glowColor = glow;
	self.textmap2.glowAlpha = glowintensity;
	self.textmap2 moveOverTime( 0.50 );
	self.textmap2.x = 0;
	self.textmap2.y = 70;
	wait 0.50;
	self playLocalSound("mp_last_stand");
	wait 3;
	self.textmap2 moveOverTime( 0.50 );
	self.textmap2.x = 700;
	self.textmap2.y = 70;
	wait 0.60;
	self.textmap2 destroy();
}

ai_IntroText( text )
{
	self endon( "disconnect" );
	wait ( 0.05 );
	self.IntroText destroy();
	self notify( "IntroText" );
	self endon( "IntroText" );
	self.IntroText = newClientHudElem( self );
	self.IntroText.horzAlign = "center";
	self.IntroText.vertAlign = "middle";
	self.IntroText.alignX = "center";
	self.IntroText.alignY = "middle";
	self.IntroText.x = 600;
	self.IntroText.y = -200;
	self.IntroText.font = "objective";
	self.IntroText.fontscale = 3;
	self.IntroText.glowColor = (0, 0, 1);
	self.IntroText setText(text);
	self.IntroText.alpha = 1;
	self.IntroText.glowAlpha = 1;
	self.IntroText moveOverTime( 0.50 );
	self.IntroText.x = 0;
	self.IntroText.y = -200;
	wait 0.5;
	self.IntroText moveOverTime( 3 );
	self.IntroText.x = -200;
	self.IntroText.y = -200;
	wait 3;
	self.IntroText moveOverTime( 0.50 );
	self.IntroText.x = -600;
	self.IntroText.y = -200;
	wait 0.60;
	self.IntroText destroy();
}

ai_IntroText2( text )
{
	self endon( "disconnect" );
	wait ( 0.05 );
	self.IntroText2 destroy();
	self notify( "IntroText2" );
	self endon( "IntroText2" );
	self.IntroText2 = newClientHudElem( self );
	self.IntroText2.horzAlign = "center";
	self.IntroText2.vertAlign = "middle";
	self.IntroText2.alignX = "center";
	self.IntroText2.alignY = "middle";
	self.IntroText2.x = 600;
	self.IntroText2.y = -160;
	self.IntroText2.font = "objective";
	self.IntroText2.fontscale = 3;
	self.IntroText2.glowColor = (0, 0, 1);
	self.IntroText2 setText(text);
	self.IntroText2.alpha = 1;
	self.IntroText2.glowAlpha = 1;
	self.IntroText2 moveOverTime( 0.50 );
	self.IntroText2.x = 100;
	self.IntroText2.y = -160;
	wait 0.5;
	self.IntroText2 moveOverTime( 3 );
	self.IntroText2.x = -100;
	self.IntroText2.y = -160;
	self playLocalSound("mp_last_stand");
	wait 3;
	self.IntroText2 moveOverTime( 0.50 );
	self.IntroText2.x = -600;
	self.IntroText2.y = -160;
	wait 0.60;
	self.IntroText2 destroy();
}

ai_IntroText3( text )
{
	self endon( "disconnect" );
	wait ( 0.05 );
	self.IntroText3 destroy();
	self notify( "IntroText3" );
	self endon( "IntroText3" );
	self.IntroText3 = newClientHudElem( self );
	self.IntroText3.horzAlign = "center";
	self.IntroText3.vertAlign = "middle";
	self.IntroText3.alignX = "center";
	self.IntroText3.alignY = "middle";
	self.IntroText3.x = 600;
	self.IntroText3.y = -120;
	self.IntroText3.font = "objective";
	self.IntroText3.fontscale = 3;
	self.IntroText3.glowColor = (0, 0, 1);
	self.IntroText3 setText(text);
	self.IntroText3.alpha = 1;
	self.IntroText3.glowAlpha = 1;
	self.IntroText3 moveOverTime( 0.50 );
	self.IntroText3.x = 200;
	self.IntroText3.y = -120;
	wait 0.5;
	self.IntroText3 moveOverTime( 3 );
	self.IntroText3.x = 0;
	self.IntroText3.y = -120;
	wait 3;
	self.IntroText3 moveOverTime( 0.50 );
	self.IntroText3.x = -700;
	self.IntroText3.y = -120;
	wait 0.60;
	self.IntroText3 destroy();
}

ai_IntroAfghan()
{
	if(getdvar("mapname") == "mp_afghan")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Desert Bunker", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroFavela()
{
	if(getdvar("mapname") == "mp_favela")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Rundown Town", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroEstate()
{
	if(getdvar("mapname") == "mp_estate")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme v1.8" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Falls of Fortune", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroSubBase()
{
	if(getdvar("mapname") == "mp_subbase")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "HELL!!!", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroScrapyard()
{
	if(getdvar("mapname") == "mp_boneyard")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme v1.8" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Aircraft Graveyard", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroSkidrow()
{
	if(getdvar("mapname") == "mp_nightshift" && level.edit == 0)
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme v1.8" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "SunRise Apartments", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
	else if(getdvar("mapname") == "mp_nightshift" && level.edit == 1)
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme v1.8" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Doomed Canal", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
	else if(getdvar("mapname") == "mp_nightshift" && level.edit == 2)
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme v1.8" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "River Rumble", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroUnderpass()
{
	if(getdvar("mapname") == "mp_underpass")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme v1.8" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Dead Red", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroTrailerpark()
{
	if(getdvar("mapname") == "mp_trailerpark")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme v1.8" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Old West", 1, (2,1,0), (2,1,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroQuarry()
{
	if(getdvar("mapname") == "mp_quarry")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme v1.8" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Dark Construction", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroRust()
{
	if(getdvar("mapname") == "mp_rust" && level.edit == 0)
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme v1.8" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "River Rapid", 1, (0,2,1), (0,2,1), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
	if(getdvar("mapname") == "mp_rust" && level.edit == 1)
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme v1.8" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "River Pad", 1, (0,2,1), (0,2,1), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroSalvage()
{
	if(getdvar("mapname") == "mp_compact")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Snowy Death", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroKarachi()
{
	if(getdvar("mapname") == "mp_checkpoint")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Surrounded", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroStrike()
{
	if(getdvar("mapname") == "mp_strike")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Ally", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroDerail()
{
	if(getdvar("mapname") == "mp_derail")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Pine Creek", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroTerminal()
{
	if(getdvar("mapname") == "mp_terminal")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Aircrafts Lair", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroBailout()
{
	if(getdvar("mapname") == "mp_complex")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "The Complex", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroWasteland()
{
	if(getdvar("mapname") == "mp_brecourt")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Wasteland", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_IntroRundown()
{
	if(getdvar("mapname") == "mp_rundown")
	{
	wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "The Holdout", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
    }
}

ai_IntroCarnival()
{
	if(getdvar("mapname") == "mp_abandon")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Parking Lot", 1, (1,1,1), (0.3,0.9,0.9), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
    }
}

ai_IntroVacant()
{
	if(getdvar("mapname") == "mp_vacant")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (1,1,0.2), (1,1,0.2), 0.75, "Map" );
		self thread ai_TextMap2( "Evening Side", 1, (1,1,0.2), (1,1,0.2), 0.75 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
    }
}

ai_IntroStorm()
{
	if(getdvar("mapname") == "mp_storm")
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (1,0,0), (1,0,0), 0.75, "Map" );
		self thread ai_TextMap2( "Rainy Gourge", 1, (0,1,1), (0,1,1), 0.75 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
    }
}

ai_IntroHighrise()
{
	if(getdvar("mapname") == "mp_highrise" && level.edit == 0)
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "Infestation", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
	else if(getdvar("mapname") == "mp_highrise" && level.edit == 1)
	{
		wait 5;
		self thread ai_IntroText( "Welcome" );
		self thread ai_IntroText2( self.name );
		wait 4;
		self thread ai_IntroText( "AI Zombies" );
		self thread ai_IntroText2( "Extreme" );
		wait 4;
		self thread ai_TextMap( 1, (2,1,0), (1,0,0), 0.50, "Map" );
		self thread ai_TextMap2( "The Infestation", 1, (1,0,0), (1,0,0), 0.50 );
		wait 4;
		self thread ai_IntroText( "Made by [115]Death" );
		self thread ai_IntroText2( "Ported by @UrBaZz & @ZERTY for PS4 Version" );
		self thread ai_IntroText3( "Enjoy The Game!" );
	}
}

ai_ModLoad()
{
/* Mapedit Don't Touch This Shit */
level thread maps\mp\_modmenu_ai3::ai_mapedit_init();

/* Global Vars */
//Bots --------------------
level.MaxWaves = 30;//can change
level.BotsForIcons = 10;//can change
level.SpawnedBots = 0;
level.RealSpawnedBots = 0;
level.BotsForWave = 0;
level.day = 0;
level.nuked = 0;
//Waves -------------------
level.Wave = 0;
//Game State --------------
level.zState = "intermission";
//Timers ------
level.IntermissionTimeStart = 10;//can change (seconds frozen before the start)
level.IntermissionTime = 0;
level.timeplayedminutes = 0;
level.timeplayed = 0;
//Brightness --------------
level.brightness = -0.07;
//Main Dvars -------------------
setDvar( "g_speed", 190 );
setDvar( "g_hardcore", 1 );
setDvar( "scr_diehard", 1 );
setDvar( "ui_netGametypeName", "^1Zombies" );
setDvar( "scr_war_timelimit", 0 );
setDvar( "g_ScoresColor_Allies", "0 1 0 0" );
setDvar( "g_TeamColor_Allies", "0 1 0 0" );
/* Connection Dvars */	
if(getDvar("z_dedicated") == "")
	setDvar( "z_dedicated", 0 ); //If Dedicated Server or Not 0 = Not Server 1 = Server
/* ZombieMod Dvars */
if(getDvar("z_money") == "")
	setDvar( "z_money", 690 ); //Start Money
if(getDvar("z_endgame") == "")
	setDvar( "z_endgame", 1 );
if(getDvar("z_find") == "") //If the zombies can find the player
	setDvar( "z_find", 1 );
/* Killstreak Dvars */
if(getDvar("z_airstrike") == "")
	setDvar( "z_airstrike", 125 );
if(getDvar("z_25") == "")
	setDvar( "z_25", 25 );
if(getDvar("z_predator_missile") == "")
	setDvar( "z_predator_missile", 50 );
if(getDvar("z_random_1") == "")
	setDvar( "z_random_1", 75 );
if(getDvar("z_sentry") == "")
	setDvar( "z_sentry", 100 );
if(getDvar("z_random_4") == "")
	setDvar( "z_random_4", 150 );
if(getDvar("z_sub") == "")
	setDvar( "z_sub", 175 );
if(getDvar("z_lmg") == "")
	setDvar( "z_lmg", 300 );
if(getDvar("z_overwatch") == "")
	setDvar( "z_overwatch", 400 );
if(getDvar("z_super") == "")
	setDvar( "z_super", 275 );
if(getDvar("z_vision") == "")
	setDvar( "z_vision", 250 );
if(getDvar("z_nuke") == "")
	setDvar( "z_nuke", 650 );
/* Init */
level thread ai_EndMatch();
level maps\mp\_modmenu_ai3::ai_FuncsMain();
level maps\mp\_modmenu_ai3::ai_precacheItems();
level thread ai_IntermissionCountdown();
level thread maps\mp\_modmenu_ai1::ai__bot_Init();
level thread ai_Shaders();
level thread maps\mp\_modmenu_ai3::ai_UpdateTimePlayed();
level thread maps\mp\_modmenu_ai3::ai_InitCountableWeapons();
/* Special Guns Load */
level thread maps\mp\_modmenu_ai3::ai__raygun_Init();
level thread maps\mp\_modmenu_ai3::ai__flamethrower_Init();
level thread maps\mp\_modmenu_ai3::ai__upgradedraygun_Init();
level thread maps\mp\_modmenu_ai3::ai__upgradedflamethrower_Init();
level thread maps\mp\_modmenu_ai3::ai__upgradededexplosiveintervention_Init();
level thread maps\mp\_modmenu_ai3::ai__explosiveintervention_Init();
/* Tweakable */
level.ZombieHealth = 90;//can change
level.destructibleSpawnedEntsLimit += 300;

/* Spawn Anti-Glitch spots */
[[level.SpawnTrigger]] ((1284, 2600, 167), (942, 2604, 51), 50, 100, "mp_terminal");
[[level.SpawnTrigger]] ((1803, 2502, 140), (1790, 2643, 51), 50, 100, "mp_terminal");

/* Hud */
level thread ai_HudMain();
level thread ai_HudMain2();

/* Player Connect */
level thread maps\mp\_modmenu_ai3::ai_onPlayerConnect();

/* Player Pain Vision */
level thread maps\mp\_modmenu_ai3::ai_SetVisionPain();

/* EndGame Text */
level.zombieDeath[0] = "Humans Defeated The Zombies!";
level.zombieDeath[1] = "Humans Survived!";
level.zombieDeath[2] = "Good Job Humans!";
level.zombieDeath[3] = "Humans Are All Alive!";
level.zombieDeath[4] = "My Face For Humans :D!";
level.zombieDeath[5] = "Mother Fucker You Survived Humans!";
level.zombieDeath[6] = "Great Job Humans!";
level.zombieDeath[7] = "Good Jon Get Ready For the Next Map!";
level.zombieDeath[8] = "Zombies are so perverts Humans FTW!";
level.zombieDeath[9] = "Humans 1 Zombies 0";
level.zombieDeath[10] = "Humans Win Bitches!";
level.zombieDeath[11] = "Victory!!!";
level.zombieDeath[12] = "Enemy Down!!!";
}

ai_Shaders()
{
    //Icons//
	precacheShader("hudicon_neutral");
	precacheShader("cardicon_fmj");
	precacheShader("cardicon_ghillie");
	precacheShader("cardicon_juggernaut_2");
	precacheShader("cardicon_bulb");
	precacheShader("cardicon_doubletap");
	precacheShader("cardicon_harrier");
	precacheShader("cardicon_burgertown");
	precacheShader("cardicon_8ball");
	precacheShader("cardicon_bullets_50cal");
	precacheShader("cardicon_gold");
	precacheShader("cardicon_skull");
	precacheShader("cardicon_tsunami");
	precacheShader("cardicon_binoculars_1");
	//Perk Icons//
	precacheShader("specialty_fastreload_upgrade");
	precacheShader("specialty_bulletdamage_upgrade");
	precacheShader("specialty_lightweight_upgrade");
	precacheShader("specialty_hardline_upgrade");
	precacheShader("specialty_steadyaim_upgrade");
	precacheShader("specialty_pistoldeath");
	precacheShader("specialty_pistoldeath_upgrade");
	//Equipment Icons//
	precacheShader("equipment_frag");
	precacheShader("equipment_semtex");
	precacheShader("equipment_c4");
	//Killstreak Icons//
	precacheShader("dpad_killstreak_uav");
	precacheShader("dpad_killstreak_hellfire_missile");
	precacheShader("dpad_killstreak_sentry_gun");
	precacheShader("dpad_killstreak_emp");
	precacheShader("dpad_killstreak_nuke");
	//Models//
	precacheModel("projectile_cbu97_clusterbomb");
	precacheModel("vehicle_uav_static_mp");
	precacheModel("vehicle_ac130_low_mp");
	precacheItem("stinger_mp");
	precacheItem("javelin_mp");
	level.startNode = level.heli_start_nodes[randomInt(level.heli_start_nodes.size)];
	level.leaveNode = level.heli_leave_nodes[ randomInt( level.heli_leave_nodes.size ) ];
}

ai_DestoyHud()
{
	self endon("disconnect");
    {
		self.moneyS destroy();
		wait 0.00001;
		self.bonusS destroy();
		wait 0.00001;
		self.ammoBoard destroy();
		wait 0.00001;
		self.stockBoard destroy();
		wait 0.00001;
		self.moneytext destroy();
		wait 0.00001;
		self.bonustext destroy();
		wait 0.00001;
		self.weapontext destroy();
		wait 0.00001;
		self.powertext destroy();
		wait 0.00001;
		self.GrenadeIcon destroy();
	}
}

ai_DestoyPerkHud()
{
	self endon("disconnect");
    {
		self.perk1 destroy();
		wait 0.00001;
		self.perk2 destroy();
		wait 0.00001;
		self.perk3 destroy();
		wait 0.0001;
		self.perk4 destroy();
		wait 0.00001;
		self.perk5 destroy();
		wait 0.00001;
		self.perk6 destroy();
		wait 0.00001;
		self.perk7 destroy();
		wait 0.00001;
	}
}

ai_Death()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("death");
		self notify("menuresponse", game["menu_team"], "spectator");
		self thread maps\mp\gametypes\_playerlogic::respawn_asSpectator( self.origin + (0, 0, 60), self.angles );
		self thread ai_DestoyHud();
		self thread ai_DestoyPerkHud();
		self thread maps\mp\_modmenu_ai3::ai_TextPopup( "Death!" );
		self thread maps\mp\_modmenu_ai3::ai_SetVision();
		self allowSpectateTeam( "freelook", true );
		self iprintlnbold("^1Wait for the round to end");
	}
	wait 1;
}

ai_Live()
{
	self endon("disconnect");
	for(;;)
    {
        if(level.zState == "intermission" && self.pers["team"] == "spectator")
        {
		    self notify("menuresponse", game["menu_team"], "allies");
		    wait 0.01;
		    self notify("menuresponse", "changeclass", "class1");
        }
	    wait 1;
	}
}

ai_zombie_endGame( winningTeam, endReasonText )
{
    thread maps\mp\gametypes\_gamelogic::endGame( winningTeam, endReasonText );
}

ai_EndMatch()
{
	level endon("disconnect");
	self endon("endgame_played");
	level.EndText = "Zombies have eaten the Humans!";
	winner = "axis";
	wait 35;
	while( 1 )
	{
		players = maps\mp\gametypes\_teams::CountPlayers();
		if(players["allies"] <= 0)
		{
		    if(getdvar("z_endgame") == "1" && level.zState != "intermission")
			{
				foreach(player in level.players)
				{
				    player freezeControls(true);
				    player VisionSetNakedForPlayer( "blacktest", 7 );
					player thread ai_IntroText( "Humans Survived" );
					player thread ai_IntroText2( level.timeplayedminutes + " Minutes" );
					player thread ai_IntroText3( level.timeplayed + " Seconds" );
				}
				wait 7;
				level thread ai_zombie_endGame( winner, level.zombieDeath[randomInt(level.zombieDeath.size)] );
				level notify("endgame_played");
			}
		}
		wait 3;
	}
}

ai_ShowHost(player)
{
	self endon("disconnect");
	for(;;)
	{
		player waittill("showHost");
		hostname = player createFontString("objective", 1.2);
		hostname setPoint("TOPCENTER", "TOPCENTER", 0, 80);
		hostname setText( level.hostname );
		hostname.glowColor = (0.3, 0.6, 0.3);
		hostname.glowAlpha = 1;
		hostname.alpha = 1;
		player thread ai_HostnamePulse(hostname);
		player waittill("hideHost");
		player notify("score_hud_destroy");
		hostname destroy();
	}
}

ai_HostnamePulse(hostname)
{
	self endon("disconnect");
	self endon("score_hud_destroy");
	while(1)
	{
		hostname fadeOverTime( 1.00 );
		hostname.alpha = 0.50;
		hostname ChangeFontScaleOverTime( 1.00 );
		hostname.fontScale = 1.5;
		wait 1;
		hostname fadeOverTime( 1.00 );
		hostname.alpha = 1;
		hostname ChangeFontScaleOverTime( 1.00 );
		hostname.fontScale = 1.2;
		wait 1;
	}
}
