#ifndef LiveSprite_H
#define LiveSprite_H

#include "Sprite.h"

class LiveSprite : public Sprite
{
private:
	int walk_speed;
	int dash_speed;
	bool dashing;

public:
	LiveSprite (int w, int h, int sheet_X, int sheet_Y, int screen_X, int screen_Y);
	void set_dashing (bool dash);
	void toggle_dashing();
	bool is_dashing();
	int get_current_speed();
};

#endif