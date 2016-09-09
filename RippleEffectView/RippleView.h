//
//  RippleView.h
//  RippleEffectView
//
//  Created by Ju on 16/9/7.
//  Copyright © 2016年 Ju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RippleView : UIView

- (void)showAnimationWithCenterPoint:(CGPoint)centerPoint
                           fromValue:(CGFloat)fromValue
                             toValue:(CGFloat)toValue;

- (void)restartLayersAnimation;

@end
