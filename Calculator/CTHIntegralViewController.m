//
//  CTHIntegralViewController.m
//  Calculator
//
//  Created by Oleksandr Chechetkin on 10/10/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHIntegralViewController.h"
#import "Constants.h"

@implementation CTHIntegralViewController

- (IBAction)rightEdgeBeenPanned:(UIScreenEdgePanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self performSegueWithIdentifier:kFromIntegralToMainSegue sender:self];
    }
}

- (IBAction)unwindToIntegralViewController:(UIStoryboardSegue *)segue {
    
}

@end
