//
//  TextureAppDelegate.m
//  Texture
//
//  Created by jeff on 5/23/09.
//  Copyright Jeff LaMarche 2009. All rights reserved.
//

#import "TextureAppDelegate.h"
#import "Globals.h"
#import "MapBlocks.h"
#import "Player.h"

@implementation TextureAppDelegate
@synthesize titleScreen;
@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication*)application
{	
	//NSLog(@"loading game master controller");
	
	titleScreen = [[TitleScreen alloc] init];
	titleScreen.view.frame = properlySizedRect;
	[window addSubview:titleScreen.view];
    [window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	//HANDLE SAVING THE PLAYER POSITION AND LEVEL GEOMETRY TO DISK HERE
	
	//grab data
	NSData* mapData = [NSData dataWithBytes: blocks length: MAP_TOTAL_BLOCKS];
	NSNumber* playerX = [NSNumber numberWithFloat:[player position].x];
	NSNumber* playerY = [NSNumber numberWithFloat:[player position].y];
	NSNumber* playerZ = [NSNumber numberWithFloat:[player position].z];
	
	//create dictionary
	NSMutableDictionary* saveDict = [[NSMutableDictionary alloc] init];
	[saveDict setObject:mapData forKey:@"mapData"];
	[saveDict setObject:playerX forKey:@"playerX"];
	[saveDict setObject:playerY forKey:@"playerY"];
	[saveDict setObject:playerZ forKey:@"playerZ"];
	
	//save data
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"savedGame.plist"];
	[saveDict writeToFile:path atomically:YES];
	
	NSLog(@"Completed saving");
}


- (void)dealloc
{
	[window release];
	[titleScreen release];
	[super dealloc];
}


@end
