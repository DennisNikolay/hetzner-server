#pragma semicolon 1

#include <sourcemod>
#include <sdktools>
#include <multicolors>
#include <geoip>

public Plugin:myinfo =
{
    name = "Random weapons",
    author = "boomix",
    description = "Every round different weapon for all players",
    version = "1.0",
    url = "http://boomix.tk"
}

//ALL WEAPONS IN GAME

#define MAX_WEAPONS     34
int LastWeaponNumber;

new const String:all_weapons[MAX_WEAPONS][] = {
    "weapon_m4a1", "weapon_m4a1_silencer", "weapon_ak47", "weapon_aug", "weapon_awp", "weapon_bizon", "weapon_deagle", "weapon_elite", "weapon_famas",
    "weapon_fiveseven", "weapon_G3SG1", "weapon_galilar", "weapon_glock", "weapon_hkp2000", "weapon_usp_silencer", "weapon_knife", "weapon_m249", "weapon_mac10",
    "weapon_mag7", "weapon_mp7", "weapon_mp9", "weapon_negev", "weapon_nova", "weapon_p90", "weapon_p250", "weapon_cz75a", "weapon_sawedoff", "weapon_scar20",
    "weapon_sg556", "weapon_ssg08", "weapon_taser", "weapon_tec9", "weapon_ump45", "weapon_xm1014"
};

//On plugin start

public OnPluginStart () {
    HookEvent("round_start", RoundStart); 
    RegAdminCmd("sm_forcechange", Command_forcechange, ADMFLAG_KICK, "[RW] Admin - don't like this weapon! :( ");
}


public OnMapStart() {
   ServerCommand("ammo_grenade_limit_total 2");
   ServerCommand("ammo_grenade_limit_flashbang 1");
   ServerCommand("mp_buytime 0");
   ServerCommand("mp_maxmoney 0");
   LastWeaponNumber = 0;
}


// ACTION ON COMMAND !FORCECHANGE

public Action:Command_forcechange(client, args) {

    RandomWeapons();

}


// RAUND START - do funciton RandomWeapons

public Action:RoundStart(Handle:event , const String: name[] , bool: dontBroadcast) {

    RandomWeapons();

}

//MAIN FUNCTION - GIVE RANDOM WEAPON

public RandomWeapons() {

    new Random;
    Random = GetRandomInt(0, 33);

    if (LastWeaponNumber != Random) {

    CPrintToChatAll("{green} This round we are playing with - %s", all_weapons[Random]);

    for (int i = 1; i < GetMaxClients(); ++i) {

        if (IsClientInGame(i) && IsPlayerAlive(i)) {
        
            new ent = GetPlayerWeaponSlot(i, 0);
            new ent1 = GetPlayerWeaponSlot(i, 1);
            new nadeslot = GetPlayerWeaponSlot(i, 3);


            if (ent > 0) {
                RemovePlayerItem(i, ent);
                RemoveEdict(ent);
            }

            if (ent1 > 0) {
                RemovePlayerItem(i, ent1);
                RemoveEdict(ent1);
            }

            if (nadeslot < 0) {
                GivePlayerItem(i, "weapon_hegrenade");
                GivePlayerItem(i, "weapon_flashbang");
            }

            if (Random == 15) {
                LastWeaponNumber = Random;
                return;
            }

            GivePlayerItem(i, all_weapons[Random]);

        }
    }

    LastWeaponNumber = Random;

    } else {
        CPrintToChatAll("Same weapons for two rounds, lets generate new one!");
        RandomWeapons();
    }

    return;

}
