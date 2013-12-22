//
//  DYCalendarView.h
//  DYHybrid
//
//  Created by dyun on 12/22/13.
//  Copyright (c) 2013 liudanyun@gmail.com. All rights reserved.
//


#import <UIKit/UIKit.h>


//simple data structure wrapper of year, month and day
typedef struct {
    NSInteger year;
    NSInteger month;
    NSInteger day;
} DYCalendarDate;

@class DYCalendarView;
@class DYCalendarButton;

@protocol DYCalendarDelegate <NSObject>
@optional

// A date button bing clicked
- (void)calendar:(DYCalendarView *)calendar dayButton:(DYCalendarButton *)dayButton selectDate:(NSDate *)date;

- (void)calendar:(DYCalendarView *)calendar changeYear:(NSInteger)year month:(NSInteger)month;

//the width and heigh is equal to make the button appeared square
//You should not make 7 * width exceed the screen size
//If you not implement this method, we will give default value 40px, which make 20px padding to the side of screen.
- (CGFloat)calendarDayButtonWidth;

@end


/*
    The DYCalendarView is a subclass of UIScrollView which contains three subviews, 
    the DYCalendarMonthView, each represent a month and when swith month, 
    calculate the prev and next month, then redraw the three month view
    You can call toNextMonth or toPrevMonth to swith month manually or you can swip the scroll view left and right,
    When month changed, you can handle it with method of DYCalendarDelegate.
 */
@interface DYCalendarView : UIScrollView<UIScrollViewDelegate>

//instance with year and month
- (instancetype)initWithOrigin:(CGPoint)origin year:(NSInteger)year month:(NSInteger)month;

//the current date represent by the Calendar view
@property (readonly, nonatomic) DYCalendarDate date;

//There is only three month views here, each for reuse.
//When you swith to previous or next month, the 'current', 'prev', 'next' month view will be redrawed;
@property (strong, nonatomic) NSArray *calendarMonthViews;

//Delegate to handle events, such as click a date
@property (weak, nonatomic) id<DYCalendarDelegate> calendarDelegate;


//scroll the view to the previous month
- (void)toPrevMonth:(id)sender;
//scrool the view to the netx month
- (void)toNextMonth:(id)sender;
@end

//Single month view, to show the date in the month
@interface DYCalendarMonth : UIView
- (instancetype)initWithFrame:(CGRect)frame buttonWidth:(CGFloat)buttonWidth;
@property (readonly, nonatomic) DYCalendarDate date;
- (void)resetDate:(DYCalendarDate)date;
@end

//Every single button of the date
@interface DYCalendarButton : UIButton
@property (nonatomic) NSInteger day;
@end