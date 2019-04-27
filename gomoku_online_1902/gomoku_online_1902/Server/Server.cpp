#include "Server.h"

SOCKET Server::serverSocket;
WSAData Server::wsaData;
SOCKADDR_IN Server::serverAddress;
int Server::nextID;
vector<Client*> Server::connections;
Util Server::util;

void Server::rejectClient(Client *client) {
	char *sent = new char[256];
	ZeroMemory(sent, 256);
	sprintf(sent, "%s", "[Reject]");
	send(client->getClientSocket(), sent, 256, 0);
}
void Server::connectClient(Client *client) {
	char *sent = new char[256];
	ZeroMemory(sent, 256);
	sprintf(sent, "%s", "[Connect]");
	send(client->getClientSocket(), sent, 256, 0);
}
void Server::enterClient(Client *client) {
	char *sent = new char[256];
	ZeroMemory(sent, 256);
	sprintf(sent, "%s", "[Enter]");
	send(client->getClientSocket(), sent, 256, 0);
}
void Server::fullClient(Client *client) {
	char *sent = new char[256];
	ZeroMemory(sent, 256);
	sprintf(sent, "%s", "[Full]");
	send(client->getClientSocket(), sent, 256, 0);
}
void Server::showRank(Client *client) {
	char *sent = new char[256];
	if (client->getLose() == 0
		&& client->getWin() ==0) {
		ZeroMemory(sent, 256);
		sprintf(sent, "%s", "[NoData]");
		send(client->getClientSocket(), sent, 256, 0);

		cout << sent << endl;
	}
	else {
		//send my rank in current user (myRank/allUsersNum)
		string data = "[Rank]"+ to_string(countMyRank(client))+"/"+to_string(connections.size());
		ZeroMemory(sent, 256);
		sprintf(sent, "%s", data.c_str());
		send(client->getClientSocket(), sent, 256, 0);
		cout << data << endl;
	}
}
int Server::countMyRank(Client *client) {
	//get my grade
	int myGrade = client->getWin() - client->getLose();
	int myRank = 1; //default
	for (int i = 0; i < connections.size(); i++) {
		int tmpGrade = connections[i]->getWin() - connections[i]->getLose();
		if (myGrade < tmpGrade) {
			myRank++;
		}
	}
	return myRank;
}
void Server::playClient(int roomID) {
	char *sent = new char[256];
	bool black = true;
	for (int i = 0; i < connections.size(); i++) {
		if (connections[i]->getRoomID() == roomID) {
			ZeroMemory(sent, 256);
			if (black) {
				sprintf(sent, "%s", "[Play]Black");
				black = false;
			}
			else {
				sprintf(sent, "%s", "[Play]White");
			}
			send(connections[i]->getClientSocket(), sent, 256, 0);
		}
	}
}
int Server::clientCountInRoom(int roomID) {
	int count = 0;
	for (int i = 0; i < connections.size(); i++) {
		if (connections[i]->getRoomID() == roomID) {
			count++;
		}
	}
	return count;
}
void Server::start() {
	WSAStartup(MAKEWORD(2, 2), &wsaData);
	serverSocket = socket(AF_INET, SOCK_STREAM, NULL);

	serverAddress.sin_addr.s_addr = inet_addr("127.0.0.1");
	serverAddress.sin_port = htons(9876);
	serverAddress.sin_family = AF_INET;

	cout << "[ C++ 오목게임 서버 가동] " << endl;
	bind(serverSocket, (SOCKADDR*)&serverAddress, sizeof(serverAddress));
	listen(serverSocket, 32);

	int addressLength = sizeof(serverAddress);
	while (true) {
		SOCKET clientSocket = socket(AF_INET, SOCK_STREAM, NULL);
		if (clientSocket = accept(serverSocket, (SOCKADDR*)&serverAddress, &addressLength)) {
			Client *client = new Client(nextID, clientSocket);
			cout << "[새로운 사용자 접속]" << endl;
			CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)ServerThread, (LPVOID)client, NULL, NULL);
			connections.push_back(client);
			nextID++;
		}
		Sleep(100);
	}
}
void Server::exitClient(int roomID) {
	char *sent = new char[256];
	for (int i = 0; i < connections.size(); i++) {
		if (connections[i]->getRoomID() == roomID) {
			ZeroMemory(sent, 256);
			sprintf(sent, "%s", "[Exit]");
			send(connections[i]->getClientSocket(), sent, 256, 0);
		}
	}
}
void Server::putClient(int roomID, int x, int y) {
	char *sent = new char[256];
	for (int i = 0; i < connections.size(); i++) {
		if (connections[i]->getRoomID() == roomID) {
			ZeroMemory(sent, 256);
			string data = "[Put]" + to_string(x) + "," + to_string(y);
			sprintf(sent, "%s", data.c_str());
			send(connections[i]->getClientSocket(), sent, 256, 0);
		}
	}
}
void Server::ServerThread(Client *client) {
	char *sent = new char[256];
	char *received = new char[256];
	int size = 0;
	while (true) {
		ZeroMemory(received, 256);
		if ((size = recv(client->getClientSocket(), received, 256, NULL)) > 0) {
			string receivedString = string(received);
			vector<string> tokens = util.getTokens(receivedString, ']');
			vector<string> clientTokens = util.getTokens(receivedString, ']');

			if (receivedString.find("[Connect]") != -1) {
				cout << "들어옴" << endl;
				string customID = clientTokens[1];
				int customInt = atoi(customID.c_str());
				
				boolean usable = true;

				for (int i = 0; i < connections.size(); i++) {
					/*  check duplication custom ID */
					if (connections[i]->getCustomID() == customInt) {
						/* you can't use this ID */
						usable = false;
						rejectClient(client);
						break;
					}
				}
				if (usable) {
					cout << "클라이언트 [ " << customID << "]: 접속" << endl;
					/* you can use the ID*/
					client->setCustomID(customInt);
					connectClient(client);

				}
			}
			else if (receivedString.find("[Enter]") != -1) {
				string roomID = tokens[1];
				int roomInt = atoi(roomID.c_str());
				int clientCount = clientCountInRoom(roomInt);

				if (clientCount >= 2) {
					fullClient(client);
				}
				client->setRoomID(roomInt);
				cout << "클라이언트 [ " << client->getClientID() << "]: " << client->getRoomID() << "번 방으로 접속" << endl;

				enterClient(client);

				if (clientCount == 1) {
					playClient(roomInt);
				}
			}
			else if (receivedString.find("[Put]") != -1) {
				string data = tokens[1];
				vector<string> dataTokens = util.getTokens(data, ',');
				int roomID = atoi(dataTokens[0].c_str());
				int x = atoi(dataTokens[1].c_str());
				int y = atoi(dataTokens[2].c_str());

				putClient(client->getRoomID(), x, y);
			}
			else if (receivedString.find("[Play]") != -1) {
				string roomID = tokens[1];
				int roomInt = atoi(roomID.c_str());

				playClient(client->getRoomID());
			}

			else if (receivedString.find("[ShowRank]") != -1) {
				showRank(client);
			}

			//add win/lose
			if (receivedString.find("[Win]") != -1) {
				cout << "["<<connections[client->getClientID()] << "] : 클라이언트 승리" << endl;
				client->setWin((client->getWin())+1);
			}
			if (receivedString.find("[Lose]") != -1) {
				cout << "["<< connections[client->getClientID()] << "] : 클라이언트 패배" << endl;
				client->setLose((client->getLose()) + 1);
			}
		}
		else {
			cout << "클라이언트[" << client->getClientID() << "]의 연결이 끊어졌습니다." << endl;

			for (int i = 0; i < connections.size(); i++) {
				if (connections[i]->getClientID() == client->getClientID()) {
					if (connections[i]->getRoomID() != -1
						&& clientCountInRoom(connections[i]->getRoomID()) == 2) {
						exitClient(connections[i]->getRoomID());
					}
					connections.erase(connections.begin() + i);
					break;
				}
			}
			delete client;
			break;
		}
	}
}