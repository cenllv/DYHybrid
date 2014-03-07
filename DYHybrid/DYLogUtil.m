//
//  DYLogUtil.m
//  DYHybrid
//
//  Created by dyun on 3/7/14.
//  Copyright (c) 2014 liudanyun@gmail.com. All rights reserved.
//

#import "DYLogUtil.h"

@implementation DYLogUtil

+ (void)logViewHierarchy:(UIView *)view
{
    [self logViewHierarchy:view level:0];
}

+ (void)logViewHierarchy:(UIView *)view level:(NSInteger)level
{
    NSString *prefix = @"";
    for (int i = 0; i < level; i++) {
        prefix = [prefix stringByAppendingString:@"-----"];
    }
    NSLog(@"%@ level = %ld %@", prefix, (long)level, view);
    for (UIView *subview in view.subviews) {
        [self logViewHierarchy:subview level:level + 1];
    }
}

@end
