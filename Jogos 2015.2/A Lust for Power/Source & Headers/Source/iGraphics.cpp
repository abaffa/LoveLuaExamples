#include "iGraphics.h"

int iGraphics::invert (int y)
{
	return (SCREEN_HEIGHT - y - 1);
};

void iGraphics::draw_image (Image i)
{
	DrawImage2D (i);
};

void iGraphics::draw_image (int x, int y, int w, int h, Image i)
{
	DrawImage2D (x, invert (y), w, h, i);
};

void iGraphics::draw_image (int x, int y, int w, int h, int cx, int cy, int cw, int ch, Image i)
{
	DrawImage2D (x, invert (y), w, h, cx, cy, cw, ch, i);
};

void iGraphics::draw_point (int x, int y)
{
	DrawPoint2D (x, invert (y));
};

void iGraphics::draw_line (int x1, int y1, int x2, int y2)
{
	DrawLine2D (x1, invert (y1), x2, invert (y2));
};

void iGraphics::draw_circle (int x, int y, int r)
{
	DrawCircle2D (x, invert (y), r);
};

void iGraphics::draw_triangle (int x1, int y1, int x2, int y2, int x3, int y3)
{
	DrawTriangle2D (x1, invert (y1), x2, invert (y2), x3, invert (y3));	
};

void iGraphics::draw_rectangle (int x1, int y1, int x2, int y2)
{
	DrawRectangle2D (x1, invert (y1), x2, invert (y2));
};

void iGraphics::draw_text (int x, int y, const char* c)
{
	DrawText2D (x, invert (y), c);
};

void iGraphics::fill_triangle (int x1, int y1, int x2, int y2, int x3, int y3)
{
	FillTriangle2D (x1, invert (y1), x2, invert (y2), x3, invert (y3));	
};

void iGraphics::fill_rectangle (int x1, int y1, int x2, int y2)
{
	FillRectangle2D (x1, invert (y1), x2, invert (y2));
};

