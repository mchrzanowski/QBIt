//
//  MapChunks.h
//  Texture
//
//  Created by scholar on 4/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapBlocks.h"
#import "Mesh.h"

#define CHUNK_WIDTH (16)
#define CHUNK_HEIGHT (16)
#define CHUNK_DEPTH (16)
#define TOTAL_CHUNK_BLOCKS (CHUNK_WIDTH*CHUNK_HEIGHT*CHUNK_DEPTH)
#define CHUNKS_WIDTH MAP_BLOCK_WIDTH/CHUNK_WIDTH
#define CHUNKS_HEIGHT MAP_BLOCK_HEIGHT/CHUNK_HEIGHT
#define CHUNKS_DEPTH MAP_BLOCK_DEPTH/CHUNK_DEPTH
#define TOTAL_CHUNKS CHUNK_WIDTH*CHUNK_HEIGHT*CHUNK_DEPTH

typedef struct{
	BOOL changed;
	uint32_t verts;
	Mesh* mesh;
} MapChunk;

@interface MapChunks : NSObject {
}
+(void) newChunks;
@end

extern MapChunk* chunks;

BOOL isValidChunk(int cx, int cy, int cz);

//fast accessor for chunks
MapChunk* getChunk(int cx, int cy, int cz);



// Locations of mesh vertices, viewing the quad from the surface normal looking down
//   2---------1
//   |      /  6
//   |    /    |
//   |  /      |
//   34________5

//in this method, neighborIndex implies the side of the block that we want to show to the user
//neighborIndex 0=RIGHT_SIDE, 1=LEFT_SIDE, 2=FRONT_SIDE, 3=BACK_SIDE, 4=TOP, 5=BOTTOM
MeshVertex* addFace(MeshVertex* mv, int x, int y, int z, int neighborIndex);

void generateChunkMesh(int cx, int cy, int cz);

uint32_t getChunkVertexCount(int cx, int cy, int cz);
