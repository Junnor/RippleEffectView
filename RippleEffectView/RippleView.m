//
//  RippleView.m
//  RippleEffectView
//
//  Created by Ju on 16/9/7.
//  Copyright © 2016年 Ju. All rights reserved.
//

#import "RippleView.h"
#import "RippleItem.h"

@interface RippleView ()

@property (copy, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) NSArray *intervals;

@end

@implementation RippleView

- (void)showAnimationWithCenterPoint:(CGPoint)centerPoint
                           fromValue:(CGFloat)fromValue
                             toValue:(CGFloat)toValue {
    [self showAnimationWithCount:3
                   timeIntervals:@[[NSNumber numberWithDouble:0.0],
                                   [NSNumber numberWithDouble:0.5],
                                   [NSNumber numberWithDouble:1.0]]
                     centerPoint:centerPoint
                       fromValue:fromValue
                         toValue:toValue];
}

// count 必须等于 intervals.count
// 另外防止以后需要更改动画的数量,因此保留了一个内部方法。
- (void)showAnimationWithCount:(NSInteger)count
                 timeIntervals:(NSArray *)intervals
                   centerPoint:(CGPoint)centerPoint
                     fromValue:(CGFloat)fromValue
                       toValue:(CGFloat)toValue {
    
    NSAssert(count == intervals.count, @"动画效果的数量必须等于时间间隔的数量!");
    
    _intervals = intervals;
    _items = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        RippleItem *item = [[RippleItem alloc] initWithFrame:self.frame];
        item.centerPoint = centerPoint;
        item.fromValue = fromValue;
        item.toValue = toValue;
        [self.items addObject:item];
    }
    
    for (int i = 0; i < self.items.count; i++) {
        NSNumber *time = self.intervals[i];
        RippleItem *circle = self.items[i];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, time.doubleValue * (NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addSubview:circle];
        });
    }
}

- (void)restartLayersAnimation {
    for (int i = 0; i < self.items.count; i++) {
        NSNumber *time = self.intervals[i];
        RippleItem *item = self.items[i];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, time.doubleValue * (NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [item setNeedsDisplay];
        });
    }
}

@end
