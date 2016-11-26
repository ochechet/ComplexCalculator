//
//  CTHIpViewController.m
//  Calculator
//
//  Created by Oleksandr Chechetkin on 10/10/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHIpViewController.h"
#import "CTHIpCalculator.h"
#import "CTHIpResultTableViewController.h"
#import "Constants.h"

static NSString *const kToIpResultSegue = @"toIpResultSegue";

@interface CTHIpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *ipAddressField;
@property (weak, nonatomic) IBOutlet UITextField *macAddressField;

@property (strong, nonatomic) CTHIpCalculator *calculator;
@property (strong, nonatomic) CTHIpResultModel *resultModel;

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
    self.macAddressField.text = self.calculator.mascAdressString;
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
    self.calculator.mascAdressString = sender.text;
}

- (IBAction)calculateButtonPressed:(id)sender {
    __weak typeof (self) weakSelf = self;
    [self.calculator calculateWithCompletion:^(CTHIpResultModel *model) {
        [weakSelf performSegueWithIdentifier:kToIpResultSegue sender:weakSelf];
    }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kToIpResultSegue]) {
        CTHIpResultTableViewController *controller = segue.destinationViewController;
        controller.resultModel = self.resultModel;
    }
}

@end
