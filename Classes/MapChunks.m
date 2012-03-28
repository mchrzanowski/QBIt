//
//  MapChunks.m
//  Texture
//
//  Created by scholar on 4/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapChunks.h"
#import "Terrain.h"

MapChunk* chunks;

@implementation MapChunks

+(void) newChunks{
	chunks = malloc(TOTAL_CHUNKS * sizeof(MapChunk));
	for(int i = 0; i< TOTAL_CHUNKS; i++){
		chunks[i].mesh = [[Mesh alloc] init];
		chunks[i].changed = YES; //mark all chunks as changed
	}
}

@end

//block checkers
inline BOOL isValidChunk(int cx, int cy, int cz){
	return (cx >= 0 && cx < CHUNKS_WIDTH && 
			cy >= 0 && cy < CHUNKS_HEIGHT &&
			cz >= 0 && cz < CHUNKS_DEPTH);
}

//fast accessor for chunks
inline MapChunk* getChunk(int cx, int cy, int cz){
	return &chunks[(cz*CHUNKS_WIDTH*CHUNKS_HEIGHT)+(cy*CHUNKS_WIDTH)+cx];
}


// Locations of mesh vertices, viewing the quad looking opposite the surface normal
//   2---------1
//   |      /  6
//   |    /    |
//   |  /      |
//   34________5

//in this method, neighborIndex implies the side of the block that we want to show to the user
//neighborIndex 0=RIGHT_SIDE, 1=LEFT_SIDE, 2=FRONT_SIDE, 3=BACK_SIDE, 4=TOP, 5=BOTTOM
inline MeshVertex* addFace(MeshVertex* mv, int x, int y, int z, int neighborIndex){

	uint8_t type = getBlock(x, y, z);
	if(type){ //if we're not == 0, which is empty
		#define VO (-128)
		x+=VO; y+=VO; z+=VO;
		//position offsets
		static const int positions[6][4][3] = { 
			//Vertices: 1&6, 2, 3&4, 5
			{ {1,1,1}, {1,0,1}, {1,0,0}, {1,1,0} }, //RIGHT_SIDE
			{ {0,0,1}, {0,1,1}, {0,1,0}, {0,0,0} }, //LEFT_SIDE
			{ {0,1,1}, {1,1,1}, {1,1,0}, {0,1,0} }, //BACK_SIDE
			{ {1,0,1}, {0,0,1}, {0,0,0}, {1,0,0} }, //FRONT_SIDE
			{ {1,1,1}, {0,1,1}, {0,0,1}, {1,0,1} }, //TOP
			{ {1,0,0}, {0,0,0}, {0,1,0}, {1,1,0} }  //BOTTOM
		};
		//determine which side TC we need
		static const int sides[] = {RIGHT, LEFT, BACK, FRONT, TOP, BOTTOM};
		int side = sides[neighborIndex];
		TexCoords* tcs = getBlockTexCoords(type, side);
		
		//fill in the vertex data with positions, texcoords, and normals
		MeshVertex* mv1 = &mv[0];
		mv1->pos[0] = (GLbyte) positions[neighborIndex][0][0] + x;
		mv1->pos[1] = (GLbyte) positions[neighborIndex][0][1] + y;
		mv1->pos[2] = (GLbyte) positions[neighborIndex][0][2] + z;
		mv1->tc[0] = tcs->right;
		mv1->tc[1] = tcs->top;
		
		MeshVertex* mv2 = &mv[1];
		mv2->pos[0] = (GLbyte) positions[neighborIndex][1][0] + x;
		mv2->pos[1] = (GLbyte) positions[neighborIndex][1][1] + y;
		mv2->pos[2] = (GLbyte) positions[neighborIndex][1][2] + z;
		mv2->tc[0] = tcs->left;
		mv2->tc[1] = tcs->top;
		
		MeshVertex* mv3 = &mv[2];
		mv3->pos[0] = (GLbyte) positions[neighborIndex][2][0] + x;
		mv3->pos[1] = (GLbyte) positions[neighborIndex][2][1] + y;
		mv3->pos[2] = (GLbyte) positions[neighborIndex][2][2] + z;
		mv3->tc[0] = tcs->left;
		mv3->tc[1] = tcs->bottom;
		
		//copy data from mv3
		MeshVertex* mv4 = &mv[3];
		mv4->pos[0] = mv3->pos[0];
		mv4->pos[1] = mv3->pos[1];
		mv4->pos[2] = mv3->pos[2];
		mv4->tc[0] = mv3->tc[0];
		mv4->tc[1] = mv3->tc[1];
		
		MeshVertex* mv5 = &mv[4];
		mv5->pos[0] = (GLbyte) positions[neighborIndex][3][0] + x;
		mv5->pos[1] = (GLbyte) positions[neighborIndex][3][1] + y;
		mv5->pos[2] = (GLbyte) positions[neighborIndex][3][2] + z;
		mv5->tc[0] = tcs->right;
		mv5->tc[1] = tcs->bottom;
		
		//copy data from mv1
		MeshVertex* mv6 = &mv[5];
		mv6->pos[0] = mv1->pos[0];
		mv6->pos[1] = mv1->pos[1];
		mv6->pos[2] = mv1->pos[2];
		mv6->tc[0] = mv1->tc[0];
		mv6->tc[1] = mv1->tc[1];
		
		//return a pointer to the next MeshVertex in the buffer
		return mv+6;
	}
	//we didn't add any vertices, so we don't need to update
	return mv;
}

