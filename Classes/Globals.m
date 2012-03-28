//
//  Globals.m
//  Texture
//
//  Created by Mike Chrzanowski on 4/25/10.
//  Copyright 2010 NYU. All rights reserved.
//

#import "Globals.h"

BOOL			shouldLoadFromDisk		= NO;
BOOL			isOverheadDisplayed;
CGRect			properlySizedRect		=	{{0.f, 0.f}, {320.f, 480.f}};
float			LOOK_RATE				=	0.25;
float			MOVE_RATE				=	5.5;
GLView			*view;
MeshPool		*meshPool;
Player			*player;
UIButton		*currentTexture;
UIButton		*jump;
UIButton		*overhead;
