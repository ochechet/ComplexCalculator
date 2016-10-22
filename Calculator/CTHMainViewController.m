//
//  CTHMainViewController.m
//  Calculator
//
//  Created by Oleksandr Chechetkin on 10/10/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHMainViewController.h"
#import "CTHIntegralViewController.h"
#import "Constants.h"

@implementation CTHMainViewController

- (IBAction)leftEdgeBeenPanned:(UIScreenEdgePanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self performSegueWithIdentifier:kToIntegralViewControllerSegue sender:self];
    }
}
- (IBAction)rightEdgeBeenPanned:(UIScreenEdgePanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self performSegueWithIdentifier:kToIpViewControllerSegue sender:self];
    }
}


@end
