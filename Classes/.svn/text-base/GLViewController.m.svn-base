//
//  GLViewController.h
//  Texture
//
//  Created by jeff on 5/23/09.
//  Copyright Jeff LaMarche 2009. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <tgmath.h>

#import "GLViewController.h"
#import "GLView.h"
#import "OpenGLCommon.h"
#import "ConstantsAndMacros.h"
#import "Globals.h"
#import "GameLogic.h"
#import "MapBlocks.h"
#import "MapChunks.h"
#import "Terrain.h"
#import "Player.h"

@implementation GLViewController
@synthesize dPad;
@synthesize terrainTex;

- (void)drawView:(GLView*)view
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glEnableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_NORMAL_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);

	//Apply the camera transformation to the scene
	[[player camera] apply];
    
	glEnable(GL_CULL_FACE);
	glEnable(GL_FOG);
	glEnable(GL_DEPTH_TEST);
	glFogf(GL_FOG_MODE, GL_LINEAR);
	glFogf(GL_FOG_START, 50.0f);
	glFogf(GL_FOG_END, 60.0f);
	static const GLfloat fogColor[] = {.686f, .843f, 1.f, 1.f};
	glFogfv(GL_FOG_COLOR, (const GLfloat *)fogColor);
	
	glDisable(GL_BLEND);
	glDisable(GL_LIGHTING);
	glColor4f(1.f, 1.f, 1.f, 1.f);
	//translate to make up for vertex offsets
	//(since we specify them in bytes ranging from [-128, 127], instead of [0-255]
	glTranslatef(128.f, 128.f, 128.f); 
	
	//adjust the texture matrix because we're using bytes [-128, 127] instead of [0.0-1.0]
	glMatrixMode(GL_TEXTURE);
	glLoadIdentity();
	glScalef(1.f/256.f, 1.f/256.f, 1./256.f);
	glTranslatef(128.f, 128.f, 128.f);
	glMatrixMode(GL_MODELVIEW);

	//draw the wooorrllld
	[terrainTex bind];
	renderWorld();
	
	//translate back to normal world coordinates
	glTranslatef(-128.f, -128.f, -128.f);
	
	//adjust the texture matrix because we're back to using floats
	glMatrixMode(GL_TEXTURE);
	glLoadIdentity();
	glMatrixMode(GL_MODELVIEW);
	
	
	//setup cloud drawing
	glDisable(GL_FOG);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	
	//draw the clouds
	static const Vertex3D cloudVerts[] = {
        { 1024.f, 1024.f,196.f},
		{ 1024.f,-1024.f,196.f},
		{-1024.f, 1024.f,196.f},
		{-1024.f,-1024.f,196.f}
    };
    static GLfloat cloudTexCoords[8];
	GLfloat curtime = fmod(CACurrentMediaTime()/1000, 2.f);
	cloudTexCoords[0] = curtime + 0.25f; cloudTexCoords[1] = curtime + 0.25f;
	cloudTexCoords[2] = curtime + 0.25f; cloudTexCoords[3] = curtime;
	cloudTexCoords[4] = curtime; cloudTexCoords[5] = curtime + 0.25f;
	cloudTexCoords[6] = curtime; cloudTexCoords[7] = curtime;
	
	[cloudTex bind];
    glVertexPointer(3, GL_FLOAT, 0, cloudVerts);
    glTexCoordPointer(2, GL_FLOAT, 0, cloudTexCoords);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
	
	//draw the selected block
	glDisable(GL_TEXTURE_2D);
	glColor4f(1.f, 1.f, 1.f, 1.f);
	Vertex3D selectedBlock = [[player camera] selectedBlock];
	static Vertex3D blockVerts[8];
	static const GLubyte idx[] = { 0, 1, 1, 2, 2, 3, 3, 0, 0, 4, 1, 5, 2, 6, 3, 7, 4, 5, 5, 6, 6, 7, 7, 4 };
	static const GLubyte tridx[] = {
		2, 1, 0, 0, 3, 2, // bottom
		4, 5, 6, 6, 7, 4, // top
		0, 1, 5, 5, 4, 0, // front
		2, 3, 7, 7, 6, 2, // back
		0, 4, 7, 7, 3, 0, //left
		5, 1, 2, 2, 6, 5 //right
	};
		
	
	if( selectedBlock.x >= 0.f && selectedBlock.y >= 0.f && selectedBlock.z >= 0.f){
		//bottom
		blockVerts[0] = Vertex3DMake(selectedBlock.x - .01f, selectedBlock.y - .01f, selectedBlock.z - .01f);
		blockVerts[1] = Vertex3DMake(selectedBlock.x + 1.01f, selectedBlock.y - .01f, selectedBlock.z - .01f);
		blockVerts[2] = Vertex3DMake(selectedBlock.x + 1.01f, selectedBlock.y + 1.01f, selectedBlock.z - .01f);
		blockVerts[3] = Vertex3DMake(selectedBlock.x - .01f, selectedBlock.y + 1.01f, selectedBlock.z - .01f);
		//top
		blockVerts[4] = Vertex3DMake(selectedBlock.x - .01f, selectedBlock.y - .01f, selectedBlock.z + 1.01f);
		blockVerts[5] = Vertex3DMake(selectedBlock.x + 1.01f, selectedBlock.y - .01f, selectedBlock.z + 1.01f);
		blockVerts[6] = Vertex3DMake(selectedBlock.x + 1.01f, selectedBlock.y + 1.01f, selectedBlock.z + 1.01f);
		blockVerts[7] = Vertex3DMake(selectedBlock.x - .01f, selectedBlock.y + 1.01f, selectedBlock.z + 1.01f);
		//render the cube outline
		glDisableClientState(GL_TEXTURE_COORD_ARRAY);
		glVertexPointer(3, GL_FLOAT, 0, blockVerts);
		glDrawElements(GL_LINES, 24, GL_UNSIGNED_BYTE, idx);
		
		//render an alpha layer
		glColor4f(1.f, 1.f, 1.f, 0.25f);
		glDrawElements(GL_TRIANGLES, 36, GL_UNSIGNED_BYTE, tridx);
	}
	
	// setup GUI rendering
	glMatrixMode(GL_PROJECTION);
	glPushMatrix();
	glLoadIdentity();
	glOrthof(0, view.bounds.size.width, view.bounds.size.height, 0, -1, 1);	//flip coordinate system to match iPhone
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	glDisable(GL_CULL_FACE);
	glDisable(GL_DEPTH_TEST);
	glEnable(GL_TEXTURE_2D);
	glEnable(GL_BLEND);
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	
	if (!isOverheadDisplayed){
		
		//draw UI here.
		static const Vertex3D dPadVertices[] = {
			{ 160.0, 160.0, 0.0},
			{ 160.0,  0.0, 0.0},
			{ 0.0,  160.0, 0.0},
			{ 0.0, 0.0, 0.0}
		};
		static const GLfloat dPadTexCoords[] = {
			0.8125, 0.8125,
			0.8125, 0.1875,
			0.1875, 0.8125,
			0.1875, 0.1875
		};
		
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);
		glColor4f(1.f, 1.f, 1.f, 1.f);
		
		[dPad bind];
		glVertexPointer(3, GL_FLOAT, 0, dPadVertices);
		glTexCoordPointer(2, GL_FLOAT, 0, dPadTexCoords);
		glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	}
    
	//change state to stop rendering GUI
	glMatrixMode(GL_PROJECTION);
	glPopMatrix();
	glMatrixMode(GL_MODELVIEW);
	
    glDisableClientState(GL_VERTEX_ARRAY);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
}

