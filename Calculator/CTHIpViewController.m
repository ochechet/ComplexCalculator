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
#import "CALayer+Animations.h"

static NSString *const kToIpResultSegue = @"toIpResultSegue";

@interface CTHIpViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ipAddressField;
@property (weak, nonatomic) IBOutlet UIPickerView *maAddressPicker;

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
    NSString *maskAddress = self.calculator.mascAdressString;
    NSInteger maskAddressRow = ([self.calculator.posibleMaskAdresses indexOfObject:maskAddress] != NSNotFound)? [self.calculator.posibleMaskAdresses indexOfObject:maskAddress]: 0;
    [self.maAddressPicker selectRow:maskAddressRow inComponent:0 animated:YES];
    [self pickerView:self.maAddressPicker didSelectRow:maskAddressRow inComponent:0];
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

- (IBAction)calculateButtonPressed:(id)sender {
    __weak typeof (self) weakSelf = self;
    [self.calculator calculateWithCompletion:^(CTHIpResultModel *model) {
        if (!model) {
            [weakSelf.ipAddressField.layer animateWrongInput];
        } else {
            weakSelf.resultModel = model;
            [weakSelf performSegueWithIdentifier:kToIpResultSegue sender:weakSelf];
        }
    }];
}

#pragma mark - UIPickerView
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.calculator.mascAdressString = [self.calculator.posibleMaskAdresses objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.calculator.posibleMaskAdresses.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.calculator.posibleMaskAdresses objectAtIndex:row];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kToIpResultSegue]) {
        CTHIpResultTableViewController *controller = segue.destinationViewController;
        controller.resultModel = self.resultModel;
    }
}

@end
