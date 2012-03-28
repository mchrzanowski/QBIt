//
//  MeshPool.m
//  Texture
//
//  Created by scholar on 4/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MeshPool.h"


@implementation MeshPool

@synthesize lruQueue;

//private methods
-(void) allocateBuffer: (Mesh*) mesh
		  withCapacity: (uint32_t) vertices{
	[mesh createBufferWithCapacity:(vertices + NEW_MESH_BUFFER_SIZE)];
	[lruQueue addObject: mesh];
	bytesUsed += sizeof(MeshVertex) * (vertices + NEW_MESH_BUFFER_SIZE);
}
-(void) freeBuffer:(Mesh*) mesh{
	bytesUsed -= [mesh vertexCapacity]*sizeof(MeshVertex);
	[mesh freeBuffer];
	[lruQueue removeObject:mesh];
}

//FOR A PASSED IN MESH, FIND IT A BUFFER THAT HAS SOME CAPACITY
-(void) getBuffer: (Mesh*) mesh
	 withCapacity: (uint32_t) vertices{
	//if the mesh already has a buffer
	if( [mesh buffer] ){
		if( [mesh vertexCapacity] >= vertices )
			return; //and it has enough capacity, use it
		else
			[mesh lostBuffer]; //otherwise, mesh loses the old buffer and we look for a new one
	}
	//look for the least recently used Mesh that satisfies 2 criteria: 1.) enough free space 2.) doesn't waste too much space
	Mesh* bestMesh = nil;
	uint32_t bestLastUsed = 0;
	for(Mesh* m in lruQueue){
		if([m vertexCapacity] > vertices && 
		   [m vertexCapacity] < vertices+REUSE_SIZE_MISMATCH &&
		   [m framesSinceLastUse] > bestLastUsed){
			//keep track of this one
			bestMesh = m; 
			bestLastUsed = [m framesSinceLastUse];
		}
	}
	//we should now have an optimal Mesh for reuse...
	if(bestMesh){
		//so steal its buffer
		[mesh setBuffer: [bestMesh buffer]
			   withSize: [bestMesh bufferSize]];
		[mesh setFramesSinceLastUse: 0];
		[bestMesh lostBuffer];
		[lruQueue removeObject: bestMesh];
		[lruQueue addObject: mesh];
		return;
	}
	//if that's not possible, check to see if we can create a new mesh
	else if( [lruQueue count] < POOL_SIZE && bytesUsed+(vertices+NEW_MESH_BUFFER_SIZE)*sizeof(MeshVertex) < MAX_BYTES ){
		[self allocateBuffer: mesh
				withCapacity: vertices + NEW_MESH_BUFFER_SIZE];
		return;
	}
	//if that's not possible, deallocate unused meshes and allocate a new larger mesh
	else{
		//start deallocating until we've freed enough space for our new mesh
		uint32_t bytesRequired = sizeof(MeshVertex)*(vertices+NEW_MESH_BUFFER_SIZE);
		uint32_t usableBytes = MAX_BYTES - bytesUsed;
		for(Mesh* m in lruQueue){
			if( [m framesSinceLastUse] > 0 ){
				usableBytes += [m vertexCapacity]*sizeof(MeshVertex);
				[self freeBuffer: m];
				if(usableBytes >= bytesRequired){
					[self allocateBuffer: mesh
							withCapacity: vertices+NEW_MESH_BUFFER_SIZE];
					return;
				}
			}
		}
	}
	//if we've reached this point, we simply don't have a mesh to give
	[NSException raise:@"Unable to find a free buffer" format:@"buffer of %d vertices impossible with %d bytes used and queue size %d", vertices, bytesUsed, [lruQueue count]];
}

-(void) incrementLastUsed{
	for(Mesh* m in lruQueue){
		uint32_t frame = [m framesSinceLastUse];
		[m setFramesSinceLastUse:frame+1];
	}
	//NSLog(@"MeshPool allocated buffers: %d,  free bytes: %d", [lruQueue count], MAX_BYTES - bytesUsed);
}

-(id) init{
	if ([super init]){
		self.lruQueue = [[NSMutableArray alloc] init];
		bytesUsed = 0;
	}
	return self;
}

- (void) dealloc {
	[lruQueue release];
	[super dealloc];
}

@end
