#ifndef SaveStateCPP
#define SaveStateCPP

#include "SaveState.h"

SaveState::SaveState()
{
	load_file();
};

//void save_file();


void SaveState::load_file()
{
	FILE * pFile;
	char line_buffer[100];
	int size = 18;
	file_good = false;
	
	char save_file_path[FILE_PATH_SIZE];
	cat_path (save_file_path, SH, "Files/SaveFile.txt");
	
	/*strcpy_s(save_file_path, PROJECT_PATH);
	strcat_s(save_file_path, SH);
	strcat_s(save_file_path, "SaveFile.txt");*/

	fopen_s (&pFile, save_file_path , "r");
	
	if (pFile == NULL) printf("Error opening save file\n");
	else 
	{
		file_good = true;

		if (fgets(line_buffer, size, pFile) != NULL)
		{
			for (int i = 0; i < 6; i++)
			{
				temples[i] = line_buffer[i] == '1' ? true : false;
			};
		};

		if (!(forest() && fire() && water() && spirit() && shadow()))
		{
			temples[5] = false; // Se não passou dos primeiros 5 templos, o da Luz não pode ter sido passado.
			phase=0;
		}
		else
		{
			if (!light())
				phase=1;
			else
				phase=2;
		};

		//printf ("Loading save file... Phase = %d\n\n", phase);
		
		if (fgets(line_buffer, size, pFile) != NULL)
		{
			for (int i = 0; i < 17; i++)
			{
				heart_container[i] = line_buffer[i] == '1' ? true : false;
			};
		};
	
		fgets (line_buffer , size, pFile);
		
		if (fgets (line_buffer , size , pFile) != NULL) hearts = atof(line_buffer);
		
		if (fgets (line_buffer , size, pFile) != NULL) mp = atof(line_buffer);
		
		if (fgets (line_buffer , size, pFile) != NULL) max_mp = atof(line_buffer);

		if (fgets(line_buffer, size, pFile) != NULL) max_stamina = atof(line_buffer);

		if (fgets (line_buffer , size, pFile) != NULL) rupees = atoi(line_buffer);

		if (fgets(line_buffer, size, pFile) != NULL)
		{
			for (int i = 0; i < 3; i++)
			{
				spell[i] = line_buffer[i] == '1' ? true : false;
			};
		};

		if (fgets(line_buffer, size, pFile) != NULL)
		{
			for (int i = 0; i < 7; i++)
			{
				easter_egg[i] = line_buffer[i] == '1' ? true : false;
			};
		};
		
		
		fclose (pFile);
	};
	
};

bool SaveState::get_temple(int t)		{ return temples[t];		};
float SaveState::get_hearts()			{ return hearts;			};
float SaveState::get_mp()				{ return mp;				};
float SaveState::get_max_mp()			{ return max_mp;			};
float SaveState::get_max_stamina()		{ return max_stamina;		};
int SaveState::get_rupees()				{ return rupees;			};

int SaveState::get_phase()
{
	return phase;
};

void SaveState::tweak_phase()
{
	switch (phase)
	{
		case 0: case 1: phase++; break;
		case 2: phase = 0; break;
	};
	
	temples[5] = (phase==2) ? true : false;
};

bool SaveState::forest()				{ return (temples[0]); };
bool SaveState::fire()					{ return (temples[1]); };
bool SaveState::water()					{ return (temples[2]); };
bool SaveState::spirit()				{ return (temples[3]); };
bool SaveState::shadow()				{ return (temples[4]); };
bool SaveState::light()					{ return (temples[5]); };

void SaveState::tweak_temple (int i)
{
	temples[i] = !temples[i];

	if (light())
		phase = 2;

	if (!light())
		phase = 1;

	if (! (forest() && fire() && water() && spirit() && shadow() ))
	{
		phase = 0;
		temples[5] = false;
	};

};

bool SaveState::get_easter_egg (int i)
{
	return easter_egg[i];
};

void SaveState::set_easter_egg (int i, bool b)
{
	easter_egg[i] = b;
};

void SaveState::tweak_easter_egg (int i)
{
	easter_egg[i] = !easter_egg[i];
};

int SaveState::get_heart_containers()
{
	int n = 3;
	for (int i=0; i<17; i++)
	{
		heart_container[i] == true ? n++ : 0;
	};

	return n;
};

void pt(bool c) { c ? printf("\t") : 0; };

