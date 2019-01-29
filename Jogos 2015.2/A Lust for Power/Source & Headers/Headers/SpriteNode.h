#ifndef SpriteNode_H
#define SpriteNode_H

#include "LiveSprite.h"

class SpriteNode
{
	private:
		int sheet_x;
		int sheet_y;
		int screen_x;
		int screen_y;
		int frame_w;
		int frame_h;
		int layer;

		SpriteNode* ptr;
		Sprite* sprite;

	public:

		SpriteNode();
		SpriteNode (Sprite* s, int l, SpriteNode* p);
	
		int get_sheet_x();
		int get_sheet_y();
		int get_crop_x();
		int get_crop_y();
		int get_screen_x();
		int get_screen_y();
		int get_frame_w();
		int get_frame_h();
		int get_layer();

		SpriteNode* get_ptr();
		Sprite* get_sprite();

		void select_frame (int x, int y);
		void set_position (int x, int y);
		void set_size (int w, int h);

		void set_ptr (SpriteNode* p);
		void set_sprite (Sprite* s);

		void insert_node (Sprite* s, int l);
		void clear();
		void draw_list (iGraphics* i);
		void draw (iGraphics* i);

		void print_node();
		void print_sprite_file_name();
		void print_node_line();
};


#endif