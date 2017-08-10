#include <GLUT/glut.h>


#define width 512
#define height 512
#define size width*height

void update(GLuint*,GLuint*) __attribute__ ((regparm(2)));

GLuint bitmap[size];
GLuint sbitmap[size];

void display(void) {
	glDrawPixels(width,height,GL_RGBA,GL_UNSIGNED_BYTE,(GLvoid*)bitmap);
    glutSwapBuffers();
}

void tick() {
	update(bitmap,sbitmap);
	update(sbitmap,bitmap);
	glutPostRedisplay();
}

void reshape (int w, int h) {
    glViewport (0, 0, (GLsizei)w, (GLsizei)h);
    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();
    gluOrtho2D(0,(float)w,0,(float)h);
    glMatrixMode (GL_MODELVIEW);
}

void mouse(int button, int state, int x, int y) {
	static int ox;
	static int oy;
	int i;
	int j;
	if (button == GLUT_LEFT_BUTTON && state == GLUT_DOWN) {
		ox = x;
		oy = y;
	} else if(button == GLUT_LEFT_BUTTON && state == GLUT_UP) {
		oy = height - oy;
		y = height - y;
		for(i = y ; i <= oy ; i++) {
			for(j = ox ; j <= x ; j++) {
				sbitmap[j+(i*width)] = bitmap[j+(i*width)] = 0xFF0000;
            }
		}
	}
}

int main (int argc, char **argv) {
    for (int i = 0 ; i < size ; i++) {
        GLuint x = (i^(i*i));
        // "random" initialization
        bitmap[i] = sbitmap[i] = x*((x % (i*7+1))%(134221) == 2);
    }
    glutInit (&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE|GLUT_RGBA);
    glutInitWindowSize (width, height);
    glutInitWindowPosition (100, 100);
    glutCreateWindow ("Means");
    glutDisplayFunc (display);
    glutReshapeFunc (reshape);
	glutIdleFunc(tick);
	glutMouseFunc(mouse);
    glutMainLoop();
    return 0;
}

