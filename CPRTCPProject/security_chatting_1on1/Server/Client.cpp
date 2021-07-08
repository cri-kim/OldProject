#include "Client.h"

Client::Client(int clientID, int roomID, SOCKET clientSocket) {
	this->clientID = clientID;
	this->roomID = roomID;
	this->clientSocket = clientSocket;
}
int Client::getClientID() {
	return clientID;
}

int Client::getRoomID() {
	return roomID;
}

SOCKET Client::getClientSocket() {
	return clientSocket;
}