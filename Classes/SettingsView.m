//
//  SettingsView.m
//  Texture
//
//  Created by Mike Chrzanowski on 4/18/10.
//  Copyright 2010 NYU. All rights reserved.
//

#import "SettingsView.h"
#import "Globals.h"


@implementation SettingsView
@synthesize	sensitivityText, movementSpeedText;
@synthesize sensitivitySlider, movementSpeedSlider;

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
	// initialize sliders and text fields to correct values with every load.
	movementSpeedSlider.value = MOVE_RATE;
	sensitivitySlider.value = LOOK_RATE;
	
	
	movementSpeedSlider.maximumValue = 10.f;
	movementSpeedSlider.minimumValue = 1.f;;
	
	sensitivitySlider.maximumValue = 2.f;
	sensitivitySlider.minimumValue = 0.1;
	
	movementSpeedText.text	= [NSString stringWithFormat:@"%.1f", movementSpeedSlider.value];
	sensitivityText.text	= [NSString stringWithFormat:@"%.1f", sensitivitySlider.value];
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
	movementSpeedText = nil;
	movementSpeedSlider = nil;
    sensitivityText = nil;
	sensitivitySlider = nil;
	//[super viewDidUnload];
}


- (void)dealloc {
	[movementSpeedText release];
	[movementSpeedSlider release];
	[sensitivityText release];
	[sensitivitySlider release];
    [super dealloc];
}

- (IBAction) backButtonPressed {
	// remove this view.
	[[self view] removeFromSuperview];
}

- (IBAction) sliderMoved: (id) sender {
	UISlider *temp = (UISlider *)sender;
	NSInteger sliderNumber = temp.tag;
	
	if (sliderNumber == 0){ 	// movement speed
		movementSpeedText.text = [NSString stringWithFormat:@"%.1f", temp.value];
		MOVE_RATE = temp.value;
	}
	else { 
		sensitivityText.text = [NSString stringWithFormat:@"%.1f", temp.value];
		LOOK_RATE = temp.value;
	}
}

@end
