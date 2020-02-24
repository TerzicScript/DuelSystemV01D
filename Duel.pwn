/*
//------------------------------------------------------------------------------
Credits: V01D
Vreme izrade: 60 minuta sa testiranjem
Datum izrade: 23.02.2020
Zahvale: OverLord pomoc pri testiranju
Potrebni incovi: Navedeni dole
//------------------------------------------------------------------------------
*/
#include <easyDialog>
#include <YSI\y_va>
#include <YSI\y_timers>
#include <YSI\y_hooks>

new PozvanDuel[MAX_PLAYERS],
    PozvaoGa[MAX_PLAYERS],
    DuelCount[MAX_PLAYERS],
    DuelHP[MAX_PLAYERS],
    DuelArmor[MAX_PLAYERS],
    DuelOruzije[MAX_PLAYERS];

hook OnGameModeInit()
{
	CreateObject(2990, -1641.61975, -2702.80054, 51.42352,   0.00000, 0.00000, 43.58386);
	CreateObject(2990, -1634.40979, -2695.93994, 51.42350,   0.00000, 0.00000, 43.58390);
	CreateObject(2990, -1627.11365, -2689.01294, 51.42350,   0.00000, 0.00000, 43.58390);
	CreateObject(2990, -1619.35547, -2688.40771, 51.42350,   0.00000, 0.00000, 143.59869);
	CreateObject(2990, -1611.28149, -2694.34521, 51.42350,   0.00000, 0.00000, 143.59869);
	CreateObject(2990, -1603.17395, -2700.30420, 51.42350,   0.00000, 0.00000, 143.59869);
	CreateObject(2990, -1595.10486, -2706.24414, 51.42350,   0.00000, 0.00000, 143.59869);
	CreateObject(2990, -1587.03198, -2712.17944, 51.42350,   0.00000, 0.00000, 143.59869);
	CreateObject(2990, -1578.94043, -2718.13745, 51.42350,   0.00000, 0.00000, 143.59869);
	CreateObject(2990, -1577.63806, -2725.40918, 51.42350,   0.00000, 0.00000, 236.81732);
	CreateObject(2990, -1583.08435, -2733.76685, 51.42350,   0.00000, 0.00000, 236.81732);
	CreateObject(2990, -1588.53247, -2742.13623, 51.42350,   0.00000, 0.00000, 236.81732);
	CreateObject(2990, -1595.29895, -2743.33643, 51.42350,   0.00000, 0.00000, 143.59869);
	CreateObject(2990, -1603.31592, -2737.48999, 51.42350,   0.00000, 0.00000, 143.59869);
	CreateObject(2990, -1611.29016, -2731.56665, 51.42350,   0.00000, 0.00000, 143.59869);
	CreateObject(2990, -1619.29419, -2725.69385, 51.42350,   0.00000, 0.00000, 143.59869);
	CreateObject(2990, -1627.30908, -2719.81128, 51.42350,   0.00000, 0.00000, 143.59869);
	CreateObject(2990, -1635.32019, -2713.95654, 51.42350,   0.00000, 0.00000, 143.59869);
	CreateObject(2990, -1643.10107, -2707.89844, 51.42350,   0.00000, 0.00000, 140.25363);
    print("Duel System by V01D");
    return 1;
}

hook OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 18549, -1621.5547, -2692.0156, 47.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 18550, -1606.3828, -2713.8438, 50.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 1686, -1610.6172, -2721.0000, 47.9297, 0.25);
	RemoveBuildingForPlayer(playerid, 18283, -1621.5547, -2692.0156, 47.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 18284, -1606.3828, -2713.8438, 50.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 1686, -1607.3047, -2716.6016, 47.9297, 0.25);
	RemoveBuildingForPlayer(playerid, 1686, -1603.9922, -2712.2031, 47.9297, 0.25);
	RemoveBuildingForPlayer(playerid, 1686, -1600.6719, -2707.8047, 47.9297, 0.25);
	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(PozvanDuel[playerid] == 1)
	{
		va_SendClientMessage(playerid, 0xFFFFFFAA, "Ubijen si u duelu protiv %s", ImeIgraca(killerid));
		va_SendClientMessage(killerid, 0xFFFFFFAA, "Ubio si igraca %s u duelu", ImeIgraca(playerid));
		PozvanDuel[playerid] = 0;
		PozvanDuel[killerid] = 0;
		ResetPlayerWeapons(killerid);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerVirtualWorld(killerid, 0);
	}
	return 1;
}

