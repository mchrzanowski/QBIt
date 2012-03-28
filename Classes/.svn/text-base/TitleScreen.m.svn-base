//
//  TitleScreen.m
//  Texture
//
//  Created by Mike Chrzanowski on 4/18/10.
//  Copyright 2010 NYU. All rights reserved.
//

#import "TitleScreen.h"
#import "GameLogic.h"
#import "Globals.h"
#import "MapBlocks.h"
#import "Player.h"

@implementation TitleScreen
@synthesize overheadButtons;
@synthesize gameController;
@synthesize settings;
@synthesize openOverhead;
@synthesize	jumpButton;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
//	NSLog(@"Title screen loading");
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    gameController = nil;
	settings = nil;
	overheadButtons = nil;
	openOverhead = nil;
	jumpButton = nil;
}


- (void)dealloc {
	[gameController release];
	[settings release];
	[overheadButtons release];
	[openOverhead release];
	[jumpButton release];
	[super dealloc];
}

-(IBAction) beginGame {
	gameController = [[GLViewController alloc] init];	
	GLView *glView = [[GLView alloc] initWithFrame:properlySizedRect];
	view = glView;		// make it externally callable
	[[self view] addSubview:view];
	
	// add overhead drop-down button.
	openOverhead = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	openOverhead.frame = CGRectMake(270.f, 0.f, 50.f, 50.f);
	openOverhead.alpha = 0.42f;
	[[self view] addSubview:openOverhead];
	currentTexture = openOverhead;		// make it global.
	
	//respond on button click
	[openOverhead addTarget:self action:@selector(displayOverheadButtons) forControlEvents:UIControlEventTouchUpInside];	
	isOverheadDisplayed = NO;		// allow OpenGL to render.
	
	// add overhead view pointer.
	overheadButtons = [[TextureOverhead alloc] init];
	view.overheadButton = overheadButtons;
	overhead = openOverhead;
	
	// Rotate and translate the view. Expand view to true iPhone dimensions.
	overheadButtons.view.transform = CGAffineTransformRotate(overheadButtons.view.transform, DEGREES_TO_RADIANS(90));
	overheadButtons.view.transform = CGAffineTransformTranslate(overheadButtons.view.transform, 90.0, 70.0);
	overheadButtons.view.frame = properlySizedRect;
	
	// set up initial image for the button. assign destroction image/enum property
	UIImage *destroyImage = [UIImage imageNamed:@"destroy.png"];
	currentTexture.tag = EMPTY;
	[currentTexture setImage:destroyImage forState: UIControlStateNormal];
	
	// jump button
	jumpButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	jumpButton.frame = CGRectMake(0.f, 430.f, 50.f, 50.f);
	jumpButton.alpha = 0.42;
	[jumpButton addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
	jumpButton.transform = CGAffineTransformMakeRotation( DEGREES_TO_RADIANS(90)); 
	[jumpButton setTitle:@"J" forState:UIControlStateNormal];
	[[self view] addSubview:jumpButton]; 
	jump = jumpButton;
	
	//start game.
	view.controller = gameController;
	view.animationInterval = 1.0 / kRenderingFrequency;
	[view startAnimation];
	
	[glView release];
}

-(IBAction) displaySettings {
	settings = [[SettingsView alloc] init];
	[[self view] addSubview:settings.view];
}

-(IBAction) displayOverheadButtons {
	[[self view] addSubview:[overheadButtons view]];
	isOverheadDisplayed = YES;
	overhead.hidden = YES;
	jumpButton.hidden = YES;
}
-(IBAction) jump{
	[player jump];
}

- (IBAction) loadFromDisk {
	shouldLoadFromDisk = YES;
	[self beginGame];
}

@end
