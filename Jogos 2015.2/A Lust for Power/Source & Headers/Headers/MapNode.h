#ifndef MapNode_H
#define MapNode_H

#include "Defines.h"

class MapNode
{
private:
	int sheet_x;
	int sheet_y;
	int screen_x;
	int screen_y;

	MapNode* ptr;

public:
	MapNode (int cx, int cy, int x, int y);
	MapNode* get_ptr() { return ptr; };
	void set_ptr (MapNode* p);
	void new_ptr (int tx, int ty, int x, int y);
	int get_screen_x();
	int get_screen_y();
	int get_sheet_x();
	int get_sheet_y();
	void delete_ptr();
};

#endif