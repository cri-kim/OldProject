#include "Server.h"

SOCKET Server::serverSocket;
WSAData Server::wsaData;
SOCKADDR_IN Server::serverAddress;
int Server::nextID;
int Server::nextRoomID;
vector<Client*> Server::connections;
Util Server::util;

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
	/* 방 증가 */
	nextRoomID++;
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

	cout << "[ C++ 채팅 서버 가동] " << endl;
	bind(serverSocket, (SOCKADDR*)&serverAddress, sizeof(serverAddress));
	listen(serverSocket, 32);

	int addressLength = sizeof(serverAddress);
	while (true) {
		SOCKET clientSocket = socket(AF_INET, SOCK_STREAM, NULL);
		if (clientSocket = accept(serverSocket, (SOCKADDR*)&serverAddress, &addressLength)) {
			Client *client = new Client(nextID, nextRoomID, clientSocket);
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
void Server::putClient(int roomID, string content) {
	char *sent = new char[256];
	for (int i = 0; i < connections.size(); i++) {
		if (connections[i]->getRoomID() == roomID) {
			ZeroMemory(sent, 256);
			string data = "[Put]" + content;
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

			if (receivedString.find("[Enter]") != -1) {
				int clientCount = clientCountInRoom(nextRoomID);

				if (clientCount >= 2) {
					fullClient(client);
				}

				enterClient(client);

			}
			else if (receivedString.find("[Put]") != -1) {
				string content = tokens[1];

				putClient(client->getRoomID(), content);
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