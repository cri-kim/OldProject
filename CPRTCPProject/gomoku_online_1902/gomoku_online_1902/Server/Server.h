#pragma once
#ifndef GOMOKU_SERVER_H
#define GOMOKU_SERVER_H
#define _CRT_SECURE_NO_WARNINGS
#pragma comment (lib, "ws2_32.lib")
#include <iostream>
using namespace std;
#include <Winsock.h>
#include <vector>
#include "Util.h"
#include "Client.h"
static class Server {
private:
	static SOCKET serverSocket;
	static WSAData wsaData;
	static SOCKADDR_IN serverAddress;
	static int nextID;
	static vector<Client*> connections;
	static Util util;
public:
	static void start();
	static int clientCountInRoom(int roomID);
	static void playClient(int roomID);
	static void exitClient(int roomID);
	static void putClient(int roomID, int x, int y);
	static void fullClient(Client *client);
	static void showRank(Client *client);
	static void enterClient(Client *client);
	static void rejectClient(Client *client);
	static void connectClient(Client *client);
	static void ServerThread(Client *client);

	static int countMyRank(Client *client);
};
#endif // !GOMOKU_SERVER_H
