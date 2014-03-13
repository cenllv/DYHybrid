//
//  UIImage+DYResize.m
//  DYHybrid
//
//  Created by dyun on 3/12/14.
//  Copyright (c) 2014 liudanyun@gmail.com. All rights reserved.
//

#import "UIImage+DYResize.h"

@implementation UIImage (DYResize)

- (UIImage *)crop:(CGFloat) ratio
{
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGFloat cRatio = width/height;
    cRatio > ratio ? (width = height * ratio) : (height = width / ratio);
    CGFloat x = (self.size.width-width)/2;
    CGFloat y = (self.size.height-height)/2;
    CGRect rect = CGRectMake(x*self.scale, y*self.scale, width*self.scale,height*self.scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

-(UIImage *)scaleToSize:(CGSize)size
{
    // Create a bitmap graphics context
    // This will also set it as the current context
    UIGraphicsBeginImageContext(size);
    
    // Draw the scaled image in the current context
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // Create a new image from current context
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Pop the current context from the stack
    UIGraphicsEndImageContext();
    
    // Return our new scaled image
    return scaledImage;
}


@end
