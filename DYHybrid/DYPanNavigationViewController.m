//
//  DYTNavigationViewController.m
//  ios-test
//
//  Created by dyun on 3/6/14.
//  Copyright (c) 2014 liudanyun@gmail.com. All rights reserved.
//

#import "DYPanNavigationViewController.h"

static CGFloat screenshotGap = 10.0f;

@interface DYHybridNavImageView : UIImageView
//do nothing, used for screenshot verify
@end

@implementation DYHybridNavImageView
@end


@interface DYPanNavigationViewController ()
{
    NSMutableArray *screenshotsStack;
    CGRect originFrame;
}
@end

@implementation DYPanNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    screenshotsStack = [NSMutableArray array];    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    originFrame = self.view.frame;
    [self logViewHierarchy:self.view.window level:0];
}

- (void)logViewHierarchy:(UIView *)view level:(NSInteger)level
{
    UIView * iv = [self.view.subviews firstObject];
    UIPanGestureRecognizer *ng = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panning:)];
    [iv addGestureRecognizer:ng];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIImageView *screenshot = [self getScreenshotFromView:self.view];
    if (screenshotsStack.count < self.viewControllers.count) {
        [screenshotsStack addObject:screenshot];
    } else {
        [screenshotsStack removeLastObject];
    }
    if (screenshotsStack.count > 1) {
        UIImageView *screenshot = [screenshotsStack objectAtIndex:screenshotsStack.count - 2];
        UIView *r = [self.view.window.subviews firstObject];
        if ([r isKindOfClass:[DYHybridNavImageView class]]) {
            [r removeFromSuperview];
        }
        [self.view.window insertSubview:screenshot atIndex:0];
    }
}

- (UIImageView *)getScreenshotFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 2.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    DYHybridNavImageView * iv = [[DYHybridNavImageView alloc]initWithFrame:CGRectInset(self.view.frame, screenshotGap, screenshotGap)];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    iv.autoresizingMask = 0xFF;
    iv.image = screenshot;
    return iv;
}

- (void)panning:(UIPanGestureRecognizer *)ng
{
    if (self.viewControllers.count < 2) {
        return;
    }
    CGPoint point = [ng translationInView:self.view];
    if (ng.state == UIGestureRecognizerStateChanged && point.x > 0) {
        CGRect f = self.view.frame;
        f.origin.x = point.x;
        self.view.frame = f;
        UIView *screenshot = [self.view.window.subviews firstObject];
        if ([screenshot isKindOfClass:[DYHybridNavImageView class]]) {
            [self updateSceenshotWithPanX:f.origin.x];
        }
    } else if (ng.state == UIGestureRecognizerStateEnded) {
        if (CGRectGetMinX(self.view.frame) < CGRectGetWidth(self.view.frame)/2) {
            [UIView animateWithDuration:0.3 animations:^{
                self.view.frame = originFrame;
            }];
        } else {
            [self panBack];
        }
    }
}

- (void)panBack
{
    UIView *screenshot = [self.view.window.subviews firstObject];
    if ([screenshot isKindOfClass:[DYHybridNavImageView class]]) {
        [UIView animateWithDuration:0.3 delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             screenshot.frame = CGRectMake(0, CGRectGetMinY(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
                             self.view.frame = CGRectOffset(originFrame, CGRectGetWidth(originFrame), 0);
                         } completion:^(BOOL finished) {
                             [self popViewControllerAnimated:NO];
                             self.view.frame = originFrame;
                         }];
    }
}

- (void)updateSceenshotWithPanX:(CGFloat)x
{
    CGFloat ratio = x/ CGRectGetWidth(self.view.frame);
    CGFloat delta = screenshotGap *  (1 - ratio);
    UIView *screenshot = [self.view.window.subviews firstObject];
    screenshot.frame = CGRectMake(delta, delta, CGRectGetWidth(self.view.frame) - 2 *delta, CGRectGetHeight(self.view.frame) - 2 * delta);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end