//
//  GLView.m
//  Texture
//
//  Created by jeff on 5/23/09.
//  Copyright Jeff LaMarche 2009. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>
#import "GLView.h"
#import "GameLogic.h"
#import "math.h"
#import "MapBlocks.h"
#import "Player.h"
#import "Globals.h"

@interface GLView (private)

- (id)initGLES;
- (BOOL)createFramebuffer;
- (void)destroyFramebuffer;

@end

@implementation GLView

@synthesize animationInterval;
@synthesize touchDic;
@synthesize overheadButton;

+ (Class) layerClass
{
	return [CAEAGLLayer class];
}
-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if(self != nil)
	{
		self = [self initGLES];
	}
	return self;
}

- (id)initWithCoder:(NSCoder*)coder
{
	if((self = [super initWithCoder:coder]))
	{
		self = [self initGLES];
	}	
	return self;
}

-(id)initGLES
{
	touchDic = [[NSMutableDictionary alloc] init];
	[self setMultipleTouchEnabled:YES];		// AAAAHHHHHHHH. STUPID LINE. 
	
	CAEAGLLayer *eaglLayer = (CAEAGLLayer*) self.layer;
	
	// Configure it so that it is opaque, does not retain the contents of the backbuffer when displayed, and uses RGBA8888 color.
	eaglLayer.opaque = YES;
	eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
										[NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking,
										kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat,
										nil];
	
	// Create our EAGLContext, and if successful make it current and create our framebuffer.
	context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
	if(!context || ![EAGLContext setCurrentContext:context] || ![self createFramebuffer])
	{
		[self release];
		return nil;
	}
	
	// Default the animation interval to 1/60th of a second.
	animationInterval = 1.0 / kRenderingFrequency;
	return self;
}

-(GLViewController *)controller
{
	return controller;
}

-(void)setController:(GLViewController *)d
{
	controller = d;
	controllerSetup = ![controller respondsToSelector:@selector(setupView:)];
}

// If our view is resized, we'll be asked to layout subviews.
// This is the perfect opportunity to also update the framebuffer so that it is
// the same size as our display area.
-(void)layoutSubviews
{
	[EAGLContext setCurrentContext:context];
	[self destroyFramebuffer];
	[self createFramebuffer];
	[self drawView];
}

- (BOOL)createFramebuffer
{
	// Generate IDs for a framebuffer object and a color renderbuffer
	glGenFramebuffersOES(1, &viewFramebuffer);
	glGenRenderbuffersOES(1, &viewRenderbuffer);
	
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	// This call associates the storage for the current render buffer with the EAGLDrawable (our CAEAGLLayer)
	// allowing us to draw into a buffer that will later be rendered to screen whereever the layer is (which corresponds with our view).
	[context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(id<EAGLDrawable>)self.layer];
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
	
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
	// For this sample, we also need a depth buffer, so we'll create and attach one via another renderbuffer.
	glGenRenderbuffersOES(1, &depthRenderbuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
	glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);

	if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
		return NO;
	}
	
	return YES;
}

// Clean up any buffers we have allocated.
- (void)destroyFramebuffer
{
	glDeleteFramebuffersOES(1, &viewFramebuffer);
	viewFramebuffer = 0;
	glDeleteRenderbuffersOES(1, &viewRenderbuffer);
	viewRenderbuffer = 0;
	
	if(depthRenderbuffer)
	{
		glDeleteRenderbuffersOES(1, &depthRenderbuffer);
		depthRenderbuffer = 0;
	}
}

- (void) updateSelector {
	update();
}

- (void)startAnimation
{
	animationTimer = [NSTimer scheduledTimerWithTimeInterval:animationInterval target:self selector:@selector(updateSelector) userInfo:nil repeats:YES];
}

- (void)stopAnimation
{
	[animationTimer invalidate];
	animationTimer = nil;
}

- (void)setAnimationInterval:(NSTimeInterval)interval
{
	animationInterval = interval;
	
	if(animationTimer)
	{
		[self stopAnimation];
		[self startAnimation];
	}
}

// Updates the OpenGL view when the timer fires
- (void)drawView {
	// Make sure that you are drawing to the current context
	[EAGLContext setCurrentContext:context];

	// If our drawing delegate needs to have the view setup, then call -setupView: and flag that it won't need to be called again.
	if(!controllerSetup) {
		[controller setupView:self];
		controllerSetup = YES;
	}
	
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	
	[controller drawView:self];
	
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	[context presentRenderbuffer:GL_RENDERBUFFER_OES];
	
	GLenum err = glGetError();
	if(err)
		NSLog(@"OpenGL Error Number: 0x%x", err);
}

// Stop animating and release resources when they are no longer needed.
- (void)dealloc
{
	[self stopAnimation];
	
	if([EAGLContext currentContext] == context)
	{
		[EAGLContext setCurrentContext:nil];
	}
	
	[context release];
	context = nil;
	
	[super dealloc];
}

