//
//  DYUtil.h
//  DYHybrid
//
//  Created by dyun on 11/30/13.
//  Copyright (c) 2013 liudanyun@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYDateUtil : NSObject

+ (NSString *)getDateStrFromDate:(NSDate *)date format:(NSString *)format;

+ (NSString *)getDateStrFromTimeInterval:(NSTimeInterval)timeInterval format:(NSString *)format;

//Return a data represent the given year, month and day;
+ (NSDate *)dayWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end
