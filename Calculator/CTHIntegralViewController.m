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

@interface CTHIntegralViewController() <UITextFieldDelegate>

@property(strong, nonatomic) CTHIntegralCalculator *calculator;
@property(strong, nonatomic) CTHFunctionParser *parser;

@property (weak, nonatomic) IBOutlet UITextField *aLimitField;
@property (weak, nonatomic) IBOutlet UITextField *bLimitField;
@property (weak, nonatomic) IBOutlet UITextField *functionFiled;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *functionButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numericButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *operationButtons;

@end

@implementation CTHIntegralViewController

#pragma mark - initialization
- (void)viewDidLoad {
    self.calculator = [[CTHIntegralCalculator alloc] init];
    self.parser = [[CTHFunctionParser alloc] init];
    
    [self configureKeyboard];
}

- (void)configureKeyboard {
    NSString *nibName = @"CTHIntegralCalculatorKeyboardView";
    UIView *keyboard = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] lastObject];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonBeenPressed:)];
    UIToolbar *tipBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    tipBar.barStyle = UIBarStyleDefault;
    tipBar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], done, nil];
    [tipBar sizeToFit];
    
    self.functionFiled.inputView = keyboard;
    self.aLimitField.inputView = keyboard;
    self.bLimitField.inputView = keyboard;
    
    self.functionFiled.inputAccessoryView = tipBar;
    self.aLimitField.inputAccessoryView = tipBar;
    self.bLimitField.inputAccessoryView = tipBar;
    
    self.functionFiled.inputAssistantItem.leadingBarButtonGroups = @[];
    self.functionFiled.inputAssistantItem.trailingBarButtonGroups = @[];
    self.aLimitField.inputAssistantItem.leadingBarButtonGroups = @[];
    self.aLimitField.inputAssistantItem.trailingBarButtonGroups = @[];
    self.bLimitField.inputAssistantItem.leadingBarButtonGroups = @[];
    self.bLimitField.inputAssistantItem.trailingBarButtonGroups = @[];
    
    self.functionFiled.delegate = self;
    self.aLimitField.delegate = self;
    self.bLimitField.delegate = self;
    
}

#pragma mark - Keyboard

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self setAllButtonsEnabled:YES];
    if (self.functionFiled == textField) {
        [self setNumericButtonsEnabled:NO];
    } else if (self.aLimitField == textField) {
        [self setFunctionButtonsEnabled:NO];
        [self setOperationButtonsEnabled:NO];
    } else if (self.bLimitField == textField) {
        [self setFunctionButtonsEnabled:NO];
        [self setOperationButtonsEnabled:NO];
    }
    return YES;
}

- (IBAction)keyboardButtonPressed:(UIButton *)sender {
    UITextField *textField = [self getResponderTextField];
    if (textField) {
        textField.text = [NSString stringWithFormat:@"%@%@",textField.text, sender.titleLabel.text];
    }
}

- (UITextField *)getResponderTextField {
    if ([self.functionFiled isFirstResponder]) {
        return self.functionFiled;
    }
    if ([self.aLimitField isFirstResponder]) {
        return self.aLimitField;
    }
    if ([self.bLimitField isFirstResponder]) {
        return self.bLimitField;
    }
    return nil;
}

- (void)setNumericButtonsEnabled:(BOOL)enabled {
    for (UIButton *button in self.numericButtons) {
        button.enabled = enabled;
    }
}

- (void)setFunctionButtonsEnabled:(BOOL)enabled {
    for (UIButton *button in self.functionButtons) {
        button.enabled = enabled;
    }
}

- (void)setOperationButtonsEnabled:(BOOL)enabled {
    for (UIButton *button in self.operationButtons) {
        button.enabled = enabled;
    }
}

- (void)setAllButtonsEnabled:(BOOL)enabled {
    [self setNumericButtonsEnabled:enabled];
    [self setOperationButtonsEnabled:enabled];
    [self setFunctionButtonsEnabled:enabled];
}

- (IBAction)clearButtonPressed:(id)sender {
    UITextField *textField = [self getResponderTextField];
    if (textField && textField.text.length) {
        textField.text = [textField.text substringToIndex:(textField.text.length - 1)];
    }
}

- (void)doneButtonBeenPressed:(id)sender {
    [self hideKeyBoard];
}

- (IBAction)tapBeenHandled:(id)sender {
    [self hideKeyBoard];
}

- (void)hideKeyBoard {
    UITextField *textField = [self getResponderTextField];
    if (textField) {
        [textField resignFirstResponder];
    }
}

#pragma mark - Calculations
- (IBAction)calculateButtonPressed:(id)sender {
    if (![self validateInput]) {
        return ;
    }
    double(^block)(double x) = [self.parser getFunctionFromString:self.functionFiled.text];
    double r = [self.calculator calculateDefinedIntegralWithFunction:block
                                                fromLimit:getDouble(self.aLimitField.text)
                                                  toLimit:getDouble(self.bLimitField.text)];
    NSLog(@"%f", r);
}

- (bool)validateInput {
    if (false/*function*/) {
        [self.functionFiled.layer animateWrongInput];
        return NO;
    }
    
    if (![CTHCalculationUtil isNumeric:self.aLimitField.text]) {
        [self.aLimitField.layer animateWrongInput];
        return NO;
    }
    
    if (![CTHCalculationUtil isNumeric:self.bLimitField.text]) {
        [self.bLimitField.layer animateWrongInput];
        return NO;
    }
    
    if (getDouble(self.aLimitField.text) >= getDouble(self.bLimitField.text)){
        [self.aLimitField.layer animateWrongInput];
        [self.bLimitField.layer animateWrongInput];
        return NO;
    }
    
    return YES;
}

@end
