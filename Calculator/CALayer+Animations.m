//
//  CALayer+Animations.m
//  Calculator
//
//  Created by AlexCheetah on 2/5/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "CALayer+Animations.h"

@implementation CALayer (Animations)

- (void)animateWrongInput {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.1;
    anim.repeatCount = 4;
    anim.autoreverses = YES;
    anim.removedOnCompletion = YES;
    anim.fromValue = [NSNumber numberWithFloat:-5.f];
    anim.toValue = [NSNumber numberWithFloat:5.f];
    [self addAnimation:anim forKey:nil];
}

@end
