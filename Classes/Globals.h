//
//  Globals.h
//  Texture
//
//  Created by Mike Chrzanowski on 4/25/10.
//  Copyright 2010 NYU. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;
@class GLView;
@class MeshPool;

extern BOOL			shouldLoadFromDisk;
extern BOOL			isOverheadDisplayed;
extern CGRect		properlySizedRect;	// avoid a weird bug that doesn't initialize the frame to 320x480.	
extern float		LOOK_RATE;
extern float		MOVE_RATE;
extern GLView		*view;
extern MeshPool		*meshPool;
extern Player		*player;
extern UIButton		*currentTexture;
extern UIButton		*jump;
extern UIButton		*overhead;


