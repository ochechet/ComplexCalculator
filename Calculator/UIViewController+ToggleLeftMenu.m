//
//  UIViewController+ToggleLeftMenu.m
//  Calculator
//
//  Created by AlexCheetah on 3/5/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "UIViewController+ToggleLeftMenu.h"
#define ANIMATION_DURATION 0.8
#define DARK_BACKGROUND 0.6;

@implementation UIViewController (ToggleLeftMenu)

- (void)toggleMenu:(UIView *)menu
withLeadingConstraint:(NSLayoutConstraint *)leadingConstraint
withBackgroundView:(UIView *)background {
    
    const BOOL open = (leadingConstraint.constant < 0);
    
    if (open) {
        leadingConstraint.constant = 0;
        background.hidden = NO;
    } else {
        leadingConstraint.constant = -menu.frame.size.width;
    }
    
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
        [self.view layoutIfNeeded];
        if (open) {
            background.alpha = DARK_BACKGROUND;
        } else {
            background.alpha = 0;
        }
     } completion:^(BOOL finished) {
        background.hidden = !open;
     }];
}

@end
