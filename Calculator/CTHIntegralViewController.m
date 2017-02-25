//
//  CTHIntegralViewController.m
//  Calculator
//
//  Created by Oleksandr Chechetkin on 10/10/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHIntegralViewController.h"
#import "CTHIntegralCalculator.h"
#import "CTHFunctionParser.h"
#import "CALayer+Animations.h"
#import "CTHCalculationUtil.h"

@interface CTHIntegralViewController()

@property(strong, nonatomic) CTHIntegralCalculator *calculator;
@property(strong, nonatomic) CTHFunctionParser *parser;

@property (weak, nonatomic) IBOutlet UITextField *aLimitField;
@property (weak, nonatomic) IBOutlet UITextField *bLimitField;
@property (weak, nonatomic) IBOutlet UITextField *functionFiled;

@end

@implementation CTHIntegralViewController

- (void)viewDidLoad {
    self.calculator = [[CTHIntegralCalculator alloc] init];
    self.parser = [[CTHFunctionParser alloc] init];
}

- (IBAction)calculateButtonPressed:(id)sender {
    if (![self validateInput]) {
        return ;
    }
    
    double(^block)(double x) = [self.parser getFunctionFromString:self.functionFiled.text];
    
    double r = [self.calculator calculateDefinedIntegralWithFunction:block
                                                fromLimit:[self.aLimitField.text doubleValue]
                                                  toLimit:[self.bLimitField.text doubleValue]];
    NSLog(@"%f", r);
}

- (bool)validateInput {
    if (false/*function*/) {
        [self.functionFiled.layer animateWrongInput];
    } else if (![CTHCalculationUtil isNumeric:self.aLimitField.text]) {
        [self.aLimitField.layer animateWrongInput];
    } else if (![CTHCalculationUtil isNumeric:self.bLimitField.text]) {
        [self.bLimitField.layer animateWrongInput];
    } else if ([self.aLimitField.text doubleValue] <= [self.bLimitField.text doubleValue]){
        [self.aLimitField.layer animateWrongInput];
        [self.bLimitField.layer animateWrongInput];
    } else {
        
    }
    return true;
}

@end
