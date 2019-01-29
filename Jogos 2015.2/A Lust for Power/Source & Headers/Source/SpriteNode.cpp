#include "SpriteNode.h"

SpriteNode::SpriteNode()
{
	ptr = NULL;
	sprite = NULL;
	layer = -1;
};

SpriteNode::SpriteNode (Sprite* s, int l, SpriteNode* p)
{
	if (s == NULL && l != -1)
	{
		printf ("Trying to construct a SpriteNode with a null sprite pointer.\n\n");
		return;
	};

	sheet_x = s->get_crop_x() / s->get_frame_w();
	sheet_y = s->get_crop_y() / s->get_frame_h();
	screen_x = s->get_screen_x();
	screen_y = s->get_screen_y();
	frame_w = s->get_frame_w();
	frame_h = s->get_frame_h();
	layer = l;
	sprite = s;
	ptr = p;
};

int SpriteNode::get_sheet_x()
{
	return sheet_x;
};

int SpriteNode::get_sheet_y()
{
	return sheet_y;
};

int SpriteNode::get_crop_x()
{
	return sheet_x * frame_w;
};

int SpriteNode::get_crop_y()
{
	return sheet_y * frame_h;
};

int SpriteNode::get_screen_x()
{
	return screen_x;
};

int SpriteNode::get_screen_y()
{
	return screen_y;
};

int SpriteNode::get_frame_w()
{
	return frame_w;
};

int SpriteNode::get_frame_h()
{
	return frame_h;
};

int SpriteNode::get_layer()
{
	return layer;
};

SpriteNode* SpriteNode::get_ptr()
{
	return ptr;
};

Sprite* SpriteNode::get_sprite()
{
	return sprite;
};

void SpriteNode::select_frame (int x, int y)
{
	sheet_x = x;
	sheet_y = y;
};

void SpriteNode::set_position (int x, int y)
{
	screen_x = x;
	screen_y = y;
};

void SpriteNode::set_size (int w, int h)
{
	frame_w = w;
	frame_h = h;
};

void SpriteNode::set_ptr (SpriteNode* p)
{
	ptr = p;
};

void SpriteNode::set_sprite (Sprite* s)
{
	sprite = s;
};

void SpriteNode::insert_node (Sprite* s, int l)
{
	int s_y = s->get_screen_y() - s->get_frame_h()/2;
	int y = screen_y - frame_h/2;
			
	if (s == NULL)
	{
		printf ("Tried to insert a null sprite pointer to the list.\n");
		return;
	};

	if ((l > layer) || (l == layer) && (s_y >= y))
	{
		if (ptr == NULL)
		{
			ptr = new SpriteNode (s, l, NULL);
		}
		else
		{
			int p_y = ptr->get_screen_y() - ptr->get_frame_h()/2;

			if ((l > ptr->get_layer()) || (l == ptr->get_layer()) && (s_y >= p_y))
			{
				ptr->insert_node (s, l);
			}
			else
			{
				SpriteNode* temp = ptr;
				ptr = new SpriteNode (s, l, temp);
			};
		};
	}
	else
	{
		printf ("Tried to insert a sprite to the list in the wrong order.\n");
	};
};

void SpriteNode::clear()
{
	if (ptr != NULL)
	{
		ptr->clear();
		delete ptr;
		ptr = NULL;
	};
};

void SpriteNode::draw_list (iGraphics* i)
{
	if (ptr != NULL)
	{
		ptr->draw (i);
		ptr->draw_list (i);
	};
};

void SpriteNode::draw (iGraphics* i)
{
	sprite->select_frame (sheet_x, sheet_y);
	sprite->set_position (screen_x, screen_y);

	sprite->draw (i);
};

void SpriteNode::print_node()
{
	if (layer == -1)
		printf ("[L | x, y | w, h]\n[head] -> ");
	else
		printf ("[%d | %d, %d | %d, %d] -> ", layer, screen_x, screen_y+frame_h/2, frame_w, frame_h);


	if (ptr != NULL)
		ptr->print_node();
	else
		printf ("[tail]\n\n");
};

void SpriteNode::print_sprite_file_name()
{
	printf ("%s", sprite->get_path());
};

void SpriteNode::print_node_line()
{
	if (layer == -1)
	{
		printf ("[head]\n");
	}
	else
	{
		int last_backslash = 0;
		int explorer = 0;
		int buffer_i = 0;
		char buffer [40]; // Arbitrário

		for (;;)
		{
			explorer++;
			if (sprite->get_path()[explorer] == '\\')
			{
				last_backslash = explorer;
				continue;
			}
			else if (sprite->get_path()[explorer] == '\0')
			{
				break;
			};
		};

		for (int sprite_i = last_backslash+1; sprite->get_path()[sprite_i] != '\0'; sprite_i++, buffer_i++)
		{
			buffer[buffer_i] = sprite->get_path()[sprite_i];
		};
		buffer[buffer_i] = '\0';


		printf ("[%s] @ Layer %d | %d, %d | %d, %d]\n", buffer, layer, screen_x, screen_y-frame_h/2, frame_w, frame_h);
	};

	if (ptr != NULL)
		ptr->print_node_line();
	else
		printf ("[tail]\n\n");
};