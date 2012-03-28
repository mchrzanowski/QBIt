//
//  MeshPool.h
//  Texture
//
//  Created by scholar on 4/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdint.h>
#import "Mesh.h"
#import "MapChunks.h"

#define POOL_SIZE (CHUNKS_WIDTH * CHUNKS_HEIGHT * CHUNKS_DEPTH) //(512)
#define KILO (1024)
#define MEGA (KILO*KILO)
#define MAX_BYTES (10*MEGA)
#define NEW_MESH_BUFFER_SIZE (50)
#define REUSE_SIZE_MISMATCH (200)

@interface MeshPool : NSObject {
	
	NSMutableArray* lruQueue;
	uint32_t bytesUsed;

}

@property(retain, nonatomic) NSMutableArray* lruQueue;

-(void) getBuffer: (Mesh*) mesh
	 withCapacity: (uint32_t) vertices;

//private methods
-(void) allocateBuffer: (Mesh*) mesh
		   withCapacity: (uint32_t) vertices;
-(void) freeBuffer: (Mesh*) mesh;
-(void) incrementLastUsed;
-(id) init;

@end