Dialog:DIALOG_DUELINVITE(const playerid, response, listitem, inputtext[]) {
	if (!response) {
		new id = PozvaoGa[playerid];
		SendClientMessage(playerid, 0xFFFFFFAA, "Odbio si poziv za duel!");
		SendClientMessage(id, 0xFFFFFFAA, "Igrac je odbio poziv za duel");
		PozvanDuel[playerid] = 0;
		PozvaoGa[playerid] = 0;
		PozvanDuel[id] = 0;
		DuelOruzije[id] = 0;
		DuelHP[id] = 0;
		DuelArmor[id] = 0; 
	}

	if (response) {
		new id = PozvaoGa[playerid];
		if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "Igrac koji vas je pozvao je izasao sa servera");
		va_SendClientMessage(playerid, 0xFFFFFFAA, "Prihvatili ste poziv za duel sa %s!Uskoro ce poceti!", ImeIgraca(id));
		va_SendClientMessage(id, 0xFFFFFFAA, "Igrac %s je prihvatio duel!Uskoro ce poceti!", ImeIgraca(playerid));
	    TogglePlayerControllable(playerid, 0);
	    TogglePlayerControllable(id, 0);
	    SetPlayerPos(playerid, -1584.9420, -2731.6934, 48.5391);
	    SetPlayerPos(id, -1631.6122, -2696.2061, 48.5391);
	    defer DuelTimer(playerid, id);
	    DuelCount[playerid] = 10;
	    GameTextForPlayer(playerid, "DUEL POCINJE", 3000, 3);
	    GameTextForPlayer(id, "DUEL POCINJE", 3000, 3);
	    new oruzije = DuelOruzije[id];
	    new health = DuelHP[id];
	    new armor = DuelArmor[id];
	    GivePlayerWeapon(playerid, oruzije, 500);
	    GivePlayerWeapon(id, oruzije, 500);
	    SetPlayerHealth(playerid, health);
	    SetPlayerHealth(id, health);
	    SetPlayerArmour(id, armor);
	    SetPlayerArmour(playerid, armor);
	    SetPlayerVirtualWorld(playerid, id);
	    SetPlayerVirtualWorld(id, id);
	}
	return 1;
}

Dialog:DIALOG_ORUZIJE(const playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		DuelOruzije[playerid] = 0;
		DuelHP[playerid] = 0;
		DuelArmor[playerid] = 0;
		SendClientMessage(playerid, -1, "Odustao si od duela!");
		return 1;
	}
	if(response)
	{
		switch(listitem)
		{
			case 0: 
			{
				DuelOruzije[playerid] = 24;
				SendClientMessage(playerid, -1, "Oruzije za Duel: Deagle");
				Dialog_Show(playerid, "DIALOG_HP", DIALOG_STYLE_INPUT, "Odabir Helta", "Odaberi sa koliko helta zelis da pocnes duel(MAX 100 | MIN 1)", "Odaberi", "Nazad");
			}
			case 1:
			{
				DuelOruzije[playerid] = 30;
				SendClientMessage(playerid, -1, "Oruzije za Duel: AK-47");
				Dialog_Show(playerid, "DIALOG_HP", DIALOG_STYLE_INPUT, "Odabir Helta", "Odaberi sa koliko helta zelis da pocnes duel(MAX 100 | MIN 1)", "Odaberi", "Nazad");
			}
			case 2:
			{
				DuelOruzije[playerid] = 16;
				SendClientMessage(playerid, -1, "Oruzije za Duel: Bomba");
				Dialog_Show(playerid, "DIALOG_HP", DIALOG_STYLE_INPUT, "Odabir Helta", "Odaberi sa koliko helta zelis da pocnes duel(MAX 100 | MIN 1)", "Odaberi", "Nazad");
			}
			case 3:
			{
				DuelOruzije[playerid] = 18;
				SendClientMessage(playerid, -1, "Oruzije za Duel: Molotov");
				Dialog_Show(playerid, "DIALOG_HP", DIALOG_STYLE_INPUT, "Odabir Helta", "Odaberi sa koliko helta zelis da pocnes duel(MAX 100 | MIN 1)", "Odaberi", "Nazad");
			}
			case 4:
			{
				DuelOruzije[playerid] = 25;
				SendClientMessage(playerid, -1, "Oruzije za Duel: ShotGun");
				Dialog_Show(playerid, "DIALOG_HP", DIALOG_STYLE_INPUT, "Odabir Helta", "Odaberi sa koliko helta zelis da pocnes duel(MAX 100 | MIN 1)", "Odaberi", "Nazad");
			}
			case 5:
			{
				DuelOruzije[playerid] = 31;
				SendClientMessage(playerid, -1, "Oruzije za Duel: M4");
				Dialog_Show(playerid, "DIALOG_HP", DIALOG_STYLE_INPUT, "Odabir Helta", "Odaberi sa koliko helta zelis da pocnes duel(MAX 100 | MIN 1)", "Odaberi", "Nazad");
			}
			case 6:
			{
				DuelOruzije[playerid] = 26;
				SendClientMessage(playerid, -1, "Oruzije za Duel: SawnOff ShotGun");
				Dialog_Show(playerid, "DIALOG_HP", DIALOG_STYLE_INPUT, "Odabir Helta", "Odaberi sa koliko helta zelis da pocnes duel(MAX 100 | MIN 1)", "Odaberi", "Nazad");
			}
		}
	}
	return 1;
}


