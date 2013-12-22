//
//  DYCalendarView.m
//  DYHybrid
//
//  Created by dyun on 12/22/13.
//  Copyright (c) 2013 liudanyun@gmail.com. All rights reserved.
//

#import "DYCalendarView.h"
#import "DYDateUtil.h"

//May provide configuration of the number in future
static NSInteger numberOfMonth = 3;

//The maximum number of a month is 6
static NSInteger numberOfMonthWeeks = 6;

@interface DYCalendarView()
{
    CGFloat dayButtonWidth;
}
@end

@implementation DYCalendarView

- (instancetype)initWithOrigin:(CGPoint)origin year:(NSInteger)year month:(NSInteger)month
{
    if ([self.calendarDelegate respondsToSelector:@selector(calendarDayButtonWidth)]) {
         dayButtonWidth = [self.calendarDelegate calendarDayButtonWidth];
    } else {
        dayButtonWidth = 40.0f;
    }
    CGSize size = CGSizeMake(320, numberOfMonthWeeks * dayButtonWidth);
    self = [super initWithFrame:(CGRect){.size=size, .origin= origin}];
    if (self) {
        self.delegate = self;
        self.contentSize = CGSizeMake(320 * numberOfMonth, numberOfMonthWeeks * dayButtonWidth);
        _date = (DYCalendarDate){.year=year, .month=month};
        [self initMontViews];
        [self resetMonthViews];
    }
    return self;
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (offset.x == 320 * (numberOfMonth - 1)) {
        _date = [self nextMonth];
    } else if (offset.x == 0) {
        _date = [self prevMonth];
    }
    [self resetMonthViews];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (offset.x == 320 * (numberOfMonth - 1)) {
        _date = [self nextMonth];
    } else if (offset.x == 0) {
        _date = [self prevMonth];
    }
    [self resetMonthViews];
}

#pragma mark -
#pragma mark IBAction and Selectors

- (void)selectDate:(DYCalendarButton *)button
{
    NSDate *day = [DYDateUtil dayWithYear:self.date.year month:self.date.month day:button.day];
    if ([self.calendarDelegate respondsToSelector:@selector(calendar:dayButton:selectDate:)]) {
        [self.calendarDelegate calendar:self dayButton:button selectDate:day];
    }
}

- (void)toPrevMonth:(id)sender {
    [self setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)toNextMonth:(id)sender {
    [self setContentOffset:CGPointMake(640, 0) animated:YES];
}


#pragma mark -
#pragma mark private

- (void)initMontViews
{
    DYCalendarMonth *current = [[DYCalendarMonth alloc]initWithFrame:CGRectMake(320, 0, 320, numberOfMonthWeeks * dayButtonWidth) buttonWidth:dayButtonWidth];
    DYCalendarMonth *prev = [[DYCalendarMonth alloc]initWithFrame:CGRectMake(0, 0, 320, numberOfMonthWeeks * dayButtonWidth) buttonWidth:dayButtonWidth];
    DYCalendarMonth *next = [[DYCalendarMonth alloc]initWithFrame:CGRectMake(640, 0, 320, numberOfMonthWeeks * dayButtonWidth) buttonWidth:dayButtonWidth];
    [self addSubview:prev];
    [self addSubview:current];
    [self addSubview:next];
    self.calendarMonthViews = @[prev, current, next];
}

- (void)resetMonthViews
{
    DYCalendarMonth *prev = self.calendarMonthViews[0];
    DYCalendarMonth *current = self.calendarMonthViews[1];
    DYCalendarMonth *next = self.calendarMonthViews[2];
    [prev resetDate:[self prevMonth]];
    [current resetDate:self.date];
    [next resetDate:[self nextMonth]];
    if ([self.calendarDelegate respondsToSelector:@selector(calendar:changeYear:month:)]) {
        [self.calendarDelegate calendar:self changeYear:self.date.year month:self.date.month];
    }
    [self scrollRectToVisible:CGRectMake(320, 0, 320, numberOfMonthWeeks * dayButtonWidth) animated:NO];
}


#pragma mark -
#pragma mark private
- (DYCalendarDate)prevMonth
{
    if (self.date.month == 1) {
        return (DYCalendarDate) {self.date.year - 1, 12};
    } else {
        return (DYCalendarDate) {self.date.year, self.date.month -1};
    }
}

- (DYCalendarDate)nextMonth
{
    if (self.date.month == 12) {
        return (DYCalendarDate) {self.date.year + 1, 1};
    } else {
        return (DYCalendarDate) {self.date.year, self.date.month +1};
    }
}

@end


@implementation DYCalendarMonth
{
    BOOL hasIntializedSubViews;
    CGFloat dayButtonWidth;
    CGFloat dayButtonPadding;
}

- (instancetype)initWithFrame:(CGRect)frame buttonWidth:(CGFloat)buttonWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        dayButtonWidth = buttonWidth;
        dayButtonPadding = (320 - 7 * dayButtonWidth) / 2;
    }
    return self;
}

- (void)layoutSubviews
{
    if (!hasIntializedSubViews) {
        for (int i = 0; i < 42; i++) {
            DYCalendarButton *button = [DYCalendarButton buttonWithType:UIButtonTypeCustom];
            NSInteger horizontalIndex = i % 7;
            NSInteger verticalIndex = i / 7;
            button.frame = CGRectMake(dayButtonPadding + horizontalIndex*dayButtonWidth, verticalIndex * dayButtonWidth, dayButtonWidth, dayButtonWidth);
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.tag = i +1;
            [button addTarget:self.superview.superview action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        hasIntializedSubViews = YES;
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDayOfMonth = [DYDateUtil dayWithYear:self.date.year month:self.date.month day:1];
    NSInteger maxDaysOfMothn = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:firstDayOfMonth].length;
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDayOfMonth];
    NSInteger weekDay = dateComponents.weekday;
    for(NSInteger i = weekDay - 1; i < weekDay + maxDaysOfMothn - 1; i++) {
        DYCalendarButton *b = (DYCalendarButton *)[self viewWithTag:i + 1] ;
        b.day = i - weekDay + 2;
        [b setTitle:[NSString stringWithFormat:@"%ld",(long)b.day] forState:UIControlStateNormal];
        b.enabled = YES;
    }
    for (NSInteger i = 0; i < weekDay - 1; i++) {
        DYCalendarButton *b = (DYCalendarButton *)[self viewWithTag:i + 1] ;
        [b setTitle:@"" forState:UIControlStateNormal];
        b.enabled = NO;
    }
    for (NSInteger i = weekDay + maxDaysOfMothn -1; i < 42; i++) {
        DYCalendarButton *b = (DYCalendarButton *)[self viewWithTag:i + 1] ;
        [b setTitle:@"" forState:UIControlStateNormal];
        b.enabled = NO;
    }
}

- (void)resetDate:(DYCalendarDate)date
{
    _date = date;
    [self setNeedsLayout];
}

@end


@implementation DYCalendarButton
@end

