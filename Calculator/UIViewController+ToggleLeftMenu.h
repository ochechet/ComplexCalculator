//
//  UIViewController+ToggleLeftMenu.h
//  Calculator
//
//  Created by AlexCheetah on 3/5/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ToggleLeftMenu)

- (void)toggleMenu:(UIView *)menu
withLeadingConstraint:(NSLayoutConstraint *)leadingConstraint
withBackgroundView:(UIView *)background;

@end
