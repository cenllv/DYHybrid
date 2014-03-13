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

@protocol DYPhotoScrollViewDelegate <NSObject>

@optional
- (void)tapOnPhotoScrollView:(DYPhotoScrollView *)photScollView gestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer;

@end

@interface DYPhotoScrollView : UIScrollView<UIScrollViewDelegate>

//The image view will be zoomed
@property (strong, nonatomic, readonly) UIImageView *zoomedImageView;

@property (weak, nonatomic) id<DYPhotoScrollViewDelegate> delegate;

//The defualt scale is calculate with the size of image;
- (void)displayImage:(UIImage *)image;

- (void)displayImage:(UIImage *)image minScale:(CGFloat)minScale maxScale:(CGFloat)maxScale;

@end
