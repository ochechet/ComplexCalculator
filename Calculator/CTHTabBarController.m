//
//  CTHTabBarController.m
//  Calculator
//
//  Created by AlexCheetah on 3/26/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "CTHTabBarController.h"
#import "Constants.h"

typedef NS_ENUM(NSInteger, TabBarsType) {
    TabBarsTypeIp,
    TabBarsTypeMain,
    TabBarsTypeIntegral
};

@interface CTHTabBarController () <UITabBarControllerDelegate>

@end

@implementation CTHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTabIfNeeded) name:kTabNeedsRefresh object:nil];
    
    self.delegate = self;
    [self changeTabIfNeeded];
}

- (void)changeTabIfNeeded {
    NSUserDefaults *storage = [NSUserDefaults standardUserDefaults];
    NSString *tabKey = [storage valueForKey:kOpenTabKey];
    if ([tabKey isEqualToString:kOpenTabTypeIp]) {
        NSInteger neededIndex = [self indexForViewControllerType:TabBarsTypeIp];
        [self.delegate tabBarController:self shouldSelectViewController:[[self viewControllers] objectAtIndex:neededIndex]];
        [self setSelectedIndex:neededIndex];
        [storage removeObjectForKey:kOpenTabKey];
    } else if ([tabKey isEqualToString:kOpenTabTypeIntegral]) {
        NSInteger neededIndex = [self indexForViewControllerType:TabBarsTypeIntegral];
        [self.delegate tabBarController:self shouldSelectViewController:[[self viewControllers] objectAtIndex:neededIndex]];
        [self setSelectedIndex:neededIndex];
        [storage removeObjectForKey:kOpenTabKey];
    }
    [storage synchronize];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

- (NSInteger)indexForViewControllerType:(TabBarsType)type {
    int index = 0;
    if (type == TabBarsTypeIp) {
        index = 1;
    } else if (type == TabBarsTypeIntegral) {
        index = 2;
    }
    return index;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
