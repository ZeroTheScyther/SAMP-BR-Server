#include <a_samp>
#include <sscanf2>
#include <YSI_Storage/y_ini>
#include <SIF>

//Login and register dialog defines
#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
#define DIALOG_SUCCESS_1 3
#define DIALOG_SUCCESS_2 4
#define DIALOG_SKINSELECT 5
#define PATH "/Users/%s.ini"

//Main Manu Text Draws
new PlayerText:GroupButton[MAX_PLAYERS];
new PlayerText:change_ped[MAX_PLAYERS];
new PlayerText:play_button[MAX_PLAYERS];
new PlayerText:cancel_button[MAX_PLAYERS];
new PlayerText:player_avatar[MAX_PLAYERS];
new PlayerText:friend_1[MAX_PLAYERS];
new PlayerText:friend_2[MAX_PLAYERS];
new PlayerText:friend_name_2[MAX_PLAYERS];
new PlayerText:friend_name_1[MAX_PLAYERS];
new PlayerText:playerName[MAX_PLAYERS];
new PlayerText:SelectMode[MAX_PLAYERS];
new PlayerText:SoloButton[MAX_PLAYERS];


//Gameplay Data
new savedPlayerName[MAX_PLAYER_NAME + 1];
new selectedPlaymode[MAX_PLAYERS] = true;
new playerTeam[MAX_PLAYERS][];

//Team Data
new teammateID;
new teammate2ID;
new teammateSkinID;
new teammate2SkinID;
new teammateName[];
new teammate2Name[];
new teammateStatus;
new teammate2Status;

//ServerData
new gPlayersInQueue = 0;

enum pInfo
{
pPass,
pAdmin,
pKills,
pDeaths,
pFriends,
pSkin
}
new PlayerInfo[MAX_PLAYERS][pInfo];

forward LoadUser_data(playerid,name[],value[]);
public LoadUser_data(playerid,name[],value[])
{
INI_Int("Password",PlayerInfo[playerid][pPass]);
INI_Int("Admin",PlayerInfo[playerid][pAdmin]);
INI_Int("Kills",PlayerInfo[playerid][pKills]);
INI_Int("Deaths",PlayerInfo[playerid][pDeaths]);
INI_Int("Friends",PlayerInfo[playerid][pFriends]);
INI_Int("Skin",PlayerInfo[playerid][pSkin]);
return 1;
}


main()
{
	print("\n----------------------------------");
	print(" GTA Battle Royale by ZeroTheScyther");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	SetGameModeText("Battle Royale");
	DisableInteriorEnterExits();
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    TogglePlayerSpectating(playerid, true);
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(fexist(UserPath(playerid)))
	{
		INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Login", "Enter your password below:", "Login", "Cancel");
	}
	else
	{
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT,"Registering...","Type your password below to register a new account.","Register","Quit");
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File,"data");
	INI_WriteInt(File,"Admin",PlayerInfo[playerid][pAdmin]);
	INI_WriteInt(File,"Kills",PlayerInfo[playerid][pKills]);
	INI_WriteInt(File,"Deaths",PlayerInfo[playerid][pDeaths]);
	INI_WriteInt(File,"Friends",PlayerInfo[playerid][pFriends]);
	INI_WriteInt(File,"Skin",PlayerInfo[playerid][pSkin]);
	INI_Close(File);
	DestroyTextdraws(playerid);

	teammate2ID = 0;
	teammateID = 0;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	GivePlayerWeapon(playerid, 46, 1);
	HideMainMenu(playerid);
	CancelSelectTextDraw(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	PlayerInfo[killerid][pKills]++;
	PlayerInfo[playerid][pDeaths]++;
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/spawn", true))
    {
        TogglePlayerSpectating(playerid, false);
        return 1;
        // Returning 1 informs the server that the command has been processed.
        // OnPlayerCommandText won't be called in other scripts.
    }
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid )
	{
	case DIALOG_REGISTER:
		{
			if (!response) return Kick(playerid);
			if(response)
			{
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT,"Registering...","You have entered an invalid password.\n Type your password below to register a new account.","Register","Quit");
			new INI:File = INI_Open(UserPath(playerid));
			INI_SetTag(File,"data");
			INI_WriteInt(File,"Password",udb_hash(inputtext));
			INI_WriteInt(File,"Admin",0);
			INI_WriteInt(File,"Kills",0);
			INI_WriteInt(File,"Deaths",0);
			INI_WriteInt(File,"Friends",0);
			INI_WriteInt(File,"Skin",299);
			INI_Close(File);
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Login", "Enter your password below:", "Login", "Cancel");
			}
		}

	case DIALOG_LOGIN:
	{
	if ( !response ) return Kick ( playerid );
	if( response )
	{
		if(udb_hash(inputtext) == PlayerInfo[playerid][pPass]) //Logged in successfully
		{
		INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
		SetSpawnInfo( playerid, 0, 299, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0 );
		DrawMainMenu(playerid);
		ShowPlayerTextdraws(playerid);
		}
		else //Failed to log in
		{
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,"Login","You have entered an incorrect password.\n Type your password below to login.","Login","Quit");
		}
		return 1;
		}
	}
	case DIALOG_SKINSELECT:
	{
		if(response)
		{
			SetPlayerSkin(playerid, strval(inputtext));
			PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
			PlayerTextDrawSetPreviewModel(playerid, player_avatar[playerid], PlayerInfo[playerid][pSkin]);
			RefreshTextdraws(playerid);
			printf("The player avatar should have the skin with id %d",PlayerInfo[playerid][pSkin]);
		}
	}
}
	return 1;
}


