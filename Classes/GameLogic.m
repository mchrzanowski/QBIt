#import "GameLogic.h"
#import "MapChunks.h"
#import "MeshPool.h"
#import "Globals.h"
#import "Player.h"
#import "GLView.h"

inline void updateLogic(){
	static BOOL firstFrame = YES;
	static CFTimeInterval lastTime;
	CFTimeInterval time = CFAbsoluteTimeGetCurrent();
	CFTimeInterval deltaT = time - lastTime;
	lastTime = time;
	if(firstFrame){
		deltaT = 0.033f;
		firstFrame = NO;
	}
	[player update: deltaT];
}

inline void update(){
	updateLogic();
	[view drawView];
}

#define VIEW_RADIUS (4)
#define VIEW_DIAMETER ((VIEW_RADIUS*2)+1)
#define VIEW_VOLUME (VIEW_DIAMETER*VIEW_DIAMETER*VIEW_DIAMETER)

//chunks should probably store a boolean value indicating whether they have "drawable" areas. (e.g., solid underground chunks have no drawable surfaces)
//this might be updated whenever the underlying blocks of a chunk change. 
void renderWorld(){
	//storage for the chunks visible this frame
	int visibleChunks[VIEW_VOLUME][3];
	int currentChunk = 0;
	
	//create a mesh pool if we don't have one already
	if(!meshPool){
		meshPool = [[MeshPool alloc] init];
	}
	
	//make all of the meshes 1 frame older
	[meshPool incrementLastUsed];
	
	//determine the VIEW_RADIUS cube around the player which is within the view distance
	Vector3D cameraPos = [[player camera] position];
	int playerChunkX=cameraPos.x/16, playerChunkY=cameraPos.y/16, playerChunkZ=cameraPos.z/16; //calculate the chunk in which the camera resides
	int cStart[3] = {playerChunkX - VIEW_RADIUS, playerChunkY - VIEW_RADIUS, playerChunkZ - VIEW_RADIUS};
	int cEnd[3] = {playerChunkX + VIEW_RADIUS, playerChunkY + VIEW_RADIUS, playerChunkZ + VIEW_RADIUS};
	
	//do bounds checking on our visible area
	if(cStart[0] < 0) cStart[0]=0;
	if(cStart[1] < 0) cStart[1]=0;
	if(cStart[2] < 0) cStart[2]=0;
	if(cEnd[0] >= CHUNKS_WIDTH) cEnd[0] = CHUNKS_WIDTH-1;
	if(cEnd[1] >= CHUNKS_HEIGHT) cEnd[1] = CHUNKS_HEIGHT-1;
	if(cEnd[2] >= CHUNKS_DEPTH) cEnd[2] = CHUNKS_DEPTH-1;
	
	//use the camera's view frustum to cull chunks within the view distance
	for(int cz = cStart[2]; cz <= cEnd[2]; cz++)
		for(int cy = cStart[1]; cy <= cEnd[1]; cy++)
			for(int cx = cStart[0]; cx <= cEnd[0]; cx++){
				
				//calculate minimum and maximum vertices in world space of this chunk for view frustum culling
				Vertex3D cMin, cMax;
				cMin.x = cx*CHUNK_WIDTH; cMin.y = cy*CHUNK_HEIGHT; cMin.z = cz*CHUNK_DEPTH;
				cMax.x = cMin.x+CHUNK_WIDTH; cMax.y = cMin.y+CHUNK_HEIGHT; cMax.z = cMin.z+CHUNK_DEPTH;
				
				//perform view frustum culling on the chunk
				if( [ [player camera] isBoxInFrustum: cMax and: cMin] ){
					//add this chunk to the list of visible chunks
					visibleChunks[currentChunk][0] = cx;
					visibleChunks[currentChunk][1] = cy;
					visibleChunks[currentChunk][2] = cz;
					++currentChunk;
					//if the chunk's mesh has a buffer, ensure that it's marked as USED
					MapChunk* chunk = getChunk(cx,cy,cz);
					if( [chunk->mesh buffer] ){
						[chunk->mesh setFramesSinceLastUse:0];
					}
				}
				else{
					//NSLog(@"Chunk (%d, %d, %d) failed VFC test", cx, cy, cz);
				}
			}
	
	//for each visible chunk
	for(int i=0; i<currentChunk; i++){
		MapChunk* chunk = getChunk(visibleChunks[i][0], visibleChunks[i][1], visibleChunks[i][2]);
		//update the number of vertices in the chunk if it's changed
		if(chunk->changed){
			chunk->verts = getChunkVertexCount(visibleChunks[i][0], visibleChunks[i][1], visibleChunks[i][2]);
			//if the chunk has no verts, mark it as unchanged
			if(0 == chunk->verts)
				chunk->changed = NO;
		}
		//if the chunk has drawable verts and has changed or has no buffer, we need a new buffer!
		if(chunk->verts > 0 && (chunk->changed || ![chunk->mesh buffer] )){
			//get a new buffer
			[meshPool getBuffer: chunk->mesh withCapacity: chunk->verts ];
			if(![chunk->mesh buffer]){
				[NSException raise:@"Mesh to draw lacks buffer" format:@"mesh %@ impossible", chunk->mesh];
			}
			//generate mesh's contents
			generateChunkMesh(visibleChunks[i][0], visibleChunks[i][1], visibleChunks[i][2]);
		}
		// draw the valid mesh
		if(chunk->verts > 0 && [chunk->mesh buffer]){
			[chunk->mesh draw];
		}
	}
	
}

inline void renderUI(){
}