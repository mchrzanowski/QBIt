//
//  Camera.h
//  Texture
//
//  Created by scholar on 4/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenGLCommon.h"
#define MOVEMENT_MULTIPLIER (0.25f)
#define TOP_PLANE		(0)
#define BOTTOM_PLANE	(1)
#define LEFT_PLANE		(2)
#define RIGHT_PLANE		(3)
#define NEAR_PLANE		(4)
#define FAR_PLANE		(5)

#define kCameraHeight	(1.5f)
#define kPersonalRadius	(0.4f)

@interface Camera : NSObject {
	Vector3D position;
	float heading;
	float pitch;
	
	// view frustum stuff
	Plane frustum[6];		// the actual frustum planes
	Vector3D lookingVector;
	Vector3D upVector;
	Vector3D rightVector;
	Vertex3D ntl,ntr,nbl,nbr,ftl,ftr,fbl,fbr;
	float screenWidth;
	float screenHeight;
	float nearClipDist;		// distance to the near plane
	float farClipDist;		// distance to far plane
	float fieldOfView;		
	float nearHeight;
	float nearWidth;
	float farHeight;
	float farWidth;
	float ratio;
	
	Vertex3D selectedBlock;
	Vertex3D selectedNeighbor;
	
	
}
//@property float zNear, zFar, fieldOfView, hNear;
-(void) setPerspective:(CGRect) rect;
-(void) apply;

-(void) setHeading: (float) newHeading;
-(void) setPitch: (float) newPitch;
-(void) setPosition: (Vector3D) newPosition;
-(Vector3D) position;

-(BOOL) isBoxInFrustum: (Vertex3D) v1 and:(Vertex3D) v2;
-(Vertex3D) selectedBlock;
-(Vertex3D) selectedNeighbor;



@end
