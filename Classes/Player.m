//
//  Player.m
//  QBit
//
//  Created by John Fernandes-Salling on 4/25/10.
//  Copyright 2010 John Fernandes-Salling. All rights reserved.
//

#import <math.h>

#import "Player.h"
#import "MapBlocks.h"
#import "Physics.h"
#import "Globals.h"


@implementation Player


@synthesize camera;
@synthesize action;
@synthesize moveForward, moveBackward, moveLeft, moveRight;


-(id) init{
	if( (self = [super init]) ) {
		// perform Player initialization here
		camera = [[Camera alloc] init]; //make a camera
		
		// set an initial player position & orientation
		position.x = 55.f;
		position.y = 55.f;
		position.z = 120.f;
		heading = 0.f;
		pitch = 0.f;
		
		// sync the camera
		Vector3D cameraPos = {position.x, position.y, position.z + 1.5f};
		[camera setPosition: cameraPos];
		[camera setPitch: pitch];
		[camera setHeading: heading];
    }
    return self;
}

-(void) dealloc{
	[camera release];
	[super dealloc];
}

-(void) jump{
	//only allow jumping if we're very close to the bottom of an empty block with a full block below it (we're standing on something)
	if( !isValidBlock(position.x, position.y, position.z - 0.01f) || getBlock(position.x, position.y, position.z - 0.01f) ){
		velocity.z += 10.f;
	}
}


-(void) lookVertically: (float) angle{
	pitch += angle;
	if(pitch > 90.0f)
		pitch = 90.0f;
	else if(pitch < -90.0f)
		pitch = -90.0f;
}

-(void) lookHorizontally: (float) angle{
	heading += angle;
	if(heading > 360.0f)
		heading -= 360.0f;
	else if(heading < 0.0f)
		heading += 360.0f;
}

-(Vector3D) position{
	return position;
}

-(void) setPosition: (Vector3D) newPosition{
	position = newPosition;
}


-(void) update: (float) deltaT{
	// handle player movements
	const float PI = 3.14159265f;
	
	Vector3D movement = {0.f, 0.f, 0.f};
	
	// adjust movement from user input
	if(moveForward) {
		float radHeading = heading*PI/180.0f;
		movement.x += deltaT * MOVE_RATE * sin(radHeading);
		movement.y += deltaT * MOVE_RATE * cos(radHeading);
	}
	if(moveBackward){
		float radHeading = heading*PI/180.0f;
		movement.x -= deltaT * MOVE_RATE * sin(radHeading);
		movement.y -= deltaT * MOVE_RATE * cos(radHeading);
	}
	if(moveLeft){
		float radHeading = (heading-90.0f)*PI/180.0f;
		movement.x += deltaT * MOVE_RATE * sin(radHeading);
		movement.y += deltaT * MOVE_RATE * cos(radHeading);
	}
	if(moveRight){
		float radHeading = (heading+90.0f)*PI/180.0f;
		movement.x += deltaT * MOVE_RATE * sin(radHeading);
		movement.y += deltaT * MOVE_RATE * cos(radHeading);
	}
	
	// adjust movement from physics
	addGravityAcceleration(&velocity, deltaT);
	movement.x += velocity.x * deltaT; 
	movement.y += velocity.y * deltaT; 
	movement.z += velocity.z * deltaT;
	
	// perform the movement in granular chunks
	[self checkedMovement:movement];
	
	// apply changes to the camera
	const float HEIGHT = 1.5f;
	
	Vector3D cameraPos = {position.x, position.y, position.z + HEIGHT};
	[camera setPosition: cameraPos];
	[camera setPitch: pitch];
	[camera setHeading: heading];
}

-(void) checkedMovement: (Vector3D) direction{
	//for any input movement, break it down into granular chunks so the displacement
	//of a chunk in any axis is less than the radius of the player
	
	const float HEIGHT = 1.7f;
	const float RADIUS = .3f;
	//const int X_AXIS = 0, Y_AXIS = 1, Z_AXIS = 2;
	
	// determine which axis has the most displacement
	float xMult = 1.f;
	if( fabs(direction.x) > RADIUS )
		xMult = fabs(RADIUS / direction.x);
	float yMult = 1.f;
	if( fabs(direction.y) > RADIUS )
		yMult = fabs(RADIUS / direction.y);
	float zMult = 1.f;
	if( fabs(direction.z) > RADIUS )
		zMult = fabs(RADIUS / direction.z);
	
	// and use that to break the direction vector into pieces
	float piece = xMult < yMult ? (xMult < zMult ? xMult : zMult) : (yMult < zMult ? yMult : zMult);
	direction.x *= piece; direction.y *= piece; direction.z *= piece;
	
	int pieces = lroundf(1.f / piece);
	for(int i = 0; i < pieces; i++){
		// collide that shit
		Vector3D oldPos = position;
		position = checkMovement2(position, direction, HEIGHT, RADIUS);
		// set velocity to zero if we stopped moving vertically
		if( fabs( oldPos.z - position.z ) < 0.00001 )
			velocity.z = 0.f;
	}
	
}



@end
