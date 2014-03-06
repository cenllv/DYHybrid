//
//  DYPhotoScrollView.m
//  DYHybrid
//
//  Created by danyun on 11/30/13.
//  Copyright (c) 2013 liudanyun@gmail.com. All rights reserved.
//

#import "DYPhotoScrollView.h"

static NSString *sObservedPath = @"image";

@interface DYPhotoScrollView()

//The image view will be zoomed
@property (strong, nonatomic) UIImageView *zoomedImageView;

//init the photo scroll view
//set the delegate, add observer, add the imageView subview
- (void)initPhotoScrollView;

//display the image
- (void)showImage;

@end

@implementation DYPhotoScrollView

- (instancetype)init
{
    self = [super init];
    [self initPhotoScrollView];
    return  self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self initPhotoScrollView];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self initPhotoScrollView];
    return self;
}

- (void)displayImage:(UIImage *)image
{
    self.zoomedImageView.image = image;
    [self showImage];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.zoomedImageView;
}

- (void)layoutSubviews
{
    [self centerScrollViewContents];
}

#pragma mark -
#pragma mark public

- (void)resetViewLayoutAfterRotateOrientation
{
    [self showImage];
}


#pragma mark -
#pragma mark private

- (void)initPhotoScrollView
{
    self.delegate = self;
    self.autoresizingMask = 0xFF; //include all resizing mask
    self.zoomedImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:self.zoomedImageView];
}


- (void)showImage
{
    __strong UIImage *zoomedImage = self.zoomedImageView.image;
    if (zoomedImage) {
        //for some uncertain reason, if you reuse the zoomedImageView, the scale of the second image will be incorrect.
        //todo: reuse the image view
        [self.zoomedImageView removeFromSuperview];
        self.zoomedImageView = [[UIImageView alloc]initWithImage:zoomedImage];
        self.zoomedImageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=zoomedImage.size};
        self.zoomedImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.zoomedImageView];
        self.contentSize = zoomedImage.size;
        self.contentOffset = CGPointZero;
        CGRect scrollViewFrame = self.frame;
        CGFloat scaleWidth = scrollViewFrame.size.width / self.contentSize.width;
        CGFloat scaleHeight = scrollViewFrame.size.height / self.contentSize.height;
        CGFloat minScale = MIN(scaleWidth, scaleHeight);
        minScale = MIN(minScale, 1.0); //in case the min scale > 1.0;
        self.minimumZoomScale = minScale;
        self.maximumZoomScale = 1.0;
        self.zoomScale = minScale;
        [self centerScrollViewContents];
    }
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.bounds.size;
    CGRect contentsFrame = self.zoomedImageView.frame;
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.zoomedImageView.frame = contentsFrame;
}

@end
