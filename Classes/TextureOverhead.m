//
//  GameButtons.m
//  Texture
//
//  Created by Mike Chrzanowski on 4/27/10.
//  Copyright 2010 NYU. All rights reserved.
//

#import "TextureOverhead.h"
#import "Globals.h"
#import "MapBlocks.h"
#import "ConstantsAndMacros.h"
#import "Player.h"

@implementation TextureOverhead
@synthesize destroy, grass, dirt, stone, bark, leaves, gravel, cobblestone, wood, sand,
	brick, goldore, pavestone, ivy, redcloth, steel, gold, diamond, orangecloth, yellowcloth, greencloth, tealcloth, limecloth,
	aquacloth, skycloth, darkbluecloth, purplecloth, violetcloth, magentacloth, blackcloth, greycloth, whitecloth;
@synthesize destroyButton, grassButton, dirtButton, stoneButton, barkButton, leavesButton, gravelButton, cobblestoneButton,
	woodButton, brickButton, goldoreButton, pavestoneButton, ivyButton, redclothButton, steelButton, goldButton, diamondButton,
	yellowclothButton, greenclothButton, tealclothButton, limeclothButton, aquaclothButton, skyclothButton, darkblueclothButton,
	purpleclothButton, violetclothButton, magentaclothButton, blackclothButton, greyclothButton, whiteclothButton, orangeclothButton,
	sandButton;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	// class has a scroll view. ignore the warning.
	[(UIScrollView*)[self view] setContentSize:CGSizeMake(320.f, 680.f)];

	
	destroy		= [UIImage imageNamed:@"destroy.png"];
	grass		= [UIImage imageNamed:@"grass.png"];
	dirt		= [UIImage imageNamed:@"dirt.png"];
	bark		= [UIImage imageNamed:@"bark.png"];
	stone		= [UIImage imageNamed:@"stone.png"];
	leaves		= [UIImage imageNamed:@"leaves.png"];
	gravel		= [UIImage imageNamed:@"gravel.png"];
	sand		= [UIImage imageNamed:@"sand.png"];
	cobblestone = [UIImage imageNamed:@"cobblestone.png"];
	wood		= [UIImage imageNamed:@"wood.png"];
	brick		= [UIImage imageNamed:@"brick.png"];
	goldore		= [UIImage imageNamed:@"goldore.png"];
	pavestone	= [UIImage imageNamed:@"pavestone.png"];
	ivy			= [UIImage imageNamed:@"ivy.png"];
	redcloth	= [UIImage imageNamed:@"redcloth.png"];
	steel		= [UIImage imageNamed:@"steel.png"];
	gold		= [UIImage imageNamed:@"gold.png"];
	diamond		= [UIImage imageNamed:@"diamond.png"];
	orangecloth = [UIImage imageNamed:@"orangecloth.png"];
	yellowcloth = [UIImage imageNamed:@"yellowcloth.png"];
	greencloth  = [UIImage imageNamed:@"greencloth.png"];
	tealcloth	= [UIImage imageNamed:@"tealcloth.png"];
	limecloth	= [UIImage imageNamed:@"limecloth.png"];
	aquacloth	= [UIImage imageNamed:@"aquacloth.png"];
	skycloth	= [UIImage imageNamed:@"skycloth.png"];
	darkbluecloth = [UIImage imageNamed:@"darkbluecloth.png"];
	purplecloth =	[UIImage imageNamed:@"purplecloth.png"];
	violetcloth	=	[UIImage imageNamed:@"violetcloth.png"];
	magentacloth =	[UIImage imageNamed:@"magentacloth.png"];
	blackcloth	= [UIImage imageNamed:@"blackcloth.png"];
	greycloth	= [UIImage imageNamed:@"greycloth.png"];
	whitecloth	= [UIImage imageNamed:@"whitecloth.png"];
	
	[destroyButton setImage:destroy forState: UIControlStateNormal];
	destroyButton.tag = EMPTY;
	destroyButton.alpha = 1.00f;
	  
	[grassButton setImage:grass forState: UIControlStateNormal];
	grassButton.tag = GRASS;
	
	[dirtButton setImage:dirt forState:UIControlStateNormal];
	dirtButton.tag = DIRT;
	
	[barkButton setImage:bark forState:UIControlStateNormal];
	barkButton.tag = BARK;
	
	[stoneButton setImage:stone forState:UIControlStateNormal];
	stoneButton.tag = STONE;
	
	[leavesButton setImage:leaves forState:UIControlStateNormal];
	leavesButton.tag = LEAVES;
	
	[sandButton setImage:sand forState:UIControlStateNormal];
	sandButton.tag = SAND; 
	
	[gravelButton setImage:gravel forState:UIControlStateNormal];
	gravelButton.tag = GRAVEL;
	
	[cobblestoneButton setImage:cobblestone forState:UIControlStateNormal];
	cobblestoneButton.tag = COBBLESTONE;
	
	[woodButton setImage:wood forState:UIControlStateNormal];
	woodButton.tag = WOOD;
	
	[brickButton setImage:brick forState:UIControlStateNormal];
	brickButton.tag = BRICK;
	
	[goldoreButton setImage:goldore forState:UIControlStateNormal];
	goldoreButton.tag = GOLDORE;
	
	[pavestoneButton setImage:pavestone forState:UIControlStateNormal];
	pavestoneButton.tag = PAVESTONE;
	
	[ivyButton setImage:ivy forState:UIControlStateNormal];
	ivyButton.tag = IVY;
	
	[redclothButton setImage:redcloth forState:UIControlStateNormal];
	redclothButton.tag = REDCLOTH;
	
	[steelButton setImage:steel forState:UIControlStateNormal];
	steelButton.tag = STEEL;
	
	[goldButton setImage:gold forState:UIControlStateNormal];
	goldButton.tag = GOLD;
	
	[diamondButton setImage:diamond forState:UIControlStateNormal];
	diamondButton.tag = DIAMOND;
	
	[orangeclothButton setImage:orangecloth forState:UIControlStateNormal];
	orangeclothButton.tag = ORANGECLOTH;
	
	[yellowclothButton setImage:yellowcloth forState:UIControlStateNormal];
	yellowclothButton.tag = YELLOWCLOTH;
	
	[greenclothButton setImage:greencloth forState:UIControlStateNormal];
	greenclothButton.tag = GREENCLOTH;
	
	[tealclothButton setImage:tealcloth forState:UIControlStateNormal];
	tealclothButton.tag = TEALCLOTH;
	
	[limeclothButton setImage:limecloth forState:UIControlStateNormal];
	limeclothButton.tag = LIMECLOTH;
	
	[aquaclothButton setImage:aquacloth forState:UIControlStateNormal];
	aquaclothButton.tag = AQUACLOTH;
	
	[skyclothButton setImage:skycloth forState:UIControlStateNormal];
	skyclothButton.tag = SKYCLOTH;
	
	[darkblueclothButton setImage:darkbluecloth forState:UIControlStateNormal];
	darkblueclothButton.tag = DARKBLUECLOTH;
	
	[purpleclothButton setImage:purplecloth forState:UIControlStateNormal];
	purpleclothButton.tag = PURPLECLOTH;
	
	[violetclothButton setImage:violetcloth forState:UIControlStateNormal];
	violetclothButton.tag = VIOLETCLOTH;
	
	[magentaclothButton setImage:magentacloth forState:UIControlStateNormal];
	magentaclothButton.tag = MAGENTACLOTH;
	
	[blackclothButton setImage:blackcloth forState:UIControlStateNormal];
	blackclothButton.tag = BLACKCLOTH;
	
	[greyclothButton setImage:greycloth forState:UIControlStateNormal];
	greyclothButton.tag = GREYCLOTH;
	
	[whiteclothButton setImage:whitecloth forState:UIControlStateNormal];
	whiteclothButton.tag = WHITECLOTH;
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    destroy		= nil; destroyButton	= nil;
	grass		= nil; grassButton		= nil;
	dirt		= nil; dirtButton		= nil;
	stone		= nil; stoneButton		= nil;
	bark		= nil; barkButton		= nil;
	leaves		= nil; leavesButton		= nil;
	gravel		= nil; gravelButton		= nil;
	cobblestone = nil; cobblestoneButton= nil;
	wood		= nil; woodButton		= nil;
	brick		= nil; brickButton		= nil;
	goldore		= nil; goldoreButton	= nil;
	pavestone	= nil; pavestoneButton	= nil;
	ivy			= nil; ivyButton		= nil;
	redcloth	= nil; redclothButton	= nil;
	steel		= nil; steelButton		= nil;
	gold		= nil; goldButton		= nil;
	diamond		= nil; diamondButton	= nil;
	orangecloth = nil; orangeclothButton= nil;
	yellowcloth = nil; yellowclothButton= nil;
	greencloth	= nil; greenclothButton	= nil;
	tealcloth	= nil; tealclothButton	= nil;
	limecloth	= nil; limeclothButton	= nil;
	aquacloth	= nil; aquaclothButton	= nil;
	skycloth	= nil; skyclothButton	= nil;
	darkbluecloth=nil; darkblueclothButton = nil;
	purplecloth = nil; purpleclothButton = nil;
	violetcloth = nil; violetclothButton = nil;
	magentacloth = nil;	magentaclothButton = nil;
	greycloth	= nil;	greyclothButton	= nil;
	whitecloth	= nil;	whiteclothButton = nil;
}


