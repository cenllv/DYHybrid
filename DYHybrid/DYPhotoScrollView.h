//
//  DYPhotoScrollView.h
//  DYHybrid
//
//  Created by danyun on 11/30/13.
//  Copyright (c) 2013 liudanyun@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 DYPhotoScrollView is used to view photo and support zoom in and zoom out.
 The minimum zoom scale = MIN(widthOfImage/widthOfScrollView, heightOfImage/heightOfScrollView)
 The maximum zoom scale = 1.0
 
 Initial the DYPhotoScrollView and set image of the zoomedImageView, you can also use SDWebImage to load image remotely.
 
 DYPhotoScrollView *v = [DYPhotoScrollView alloc]initWithFrame:];
 v.zoomedImageView.image = [UIImage imageNamed:@""];
 or
 Use SDWebImage to set image, refer to https://github.com/DYun/SDWebImage/blob/master/README.md, however, it is better
 to set a placholder
 
 */


@interface DYPhotoScrollView : UIScrollView<UIScrollViewDelegate>

- (void) resetViewLayoutAfterRotateOrientation;

- (void) displayImage:(UIImage *)image;

//centralize the zoomed view in the zooming process
- (void)centerScrollViewContents;

@end