public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == play_button[playerid])
    {
		PlayerTextDrawShow(playerid, cancel_button[playerid]);
		PlayerTextDrawHide(playerid, play_button[playerid]);
        return 1;
    }
	if(playertextid == cancel_button[playerid])
    {
		PlayerTextDrawShow(playerid, play_button[playerid]);
		PlayerTextDrawHide(playerid, cancel_button[playerid]);
        return 1;
    }
	if(playertextid == SoloButton[playerid])
    {
		PlayerTextDrawHide(playerid, friend_1[playerid]);
		PlayerTextDrawHide(playerid, friend_2[playerid]);
		PlayerTextDrawHide(playerid, friend_name_2[playerid]);
		PlayerTextDrawHide(playerid, friend_name_1[playerid]);
		PlayerTextDrawColor(playerid, SoloButton[playerid], 0x7cfc00);
		PlayerTextDrawColor(playerid, GroupButton[playerid], -1);
		selectedPlaymode[playerid] = true;
		RefreshTextdraws(playerid);
        return 1;
	}
	if(playertextid == GroupButton[playerid])
    {
		PlayerTextDrawShow(playerid, friend_1[playerid]);
		PlayerTextDrawShow(playerid, friend_2[playerid]);
		PlayerTextDrawShow(playerid, friend_name_2[playerid]);
		PlayerTextDrawShow(playerid, friend_name_1[playerid]);
		PlayerTextDrawColor(playerid, SoloButton[playerid], -1);
		PlayerTextDrawColor(playerid, GroupButton[playerid], 0x7cfc00);
		selectedPlaymode[playerid] = false;
		RefreshTextdraws(playerid);
        return 1;
	}
	if(playertextid == change_ped[playerid])
    {
		ShowPlayerDialog(playerid, DIALOG_SKINSELECT, DIALOG_STYLE_INPUT, "Skin Select", "Enter the ID of the skin you want to use", "Select", "Cancel");
        return 1;
    }
	if(playertextid == friend_1[playerid])
	{
		return 1;
	}
    return 0;
}

stock UserPath(playerid)
{
new string[128],playername[MAX_PLAYER_NAME];
GetPlayerName(playerid,playername,sizeof(playername));
format(string,sizeof(string),PATH,playername);
return string;
}

stock udb_hash(buf[]) {
new length=strlen(buf);
new s1 = 1;
new s2 = 0;
new n;
for (n=0; n<length; n++)
{
s1 = (s1 + buf[n]) % 65521;
s2 = (s2 + s1) % 65521;
}
return (s2 << 16) + s1;
}

