//
//  Camera.m
//  Texture
//
//  Created by scholar on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Camera.h"
#import <math.h>
#import "ConstantsAndMacros.h"
#import "OpenGLCommon.h"
#import "MapBlocks.h"
#import "Physics.h"
#define PI (3.14159265f)

@implementation Camera
- (void) setPerspective: (CGRect) rect {
	
	nearClipDist = 0.01;
	farClipDist = 1000;
	fieldOfView = 90.0; 
	
	glEnable(GL_DEPTH_TEST);
	glMatrixMode(GL_PROJECTION); 
	
	screenWidth = rect.size.width;
	screenHeight = rect.size.height;
	
	ratio = screenWidth / screenHeight;
	
	glViewport(0, 0, rect.size.width, rect.size.height); 
	gluPerspective(fieldOfView,ratio,nearClipDist,farClipDist);
	
	nearWidth = nearClipDist * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0); 
	nearHeight = nearWidth * ratio;
	farWidth = farClipDist * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0);  
	farHeight = farWidth * ratio;
	
	glMatrixMode(GL_MODELVIEW);
    
    // Turn necessary features on
    glEnable(GL_TEXTURE_2D);
}


-(void) apply{
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	//OpenGL defaults to X+ = right, Y+ = up, Z+ = screen surface normal
	//Make camera default to Z+ = up, X+ = right, Y+ = screen surface normal
	glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);
	glRotatef(90.0f, 0.0f, 1.0f, 0.0f);
	//apply the rotations and position translation (inverse, so the "world" moves)
	glRotatef(pitch, 1.0f, 0.0f, 0.0f);
	glRotatef(heading, 0.0f, 0.0f, 1.0f);
	glTranslatef(-position.x, -position.y, -position.z);

	float nheading = -heading;
	float npitch = -pitch;
	
	float theta = DEGREES_TO_RADIANS( (90.0f + nheading) ); //by default, heading=0 means looking up y
	float phi = DEGREES_TO_RADIANS( (90.0f - npitch) );
	
	lookingVector.x = cos(theta) * sin(phi);
	lookingVector.y = sin(theta) * sin(phi);
	lookingVector.z = cos(phi);
	
	phi = DEGREES_TO_RADIANS( (90.0f - (npitch+90.0f) ) );
	
	upVector.x = cos(theta) * sin(phi);
	upVector.y = sin(theta) * sin(phi);
	upVector.z = cos(phi);
	
	rightVector = Vector3DCrossProduct(&lookingVector, &upVector);
	
	/*
	NSLog(@"nheading %f", nheading);
	NSLog(@"npitch %f", npitch);
	NSLog(@"position vector %f %f %f", position.x, position.y, position.z);
	NSLog(@"lookingVector %f, %f, %f", lookingVector.x, lookingVector.y, lookingVector.z);	
 	NSLog(@"upVector %f, %f, %f", upVector.x, upVector.y, upVector.z);
	NSLog(@"rightVector %f, %f, %f", rightVector.x, rightVector.y, rightVector.z);	
	 */
	
	Vector3D nc = Vector3DMultiplyScalar(&lookingVector, nearClipDist);
	nc = Vector3DAdd(&nc, &position);
	
	Vector3D fc = Vector3DMultiplyScalar(&lookingVector, farClipDist);
	fc = Vector3DAdd(&position, &fc);
	
	// create the near plane vectors
	Vector3D nearHeightY = Vector3DMultiplyScalar(&upVector, nearHeight);
	Vector3D nearWidthX  = Vector3DMultiplyScalar(&rightVector, nearWidth);
	
	ntl = Vector3DAdd(&nc, &nearHeightY );
	ntl = Vector3DSubtract (&ntl, &nearWidthX);
	
	ntr = Vector3DAdd(&nc, &nearHeightY);
	ntr = Vector3DAdd(&ntr, &nearWidthX);
	
	nbl = Vector3DSubtract(&nc, &nearHeightY);
	nbl = Vector3DSubtract(&nbl, &nearWidthX);
	
	nbr = Vector3DSubtract(&nc, &nearHeightY); 
	nbr = Vector3DAdd(&nbr, &nearWidthX);
	
	//create the far plane vectors
	Vector3D farHeightY = Vector3DMultiplyScalar(&upVector, farHeight);
	Vector3D farWidthX = Vector3DMultiplyScalar(&rightVector, farWidth);
	
	ftl = Vector3DAdd(&fc, &farHeightY); 
	ftl = Vector3DSubtract(&ftl, &farWidthX);
	
	ftr = Vector3DAdd(&fc, &farHeightY);
	ftr = Vector3DAdd(&ftr, &farWidthX);
				 
	fbl = Vector3DSubtract(&fc, &farHeightY);
	fbl = Vector3DSubtract(&fbl, &farWidthX);
	
	fbr = Vector3DSubtract(&fc, &farHeightY); 
	fbr = Vector3DAdd(&fbr, &farWidthX);
	
	// create the frustum
	frustum[TOP_PLANE]		= createPlane(ntr, ntl, ftl);
	frustum[BOTTOM_PLANE]	= createPlane(nbl,nbr,fbr);
	frustum[LEFT_PLANE]		= createPlane(ntl,nbl,fbl);
	frustum[RIGHT_PLANE]	= createPlane(nbr,ntr,fbr);
	frustum[NEAR_PLANE]		= createPlane(ntl,ntr,nbr);
	frustum[FAR_PLANE]		= createPlane(ftr,ftl,fbl);
	
