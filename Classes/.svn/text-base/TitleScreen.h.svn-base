//
//  TitleScreen.h
//  Texture
//
//  Created by Mike Chrzanowski on 4/18/10.
//  Copyright 2010 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLView.h"
#import "TextureOverhead.h"
#import "GLViewController.h"
#import "SettingsView.h"

@interface TitleScreen : UIViewController {
	TextureOverhead		*overheadButtons;
	GLViewController	*gameController;
	SettingsView		*settings;
	UIButton			*openOverhead;
	UIButton			*jumpButton;
}

@property(nonatomic, retain) IBOutlet TextureOverhead	*overheadButtons;
@property(nonatomic, retain) IBOutlet GLViewController	*gameController;
@property(nonatomic, retain) IBOutlet SettingsView		*settings;
@property(nonatomic, retain) IBOutlet UIButton			*openOverhead;
@property(nonatomic, retain) IBOutlet UIButton			*jumpButton;
- (IBAction) beginGame;
- (IBAction) displaySettings;
- (IBAction) displayOverheadButtons;
- (IBAction) jump;
- (IBAction) loadFromDisk;
@end