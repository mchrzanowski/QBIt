//
//  Mesh.h
//  Texture
//
//  Created by scholar on 4/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenGLCommon.h"


typedef struct {
	GLbyte pos[3]; //position
	GLbyte tc[2]; //texture coordinate
} MeshVertex;


@interface Mesh : NSObject {
	uint32_t bufferSize;
	uint32_t bufferVerts;
	MeshVertex* buffer;
	
	uint32_t framesSinceLastUse;
}

-(id) init;
-(MeshVertex*) buffer;
-(uint32_t) bufferSize;
-(void) setBuffer: (MeshVertex*) newBuffer
		 withSize: (uint32_t) newBufferSize;
-(uint32_t) vertexCapacity;
-(void) setBufferVerts: (uint32_t) newBufferVerts;
-(uint32_t) framesSinceLastUse;
-(void) setFramesSinceLastUse: (uint32_t) newFramesSinceLastUse;
-(void) draw;
-(void) createBuffer;
-(void) createBufferWithCapacity: (uint32_t) vertices;
-(void) lostBuffer;
-(void) freeBuffer;
+(void) enableDraw;
+(void) disableDraw;

@end
