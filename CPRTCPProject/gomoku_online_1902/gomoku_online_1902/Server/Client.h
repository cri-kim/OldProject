#pragma once
#ifndef GOMOKU_CLIENT_H
#define GOMOKU_CLIENT_H
#define _CRT_SECURE_NO_WARNINGS
#include <winsock.h>
class Client {
private:
	int clientID;
	int customID;
	int roomID;
	SOCKET clientSocket;
	int win;
	int lose;
public:
	Client(int clientID, SOCKET clientSocket);
	int getClientID();
	int getCustomID();
	int getWin();
	int getLose();
	int getRoomID();
	void setCustomID(int customID);
	void setRoomID(int roomID);
	void setWin(int win);
	void setLose(int lose);
	SOCKET getClientSocket();
};
#endif // !GOMOKU_CLIENT_H
