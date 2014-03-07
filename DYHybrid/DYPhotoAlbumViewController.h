//
//  DYPhotoAlbumViewController.h
//  DYHybrid
//
//  Created by danyun on 12/7/13.
//  Copyright (c) 2013 liudanyun@gmail.com. All rights reserved.
//


#import <UIKit/UIKit.h>

/*
 * For display photo or image in a scroll view, supporting paging, and infinite cycle scroll.
 * There will be only maximum three iamge in the scrollview, when scroll to next page, 
 * the passed scrollView will be reused to show the new image for performance consideration.
 *
 */

@interface DYPhotoAlbumViewController : UIViewController<UIScrollViewDelegate>
//
@property (strong, nonatomic) IBOutlet UIScrollView *albumScrollView;

- (void)displayImages:(NSArray *)images currentPage:(NSInteger)currentPage;
//the current index of the displayed image;
@property (nonatomic, readonly) NSInteger currentPage;

@end
