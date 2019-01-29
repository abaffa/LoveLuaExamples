#include "MapBuilder.h"
#include "Defines.h"
#include <stdlib.h>

MapBuilder::MapBuilder()
{
	map_list_head = new MapNode (0, 0, 0, 0);
	map_list_tail = map_list_head;

	FILE * pFile;
	char line_buffer[100];			// 100: arbitrário
	char argument_buffer[9][10];	// 9: máximo de args + função; 10: arbitrário
	int size = 100;
	int arguments = 0;
	int current_argument = 0;
	char map_file_path[FILE_PATH_SIZE];
	cat_path (map_file_path, SH, "Files/MapFileBG.txt");
	fopen_s (&pFile, map_file_path , "r");
	
	if (pFile == NULL) printf("Error opening background map file\n");
	else 
	{
		while (fgets(line_buffer, size, pFile) != NULL)
		{
			int arg_i, line_i;
			for (arg_i=0, line_i=0; line_buffer[line_i]!='('; arg_i++, line_i++)
			{
				if (line_buffer[line_i] != ' ')
					argument_buffer[0][arg_i] = line_buffer[line_i];
			};

			argument_buffer[0][arg_i] = '\0';
			line_i++;
			
			if (strcmp(argument_buffer[0], "Tile")==0)
				arguments = 4;
			else if (strcmp(argument_buffer[0], "Rect")==0 || strcmp(argument_buffer[0], "As_is")==0 || strcmp(argument_buffer[0],"St")==0)
				arguments = 6;
			else if (strcmp(argument_buffer[0], "Row")==0 || strcmp(argument_buffer[0], "Col")==0)
				arguments = 5;
				
			for (current_argument = 1; current_argument <= arguments; current_argument++)
			{
				for (arg_i=0; line_buffer[line_i]!=',' && line_buffer[line_i]!=')'; arg_i++, line_i++)
				{
					//if (line_buffer[line_i] != ' ')
						argument_buffer[current_argument][arg_i] = line_buffer[line_i];
				};
				argument_buffer[current_argument][arg_i] = '\0';
				line_i++;
			};
		
			if(0)
			{
				printf("N = %d\n", arguments);
				for (int print_i = 0; print_i <= arguments; print_i++)
					printf("Arg %d = [%s]\n", print_i, argument_buffer[print_i]);
				printf("\n");
			};

			if (strcmp(argument_buffer[0], "Tile")==0)
				Tile(atoi(argument_buffer[1]), atoi(argument_buffer[2]), atoi(argument_buffer[3]), atoi(argument_buffer[4]));
			else if (strcmp(argument_buffer[0], "Rect")==0)
				Rect(atoi(argument_buffer[1]), atoi(argument_buffer[2]), atoi(argument_buffer[3]), atoi(argument_buffer[4]), atoi(argument_buffer[5]), atoi(argument_buffer[6]));
			else if (strcmp(argument_buffer[0], "Row")==0)
				Row(atoi(argument_buffer[1]), atoi(argument_buffer[2]), atoi(argument_buffer[3]), atoi(argument_buffer[4]), atoi(argument_buffer[5]));
			else if (strcmp(argument_buffer[0], "Col")==0)
				Col(atoi(argument_buffer[1]), atoi(argument_buffer[2]), atoi(argument_buffer[3]), atoi(argument_buffer[4]), atoi(argument_buffer[5]));
			else if (strcmp(argument_buffer[0], "As_is")==0)
				As_is(atoi(argument_buffer[1]), atoi(argument_buffer[2]), atoi(argument_buffer[3]), atoi(argument_buffer[4]), atoi(argument_buffer[5]), atoi(argument_buffer[6]));
			else if (strcmp(argument_buffer[0], "St")==0)
				St(atoi(argument_buffer[1]), atoi(argument_buffer[2]), atoi(argument_buffer[3]), atoi(argument_buffer[4]), atoi(argument_buffer[5]), atoi(argument_buffer[6]));
			
		};
		
		fclose (pFile);
	};

};

void MapBuilder::Tile (int tx, int ty, int x, int y)
{
	map_list_tail->new_ptr(tx, ty, x, y);
	map_list_tail = map_list_tail->get_ptr();
};

void MapBuilder::Rect (int tx, int ty, int x, int y, int w, int h)
{
	//printf("Rect function called with arguments %d, %d, %d, %d, %d and %d.\n", tx, ty, x, y, w, h);

	for (int i=0; i<h; i++)
	{
		for (int j=0; j<w; j++)
		{
			map_list_tail->new_ptr(tx, ty, (j*TILE_SIZE)+x, (i*TILE_SIZE)+y);
			map_list_tail = map_list_tail->get_ptr();
		};
	};
};

void MapBuilder::Row (int tx, int ty, int x, int y, int w)
{
	//printf("Row  function called with arguments %d, %d, %d, %d and %d.\n", tx, ty, x, y, w);

	for (int i=0; i<w; i++)
	{
		map_list_tail->new_ptr(tx,ty,(i*TILE_SIZE)+x, y);
		map_list_tail = map_list_tail->get_ptr();
	};
};

void MapBuilder::Col (int tx, int ty, int x, int y, int h)
{
	//printf("Col  function called with arguments %d, %d, %d, %d and %d.\n", tx, ty, x, y, h);

	for (int i=0; i<h; i++)
	{
		map_list_tail->new_ptr(tx, ty, x, (i*TILE_SIZE)+y);
		map_list_tail = map_list_tail->get_ptr();
	};
};

void MapBuilder::As_is (int tx, int ty, int x, int y, int w, int h)
{
	//printf("\'As is\' function called with arguments %d, %d, %d, %d, %d and %d.\n", tx, ty, x, y, w, h);

	for (int i=0; i<h; i++)
	{
		for (int j=0; j<w; j++)
		{
			map_list_tail->new_ptr(tx+j, ty+i, (j*TILE_SIZE)+x, (i*TILE_SIZE)+y);
			map_list_tail = map_list_tail->get_ptr();
		};
	};
};

void MapBuilder::St (int tx, int ty, int x, int y, int w, int h)
{
	//printf("\'St\' function called with arguments %d, %d, %d, %d, %d and %d.\n", tx, ty, x, y, w, h);

	Tile (tx, ty, x, y);
	Row (tx+1, ty, x+TILE_SIZE, y, w-2);
	Tile (tx+2, ty, x+(w-2)*TILE_SIZE, y);
	Col (tx, ty+1, x, y+TILE_SIZE, h-2);
	Tile (tx, ty+2, x, y+(h-2)*TILE_SIZE);
	Row (tx+1, ty+2, x+TILE_SIZE, y+(h-2)*TILE_SIZE, w-3);
	Col (tx+2, ty+1, x+(w-2)*TILE_SIZE, y+TILE_SIZE, h-3);
	Tile (tx+2, ty+2, x+(w-2)*TILE_SIZE, y+(h-2)*TILE_SIZE);
	Rect (tx+1, ty+1, x+TILE_SIZE, y+TILE_SIZE, w-3, h-3);
};


MapNode* MapBuilder::get_list_head()
{
	return map_list_head;
};

MapNode* MapBuilder::get_list_tail()
{
	printf("Map Tail: (%d, %d, %d, %d)\n",map_list_tail->get_sheet_x(), map_list_tail->get_sheet_y(), map_list_tail->get_screen_x(), map_list_tail->get_screen_y());
		
	return map_list_tail;
};

void MapBuilder::delete_list()
{
	map_list_head->delete_ptr();
};
