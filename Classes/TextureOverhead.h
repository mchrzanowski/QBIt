//
//  GameButtons.h
//  Texture
//
//  Created by Mike Chrzanowski on 4/27/10.
//  Copyright 2010 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextureOverhead : UIViewController {
	UIImage		*destroy;
	UIImage		*grass;
	UIImage		*dirt;
	UIImage		*stone;
	UIImage		*bark;
	UIImage		*leaves;
	UIImage		*sand;
	UIImage		*gravel;
	UIImage		*cobblestone;
	UIImage		*wood;
	UIImage		*brick;
	UIImage		*goldore;
	UIImage		*pavestone;
	UIImage		*ivy;
	UIImage		*redcloth;
	UIImage		*steel;
	UIImage		*gold;
	UIImage		*diamond;
	UIImage		*orangecloth;
	UIImage		*yellowcloth;
	UIImage		*greencloth;
	UIImage		*tealcloth;
	UIImage		*limecloth;
	UIImage		*aquacloth;
	UIImage		*skycloth;
	UIImage		*darkbluecloth;
	UIImage		*purplecloth;
	UIImage		*violetcloth;
	UIImage		*magentacloth;
	UIImage		*blackcloth;
	UIImage		*greycloth;
	UIImage		*whitecloth;
	
	 
	UIButton		*destroyButton;
	UIButton		*grassButton;
	UIButton		*dirtButton;
	UIButton		*stoneButton;
	UIButton		*barkButton;
	UIButton		*leavesButton;
	UIButton		*sandButton;
	UIButton		*gravelButton;
	UIButton		*cobblestoneButton;
	UIButton		*woodButton;
	UIButton		*brickButton;
	UIButton		*goldoreButton;
	UIButton		*pavestoneButton;
	UIButton		*ivyButton;
	UIButton		*redclothButton;
	UIButton		*steelButton;
	UIButton		*goldButton;
	UIButton		*diamondButton;
	UIButton		*orangeclothButton;
	UIButton		*yellowclothButton;
	UIButton		*greenclothButton;
	UIButton		*tealclothButton;
	UIButton		*limeclothButton;
	UIButton		*aquaclothButton;
	UIButton		*skyclothButton;
	UIButton		*darkblueclothButton;
	UIButton		*purpleclothButton;
	UIButton		*violetclothButton;
	UIButton		*magentaclothButton;
	UIButton		*blackclothButton;
	UIButton		*greyclothButton;
	UIButton		*whiteclothButton;
	 
}
@property(nonatomic, retain) UIImage *destroy, *grass, *dirt, *stone, *bark, *leaves,
	*gravel, *cobblestone, *wood, *brick, *goldore, *pavestone, *ivy, *redcloth, *steel, *gold, *diamond, *orangecloth,
	*yellowcloth, *greencloth, *tealcloth, *limecloth, *aquacloth, *skycloth, *darkbluecloth, *purplecloth, *violetcloth,
	*magentacloth, *greycloth, *whitecloth, *blackcloth, *sand;
@property(nonatomic, retain) IBOutlet UIButton *destroyButton, *grassButton, *dirtButton, 
	*stoneButton, *barkButton, *leavesButton, *gravelButton, *cobblestoneButton, *woodButton, *brickButton,
*goldoreButton, *pavestoneButton, *ivyButton, *redclothButton, *steelButton, *goldButton, *diamondButton, *orangeclothButton,
*yellowclothButton, *greenclothButton, *tealclothButton, *limeclothButton, *aquaclothButton, *skyclothButton, *darkblueclothButton,
*purpleclothButton, *violetclothButton, *magentaclothButton, *greyclothButton, *whiteclothButton, *blackclothButton, *sandButton;
- (IBAction) hide;
- (IBAction) selectTexture: (id) sender;
@end