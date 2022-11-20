#pragma comment(lib, "libsteam_api.so")

#include <iostream>
#include <fstream>
#include <string>
#include <chrono>
#include <thread>
//the original path to the headers is "./sdk/public/steam/....h"
#include "headers/steam_api.h"
#include "headers/isteammatchmaking.h"

class LobbyListManager {
	CCallResult <LobbyListManager, LobbyMatchList_t> m_CallResultLobbyMatchList;
	std::ofstream* fout;
public:
	LobbyListManager(std::ofstream* fout) {
		this->fout = fout;
	}
	void FindLobbies() {
		SteamMatchmaking()->AddRequestLobbyListNearValueFilter("difficulty", 5);
		SteamMatchmaking()->AddRequestLobbyListDistanceFilter(k_ELobbyDistanceFilterWorldwide);
		SteamAPICall_t hSteamAPICall = SteamMatchmaking()->RequestLobbyList();
		m_CallResultLobbyMatchList.Set(hSteamAPICall, this, &LobbyListManager::OnLobbyMatchList);
	}
	void OnLobbyMatchList(LobbyMatchList_t* pLobbyMatchList, bool bIOFailure) {
		if (pLobbyMatchList->m_nLobbiesMatching == 0) {
			*fout << "-3\nNo lobbies found";
			fout->close();
			exit(0);
		}
		*fout << "0\n";
		for (int i = 0; i < pLobbyMatchList->m_nLobbiesMatching; i++) {
			CSteamID lobbyID = SteamMatchmaking()->GetLobbyByIndex(i);		
			std::string value;
			char keys[5][k_cubChatMetadataMax] = { "difficulty" , "level", "num_players", "owner_name", "state" };
			for (int l = 0; l < 5; l++) {
				value = SteamMatchmaking()->GetLobbyData(lobbyID, keys[l]);
				*fout << keys[l] << ':' << value << "\n";
			}

		}
		fout->close();
		exit(0);
	}
};

int main() {
	std::ofstream fout("lobbies.txt", std::ios_base::trunc);
	if (!fout.is_open()) 
		return -1;

	if (!SteamAPI_Init()) {
		fout << "-2\nCannot connect to steam";
		fout.close();
		return -2;
	}

	LobbyListManager m(&fout);
	m.FindLobbies();
	while (true) {
		std::this_thread::sleep_for(std::chrono::milliseconds(100));
		SteamAPI_RunCallbacks();
	}
}
