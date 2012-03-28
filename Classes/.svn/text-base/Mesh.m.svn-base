//
//  Mesh.m
//  Texture
//
//  Created by scholar on 4/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Mesh.h"
#import "MapChunks.h"


@implementation Mesh

-(id) init{
	if( [super init] ){
		bufferSize = 0;
		bufferVerts = 0;
		buffer = nil;
		framesSinceLastUse = 0;
	}
	return self;
}

-(MeshVertex*) buffer{
	return buffer;
}

-(void) setBuffer: (MeshVertex*) newBuffer
		 withSize:(uint32_t) newSize{
	buffer = newBuffer;
	bufferSize = newSize;
}

-(uint32_t) bufferSize{
	return bufferSize;
}

-(uint32_t) vertexCapacity{
	return (bufferSize / sizeof(MeshVertex));
}

-(void) setBufferVerts: (uint32_t) newBufferVerts{
	bufferVerts = newBufferVerts;
}

-(uint32_t) framesSinceLastUse{
	return framesSinceLastUse;
}
-(void) setFramesSinceLastUse: (uint32_t) newFramesSinceLastUse{
	framesSinceLastUse = newFramesSinceLastUse;
}

-(void) draw{
	glVertexPointer(3, GL_BYTE, sizeof(MeshVertex), &(buffer[0].pos[0]));
	glTexCoordPointer(2, GL_BYTE, sizeof(MeshVertex), &(buffer[0].tc[0]));
	glDrawArrays(GL_TRIANGLES, 0, bufferVerts);
}

-(void) createBuffer{
	bufferSize = sizeof(MeshVertex)*6*2*3*TOTAL_CHUNK_BLOCKS; //6 faces per cube, 2 triangles per face, 3 MeshVerts per triangle
	bufferVerts = 0;
	buffer = malloc(bufferSize);
}

-(void) createBufferWithCapacity: (uint32_t) vertices{
	bufferSize = sizeof(MeshVertex)*vertices;
	bufferVerts = 0;
	buffer = malloc(bufferSize);
}

-(void) freeBuffer{
	free(buffer);
	[self lostBuffer];
}

-(void) lostBuffer{
	buffer = nil;
	bufferSize = 0;
	bufferVerts = 0;
}

+(void) enableDraw{
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisableClientState(GL_NORMAL_ARRAY);
}

+(void) disableDraw{
	glDisableClientState(GL_VERTEX_ARRAY);
}

- (void) dealloc {
	[super dealloc];
}

@end
