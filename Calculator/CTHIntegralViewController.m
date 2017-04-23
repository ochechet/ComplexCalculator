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
#import "UIViewController+ToggleLeftMenu.h"
#import "HistoryManager.h"
#import "CTHHistoryViewController.h"
#import "HistoryControllerDelegate.h"
#import "CTHHistoryPreviewViewController.h"
#import "IpHistoryItemModel.h"
#import "Constants.h"

//NOTE, ochechet: bad design!
typedef NS_ENUM(NSInteger, HistoryOpenState) {
    HistoryOpenStateOpen,
    HistoryOpenStateClosed,
    HistoryOpenStateToggle
};

@interface CTHIntegralViewController() <UITextFieldDelegate, HistoryControllerDelegate>

@property(strong, nonatomic) CTHIntegralCalculator *calculator;
@property(strong, nonatomic) CTHFunctionParser *parser;

@property (weak, nonatomic) IBOutlet UITextField *aLimitField;
@property (weak, nonatomic) IBOutlet UITextField *bLimitField;
@property (weak, nonatomic) IBOutlet UITextField *functionFiled;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *functionButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numericButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *operationButtons;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *equalButton;

@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet UILabel *bResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *aResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *functionResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalResultLabel;

@property (weak, nonatomic) CTHHistoryViewController *historyController;
@property (weak, nonatomic) IBOutlet UIView *historyContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *historyContainerLeadingConstraint;
@property (weak, nonatomic) IBOutlet UIView *historyContainerBackgroundView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *historyButton;

@end

@implementation CTHIntegralViewController

#pragma mark - initialization
- (void)viewDidLoad {
    self.calculator = [[CTHIntegralCalculator alloc] init];
    self.parser = [[CTHFunctionParser alloc] init];
    
    [self configureKeyboard];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.historyController.itemsArray = [[HistoryManager sharedManager] getHistoryInfoArrayForType:HistoryItemTypeIntegral];
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
    
    NSArray *allButtons = [[[[NSArray arrayWithArray:self.functionButtons]
                             arrayByAddingObjectsFromArray:self.numericButtons]
                            arrayByAddingObjectsFromArray:self.operationButtons]
                           arrayByAddingObjectsFromArray:@[self.clearButton, self.equalButton]];
    
    CGFloat radius = ((self.clearButton.frame.size.height + self.clearButton.frame.size.width) / 2) * 0.1;
    for (UIButton *button in allButtons) {
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = radius;
    }
    
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
/*
- (IBAction)tapBeenHandled:(id)sender {
    [self hideKeyBoard];

}
*/
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
    [self showResultViewWithResult:r];
    [self saveHistory];
}

- (void)showResultViewWithResult:(double)result {
    self.resultView.hidden = NO;
    self.aResultLabel.text = self.aLimitField.text;
    self.bResultLabel.text = self.bLimitField.text;
    self.functionResultLabel.text = self.functionFiled.text;
    self.totalResultLabel.text = [NSString stringWithFormat:@"%f", result];
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

#pragma mark - History
- (void)saveHistory {
    UIImage *image = [[UIImage alloc] init];
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 1); //making image from view
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSString *infoString = @"INFO";/*[NSString stringWithFormat:@"Ip: %@\nMask: %@\nNetwork: %@\nHost: %@\nBroadcast: %@\nFirst host: %@\nLast host: %@",self.resultModel.ipAddress, self.resultModel.maskAddress, self.resultModel.networkAddress, self.resultModel.hostAddress, self.resultModel.broadcast, self.resultModel.minimalHost, self.resultModel.maximalHost];*/
    
    NSDictionary *metaDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"ONE", @"one",
                                    @"TWO", @"two", nil];
    NSData *meta = [NSJSONSerialization dataWithJSONObject:metaDictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    HistoryManager *manager = [HistoryManager sharedManager];
    if (![manager itemOfType:HistoryItemTypeIp withMetaExist:meta]) {
        [manager saveHistoryItemOfType:HistoryItemTypeIntegral
                             withImage:image
                                 title:@"TITLE"
                                  info:infoString
                                  meta:meta];
    }
}

- (void)applyHistoryItem:(IpHistoryItemModel *)item {
    
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kIntegralEmbedHistorySegue]) {
        self.historyController = segue.destinationViewController;
        self.historyController.delegate = self;
        self.historyController.itemsArray = [[HistoryManager sharedManager] getHistoryInfoArrayForType:HistoryItemTypeIntegral];
        self.historyController.historyContainer = self.historyContainer;
        self.historyController.historyButton = self.historyButton;
        self.historyController.historyContainerLeadingConstraint = self.historyContainerLeadingConstraint;
        self.historyController.historyContainerBackgroundView = self.historyContainerBackgroundView;
    }
}

@end
