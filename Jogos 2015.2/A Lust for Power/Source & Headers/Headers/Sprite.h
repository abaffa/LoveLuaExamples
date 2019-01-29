// 1.1

#ifndef __Sprite__
#define __Sprite__

#include "Defines.h"
#include "Graphics.h"
#include "iGraphics.h"
using namespace PlayLib;

enum axis
{
	horizontal,
	vertical
};

class Sprite : public Image
{
	protected:
		int screen_x;
		int screen_y;
		int sheet_x;
		int sheet_y;
		int frame_w;
		int frame_h;
		char path[FILE_PATH_SIZE];

	public:
		Sprite ();
		Sprite (int w, int h, const char* p);
		Sprite (int w, int h);
		Sprite (int w, int h, int sheet_X, int sheet_Y, int screen_X, int screen_Y);
		void load (const char* sub_folder_path, char* file_name);
		void load_direct (char* file_path);
		void set_position (int x, int y);
		void draw (Graphics* g);
		void draw (iGraphics* i);
		void set_frame_w (int w);
		void set_frame_h (int h);
		int get_frame_w();
		int get_frame_h();
		int get_crop_x();
		int get_crop_y();
		int get_screen_x();
		int get_screen_y();
		int get_sheet_x();
		int get_sheet_y();
		void select_frame (int x, int y);
		void print_path();
		void print_pos ();
		void move (int x, int y);
		void move (int n, axis a);
		char* get_path();
};

#endif