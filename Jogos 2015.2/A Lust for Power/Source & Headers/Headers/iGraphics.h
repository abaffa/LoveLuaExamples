#ifndef __iGraphics__
#define __iGraphics__
#include "Graphics.h"
#include "Defines.h" // Só precisa ter #define SCREEN_HEIGHT número
// (Ou esse #define pode estar aqui mesmo, sem #incluir o "Defines.h".)

class iGraphics : public Graphics
{
public:

	int invert (int y);

	void draw_image (Image i);
	void draw_image (int x, int y, int w, int h, Image i);
	void draw_image (int x, int y, int w, int h, int cx, int cy, int cw, int ch, Image i);

	void draw_point (int x, int y);
	void draw_line (int x1, int y1, int x2, int y2);
	void draw_circle (int x, int y, int r);
	void draw_triangle (int x1, int y1, int x2, int y2, int x3, int y3);
	void draw_rectangle (int x1, int y1, int x2, int y2);
	void draw_text (int x, int y, const char* c);
	
	void fill_circle (int x, int y, int r);
	void fill_triangle (int x1, int y1, int x2, int y2, int x3, int y3);
	void fill_rectangle (int x1, int y1, int x2, int y2);
};

#endif