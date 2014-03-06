//
//  DYConstant.h
//  DYHybrid
//
//  Created by dyun on 3/6/14.
//  Copyright (c) 2014 liudanyun@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define DY_SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface DYConstant : NSObject

+ (instancetype) getInstance;

@property (nonatomic) CGSize screenSize;

@end
