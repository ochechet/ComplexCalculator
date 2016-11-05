//
//  CTHIpViewController.m
//  Calculator
//
//  Created by Oleksandr Chechetkin on 10/10/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHIpViewController.h"
#import "CTHIpCalculator.h"
#import "Constants.h"

@interface CTHIpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *ipAddressField;
@property (weak, nonatomic) IBOutlet UITextField *macAddressField;

@property (strong, nonatomic) CTHIpCalculator *calculator;

@end

@implementation CTHIpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calculator = [[CTHIpCalculator alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.calculator refresh];
    self.ipAddressField.text = self.calculator.ipAddressString;
    self.macAddressField.text = self.calculator.macAdressString;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.calculator persist];
}

- (IBAction)leftEdgeBeenPanned:(UIScreenEdgePanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self performSegueWithIdentifier:kUnwindFormIpToMainViewController sender:self];
    }
}
- (IBAction)ipAdressFieldDidChanged:(UITextField *)sender {
    self.calculator.ipAddressString = sender.text;
}

- (IBAction)macAddressFieldDidChanged:(UITextField *)sender {
    self.calculator.macAdressString = sender.text;
}

- (IBAction)calculateButtonPressed:(id)sender {
    
}

@end
