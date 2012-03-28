//
//  TextureAppDelegate.h
//  Texture
//
//  Created by jeff on 5/23/09.
//  Copyright Jeff LaMarche 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleScreen.h"

@interface TextureAppDelegate : NSObject <UIApplicationDelegate>
{	
	TitleScreen *titleScreen;
	UIWindow *window;
}
@property(nonatomic, retain) IBOutlet TitleScreen *titleScreen;
@property(nonatomic, retain) IBOutlet UIWindow *window;
@end
