#pragma once
#ifndef GOMOKU_RANKER_H
#define GOMOKU_RANKER_H
#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
using namespace std;
class Ranker {
private:
	string rankerID;
	int win;
	int lose;
public:
	Ranker(string rankerID, int win, int lose);
	void setWin(int win);
	void setLose(int lose);
	string getRankerID();
	int getWin();
	int getLose();
};
#endif // !GOMOKU_RANKER_H
#pragma once