- (void)dealloc {
	[destroy		release];[destroyButton		release];
	[grass			release];[grassButton		release];
	[dirt			release];[dirtButton		release];
	[stone			release];[stoneButton		release];
	[bark			release];[barkButton		release];
	[leaves			release];[leavesButton		release];
	[gravel			release];[gravelButton		release];
	[cobblestone	release];[cobblestoneButton	release];
	[wood			release];[woodButton		release];	
	[brick			release];[brickButton		release];
	[goldore		release];[goldoreButton		release];
	[pavestone		release];[pavestoneButton	release];
	[ivy			release];[ivyButton			release];
	[redcloth		release];[redclothButton	release];
	[steel			release];[steelButton		release];
	[gold			release];[goldButton		release];
	[diamond		release];[diamondButton		release];
	[orangecloth	release];[orangeclothButton release];
	[yellowcloth	release];[yellowclothButton	release];
	[greencloth		release];[greenclothButton	release];
	[tealcloth		release];[tealclothButton	release];
	[limecloth		release];[limeclothButton	release];
	[aquacloth		release];[aquaclothButton	release];
	[skycloth		release];[skyclothButton	release];
	[darkbluecloth	release];[darkblueclothButton release];
	[purplecloth	release];[purpleclothButton	release];
	[violetcloth	release];[violetclothButton	release];
	[magentacloth	release];[magentaclothButton release];
	[blackcloth		release];[blackclothButton	release];
	[greycloth		release];[greyclothButton	release];
	[whitecloth		release];[whiteclothButton	release];
    [super dealloc];
}

