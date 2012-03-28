/*
 *  Physics.c
 *  Texture
 *
 *  Created by Mike Chrzanowski on 4/25/10.
 *  Copyright 2010 NYU. All rights reserved.
 *
 */

#import "Physics.h"
#import "MapBlocks.h"

void addGravityAcceleration(Vector3D* velocity, float deltaT){
	const float GRAVITY = -20.f;
	velocity->z += GRAVITY * deltaT;
	//velocity->z = 0.f;
}

BOOL checkMovement(Vector3D position, Vector3D direction, float radius, int axis){
	int posX = (int)position.x; int posY = (int)position.y; int posZ = (int)position.z;
	BOOL cool = YES;
	switch (axis) {
			
		case 0:
		{ //X
			//determine which x direction to check
			int xOffset = 1;
			if( direction.x < 0.f )
				xOffset = -1;
			//check the x direction, 1 or 2 of 3 possible blocks
			cool = cool && isValidBlock(posX + xOffset, posY, posZ) && !getBlock(posX + xOffset, posY, posZ);
			if( position.y + radius > posY ){ //check positive Y neighbor
				cool = cool && isValidBlock(posX + xOffset, posY + 1, posZ) && !getBlock(posX + xOffset, posY + 1, posZ);
			}
			else if( position.y - radius < posY ){ //check negative Y neighbor
				cool = cool && isValidBlock(posX + xOffset, posY - 1, posZ) && !getBlock(posX + xOffset, posY - 1, posZ);
			}
			break;
		}
			
		case 1:
		{ //Y
			//determine which y direction to check
			int yOffset = 1;
			if( direction.y < 0.f )
				yOffset = -1;
			//check the x direction, 1 or 2 of 3 possible blocks
			cool = cool && isValidBlock(posX, posY + yOffset, posZ) && !getBlock(posX, posY + yOffset, posZ);
			if( position.x + radius  > posX ){ //check positive X neighbor
				cool = cool && isValidBlock(posX + 1, posY + yOffset, posZ) && !getBlock(posX + 1, posY + yOffset, posZ);
			}
			else if( position.x - radius < posX ){ //check negative X neighbor
				cool = cool && isValidBlock(posX - 1, posY + yOffset, posZ) && !getBlock(posX - 1, posY + yOffset, posZ);
			}
			break;
		}
			
		case 2:
		{ //Z
			//determine which z direction to check
			int zOffset = 1;
			if( direction.z < 0.f )
				zOffset = -1;
			//check the block above or below
			cool = cool && isValidBlock(posX, posY, posZ + zOffset) && !getBlock(posX, posY, posZ + zOffset);
			//TODO: check the other blocks
			break;
		}
		default:
			break;
	}
	return cool;
}

