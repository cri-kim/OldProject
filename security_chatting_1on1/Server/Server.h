#pragma once
#ifndef GOMOKU_SERVER_H
#define GOMOKU_SERVER_H
#define _CRT_SECURE_NO_WARNINGS
#pragma comment (lib, "ws2_32.lib")
#include <iostream>
using namespace std;
#include <Winsock.h>
/* openssl Ãß°¡ */
#include <openssl/ssl.h>
#include <openssl/err.h>
#include <vector>
#include "Util.h"
#include "Client.h"
static class Server {
private:
	static SOCKET serverSocket;
	static WSAData wsaData;
	static SOCKADDR_IN serverAddress;
	static int nextID;
	static int nextRoomID;
	static vector<Client*> connections;
	static Util util;
public:
	static void start();
	static int clientCountInRoom(int roomID);
	static void exitClient(int roomID);
	static void putClient(int roomID, string content, SSL *ssl);
	static void enterClient(Client *client, SSL *ssl);
	static void ServerThread(Client *client);
	static void close();
};
#endif // !GOMOKU_SERVER_H
