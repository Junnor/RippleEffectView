//
//  RippleItem.m
//  RippleEffectView
//
//  Created by Ju on 16/9/7.
//  Copyright © 2016年 Ju. All rights reserved.
//

#import "RippleItem.h"
#import <QuartzCore/QuartzCore.h>

@implementation RippleItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGRect originBounds = CGRectMake(0, 0, self.fromValue, self.fromValue);
    CGRect animationBounds = CGRectMake(-(self.toValue - self.fromValue) / 2,
                                        -(self.toValue - self.fromValue) / 2,
                                        self.toValue, self.toValue);
    
    CAShapeLayer *rectShape = [CAShapeLayer layer];
    rectShape.bounds = originBounds;
    rectShape.position = self.centerPoint;
    rectShape.cornerRadius = originBounds.size.width / 2;
    rectShape.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:rectShape];
    
    UIBezierPath *startShape = [UIBezierPath bezierPathWithRoundedRect:originBounds cornerRadius:self.fromValue / 2];
    UIBezierPath *endShape = [UIBezierPath bezierPathWithRoundedRect:animationBounds cornerRadius:self.toValue / 2];
    
    // animate the `path`
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (__bridge id _Nullable)(startShape.CGPath);
    pathAnimation.toValue = (__bridge id _Nullable)(endShape.CGPath);
    pathAnimation.removedOnCompletion = false;
    
    // animate the `opacity`
    CABasicAnimation *opAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opAnimation.removedOnCompletion = false;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.duration = 3;
    group.repeatCount = MAXFLOAT;
    group.fillMode = kCAFillModeBoth;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.animations = @[pathAnimation, opAnimation];
    
    [rectShape addAnimation:group forKey:nil];
}

@end
