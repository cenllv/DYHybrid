//
//  DYPhotoAlbumViewController.m
//  DYHybrid
//
//  Created by danyun on 12/7/13.
//  Copyright (c) 2013 liudanyun@gmail.com. All rights reserved.
//

#import "DYPhotoScrollView.h"
#import "DYPhotoAlbumViewController.h"

@interface DYPhotoAlbumViewController()
@property (strong, nonatomic) NSArray *images;
@end

@implementation DYPhotoAlbumViewController
{
    NSInteger prevPage;
    NSInteger nextPage;
    NSArray *singlePhotoScrollViews;
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
        _currentPage = pageDel > 0 ? nextPage : prevPage;
        [self filePage];
    }
}


#pragma mark -
#pragma mark Private

- (void)displayImages:(NSArray *)images currentPage:(NSInteger)currentPage
{
    self.images = images;
    _currentPage = currentPage;
}

- (void)initSinglePhotoScrollViews
{
    self.albumScrollView.delegate = self;
    self.albumScrollView.pagingEnabled = YES;
    if (singlePhotoScrollViews.count == 0) {
        self.albumScrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.albumScrollView.frame), CGRectGetHeight(self.albumScrollView.frame));
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
        singlePhotoScrollViews = @[p, c, n];
    }
}

- (void)resetPrevAndNextPage
{
    prevPage = _currentPage > 0 ? _currentPage -1 : self.images.count -1;
    nextPage = (_currentPage + 1) % self.images.count;
}

- (void)filePage
{
    [self resetPrevAndNextPage];
    DYPhotoScrollView *p = singlePhotoScrollViews[0];
    DYPhotoScrollView *c = singlePhotoScrollViews[1];
    DYPhotoScrollView *n = singlePhotoScrollViews[2];
    [p displayImage:self.images[prevPage]];
    [c displayImage:self.images[_currentPage]];
    [n displayImage:self.images[nextPage]];
    CGRect bounds = self.albumScrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds);
    [self.albumScrollView scrollRectToVisible:bounds animated:NO];
}

@end
