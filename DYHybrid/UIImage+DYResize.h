//
//  UIImage+DYResize.h
//  DYHybrid
//
//  Created by dyun on 3/12/14.
//  Copyright (c) 2014 liudanyun@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DYResize)

//crop a part from the original iamge
- (UIImage *)crop:(CGFloat) ratio;

//scale the image to a specific size
- (UIImage *)scaleToSize:(CGSize)size;
@end