//takes a destination, and an (dX, dY, dZ) of its base, plus a float height and radius, determines if there's a collision
//NOTE: for this method to be accurate on our grid, the maginute of the motion must be LESS THAN the radius of the player
Vector3D checkStack(Vector3D dest, int dX, int dY, int dZ, float height, float radius){
	BOOL blockStackFull = NO;
	int dZtorso = (int)(dest.z + height/2.f);
	int dZhead = (int)(dest.z + height);
	
	if(!isValidBlock(dX, dY, dZ) || getBlock(dX, dY, dZ))
		blockStackFull = YES;
	else if(!isValidBlock(dX, dY, dZtorso) || getBlock(dX, dY, dZtorso))
		blockStackFull = YES;
	else if(!isValidBlock(dX, dY, dZhead) || getBlock(dX, dY, dZhead))
		blockStackFull = YES;
	
	//if this block stack is empty, there's no collision
	if(!blockStackFull){
		return dest;
	}
	
	//otherwise we actually need to do a collision test
	BOOL xCollide = (dest.x + radius > dX && dest.x - radius < dX + 1);
	BOOL yCollide = (dest.y + radius > dY && dest.y - radius < dY + 1);
	//if we miss one of the easy axes, there's no collision
	if( !xCollide || !yCollide)
		return dest;
	
	//there might be a collision, so the x and y depths are now useful
	float circleXMin = dest.x - radius;
	float circleXMax = dest.x + radius;
	float xCollideStart = (circleXMin < dX ? dX : circleXMin);
	float xCollideEnd = (circleXMax > (dX + 1.f) ? (dX + 1.f) : circleXMax);
	float xDepth = xCollideEnd - xCollideStart;
	
	float circleYMin = dest.y - radius;
	float circleYMax = dest.y + radius;
	float yCollideStart = (circleYMin < dY ? dY : circleYMin);
	float yCollideEnd = (circleYMax > (dY + 1.f) ? (dY + 1.f) : circleYMax);
	float yDepth = yCollideEnd - yCollideStart;
	
	//NEED TO USE VORONOI REGIONS TO DETERMINE WHICH AXES MAKE A COLLISION
	
	//left side of cube
	if(dest.x < dX){
		//bottom grid square
		if(dest.y < dY){
			float BLDepth = radius - sqrt( (dX - dest.x)*(dX - dest.x) + (dY - dest.y)*(dY - dest.y) ); //bottom left
			if( (circleYMax > dY) && (circleXMax > dX) && (BLDepth > 0.f) ){
				//we collided with the BL corner of the cube, so project outward along the BL axis
				Vector2D proj = {dest.x - dX, dest.y - dY};
				Vector2DNormalize(&proj);
				dest.x = proj.x * BLDepth; dest.y = proj.y * BLDepth;
			}
		}
		//top grid square
		else if(dest.y > dY + 1.f){
			float TLDepth = radius - sqrt( (dX - dest.x)*(dX - dest.x) + (dY + 1 - dest.y)*(dY + 1 - dest.y) ); //top left
			if( (circleYMin > dY + 1.f) && (circleXMax > dX)  && (TLDepth > 0.f) ){
				//we collided with the TL corner of the cube, so project outward along the TL axis
				Vector2D proj = {dest.x - dX, dest.y - (dY + 1.f)}; 
				Vector2DNormalize(&proj);
				dest.x = proj.x * TLDepth; dest.y = proj.y * TLDepth;
			}
		}
		//dest.y in cube's y-axis
		else{
			if( (circleXMax > dX) ){
				//we collided with the left side of the cube, so project left along the X-axis
				dest.x -= xDepth;
			}
		}
	}
	//right side of cube
	else if(dest.x > dX + 1.f){
		//bottom grid square
		if(dest.y < dY){
			float BRDepth = radius - sqrt( (dX + 1 - dest.x)*(dX + 1- dest.x) + (dY - dest.y)*(dY - dest.y) ); //bottom right
			if( (circleYMax > dY) && (circleXMin < dX + 1.f) && ( BRDepth > 0.f) ){
				//we collided with the BR corner of the cube, so project outward along the BR axis
				Vector2D proj = {dest.x - (dX + 1.f), dest.y}; 
				Vector2DNormalize(&proj);
				dest.x = proj.x * BRDepth; dest.y = proj.y * BRDepth;
			}
		}
		//top grid square
		else if(dest.y > dY + 1.f){
			float TRDepth = radius - sqrt( (dX + 1 - dest.x)*(dX + 1- dest.x) + (dY + 1 - dest.y)*(dY + 1 - dest.y) ); //top right
			if( (circleYMin < dY + 1.f) && (circleXMin < dX + 1.f) && (TRDepth < 0.f) ){
				//we collided with the TR corner of the cube, so project outward along the TR axis
				Vector2D proj = {dest.x - (dX + 1.f), dest.y + (dY + 1.f)}; 
				Vector2DNormalize(&proj);
				dest.x = proj.x * TRDepth; dest.y = proj.y * TRDepth;
			}
		}
		//dest.y in cube's y-axis
		else{
			if( ( circleXMin < dX + 1.f) ){
				//we collided with the right side of the cube, so project right along the X-axis
				dest.x += xDepth;
			}
		}
	}
	//center.x in cube's x-axis
	else{
		//bottom grid square
		if(dest.y < dY){
			if( (circleYMax > dY) ){
				//we collided with the bottom side of the cube, so project down along the Y-axis
				dest.y -= yDepth;
			}
		}
		//top grid square
		else if(dest.y > dY + 1.f){
			if( (circleYMin < dY + 1.f) ){
				//we collided with the top side of the cube, so project up along the Y-axis
				dest.y += yDepth;
			}
		}
		//INSIDE the cube
		else{
			if(xDepth < yDepth){
				//project out of x-axis
				if(dest.x > dX + .5f)
					dest.x += xDepth; //right half goes right
				else
					dest.x -= xDepth;
			}
			else{
				if(dest.y > dY + .5f)
					dest.y += yDepth; //top side goes up
				else
					dest.y -= yDepth;
			}
		}
	}

	return dest;
}