/*	NSLog(@"nc:  %f, %f, %f", nc.x,	 nc.y,  nc.z);
	NSLog(@"ntl: %f, %f, %f", ntl.x, ntl.y, ntl.z);
	NSLog(@"ntr: %f, %f, %f", ntr.x, ntr.y, ntr.z);
	NSLog(@"nbl: %f, %f, %f", nbl.x, nbl.y, nbl.z);
	NSLog(@"nbr: %f, %f, %f", nbr.x, nbr.y, nbr.z);
	
	NSLog(@"fc:  %f, %f, %f", fc.x,  fc.y,  fc.z);
	NSLog(@"ftl: %f, %f, %f", ftl.x, ftl.y, ftl.z);
	NSLog(@"ftr: %f, %f, %f", ftr.x, ftr.y, ftr.z);
	NSLog(@"fbl: %f, %f, %f", fbl.x, fbl.y, fbl.z);
	NSLog(@"fbr: %f, %f, %f", fbr.x, fbr.y, fbr.z); 
*/
	
	Vector3D raydir = Vector3DSubtract(&fc, &nc);
	Vector3DNormalize(&raydir);
	raytrace2(position, raydir, &selectedBlock, &selectedNeighbor);
}

- (BOOL) isBoxInFrustum: (Vertex3D) maxV and:(Vertex3D) minV {
	
	BOOL result = YES;	
	int outside, inside = 0;
	
	Vertex3D vertices[8] = {	
		minV,
		Vertex3DMake(minV.x, maxV.y, minV.z),
		Vertex3DMake(maxV.x, minV.y, minV.z),
		Vertex3DMake(maxV.x, maxV.y, minV.z),
		Vertex3DMake(minV.x, maxV.y, maxV.z),
		Vertex3DMake(maxV.x, minV.y, maxV.z),
		Vertex3DMake(minV.x, minV.y, maxV.z),
		maxV
	};
	
	// for each plane do ...
	for(int i=0; i < 6; i++) {
		
		// reset counters for corners in and out
		outside = 0;
		inside = 0;
		// for each corner of the box do ...
		// get out of the cycle as soon as a box as corners
		// both inside and out of the frustum
		for (int k = 0; k < 8 && (inside == 0 || outside == 0); k++) {
			
			// is the corner outside or inside
			if ( planarDistance(frustum[i], vertices[k]) < 0)
				outside++;
			else
				inside++;
		}
		//if all corners are out
		if (!inside)
			return NO;
		// if some corners are out and others are in	
		else if (outside)
			result = YES;
	}
	return result;	
	
}

-(Vertex3D) selectedBlock{
	return selectedBlock;
}

-(Vertex3D) selectedNeighbor{
	return selectedNeighbor;
}

-(void) setHeading: (float) newHeading{
	heading = newHeading;
}

-(void) setPitch: (float) newPitch{
	pitch = newPitch;
}

-(Vector3D) position{
	return position;
}

-(void) setPosition: (Vector3D) newPosition{
	position = newPosition;
}

#undef PI

@end