void SaveState::print_table()
{
	if (file_good)
	{
		bool c = true;

		printf("\n\n");
		//printf("0\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\t11\t12\t13\t14\t15\n");
		pt(c); printf("Hearts:\t\t%5.2f\t/% 4d\n",get_hearts(), get_heart_containers());
		pt(c); printf("Mana:\t\t%5.2f\t/ % 4.2f\n",get_mp(), get_max_mp());
		pt(c); printf("Stamina:\txx.xx\t/ % 4.2f\n",get_max_stamina());
		pt(c); printf("Rupees:\t\t%2d\t/% 4d\n\n\n",get_rupees(), MAX_RUPEES);

		pt(c); printf("Temple\t\tCleared\t\tHearts\t\tEaster Egg\tSpell\n");
		pt(c); printf("---------------------------------------------------------------------------------\n");
		pt(c); printf("Forest\t\t%d\t\t[%d, %d, %d]\t%d\t\t%d (Farore's Wind)\n",
			forest(),
			heart_container[0],heart_container[1],heart_container[2],
			easter_egg[0],spell[0]);

		pt(c); printf("Fire\t\t%d\t\t[%d, %d, %d]\t%d\t\t%d (Din's Fire)\n",
			fire(),
			heart_container[3],heart_container[4],heart_container[5],
			easter_egg[1],spell[1]);

		pt(c); printf("Water\t\t%d\t\t[%d, %d, %d]\t%d\t\t%d (Nayru's Love)\n",
			water(),
			heart_container[6],heart_container[7],heart_container[8],
			easter_egg[2],spell[2]);

		pt(c); printf("Spirit\t\t%d\t\t[%d, %d, %d]\t%d\n",spirit(),
			heart_container[9],heart_container[10],heart_container[11],
			easter_egg[3],spell[0]);

		pt(c); printf("Shadow\t\t%d\t\t[%d, %d, %d]\t%d\n",shadow(),
			heart_container[12],heart_container[13],heart_container[14],
			easter_egg[4],spell[0]);

		pt(c); printf("Light\t\t%d\t\t[-------]\t%d\n",light(),
			easter_egg[5],spell[0]);

		pt(c); printf("Heart containers from Merchant:\t[%d  ,  %d]\n",
			heart_container[15], heart_container[16]);

		pt(c); printf("Hero's easter egg:\t\t\t\t%d\n",easter_egg[6]);

		printf("\n\n");
	};
};


void SaveState::graphics_print_table (Graphics g) // Corrigir todas as tabulações e quebras de linha
{
	if (file_good)
	{
		bool c = true;
		int x[64];
		int y = 650;
		int h = 28;

		for (int i=0; i<64; i++)
			x[i]=8*i+50;
		
		g.SetTextFont ("Consolas", 16, FONT_WEIGHT_NORMAL, false, false);

		g.DrawText2D (x[0],y,"Hearts:");
		g.DrawText2D (x[6],y,"%5.2f/",get_hearts());
		g.DrawText2D (x[9],y,"%d",get_heart_containers());		
		y-= h;

		g.DrawText2D (x[0],y,"Mana:\t\t%5.2f\t/  %.2f\n",get_mp(), get_max_mp()); y-= h;
		g.DrawText2D (x[0],y,"Stamina:\txx.xx\t/  %.2f\n",get_max_stamina()); y-= h;
		g.DrawText2D (x[0],y,"Rupees:\t\t%2d\t/  %d\n\n\n",get_rupees(), MAX_RUPEES); y-= 2*h;

		g.DrawText2D (x[0],y,"Temple\t\tCleared\t\tHearts\t\tEaster Egg\tSpell\n"); y-= h;
		g.DrawText2D (x[0],y,"---------------------------------------------------------------------------------\n"); y-= h;
		g.DrawText2D (x[0],y,"Forest\t\t%d\t\t[%d, %d, %d]\t%d\t\t%d (Farore's Wind)\n",
			forest(),
			heart_container[0],heart_container[1],heart_container[2],
			easter_egg[0],spell[0]); y-= h;

		g.DrawText2D (x[0],y,"Fire\t\t%d\t\t[%d, %d, %d]\t%d\t\t%d (Din's Fire)\n",
			fire(),
			heart_container[3],heart_container[4],heart_container[5],
			easter_egg[1],spell[1]); y-= h;

		g.DrawText2D (x[0],y,"Water\t\t%d\t\t[%d, %d, %d]\t%d\t\t%d (Nayru's Love)\n",
			water(),
			heart_container[6],heart_container[7],heart_container[8],
			easter_egg[2],spell[2]); y-= h;

		g.DrawText2D (x[0],y,"Spirit\t\t%d\t\t[%d, %d, %d]\t%d\n",spirit(),
			heart_container[9],heart_container[10],heart_container[11],
			easter_egg[3],spell[0]); y-= h;

		g.DrawText2D (x[0],y,"Shadow\t\t%d\t\t[%d, %d, %d]\t%d\n",shadow(),
			heart_container[12],heart_container[13],heart_container[14],
			easter_egg[4],spell[0]); y-= h;

		g.DrawText2D (x[0],y,"Light\t\t%d\t\t[-------]\t%d\n",light(),
			easter_egg[5],spell[0]); y-= h;

		g.DrawText2D (x[0],y,"Heart containers from Merchant:\t[%d  ,  %d]\n",
			heart_container[15], heart_container[16]); y-= h;

		g.DrawText2D (x[0],y,"Hero's easter egg:\t\t\t\t%d\n",easter_egg[6]); y-= h;
	

		g.DrawText2D (x[0],y,"\n\n"); y-= h;
	};
};

void SaveState::alter_hearts (float h)
{
	if (hearts + h >= get_heart_containers())
		hearts = get_heart_containers();
	else if (hearts + h <= 0.0f)
		hearts = 0.0f;
	else
		hearts += h;
};

void SaveState::set_hearts (float h)
{
	hearts = h;
};

void SaveState::alter_rupees (int r)
{
	if (rupees+r >= 0 && rupees+r <= MAX_RUPEES)
		rupees += r;
	else if (rupees+r < 0)
		rupees = 0;
	else if (rupees+r > MAX_RUPEES)
		rupees = MAX_RUPEES;
};


#endif