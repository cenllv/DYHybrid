//
//  DYPhotoAlbumViewController.m
//  DYHybrid
//
//  Created by danyun on 12/7/13.
//  Copyright (c) 2013 liudanyun@gmail.com. All rights reserved.
//

#import "DYPhotoScrollView.h"
#import "DYPhotoAlbumViewController.h"


@implementation DYPhotoAlbumViewController
{
    NSInteger prevPage;
    NSInteger nextPage;
    NSArray *singlePhotoScrollViews;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //To get the right frame to init the single image view; not init in the viewDidLoad;
    [self initSinglePhotoScrollViews];
    [self filePage];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = self.albumScrollView.contentOffset;
    NSInteger pageDel = (NSInteger)(offset.x/CGRectGetWidth(scrollView.frame)) - 1;
    if (pageDel != 0) {
        self.page = pageDel > 0 ? nextPage : prevPage;
        [self filePage];
    }
}


#pragma mark -
#pragma mark Private

- (void)initSinglePhotoScrollViews
{
    if (singlePhotoScrollViews.count == 0) {
        CGRect bounds = self.albumScrollView.bounds;
        CGFloat width = CGRectGetWidth(bounds);
        CGFloat height = CGRectGetHeight(bounds);
        CGFloat startX = 0;
        DYPhotoScrollView *p = [[DYPhotoScrollView alloc]initWithFrame:CGRectMake(startX, 0, width, height)];
        [self.albumScrollView addSubview:p];
        startX += width;
        DYPhotoScrollView *c = [[DYPhotoScrollView alloc]initWithFrame:CGRectMake(startX, 0, width, height)];
        [self.albumScrollView addSubview:c];
        startX += width;
        DYPhotoScrollView *n = [[DYPhotoScrollView alloc]initWithFrame:CGRectMake(startX, 0, width, height)];
        [self.albumScrollView addSubview:n];
    }
}

- (void)resetPrevAndNextPage
{
    prevPage = self.page > 0 ? self.page -1 : self.images.count -1;
    nextPage = (self.page + 1) % self.images.count;
}

- (void)filePage
{
    [self resetPrevAndNextPage];
    DYPhotoScrollView *p = singlePhotoScrollViews[prevPage];
    DYPhotoScrollView *c = singlePhotoScrollViews[self.page];
    DYPhotoScrollView *n = singlePhotoScrollViews[nextPage];
    p.zoomedImageView.image = self.images[prevPage];
    c.zoomedImageView.image = self.images[self.page];
    n.zoomedImageView.image = self.images[nextPage];
    CGRect bounds = self.albumScrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds);
    [self.albumScrollView scrollRectToVisible:bounds animated:NO];
}

@end