- (IBAction) hide {
	[[self view] removeFromSuperview];
	isOverheadDisplayed = NO;		// resume opengl rendering
	overhead.hidden = NO;
	jump.hidden = NO;
}

- (IBAction) selectTexture: (id) sender{
	UIButton *temp = (UIButton *) sender;
	uint8_t textureNumber = temp.tag;
	player.action = textureNumber;

	switch(temp.tag){
		case EMPTY:
			[currentTexture setImage:destroy forState: UIControlStateNormal];
			break;
		case GRASS:
			[currentTexture setImage:grass forState: UIControlStateNormal];
			break;
		case DIRT:
			[currentTexture setImage:dirt forState: UIControlStateNormal];
			break;
		case BARK:
			[currentTexture setImage:bark forState: UIControlStateNormal];
			break;
		case STONE:
			[currentTexture setImage:stone forState: UIControlStateNormal];
			break;
		case LEAVES:
			[currentTexture setImage:leaves forState: UIControlStateNormal];
			break;
		case SAND:
			[currentTexture setImage:sand forState:UIControlStateNormal];
			break;
		case GRAVEL:
			[currentTexture setImage:gravel forState:UIControlStateNormal];
			break;
		case COBBLESTONE:
			[currentTexture setImage:cobblestone forState:UIControlStateNormal];
			break;
		case WOOD:
			[currentTexture setImage:wood forState:UIControlStateNormal];
			break;
		case BRICK:
			[currentTexture setImage:brick forState:UIControlStateNormal];
			break;
		case GOLDORE:
			[currentTexture setImage:goldore forState:UIControlStateNormal];
			break;
		case PAVESTONE:
			[currentTexture setImage:pavestone forState:UIControlStateNormal];
			break;
		case IVY:
			[currentTexture setImage:ivy forState:UIControlStateNormal];
			break;
		case REDCLOTH:
			[currentTexture setImage:redcloth forState:UIControlStateNormal];
			break;
		case STEEL:
			[currentTexture setImage:steel forState:UIControlStateNormal];
			break;
		case GOLD:
			[currentTexture setImage:gold forState:UIControlStateNormal];
			break;
		case DIAMOND:
			[currentTexture setImage:diamond forState:UIControlStateNormal];
			break;
		case ORANGECLOTH:	
			[currentTexture setImage:orangecloth forState:UIControlStateNormal];
			break;
		case YELLOWCLOTH:
			[currentTexture setImage:yellowcloth forState:UIControlStateNormal];
			break;
		case GREENCLOTH:
			[currentTexture setImage:greencloth forState:UIControlStateNormal];
			break;
		case TEALCLOTH:	
			[currentTexture setImage:tealcloth forState:UIControlStateNormal];
			break;
		case LIMECLOTH:
			[currentTexture setImage:limecloth forState:UIControlStateNormal];
			break;
		case AQUACLOTH:
			[currentTexture setImage:aquacloth forState:UIControlStateNormal];
			break;
		case SKYCLOTH:
			[currentTexture setImage:skycloth forState:UIControlStateNormal];
			break;
		case DARKBLUECLOTH:
			[currentTexture setImage:darkbluecloth forState:UIControlStateNormal];
			break;
		case PURPLECLOTH:
			[currentTexture setImage:purplecloth forState:UIControlStateNormal];
			break;
		case VIOLETCLOTH:
			[currentTexture setImage:violetcloth forState:UIControlStateNormal];
			break;
		case MAGENTACLOTH:
			[currentTexture setImage:magentacloth forState:UIControlStateNormal];
			break;
		case BLACKCLOTH:
			[currentTexture setImage:blackcloth forState:UIControlStateNormal];
			break;
		case GREYCLOTH:
			[currentTexture setImage:greycloth forState:UIControlStateNormal];
			break;
		case WHITECLOTH:
			[currentTexture setImage:whitecloth forState:UIControlStateNormal];
			break;
		default:
			[currentTexture setImage:nil forState:UIControlStateNormal];
			break;
	}
	currentTexture.transform = CGAffineTransformMakeRotation( DEGREES_TO_RADIANS(90));
	[self hide];		// hide view after selection
}
@end
