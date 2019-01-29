#include "MapNode.h"

MapNode::MapNode (int cx, int cy, int x, int y)
{
	sheet_x = cx;
	sheet_y = cy;
	screen_x = x;
	screen_y = y;

	ptr = NULL;
};


void MapNode::set_ptr (MapNode* p)
{
	ptr = p;
};

void MapNode::new_ptr (int tx, int ty, int x, int y)
{
	ptr = new MapNode (tx, ty, x, y);
};

int MapNode::get_screen_x()
{
	return screen_x;
};

int MapNode::get_screen_y()
{
	return screen_y;
};

int MapNode::get_sheet_x()
{
	return sheet_x;
};

int MapNode::get_sheet_y()
{
	return sheet_y;
};

void MapNode::delete_ptr()
{
	if (ptr != NULL)
	{
		ptr->delete_ptr();
		delete ptr;
	}
};