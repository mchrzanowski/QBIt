//
//  MapBlocks.h
//  Texture
//
//  Created by scholar on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <stdint.h>
#import "OpenGLCommon.h"

#define MAP_BLOCK_WIDTH (128)
#define MAP_BLOCK_HEIGHT (128)
#define MAP_BLOCK_DEPTH (128)
#define MAP_TOTAL_BLOCKS (MAP_BLOCK_WIDTH * MAP_BLOCK_HEIGHT * MAP_BLOCK_DEPTH)

@interface MapBlocks : NSObject
{
}
+(void) newBlocks;
@end

extern uint8_t* blocks;

typedef enum BLOCK_TYPE{
	EMPTY = 0,
	GRASS,
	DIRT,
	STONE,
	BARK,
	LEAVES,
	SAND,
	GRAVEL,
	COBBLESTONE,
	WOOD,
	BRICK,
	GOLDORE,
	PAVESTONE,
	IVY,
	REDCLOTH,
	STEEL,
	GOLD,
	DIAMOND,
	ORANGECLOTH,
	YELLOWCLOTH,
	GREENCLOTH,
	TEALCLOTH,
	LIMECLOTH,
	AQUACLOTH,
	SKYCLOTH,
	DARKBLUECLOTH,
	PURPLECLOTH,
	VIOLETCLOTH,
	MAGENTACLOTH,
	BLACKCLOTH,
	GREYCLOTH,
	WHITECLOTH,
	BLOCK_TYPES
} BLOCK_TYPE;

//block checkers
BOOL isValidBlock(int x, int y, int z);

//hopefully a fast accessor for blocks
uint8_t getBlock(int x, int y, int z);

//hopefully a fast setter for blocks
void setBlock(uint8_t val, int x, int y, int z);

//block changer sets the chunk's change bit
void changeBlock(uint8_t val, int x, int y, int z);

float lerp(float t, float begin, float end);

void makeSphereOfType(uint8_t blockType, int x, int y, int z, int radius, BOOL overwrite);
void randomizeBlocks();

Vertex3D raytrace(Vector3D raypos, Vector3D raydir);
void raytrace2(Vector3D raypos, Vector3D raydir, Vector3D* selected, Vector3D* neighbor);