-(void)setupView:(GLView*)view
{
	// Create the global player
	player = [[Player alloc] init];
	
	// Initialize the camera
	[[player camera] setPerspective: view.bounds];
	
	// Load the textures
	dPad = [[GLTexture alloc] initWithTextureName:@"controls" andType:@"png"];
	terrainTex = [[GLTexture alloc] initWithTextureName:@"terrain" andType:@"png"];
	cloudTex = [[GLTexture alloc] initWithTextureName:@"clouds" andType:@"png"];
	
	// Build the arrays
	[Terrain newTerrains];
	[MapBlocks newBlocks];
	[MapChunks newChunks];
	
	// Set the sky color
	glClearColor(.686f, .843f, 1.f, 1.f);
	
	//prelim data for reading from disk
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"savedGame.plist"];
	NSFileManager* fileManager = [NSFileManager defaultManager];
	
	//if we're loading from disk, DO IT
	if(shouldLoadFromDisk && [fileManager isReadableFileAtPath:path]){
		//create dictionary from file
		NSDictionary* saveDict = [NSDictionary dictionaryWithContentsOfFile: path];
		
		//grab data from dictionary
		NSData* mapData = [saveDict objectForKey:@"mapData"];
		NSNumber* playerX = [saveDict objectForKey:@"playerX"];
		NSNumber* playerY = [saveDict objectForKey:@"playerY"];
		NSNumber* playerZ = [saveDict objectForKey:@"playerZ"];
		
		//write data to game state
		//PLAYER
		Vector3D savedPlayerPos = {[playerX floatValue], [playerY floatValue], [playerZ floatValue]};
		[player setPosition:savedPlayerPos];
		//MAP
		uint8_t* map = (uint8_t*)[mapData bytes];
		for(int i=0; i < MAP_TOTAL_BLOCKS; i++){
			blocks[i] = map[i];
		}
		
	}
	//otherwise we just generate random blocks
	else{
		// Generate random blocks
		randomizeBlocks();
	}
}
- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning]; 
}

- (void)dealloc 
{
	[dPad release];
	[terrainTex release];
	[cloudTex release];
    [super dealloc];
} 


@end
