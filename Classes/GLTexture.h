//
//  GLTexture.h
//  Texture
//
//  Created by scholar on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenGLCommon.h"


@interface GLTexture : NSObject {
	GLuint handle;
}

-(id) initWithTextureName:(NSString*) filename
				  andType:(NSString*) filetype;

-(void) bind;


@end
