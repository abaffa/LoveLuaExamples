#ifndef __MapBuilder__
#define __MapBuilder__

#include "MapNode.h"

class MapBuilder
{
	private:
	
		int **matrix;
		MapNode* map_list_head;
		MapNode* map_list_tail;
	
	public:
	
		MapBuilder();

		void Tile		(int tx, int ty, int x, int y);
		void Rect		(int tx, int ty, int x, int y, int w, int h);
		void Row		(int tx, int ty, int x, int y, int w);
		void Col		(int tx, int ty, int x, int y, int h);
		void Sq			(int tx, int ty, int x, int y, int s);
		void As_is		(int tx, int ty, int x, int y, int w, int h);
		void St			(int tx, int ty, int x, int y, int w, int h);

		MapNode* get_list_head();
		MapNode* get_list_tail();
		void delete_list();
};

#endif /* defined(__MapBuilder__) */