Dialog:DIALOG_HP(const playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, DIALOG_ORUZIJE, DIALOG_STYLE_LIST, "Odabir Oruzija", "Deagle\nAK-47\nBomba\nMolotov\nShotGun\nM4\nSawnOff ShotGun", "Odaberi", "Odustani");
	if(response)
	{
		new zivot = strval( inputtext );
		if(zivot > 100 || zivot < 1) return Dialog_Show(playerid, DIALOG_HP, DIALOG_STYLE_INPUT, "Odabir Helta", "Odaberi sa koliko helta zelis da pocnes duel(MAX 100 | MIN 1)", "Odaberi", "Nazad");
		DuelHP[playerid] = zivot;
		va_SendClientMessage(playerid, -1, "Odabrao si %d helta za duel!", DuelHP[playerid]);
		Dialog_Show(playerid, DIALOG_ARMOR, DIALOG_STYLE_INPUT, "Odabir Pancira", "Odaberi sa koliko pancira zelis da pocnes duel(MAX 100 | MIN 1)", "Odaberi", "Nazad");
	}
	return 1;
}

Dialog:DIALOG_ARMOR(const playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, DIALOG_HP, DIALOG_STYLE_INPUT, "Odabir Helta", "Odaberi sa koliko helta zelis da pocnes duel(MAX 100 | MIN 1)", "Odaberi", "Nazad");
	if(response) 
	{
		new pancir = strval( inputtext );
		if(pancir > 100 || pancir < 1) return Dialog_Show(playerid, DIALOG_ARMOR, DIALOG_STYLE_INPUT, "Odabir Pancira", "Odaberi sa koliko pancira zelis da pocnes duel(MAX 100 | MIN 1)", "Odaberi", "Nazad");
		DuelArmor[playerid] = pancir;
		va_SendClientMessage(playerid, -1, "Odabrao si %d armora za duel!", DuelArmor[playerid]);
		Dialog_Show(playerid, DIALOG_PROTIVNIK, DIALOG_STYLE_INPUT, "Odabir Protivnika", "Unesi ID protivnika", "Odaberi", "Nazad");
	}
    return 1;
} 
    
Dialog:DIALOG_PROTIVNIK(const playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, DIALOG_ARMOR, DIALOG_STYLE_INPUT, "Odabir Pancira", "Odaberi sa koliko pancira zelis da pocnes duel(MAX 100 | MIN 1)", "Odaberi", "Nazad");
	if(response)
	{
		new id = strval(inputtext);
		if(!IsPlayerConnected(id)) return Dialog_Show(playerid, DIALOG_PROTIVNIK, DIALOG_STYLE_INPUT, "Odabir Protivnika", "Protivnik nije online!Unesi ID protivnika", "Odaberi", "Nazad");
		if(PozvanDuel[id] == 1) return Dialog_Show(playerid, DIALOG_PROTIVNIK, DIALOG_STYLE_INPUT, "Odabir Protivnika", "Protivnik je vec pozvan od nekoga!Unesi ID protivnika", "Odaberi", "Nazad");
		new string[128];
		format(string, 128, "Igrac %s vas je pozvao na duel", ImeIgraca(playerid));
		Dialog_Show(id, DIALOG_DUELINVITE, DIALOG_STYLE_MSGBOX, "Duel Poziv", string, "Potvrdi", "Odustani");
		va_SendClientMessage(playerid, -1, "Pozvao si igraca %s na duel!", ImeIgraca(id));
		PozvanDuel[id] = 1;
		PozvanDuel[playerid] = 1;
		PozvaoGa[id] = playerid;
	}
	return 1;
}    
    
CMD:duel(playerid, params[])
{
	Dialog_Show(playerid, DIALOG_ORUZIJE, DIALOG_STYLE_LIST, "Odabir Oruzija", "Deagle\nAK-47\nBomba\nMolotov\nShotGun\nM4\nSawnOff ShotGun", "Odaberi", "Odustani");
	return 1;
}

timer DuelTimer[1000](playerid, id)
{
	if(DuelCount[playerid] != 0)
	{
		va_GameTextForPlayer(playerid, "%d", 1000, 3, DuelCount[playerid]);
		va_GameTextForPlayer(id, "%d", 1000, 3, DuelCount[playerid]);
		DuelCount[playerid]--;
		defer DuelTimer(playerid,id);
	}
	else
	{
		GameTextForPlayer(playerid, "KRENI", 1000, 3);
		GameTextForPlayer(id, "KRENI", 1000, 3);
		TogglePlayerControllable(playerid, 1);
		TogglePlayerControllable(id, 1);
	}
	return 1;
}

ImeIgraca(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}