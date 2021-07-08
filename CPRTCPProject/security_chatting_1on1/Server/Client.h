#pragma once
#ifndef GOMOKU_CLIENT_H
#define GOMOKU_CLIENT_H
#define _CRT_SECURE_NO_WARNINGS
#include <winsock.h>
class Client {
private:
	int clientID;
	int roomID;
	SOCKET clientSocket;
public:
	Client(int clientID, int roomID, SOCKET clientSocket);
	int getClientID();
	int getRoomID();
	SOCKET getClientSocket();
};
#endif // !GOMOKU_CLIENT_H
