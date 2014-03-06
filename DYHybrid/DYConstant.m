//
//  DYConstant.m
//  DYHybrid
//
//  Created by dyun on 3/6/14.
//  Copyright (c) 2014 liudanyun@gmail.com. All rights reserved.
//

#import "DYConstant.h"

@implementation DYConstant


+ (instancetype) getInstance
{
    static DYConstant *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [DYConstant new];
    });
    return instance;
}

@end
