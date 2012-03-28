//
//  MapBlocks.m
//  Texture
//
//  Created by scholar on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapBlocks.h"
#import "MapChunks.h"

uint8_t* blocks;

@implementation MapBlocks

+(void) newBlocks{
	blocks = malloc( sizeof(uint8_t) * MAP_TOTAL_BLOCKS );
}

@end

//block checkers
inline BOOL isValidBlock(int x, int y, int z){
	return (x >= 0 && x < MAP_BLOCK_WIDTH && 
			y >= 0 && y < MAP_BLOCK_HEIGHT &&
			z >= 0 && z < MAP_BLOCK_DEPTH);
}

//hopefully a fast accessor for blocks
inline uint8_t getBlock(int x, int y, int z){
	return blocks[(z*MAP_BLOCK_WIDTH*MAP_BLOCK_HEIGHT)+(y*MAP_BLOCK_WIDTH)+x];
}

//hopefully a fast setter for blocks
inline void setBlock(uint8_t val, int x, int y, int z){
	blocks[z*(MAP_BLOCK_WIDTH*MAP_BLOCK_HEIGHT)+y*MAP_BLOCK_WIDTH+x] = val;
}

//block changer sets the chunk's change bit
inline void changeBlock(uint8_t val, int x, int y, int z){
	setBlock(val, x, y, z);
	int cx = x / CHUNK_WIDTH; int cy = y / CHUNK_HEIGHT; int cz = z / CHUNK_DEPTH;
	MapChunk* chunk = getChunk(cx, cy, cz);
	chunk->changed = YES;
	//x neighbors
	if( x%CHUNK_WIDTH == 0 && isValidChunk(cx-1, cy, cz) ){
		chunk = getChunk(cx - 1, cy, cz);
		chunk->changed = YES;
	}
	else if( x%CHUNK_WIDTH == CHUNK_WIDTH-1 && isValidChunk(cx+1, cy, cz) ){
		chunk = getChunk(cx + 1, cy, cz);
		chunk->changed = YES;
	}
	//y neighbors
	if( y%CHUNK_HEIGHT == 0 && isValidChunk(cx, cy-1, cz) ){
		chunk = getChunk(cx, cy - 1, cz);
		chunk->changed = YES;
	}
	else if( y%CHUNK_HEIGHT == CHUNK_HEIGHT-1 && isValidChunk(cx, cy+1, cz) ){
		chunk = getChunk(cx, cy + 1, cz);
		chunk->changed = YES;
	}
	//z neighbors
	if( z%CHUNK_DEPTH == 0 && isValidChunk(cx, cy, cz-1) ){
		chunk = getChunk(cx, cy, cz - 1);
		chunk->changed = YES;
	}
	else if( z%CHUNK_DEPTH == CHUNK_DEPTH-1 && isValidChunk(cx, cy, cz+1) ){
		chunk = getChunk(cx, cy, cz + 1);
		chunk->changed = YES;
	}
}

// t begin: 0.0, t end: 1.0
inline float lerp(float t, float begin, float end){
	return (1.0f - t)*begin + t*end;
}

void inline makeSphereOfType(uint8_t blockType, int cx, int cy, int cz, int radius, BOOL overwrite){
	for(int z = cz - radius; z < cz + radius; z++)
		for(int y = cy - radius; y < cy + radius; y++)
			for(int x = cx - radius; x < cx + radius; x++)
				if( isValidBlock(x, y, z) && (overwrite || !getBlock(x, y, z)) ){
					//if block is valid and empty, set it with type
					if( (x-cx)*(x-cx) + (y-cy)*(y-cy) + (z-cz)*(z-cz) < radius*radius)
						setBlock(blockType, x, y, z);
				}
}

