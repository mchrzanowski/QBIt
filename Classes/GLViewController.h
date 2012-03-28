//
//  GLViewController.h
//  Texture
//
//


#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "GLTexture.h"
#import "Camera.h"


@class GLView;
@interface GLViewController : UIViewController {
    GLTexture	*dPad;
	GLTexture	*terrainTex;
	GLTexture	*cloudTex;
	
}
@property(retain, nonatomic) GLTexture *dPad;
@property(retain, nonatomic) GLTexture *terrainTex;
- (void)drawView:(GLView*)view;
- (void)setupView:(GLView*)view;
@end
