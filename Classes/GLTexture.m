//
//  GLTexture.m
//  Texture
//
//  Created by scholar on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GLTexture.h"


@implementation GLTexture

-(id) initWithTextureName:(NSString*) filename
				  andType:(NSString*) filetype{
	NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:filetype];
	NSData *texData = [[NSData alloc] initWithContentsOfFile:path];
    UIImage *image = [[UIImage alloc] initWithData:texData];
    
    if (image == nil)
        [NSException raise:@"Texture load error" format:@"unable to find image file %@.%@", filename, filetype];
    
 	GLuint width = CGImageGetWidth(image.CGImage);
    GLuint height = CGImageGetHeight(image.CGImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    void *imageData = malloc( height * width * 4 );
    CGContextRef context = CGBitmapContextCreate( imageData, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
	
    // Flip the Y-axis
    CGContextTranslateCTM (context, 0, height);
    CGContextScaleCTM (context, 1.0, -1.0);
    
    CGColorSpaceRelease( colorSpace );
    CGContextClearRect( context, CGRectMake( 0, 0, width, height ) );
    CGContextDrawImage( context, CGRectMake( 0, 0, width, height ), image.CGImage );
	
	// Bind the number of textures we need, in this case one.
    glGenTextures(1, &handle);
    glBindTexture(GL_TEXTURE_2D, handle);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST); 
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
	
    CGContextRelease(context);
    
    free(imageData);
    [image release];
    [texData release];
	
	return self;
}

-(void) bind{
	glBindTexture(GL_TEXTURE_2D, handle);
}


@end
