//
//  SettingsView.h
//  Texture
//
//  Created by Mike Chrzanowski on 4/18/10.
//  Copyright 2010 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsView : UIViewController {
	UITextField		*movementSpeedText;
	UITextField		*sensitivityText;
	
	UISlider		*movementSpeedSlider;
	UISlider		*sensitivitySlider;
}
- (IBAction) backButtonPressed;
@property(nonatomic, retain) IBOutlet UITextField *movementSpeedText, *sensitivityText;
@property(nonatomic, retain) IBOutlet UISlider *sensitivitySlider, *movementSpeedSlider;
-(IBAction) sliderMoved: (id) sender;
-(IBAction) backButtonPressed;
@end
