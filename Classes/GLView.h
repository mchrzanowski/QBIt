//
//  GLView.h
//  Texture
//
//  Created by jeff on 5/23/09.
//  Copyright Jeff LaMarche 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "ConstantsAndMacros.h"
#import "OpenGLCommon.h"
#import "Camera.h"
#import "GLViewController.h"
#import "TextureOverhead.h"

#define CONTROL_SURFACE_BOUND (160)	//macro safety
#define CONTROL_CENTER (80)
#define DEADZONE (20)
#define PI (3.141592654)
#define RAD_TO_DEG (180/PI)

@class GLViewController;
@interface GLView : UIView
{
	@private
	// The pixel dimensions of the backbuffer
	GLint backingWidth;
	GLint backingHeight;
	EAGLContext *context;
	GLuint viewRenderbuffer, viewFramebuffer;
	GLuint depthRenderbuffer;
	NSTimer *animationTimer;
	NSTimeInterval animationInterval;
	GLViewController *controller;
	BOOL controllerSetup;
	//Dictionary of UITouches -> start times
	NSMutableDictionary* touchDic;
	
	TextureOverhead	*overheadButton;

}


@property(nonatomic, assign) GLViewController *controller;
@property NSTimeInterval animationInterval;
@property(nonatomic, retain) NSMutableDictionary* touchDic;
@property(nonatomic, retain) TextureOverhead *overheadButton;
-(void)startAnimation;
-(void)stopAnimation;
-(void)drawView;
-(void)updateSelector;
- (int)getDpadButton:(UITouch*) touch;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end
