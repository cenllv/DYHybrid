//
//  DYUtil.m
//  DYHybrid
//
//  Created by dyun on 11/30/13.
//  Copyright (c) 2013 liudanyun@gmail.com. All rights reserved.
//

#import "DYDateUtil.h"

@implementation DYDateUtil

+ (NSString *)getDateStrFromDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *f = [[NSDateFormatter alloc]init];
    [f setDateFormat:format];
    return [f stringFromDate:date];
}

+ (NSString *) getDateStrFromTimeInterval:(NSTimeInterval)timeInterval format:(NSString *)format
{
    return [self getDateStrFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval] format:format];
}

@end