Vector3D checkMovement2(Vector3D pos, Vector3D dir, float height, float radius){
	int posX = (int) pos.x;
	int posY = (int) pos.y;
	
	const float EPSILON = 0.001f;
	float zMovement = dir.z;
	int dZ = (int)(pos.z + dir.z);
	int zOffset = 1;
	
	//first, check to see if there's z movement
	if( fabs(dir.z) > 0.f){
		//then determine the correct Z-layer to test
		if(dir.z > 0.f){
			dZ = (int) (pos.z + height + dir.z); //check head location
		}
		//check the location we're in
		if( !isValidBlock(posX, posY, dZ) || getBlock(posX, posY, dZ) ){
			zMovement = (float)(dZ + zOffset) - pos.z;
			if(dir.z > 0)
				zMovement = (float)dZ - (pos.z + height + EPSILON);
		}
		//check the block to the right
		else if( (pos.x + radius > posX + 1.f) && (!isValidBlock(posX+1, posY, dZ) || getBlock(posX+1, posY, dZ)) ){
			zMovement = (float)(dZ + zOffset) - pos.z;
			if(dir.z > 0)
				zMovement = (float)dZ - (pos.z + height + EPSILON);
		}
		//check the block to the left
		else if( (pos.x - radius < posX) && (!isValidBlock(posX-1, posY, dZ) || getBlock(posX-1, posY, dZ)) ){
			zMovement = (float)(dZ + zOffset) - pos.z;
			if(dir.z > 0)
				zMovement = (float)dZ - (pos.z + height + EPSILON);
		}
		//check the block to the back
		else if( (pos.y + radius > posY + 1.f) && (!isValidBlock(posX, posY+1, dZ) || getBlock(posX, posY+1, dZ)) ){
			zMovement = (float)(dZ + zOffset) - pos.z;
			if(dir.z > 0)
				zMovement = (float)dZ - (pos.z + height + EPSILON);
		}
		//check the block to the front
		else if( (pos.y - radius < posY) && (!isValidBlock(posX, posY-1, dZ) || getBlock(posX, posY-1, dZ)) ){
			zMovement = (float)(dZ + zOffset) - pos.z;
			if(dir.z > 0)
				zMovement = (float)dZ - (pos.z + height + EPSILON);
		}
	}
	
	//correct for the actual zMovement performed
	Vector3D fdest = {pos.x + dir.x, pos.y + dir.y, pos.z + zMovement};
	int dX = (int) fdest.x;
	int dY = (int) fdest.y;
	dZ = (int)fdest.z;
	
	
	//then, once moved into the z position, perform the xy-movements
	fdest = checkStack(fdest, dX, dY, dZ, height, radius); //center :: ANNOTATION IS PLAYER POSITION RELATIVE TO COLLIDING BLOCK
	if( fdest.x + radius > dX + 1.f){
		fdest = checkStack(fdest, dX+1, dY, dZ, height, radius); //left
		dX = (int) fdest.x;
		dY = (int) fdest.y;
		dZ = (int) fdest.z;
	}
	else if( fdest.x - radius < dX ){
		fdest = checkStack(fdest, dX-1, dY, dZ, height, radius); //right BROKEN
		dX = (int) fdest.x;
		dY = (int) fdest.y;
		dZ = (int) fdest.z;
	}
	if( fdest.y + radius > dY + 1.f){
		fdest = checkStack(fdest, dX, dY+1, dZ, height, radius); //front
		dX = (int) fdest.x;
		dY = (int) fdest.y;
		dZ = (int) fdest.z;
	}
	else if( fdest.y - radius < dY ){
		fdest = checkStack(fdest, dX, dY-1, dZ, height, radius); //back BROKEN
		dX = (int) fdest.x;
		dY = (int) fdest.y;
		dZ = (int) fdest.z;
	}
	
	//TODO: check the diagonals too!!!
	return fdest; 
		
}