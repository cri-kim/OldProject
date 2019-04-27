#include "Ranker.h"

Ranker::Ranker(string rankerID, int win, int lose){
	this->rankerID = rankerID;
	this->win;
	this->lose = lose;
}
void Ranker::setWin(int win) {
	this->win;
}
void Ranker::setLose(int lose) {
	this->lose = lose;
}
string Ranker::getRankerID() {
	return this->rankerID;
}
int Ranker::getWin() {
	return this->win;
}
int Ranker::getLose() {
	return this->lose;
}