stock DrawMainMenu(playerid)
{
	change_ped[playerid] = CreatePlayerTextDraw(playerid, 601.000000, 396.000000, "HUD:radar_tshirt");
	PlayerTextDrawFont(playerid, change_ped[playerid], 4);
	PlayerTextDrawLetterSize(playerid, change_ped[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, change_ped[playerid], 26.500000, 26.500000);
	PlayerTextDrawSetOutline(playerid, change_ped[playerid], 0);
	PlayerTextDrawSetShadow(playerid, change_ped[playerid], 0);
	PlayerTextDrawAlignment(playerid, change_ped[playerid], 3);
	PlayerTextDrawColor(playerid, change_ped[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, change_ped[playerid], -2016478465);
	PlayerTextDrawBoxColor(playerid, change_ped[playerid], 50);
	PlayerTextDrawUseBox(playerid, change_ped[playerid], 1);
	PlayerTextDrawSetProportional(playerid, change_ped[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, change_ped[playerid], 1);
	print("Created playerid, change_ped[playerid]");

	play_button[playerid] = CreatePlayerTextDraw(playerid, 71.000000, 382.000000, "Play");
	PlayerTextDrawFont(playerid, play_button[playerid], 2);
	PlayerTextDrawLetterSize(playerid, play_button[playerid], 0.437498, 4.750000);
	PlayerTextDrawTextSize(playerid, play_button[playerid], 304.500000, 105.500000);
	PlayerTextDrawSetOutline(playerid, play_button[playerid], 1);
	PlayerTextDrawSetShadow(playerid, play_button[playerid], 0);
	PlayerTextDrawAlignment(playerid, play_button[playerid], 2);
	PlayerTextDrawColor(playerid, play_button[playerid], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, play_button[playerid], 255);
	PlayerTextDrawBoxColor(playerid, play_button[playerid], 200);
	PlayerTextDrawUseBox(playerid, play_button[playerid], 1);
	PlayerTextDrawSetProportional(playerid, play_button[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, play_button[playerid], 1);

	cancel_button[playerid] = CreatePlayerTextDraw(playerid, 71.000000, 382.000000, "Cancel");
	PlayerTextDrawFont(playerid, cancel_button[playerid], 2);
	PlayerTextDrawLetterSize(playerid, cancel_button[playerid], 0.437498, 4.750000);
	PlayerTextDrawTextSize(playerid, cancel_button[playerid], 304.500000, 105.500000);
	PlayerTextDrawSetOutline(playerid, cancel_button[playerid], 1);
	PlayerTextDrawSetShadow(playerid, cancel_button[playerid], 0);
	PlayerTextDrawAlignment(playerid, cancel_button[playerid], 2);
	PlayerTextDrawColor(playerid, cancel_button[playerid], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, cancel_button[playerid], 255);
	PlayerTextDrawBoxColor(playerid, cancel_button[playerid], 200);
	PlayerTextDrawUseBox(playerid, cancel_button[playerid], 1);
	PlayerTextDrawSetProportional(playerid, cancel_button[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, cancel_button[playerid], 1);

	player_avatar[playerid] = CreatePlayerTextDraw(playerid, 239.000000, 69.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, player_avatar[playerid], 5);
	PlayerTextDrawLetterSize(playerid, player_avatar[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, player_avatar[playerid], 150.000000, 232.000000);
	PlayerTextDrawSetOutline(playerid, player_avatar[playerid], 0);
	PlayerTextDrawSetShadow(playerid, player_avatar[playerid], 0);
	PlayerTextDrawAlignment(playerid, player_avatar[playerid], 1);
	PlayerTextDrawColor(playerid, player_avatar[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, player_avatar[playerid], 125);
	PlayerTextDrawBoxColor(playerid, player_avatar[playerid], 255);
	PlayerTextDrawUseBox(playerid, player_avatar[playerid], 0);
	PlayerTextDrawSetProportional(playerid, player_avatar[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, player_avatar[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, player_avatar[playerid], PlayerInfo[playerid][pSkin]);
	PlayerTextDrawSetPreviewRot(playerid, player_avatar[playerid], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, player_avatar[playerid], 1, 1);

	friend_1[playerid] = CreatePlayerTextDraw(playerid, 393.000000, 69.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, friend_1[playerid], 5);
	PlayerTextDrawLetterSize(playerid, friend_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, friend_1[playerid], 150.000000, 232.000000);
	PlayerTextDrawSetOutline(playerid, friend_1[playerid], 0);
	PlayerTextDrawSetShadow(playerid, friend_1[playerid], 0);
	PlayerTextDrawAlignment(playerid, friend_1[playerid], 1);
	PlayerTextDrawColor(playerid, friend_1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, friend_1[playerid], 125);
	PlayerTextDrawBoxColor(playerid, friend_1[playerid], 255);
	PlayerTextDrawUseBox(playerid, friend_1[playerid], 0);
	PlayerTextDrawSetProportional(playerid, friend_1[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, friend_1[playerid], 1);
	PlayerTextDrawSetPreviewModel(playerid, friend_1[playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid, friend_1[playerid], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, friend_1[playerid], 1, 1);

	friend_2[playerid] = CreatePlayerTextDraw(playerid, 85.000000, 70.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, friend_2[playerid], 5);
	PlayerTextDrawLetterSize(playerid, friend_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, friend_2[playerid], 150.000000, 232.000000);
	PlayerTextDrawSetOutline(playerid, friend_2[playerid], 0);
	PlayerTextDrawSetShadow(playerid, friend_2[playerid], 0);
	PlayerTextDrawAlignment(playerid, friend_2[playerid], 1);
	PlayerTextDrawColor(playerid, friend_2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, friend_2[playerid], 125);
	PlayerTextDrawBoxColor(playerid, friend_2[playerid], 255);
	PlayerTextDrawUseBox(playerid, friend_2[playerid], 0);
	PlayerTextDrawSetProportional(playerid, friend_2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, friend_2[playerid], 1);
	PlayerTextDrawSetPreviewModel(playerid, friend_2[playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid, friend_2[playerid], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, friend_2[playerid], 1, 1);

	friend_name_2[playerid] = CreatePlayerTextDraw(playerid, 160.000000, 46.000000, "");
	PlayerTextDrawFont(playerid, friend_name_2[playerid], 1);
	PlayerTextDrawLetterSize(playerid, friend_name_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, friend_name_2[playerid], 400.000000, 141.500000);
	PlayerTextDrawSetOutline(playerid, friend_name_2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, friend_name_2[playerid], 0);
	PlayerTextDrawAlignment(playerid, friend_name_2[playerid], 2);
	PlayerTextDrawColor(playerid, friend_name_2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, friend_name_2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, friend_name_2[playerid], 50);
	PlayerTextDrawUseBox(playerid, friend_name_2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, friend_name_2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, friend_name_2[playerid], 0);

	friend_name_1[playerid] = CreatePlayerTextDraw(playerid, 467.000000, 46.000000, "");
	PlayerTextDrawFont(playerid, friend_name_1[playerid], 1);
	PlayerTextDrawLetterSize(playerid, friend_name_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, friend_name_1[playerid], 400.000000, 141.500000);
	PlayerTextDrawSetOutline(playerid, friend_name_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, friend_name_1[playerid], 0);
	PlayerTextDrawAlignment(playerid, friend_name_1[playerid], 2);
	PlayerTextDrawColor(playerid, friend_name_1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, friend_name_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, friend_name_1[playerid], 50);
	PlayerTextDrawUseBox(playerid, friend_name_1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, friend_name_1[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, friend_name_1[playerid], 0);

	GetPlayerName(playerid, savedPlayerName, sizeof(savedPlayerName));
	new savedPlayerNameString[MAX_PLAYER_NAME + 23 + 1];
    format(savedPlayerNameString, sizeof(savedPlayerNameString), "%s", savedPlayerName);

	playerName[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 45.000000, savedPlayerNameString);
	PlayerTextDrawFont(playerid, playerName[playerid], 1);
	PlayerTextDrawLetterSize(playerid, playerName[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, playerName[playerid], 400.000000, 141.500000);
	PlayerTextDrawSetOutline(playerid, playerName[playerid], 1);
	PlayerTextDrawSetShadow(playerid, playerName[playerid], 0);
	PlayerTextDrawAlignment(playerid, playerName[playerid], 2);
	PlayerTextDrawColor(playerid, playerName[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, playerName[playerid], 255);
	PlayerTextDrawBoxColor(playerid, playerName[playerid], 50);
	PlayerTextDrawUseBox(playerid, playerName[playerid], 1);
	PlayerTextDrawSetProportional(playerid, playerName[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, playerName[playerid], 0);

	SelectMode[playerid] = CreatePlayerTextDraw(playerid, 50.000000, 325.000000, "Select Mode");
	PlayerTextDrawFont(playerid, SelectMode[playerid], 1);
	PlayerTextDrawLetterSize(playerid, SelectMode[playerid], 0.337500, 1.950000);
	PlayerTextDrawTextSize(playerid, SelectMode[playerid], 400.000000, 103.000000);
	PlayerTextDrawSetOutline(playerid, SelectMode[playerid], 0);
	PlayerTextDrawSetShadow(playerid, SelectMode[playerid], 2);
	PlayerTextDrawAlignment(playerid, SelectMode[playerid], 2);
	PlayerTextDrawColor(playerid, SelectMode[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, SelectMode[playerid], 255);
	PlayerTextDrawBoxColor(playerid, SelectMode[playerid], 50);
	PlayerTextDrawUseBox(playerid, SelectMode[playerid], 0);
	PlayerTextDrawSetProportional(playerid, SelectMode[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SelectMode[playerid], 0);

	SoloButton[playerid] = CreatePlayerTextDraw(playerid, 37.000000, 357.000000, "Solo");
	PlayerTextDrawFont(playerid, SoloButton[playerid], 2);
	PlayerTextDrawLetterSize(playerid, SoloButton[playerid], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, SoloButton[playerid], 16.500000, 32.000000);
	PlayerTextDrawSetOutline(playerid, SoloButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SoloButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, SoloButton[playerid], 2);
	PlayerTextDrawColor(playerid, SoloButton[playerid], 0x7cfc00);
	PlayerTextDrawBackgroundColor(playerid, SoloButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, SoloButton[playerid], 200);
	PlayerTextDrawUseBox(playerid, SoloButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SoloButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SoloButton[playerid], 1);

	GroupButton[playerid] = CreatePlayerTextDraw(playerid, 101.000000, 357.000000, "Squad");
	PlayerTextDrawFont(playerid, GroupButton[playerid], 2);
	PlayerTextDrawLetterSize(playerid, GroupButton[playerid], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, GroupButton[playerid], 16.500000, 39.500000);
	PlayerTextDrawSetOutline(playerid, GroupButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, GroupButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, GroupButton[playerid], 2);
	PlayerTextDrawColor(playerid, GroupButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, GroupButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, GroupButton[playerid], 200);
	PlayerTextDrawUseBox(playerid, GroupButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, GroupButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, GroupButton[playerid], 1);

	return 1;
}

stock ShowPlayerTextdraws(playerid)
{
	PlayerTextDrawShow(playerid, GroupButton[playerid]);
	PlayerTextDrawShow(playerid, play_button[playerid]);
	PlayerTextDrawShow(playerid, player_avatar[playerid]);
	PlayerTextDrawShow(playerid, playerName[playerid]);
	PlayerTextDrawShow(playerid, SelectMode[playerid]);
	PlayerTextDrawShow(playerid, SoloButton[playerid]);
	PlayerTextDrawShow(playerid, change_ped[playerid]);
	SelectTextDraw(playerid, 0x00FF00FF);
	return 1;
}

stock DestroyTextdraws(playerid)
{
	PlayerTextDrawDestroy(playerid, GroupButton[playerid]);
	PlayerTextDrawDestroy(playerid, GroupButton[playerid]);
	PlayerTextDrawDestroy(playerid, play_button[playerid]);
	PlayerTextDrawDestroy(playerid, player_avatar[playerid]);
	PlayerTextDrawDestroy(playerid, friend_1[playerid]);
	PlayerTextDrawDestroy(playerid, friend_2[playerid]);
	PlayerTextDrawDestroy(playerid, friend_name_2[playerid]);
	PlayerTextDrawDestroy(playerid, friend_name_1[playerid]);
	PlayerTextDrawDestroy(playerid, playerName[playerid]);
	PlayerTextDrawDestroy(playerid, SelectMode[playerid]);
	PlayerTextDrawDestroy(playerid, SoloButton[playerid]);
	PlayerTextDrawDestroy(playerid, change_ped[playerid]);
	return 1;
}

stock HideMainMenu(playerid)
{
	PlayerTextDrawHide(playerid, GroupButton[playerid]);
	PlayerTextDrawHide(playerid, play_button[playerid]);
	PlayerTextDrawHide(playerid, player_avatar[playerid]);
	PlayerTextDrawHide(playerid, friend_1[playerid]);
	PlayerTextDrawHide(playerid, friend_2[playerid]);
	PlayerTextDrawHide(playerid, friend_name_2[playerid]);
	PlayerTextDrawHide(playerid, friend_name_1[playerid]);
	PlayerTextDrawHide(playerid, playerName[playerid]);
	PlayerTextDrawHide(playerid, SelectMode[playerid]);
	PlayerTextDrawHide(playerid, SoloButton[playerid]);
	PlayerTextDrawHide(playerid, change_ped[playerid]);
	PlayerTextDrawHide(playerid, cancel_button[playerid]);
	return 1;
}

stock RefreshTextdraws(playerid)
{
	PlayerTextDrawHide(playerid, SoloButton[playerid]);
	PlayerTextDrawHide(playerid, GroupButton[playerid]);
	PlayerTextDrawShow(playerid, SoloButton[playerid]);
	PlayerTextDrawShow(playerid, GroupButton[playerid]);

	PlayerTextDrawHide(playerid, player_avatar[playerid]);
	PlayerTextDrawShow(playerid, player_avatar[playerid]);
	return 1;
}