#define NONE	(0)
#define UP		(1)
#define DOWN	(2)
#define LEFT	(3)
#define RIGHT	(4)
- (int)getDpadButton:(UITouch*) touch{
	CGPoint currentPosition = [touch locationInView: self];
	if (currentPosition.x < CONTROL_SURFACE_BOUND && currentPosition.y < CONTROL_SURFACE_BOUND) { //within the control bounds?
		float theta;
		float relativeX = currentPosition.x - CONTROL_CENTER;
		float relativeY = currentPosition.y - CONTROL_CENTER;
		
		//copied from wikipedia: determining theta from x,y coordinates
		if (relativeX > 0 && relativeY >= 0)
			theta = atan(relativeY/relativeX);
		else if (relativeX > 0 && relativeY < 0)
			theta = atan(relativeY/relativeX) + 2*PI;
		else if (relativeX < 0)
			theta = atan(relativeY/relativeX) + PI;
		else if (relativeX == 0 && relativeY > 0)
			theta = PI/2;
		else if (relativeX == 0 && relativeY < 0)
			theta = 3*PI/2;
		else
			theta = 0;
		
		theta = RAD_TO_DEG * theta;		// convert rads to degrees.
				
		if (theta >= 45 && theta <= 135) {
			return RIGHT;
		}
		else if (theta < 45 || theta >= 315) {
			return UP;
		}
		else if (theta > 135 && theta <= 225) {
			return DOWN;
		}
		else {
			return LEFT;
		}
	}
	return NONE;
		
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"touches began.");
	for (UITouch* touch in touches) {
		int button = [self getDpadButton:touch];
		switch (button) {
			case UP:
				[player setMoveForward: YES];
				break;
			case DOWN:
				[player setMoveBackward: YES];
				break;
			case LEFT:
				[player setMoveLeft: YES];
				break;
			case RIGHT:
				[player setMoveRight: YES];
				break;
			default:
			{
				//This touch was outside the Dpad, so store its starting time
				NSNumber* key = [[[NSNumber alloc] initWithInt: (int) touch] autorelease]; //address of touch
				NSNumber* val = [[[NSNumber alloc] initWithDouble: [touch timestamp]] autorelease]; //time touch started
				[touchDic setObject:val forKey:key];
				break;
			}
		}
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"touches moved.");
	[player setMoveForward: NO];
	[player setMoveBackward: NO];
	[player setMoveLeft: NO];
	[player setMoveRight: NO];
	for(UITouch* touch in [event allTouches]) {
	//	NSLog(@"touch id: %d", (int)touch);
		int button = [self getDpadButton:touch];
		switch (button) {
			case UP:
				[player setMoveForward: YES];
				break;
			case DOWN:
				[player setMoveBackward: YES];
				break;
			case LEFT:
				[player setMoveLeft: YES];
				break;
			case RIGHT:
				[player setMoveRight: YES];
				break;
			default:
			{
				
				CGPoint currentPosition = [touch locationInView: self];
				CGPoint prevPosition = [touch previousLocationInView:self];
				if(currentPosition.x != prevPosition.x){
					[player lookVertically: -LOOK_RATE * (currentPosition.x - prevPosition.x)];
				}
				if(currentPosition.y != prevPosition.y){
					[player lookHorizontally: LOOK_RATE * (currentPosition.y - prevPosition.y)];
				}
				break;
			}
		}
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	for(UITouch* touch in touches){
		int button = [self getDpadButton:touch];
		switch (button) {
			case UP:
				[player setMoveForward: NO];
				break;
			case DOWN:
				[player setMoveBackward: NO];
				break;
			case LEFT:
				[player setMoveLeft: NO];
				break;
			case RIGHT:
				[player setMoveRight: NO];
				break;
			default:
			{
				//This touch was outside the Dpad, so check if it was a tap
				NSNumber* key = [[[NSNumber alloc] initWithInt: (int) touch] autorelease]; //address of touch
				NSNumber* startTime = [touchDic objectForKey:key];
				if(startTime){
					const float kTapThreshold = 2.f;
					CGPoint currentPosition = [touch locationInView: self];
					CGPoint prevPosition = [touch previousLocationInView:self];
					//Determine if the touch meets the criteron for a tap
					if( [touch timestamp] - [startTime doubleValue] < 0.25f && 
					   fabs(currentPosition.x - prevPosition.x) < kTapThreshold &&
					   fabs(currentPosition.y - prevPosition.y) < kTapThreshold ){
						//If the player is deleting blocks, delete the selected block
						if( ![player action] ){
							Vertex3D block = [[player camera] selectedBlock];
							if( block.x >= 0 && block.y >= 0 && block.z >= 0)
								changeBlock([player action], (int)block.x, (int)block.y, (int)block.z);
						}
						//Otherwise, grab the neighbor of the selected block, and fill it with the block action type
						else{
							Vertex3D neighbor = [[player camera] selectedNeighbor];
							changeBlock([player action], (int)neighbor.x, (int)neighbor.y, (int)neighbor.z);
						}
					}
					else{
						//that wasn't a tap - respond appropriately
					}
					[touchDic removeObjectForKey:key]; //gotta do this last, because it results in key being released
				}
				break;
			}
		}
	}
}

@end