void randomizeBlocks(){
	srandom(time(NULL));
#define RNG_CHUNKS (MAP_BLOCK_HEIGHT-1)
#define RNG_BLOCKS (RNG_CHUNKS-1)
	
	//set some random values for the chunk height
	for(int y = 0; y <= CHUNKS_HEIGHT; y++)
		for(int x = 0; x <= CHUNKS_WIDTH; x++){
			setBlock( 56 + (random() % 16), x, y, RNG_CHUNKS);
		}
	
	//average out the random chunk heights
	for(int y = 0; y <= CHUNKS_HEIGHT; y++)
		for(int x = 0; x <= CHUNKS_WIDTH; x++){
			int contributors = 1;
			int average = getBlock(x, y, RNG_CHUNKS);
			if( isValidChunk(x-1, y, 0) ){
				++contributors;
				average += getBlock(x-1, y, RNG_CHUNKS);
			}
			if( isValidChunk(x+1, y, 0) ){
				++contributors;
				average += getBlock(x+1, y, RNG_CHUNKS);
			}
			if( isValidChunk(x, y-1, 0) ){
				++contributors;
				average += getBlock(x, y-1, RNG_CHUNKS);
			}
			if( isValidChunk(x, y+1, 0) ){
				++contributors;
				average += getBlock(x, y+1, RNG_CHUNKS);
			}
			average /= contributors;
			setBlock(average, x, y, RNG_CHUNKS);
		}
	
	//lerping!
	//fill in block heights using chunk heights
	for(int y = 0; y<MAP_BLOCK_HEIGHT; y++)
		for(int x = 0; x<MAP_BLOCK_WIDTH; x++){
			int bottomLeft = getBlock(x/CHUNK_WIDTH, y/CHUNK_HEIGHT, RNG_CHUNKS);
			int bottomRight = getBlock((x/CHUNK_WIDTH)+1, y/CHUNK_HEIGHT, RNG_CHUNKS);
			int topLeft = getBlock(x/CHUNK_WIDTH, (y/CHUNK_HEIGHT)+1, RNG_CHUNKS);
			int topRight = getBlock((x/CHUNK_WIDTH)+1, (y/CHUNK_HEIGHT)+1, RNG_CHUNKS);
			
			int left = y/CHUNK_HEIGHT;
			int leftB = left*CHUNK_HEIGHT;
			int leftX = x/CHUNK_WIDTH;
			int leftXB = leftX*CHUNK_WIDTH;
			float heightT = (float)(y-leftB)/(float)(CHUNK_HEIGHT);
			float widthT = (float)(x-leftXB)/(float)(CHUNK_WIDTH);
			float leftHeight = lerp( heightT, bottomLeft, topLeft );
			float rightHeight = lerp( heightT, bottomRight, topRight );
			int lerpedHeight = lroundf(lerp( widthT, leftHeight, rightHeight));
			//store height of this location for future reference
			setBlock(lerpedHeight, x, y, RNG_BLOCKS);
			//make stone
#define SOIL_THICKNESS 2
			for(int z = 0; z<lerpedHeight-SOIL_THICKNESS; z++){
				setBlock(STONE, x, y, z); //STONE
			}
			//make dirt
			for(int z = lerpedHeight-SOIL_THICKNESS; z<lerpedHeight; z++){
				setBlock(DIRT, x, y, z); //DIRT
			}
			//make grass
			setBlock(GRASS, x, y, lerpedHeight); //GRASS
		}
	
	//make some tree trunks
#define TREES 25
#define TREE_TRUNK_HEIGHT 4
	for(int i=0; i<TREES; i++){
		int height = random() % TREE_TRUNK_HEIGHT + 4;
		int x = random() % MAP_BLOCK_WIDTH;
		int y = random() % MAP_BLOCK_HEIGHT;
		int zStart = 1+getBlock(x, y, RNG_BLOCKS);
		for(int z = zStart; z <= zStart + height; z++){
			setBlock(BARK, x, y, z); //BARK
		}
		int z = zStart + height;
		makeSphereOfType(LEAVES, x, y, z, height/2, NO); //LEAVES
		
	}
	
	//place some ore deposits
#define ORES 1000
	for(int i=0; i<ORES; i++){
		int z = random() % 54;
		int x = random() % MAP_BLOCK_WIDTH;
		int y = random() % MAP_BLOCK_HEIGHT;
		int radius = 1 + random() % 3;
		makeSphereOfType(GOLDORE, x, y, z, radius, YES);
	}
	
	//empty out our old storage
	//set some random values for the chunk height
	for(int y = 0; y <= CHUNKS_HEIGHT; y++)
		for(int x = 0; x <= CHUNKS_WIDTH; x++){
			setBlock( 0, x, y, RNG_CHUNKS);
		}
	for(int y = 0; y <= MAP_BLOCK_HEIGHT; y++)
		for(int x = 0; x <= MAP_BLOCK_WIDTH; x++){
			setBlock(0, x, y, RNG_BLOCKS);
		}
	
#undef RNG_CHUNKS
#undef RNG_BLOCKS
#undef SOIL_THICKNESS
#undef TREES
#undef TREE_TRUNK_HEIGHT
}

