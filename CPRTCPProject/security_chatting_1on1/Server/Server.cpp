#include "Server.h"


SOCKET Server::serverSocket;
WSAData Server::wsaData;
SOCKADDR_IN Server::serverAddress;
int Server::nextID;
int Server::nextRoomID;
vector<Client*> Server::connections;
Util Server::util;
SSL Server::*ssl;

void Server::enterClient(Client *client, SSL *ssl) {
	
	/* SSL 출력 */
	//char *sent = new char[256];
	//ZeroMemory(sent, 256);
	//int length = wsprintfA(sent, "[Echo]: %s\n", input);
	//sprintf(sent, "%s", "[Enter]");
	//int length = wsprintfA(sent, "[Enter]");
	//send(client->getClientSocket(), sent, 256, 0);
	//SSL_write(ssl, sent, strlen(sent));
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
	SSL_load_error_strings();
	SSL_library_init();
	OpenSSL_add_all_algorithms();

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
void Server::putClient(int roomID, string content, SSL *ssl) {
	/* SSL 출력 */
	char *sent = new char[256];
	for (int i = 0; i < connections.size(); i++) {
		if (connections[i]->getRoomID() == roomID) {
			ZeroMemory(sent, 256);
			string data = "[Put]" + content;
			//int length = wsprintfA(sent, "%s", data);
			strcpy(sent, data.c_str());// string to char
			//sprintf(sent, "%s", data.c_str());
			//send(connections[i]->getClientSocket(), sent, 256, 0);
			SSL_write(ssl, sent, strlen(sent));
		}
	}
}
void Server::ServerThread(Client *client) {
	char *sent = new char[256];
	char *received = new char[256];
	int size = 0;


	/* SSL 객체 초기화 */
	SSL_CTX *sslContext = SSL_CTX_new(SSLv23_server_method());
	SSL_CTX_set_options(sslContext, SSL_OP_SINGLE_DH_USE);

	/* 공개키와 개인키 초기화 */
	SSL_CTX_use_certificate_file(sslContext, "./cert.pem", SSL_FILETYPE_PEM);
	SSL_CTX_use_PrivateKey_file(sslContext, "./key.pem", SSL_FILETYPE_PEM);

	while (true) {

		/* SSL 통신 처리 */
		SSL *ssl = SSL_new(sslContext);
		SSL_set_fd(ssl, client->getClientSocket());
		SSL_accept(ssl);

		/* SSL 입력 */ 
		//char input[4096] = { 0 }; 
		//SSL_read(ssl, (char *)input, 4096);

		/* SSL 출력 */ 
		//char output[4096] = { 0 }; 
		//int length = wsprintfA(output, "[Echo]: %s\n", input); 
		//SSL_write(ssl, output, length);

		ZeroMemory(received, 256);
		if ((size = recv(client->getClientSocket(), received, 256, NULL)) > 0) {
			/* Read SSL input */
			SSL_read(ssl, received, 256);
			string receivedString = string(received);
			vector<string> tokens = util.getTokens(receivedString, ']');
			cout << received << endl;

			if (receivedString.find("[Enter]") != -1) {
				int clientCount = clientCountInRoom(nextRoomID);
				if (clientCount >= 2) {
					nextRoomID++;
				}

				enterClient(client, ssl);

			}
			else if (receivedString.find("[Put]") != -1) {
				string content = tokens[1];

				putClient(client->getRoomID(), content, ssl);
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
			SSL_free(ssl);
			closesocket(client->getClientSocket());
			delete client;
			break;
		}
	}
	SSL_CTX_free(sslContext);
}
void Server::close() {
	ERR_free_strings();
	EVP_cleanup();
	WSACleanup();
}