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
 
 Use SDWebImage to set image, refer to https://github.com/DYun/SDWebImage/blob/master/README.md
 */


@interface DYPhotoScrollView : UIScrollView<UIScrollViewDelegate>

//The image view will be zoomed
@property (strong, nonatomic, readonly) UIImageView *zoomedImageView;

- (void) displayImage:(UIImage *)image;

@end
