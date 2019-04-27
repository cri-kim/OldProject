#include "Client.h"

Client::Client(int clientID, SOCKET clientSocket) {
	this->clientID = clientID;
	this->roomID = -1;
	this->clientSocket = clientSocket;
	//�ʱⰪ
	this->win = 0;
	this->lose = 0;
}
int Client::getClientID() {
	return clientID;
}

int Client::getCustomID() {
	return customID;
}

int Client::getRoomID() {
	return roomID;
}

void Client::setCustomID(int customID) {
	this->customID = customID;
}

void Client::setRoomID(int roomID) {
	this->roomID = roomID;
}
SOCKET Client::getClientSocket() {
	return clientSocket;
}
void Client::setLose(int lose) {
	this->lose=lose;
}
void Client::setWin(int win) {
	this->win=win;
}
int Client::getWin() {
	return win;
}
int Client::getLose() {
	return lose;
}

