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

+ (NSDate *)dayWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSDateComponents *components = [[NSDateComponents alloc]init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [[NSCalendar currentCalendar]dateFromComponents:components];
}

@end
