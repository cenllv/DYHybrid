//
//  DYPhotoScrollView.m
//  DYHybrid
//
//  Created by danyun on 11/30/13.
//  Copyright (c) 2013 liudanyun@gmail.com. All rights reserved.
//

#import "DYPhotoScrollView.h"

@interface DYPhotoScrollView()

- (void)initPhotoScrollView;

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

#pragma mark -
#pragma mark UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.zoomedImageView;
}

#pragma mark -
#pragma mark override

- (void)layoutSubviews
{
    [self centerScrollViewContents];
}

#pragma mark -
#pragma mark public

- (void)displayImage:(UIImage *)image
{
    _zoomedImageView.image = image;
    _zoomedImageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    self.contentSize = image.size;
    self.contentOffset = CGPointZero;
    CGFloat scaleWidth = CGRectGetWidth(self.frame) / self.contentSize.width;
    CGFloat scaleHeight = CGRectGetHeight(self.frame) / self.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    minScale = MIN(minScale, 1.0); //in case the min scale > 1.0;
    self.minimumZoomScale = minScale;
    self.maximumZoomScale = 1.0;
    self.zoomScale = minScale;
    [self centerScrollViewContents];
}

#pragma mark -
#pragma mark private

- (void)initPhotoScrollView
{
    self.delegate = self;
    self.autoresizingMask = 0xFF; //include all resizing mask
    _zoomedImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _zoomedImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.clipsToBounds = YES;
    [self addSubview:self.zoomedImageView];
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