//THIS SHIT IS BROKE. DON'T USE IT IF YOU CAN HELP IT.
Vertex3D raytrace(Vector3D raypos, Vector3D raydir){
	NSLog(@"Ray position: %f, %f, %f", raypos.x, raypos.y, raypos.z);
	NSLog(@"Ray direction: %f, %f, %f", raydir.x, raydir.y, raydir.z);
	const float MAX_DIST = 20.f;
	
	//initialization
	int X = raypos.x; int STARTX = X;
	int Y = raypos.y; int STARTY = Y;
	int Z = raypos.z; int STARTZ = Z;
	
	if(getBlock(X, Y, Z)){
		//WE HIT SOMETHING!
		NSLog(@"Selected block x:%d, y:%d, z:%d", X, Y, Z);
		return Vertex3DMake(X, Y, Z);
	}
	
	Vector3D tDelta = {0.f, 0.f, 0.f};
	Vector3D tMax = {0.f, 0.f, 0.f};
	int stepX = 1; int stepY = 1; int stepZ = 1;
	int justOutX = MAP_BLOCK_WIDTH; int justOutY = MAP_BLOCK_HEIGHT; int justOutZ = MAP_BLOCK_DEPTH;
	
	if(raydir.x < 0.f){
		tDelta.x = -1.f/raydir.x;
		tMax.x = (raypos.x - X) / raydir.x;
		stepX = -1; justOutX = -1;
	}
	else if(raydir.x > 0.f)
		tDelta.x = 1.f/raydir.x;
		tMax.x = (X + 1 - raypos.x) / raydir.x;
	if(raydir.y < 0.f){
		tDelta.y = -1.f/raydir.y;
		tMax.y = (raypos.y - Y ) / raydir.y;
		stepY = -1; justOutY = -1;
	}
	else if(raydir.y > 0.f)
		tDelta.y = 1.f/raydir.y;
		tMax.y = (Y + 1 - raypos.y) / raydir.y;
	if(raydir.z < 0.f){
		tDelta.z = -1.f/raydir.z;
		tMax.z = (raypos.z - Z) / raydir.z;
		stepZ = -1; justOutZ = -1;
	}
	else if(raydir.z > 0.f)
		tDelta.z = 1.f/raydir.z;
		tMax.z = (Z + 1 - raypos.z) / raydir.z;
	
	//iteration
	float distSquared = 0.f;
	do {
		NSLog(@"Traversing block x:%d, y:%d, z:%d", X, Y, Z);
		if(tMax.x < tMax.y) {
			if(tMax.x < tMax.z) {
				X += stepX;
				if(X == justOutX)
					return Vertex3DMake(-1, -1, -1); /* outside grid */
				tMax.x += tDelta.x;
			} else {
				Z += stepZ;
				if(Z == justOutZ)
					return Vertex3DMake(-1, -1, -1);
				tMax.z += tDelta.z;
			}
		} else {
			if(tMax.y < tMax.z) {
				Y += stepY;
				if(Y == justOutY)
					return Vertex3DMake(-1, -1, -1);
				tMax.y += tDelta.y;
			} else {
				Z += stepZ;
				if(Z == justOutZ)
					return Vertex3DMake(-1, -1, -1);
				tMax.z += tDelta.z;
			}
		}
		if(getBlock(X, Y, Z)){
			//WE HIT SOMETHING!
			NSLog(@"Selected block x:%d, y:%d, z:%d", X, Y, Z);
			return Vertex3DMake(X, Y, Z);
		}
		distSquared = (X - STARTX)*(X - STARTX) + (Y - STARTY)*(Y - STARTY) + (Z-STARTZ)*(Z-STARTZ);
		NSLog(@"Distance squared: %f", distSquared);
	} while(distSquared < MAX_DIST);
	return Vertex3DMake(-1, -1, -1); //didn't hit anything
}

void raytrace2(Vector3D raypos, Vector3D raydir, Vector3D* selected, Vector3D* neighbor){
	const float maxT = 6.f;
	float t = 0.f;
	int px = raypos.x, py = raypos.y, pz = raypos.z;
	int x=0, y=0, z=0;
	for(int i=0; i<600; i++){
		t = maxT * (((float)i)/600.f);
		px = x; py = y; pz = z;
		x = (int)(raypos.x + t * raydir.x);
		y = (int)(raypos.y + t * raydir.y);
		z = (int)(raypos.z + t * raydir.z);
		//NSLog(@"Traversing block x:%d, y:%d, z:%d with t:%f", x, y, z, t);
		if(isValidBlock(x, y, z) && getBlock(x, y, z)){
			//NSLog(@"Selected block x:%d, y:%d, z:%d", x, y, z);
			selected->x = x; selected->y = y; selected->z = z;
			neighbor->x = px; neighbor->y = py; neighbor->z = pz;
			return;
		}
	}
	selected->x = -1; selected->y = -1; selected->z = -1;
	neighbor->x = -1; neighbor->y = -1; neighbor->z = -1;
	return;
}