void generateChunkMesh(int cx, int cy, int cz){
	//validate chunk coordinates
	if( cx >= CHUNKS_WIDTH || cx < 0 ||
	   cy >= CHUNKS_HEIGHT || cy < 0 ||
	   cz >= CHUNKS_DEPTH || cz < 0)
		exit(1);
	
	MapChunk* chunk = getChunk(cx, cy, cz);
	chunk->changed = NO;
	MeshVertex* tempMV = [chunk->mesh buffer];
	MeshVertex* bufferStart = tempMV;
	
	//calculate literal bounds of chunk (start included, end excluded)
	//ensure that chunks near the edge of the map don't attempt to query out-of-bounds blocks
	int cStart[3] = {cx*CHUNK_WIDTH, cy*CHUNK_HEIGHT, cz*CHUNK_DEPTH};
	if(cx > 0) --cStart[0];
	if(cy > 0) --cStart[1];
	if(cz > 0) --cStart[2];
	int cEnd[3] = {cStart[0]+CHUNK_WIDTH, cStart[1]+CHUNK_HEIGHT, cStart[2]+CHUNK_DEPTH};
	if(cx < CHUNKS_WIDTH-1) ++cEnd[0];
	if(cy < CHUNKS_HEIGHT-1) ++cEnd[1];
	if(cz < CHUNKS_DEPTH-1) ++cEnd[2];
	
	//offsets of the 6 neighbours
	static const int next[6][3] = { {-1, 0, 0}, {1, 0, 0}, {0, -1, 0}, {0, 1, 0}, {0, 0, -1}, {0, 0, 1} };
	//grab blocks from the interior
	for(int z = cStart[2]; z <= cEnd[2]; z++)
		for(int y = cStart[1]; y <= cEnd[1]; y++)
			for(int x = cStart[0]; x <= cEnd[0]; x++){
				//if this block is empty, check if its neighbors are full
				if(!getBlock(x, y, z)){
					for( int n = 0; n < 6; n++){
						//check to draw neighbor, add vertices, texCoords, normals
						if(isValidBlock(x+next[n][0], y+next[n][1], z+next[n][2]) &&
						   (x+next[n][0])/CHUNK_WIDTH == cx && (y+next[n][1])/CHUNK_HEIGHT == cy && (z+next[n][2])/CHUNK_DEPTH == cz)
							tempMV = addFace(tempMV, x+next[n][0], y+next[n][1], z+next[n][2], n);
					}
				}
			}
	
	//NSLog(@"Buffer vertices:%d", (tempMV - bufferStart));
	[chunk->mesh setBufferVerts: (uint32_t)(tempMV - bufferStart)];
}

uint32_t getChunkVertexCount(int cx, int cy, int cz){
	uint32_t vertices = 0;
	//validate chunk coordinates
	if(cx >= CHUNKS_WIDTH || cx < 0 ||
	   cy >= CHUNKS_HEIGHT || cy < 0 ||
	   cz >= CHUNKS_DEPTH || cz < 0)
		exit(1);
	//calculate literal bounds of chunk (start included, end excluded)
	//ensure that chunks near the edge of the map don't attempt to query out-of-bounds blocks
	int cStart[3] = {cx*CHUNK_WIDTH, cy*CHUNK_HEIGHT, cz*CHUNK_DEPTH};
	if(cx > 0) --cStart[0];
	if(cy > 0) --cStart[1];
	if(cz > 0) --cStart[2];
	int cEnd[3] = {cStart[0]+CHUNK_WIDTH, cStart[1]+CHUNK_HEIGHT, cStart[2]+CHUNK_DEPTH};
	if(cx < CHUNKS_WIDTH-1) ++cEnd[0];
	if(cy < CHUNKS_HEIGHT-1) ++cEnd[1];
	if(cz < CHUNKS_DEPTH-1) ++cEnd[2];
	//offsets of the 6 neighbours
	static const int next[6][3] = { {-1, 0, 0}, {1, 0, 0}, {0, -1, 0}, {0, 1, 0}, {0, 0, -1}, {0, 0, 1} };
	//grab blocks from the interior
	for(int z = cStart[2]; z <= cEnd[2]; z++)
		for(int y = cStart[1]; y <= cEnd[1]; y++)
			for(int x = cStart[0]; x <= cEnd[0]; x++){
				//if this block is empty, check if its neighbors are full
				if(!getBlock(x, y, z)){
					for( int n = 0; n < 6; n++){
						//check for a valid, nonempty neighbor
						if( isValidBlock(x+next[n][0], y+next[n][1], z+next[n][2]) && 
						   (x+next[n][0])/CHUNK_WIDTH == cx && (y+next[n][1])/CHUNK_HEIGHT == cy && (z+next[n][2])/CHUNK_DEPTH == cz &&
							getBlock(x+next[n][0], y+next[n][1], z+next[n][2]) ){
							vertices += 6; //6 vertices for every valid nonempty neighbor
						}
					}
				}
			}

	return vertices;
}
