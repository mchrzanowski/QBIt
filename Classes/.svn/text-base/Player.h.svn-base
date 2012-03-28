//
//  Player.h
//  Texture
//
//  Created by Mike Chrzanowski on 4/25/10.
//  Copyright 2010 NYU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdint.h>

#import "Camera.h"
#import "OpenGLCommon.h"


@interface Player : NSObject {

	// Owned objects
	Camera* camera;
	
	// Location & orientation data
	Vector3D position;
	float heading;
	float pitch;
	
	// Physics data
	Vector3D velocity;
	
	// User input data
	uint8_t action;
	BOOL moveForward, moveBackward, moveLeft, moveRight;
	
}

@property(nonatomic, readonly) Camera* camera;
@property(nonatomic) uint8_t action;
@property(nonatomic) BOOL moveForward, moveBackward, moveLeft, moveRight;

-(void) jump;

-(void) lookVertically: (float) angle;
-(void) lookHorizontally: (float) angle;

-(Vector3D) position;
-(void) setPosition: (Vector3D) newPosition;

-(void) update: (float) deltaT;
-(void) checkedMovement: (Vector3D) direction;

@end
