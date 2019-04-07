#pragma once
#ifndef GOMOKU_UTIL_H
#define GOMOKU_UTIL_H
#define _CRT_SECURE_NO_WARNINGS
using namespace std;
#include <vector>
#include <sstream>
class Util {
public:
	vector<string> getTokens(string input, char delimiter);
};
#endif // !GOMOKU_UTIL_H
#pragma once
