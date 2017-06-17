//
//  CTHIntegralViewController.m
//  Calculator
//
//  Created by Oleksandr Chechetkin on 10/10/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHIntegralViewController.h"
#import "CTHIntegralCalculator.h"
#import "IntegralCalculationsResultModel.h"
#import "CALayer+Animations.h"

#import "UIViewController+ToggleLeftMenu.h"
#import "HistoryManager.h"
#import "CTHHistoryViewController.h"
#import "HistoryControllerDelegate.h"
#import "CTHHistoryPreviewViewController.h"
#import "IntegralHistoryItemModel.h"
#import "Constants.h"

//NOTE, ochechet: bad design!
typedef NS_ENUM(NSInteger, HistoryOpenState) {
    HistoryOpenStateOpen,
    HistoryOpenStateClosed,
    HistoryOpenStateToggle
};

@interface CTHIntegralViewController() <UITextFieldDelegate, HistoryControllerDelegate>

@property(strong, nonatomic) CTHIntegralCalculator *calculator;

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
    [self configureKeyboard];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doCustomLayout)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.historyController.itemsArray = [[HistoryManager sharedManager] getHistoryInfoArrayForType:HistoryItemTypeIntegral];
    [self doCustomLayout];
}

- (void)doCustomLayout {
    NSUserDefaults *storage = [NSUserDefaults standardUserDefaults];
    NSString *functionToUse = [storage valueForKey:kFunctionToUseKey];
    NSString *aLimitToUse = [storage valueForKey:kALimitToUseKey];
    NSString *bLimitToUse = [storage valueForKey:kBLimitToUseKey];
    
    if (functionToUse && aLimitToUse && bLimitToUse) {
        IntegralHistoryItemModel *item = [[IntegralHistoryItemModel alloc] initWithImage:nil
                                                                                   title:nil
                                                                                    info:nil
                                                                                function:functionToUse
                                                                                  aLimit:aLimitToUse
                                                                                  bLimit:bLimitToUse];
        [storage removeObjectForKey:kFunctionToUseKey];
        [storage removeObjectForKey:kALimitToUseKey];
        [storage removeObjectForKey:kBLimitToUseKey];
        [storage synchronize];
        
        [self applyHistoryItem:item];
    } else {
        [self.calculator refresh];
        self.functionFiled.text = self.calculator.function;
        self.aLimitField.text = self.calculator.aLimit;
        self.bLimitField.text = self.calculator.bLimit;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.calculator persist];
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

- (void)hideKeyBoard {
    UITextField *textField = [self getResponderTextField];
    if (textField) {
        [textField resignFirstResponder];
    }
}

#pragma mark - Actions
- (IBAction)aLimitFieldChanged:(id)sender {
    self.calculator.aLimit = self.aLimitField.text;
}

- (IBAction)bLimitFieldChanged:(id)sender {
    self.calculator.bLimit = self.bLimitField.text;
}

- (IBAction)functionFieldChanged:(id)sender {
    self.calculator.function = self.functionFiled.text;
}

#pragma mark - Calculations
- (void)calculate {
    [self hideKeyBoard];
    self.calculator.bLimit = self.bLimitField.text;
    self.calculator.aLimit = self.aLimitField.text;
    self.calculator.function = self.functionFiled.text;
    
    IntegralCalculationsResultModel *result = [self.calculator calculateDefinedIntegral];

    if (result.success) {
        [self showResultViewWithResult:result.result];
        [self saveHistory];
    } else {
        switch (result.failReason) {
            case FailReasonNoALimit:
                [self.aLimitField.layer animateWrongInput];
                break;
            case FailReasonNoBLimit:
                [self.bLimitField.layer animateWrongInput];
                break;
            case FailReasonNoFunction:
                [self.functionFiled.layer animateWrongInput];
                break;
            case FailReasonWrongLimits:
                [self.aLimitField.layer animateWrongInput];
                [self.bLimitField.layer animateWrongInput];
                break;
        }
    }
    self.historyController.itemsArray = [[HistoryManager sharedManager] getHistoryInfoArrayForType:HistoryItemTypeIntegral];
}

- (IBAction)calculateButtonPressed:(id)sender {
    [self calculate];
}

- (void)showResultViewWithResult:(double)result {
    self.resultView.hidden = NO;
    self.aResultLabel.text = self.aLimitField.text;
    self.bResultLabel.text = self.bLimitField.text;
    self.functionResultLabel.text = self.functionFiled.text;
    self.totalResultLabel.text = [NSString stringWithFormat:@"%f", result];
}

#pragma mark - History
- (void)saveHistory {
    UIImage *image = [[UIImage alloc] init];
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 1); //making image from view
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSString *infoString = [NSString stringWithFormat:@"Function: %@\nLimit a: %@\nLimit b: %@", self.functionFiled.text, self.aLimitField.text, self.bLimitField.text];
    
    NSDictionary *metaDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.functionFiled.text, kIntegralHistoryMetaKeyFunction,
                                    self.aLimitField.text, kIntegralHistoryMetaKeyALimit,
                                    self.bLimitField.text, kIntegralHistoryMetaKeyBLimit, nil];
    NSData *meta = [NSJSONSerialization dataWithJSONObject:metaDictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    HistoryManager *manager = [HistoryManager sharedManager];
    if (![manager itemOfType:HistoryItemTypeIntegral withMetaExist:meta]) {
        [manager saveHistoryItemOfType:HistoryItemTypeIntegral
                             withImage:image
                                 title:self.functionFiled.text
                                  info:infoString
                                  meta:meta];
    }
}

- (void)applyHistoryItem:(id<HistoryItemModelProtocol>)item {
    IntegralHistoryItemModel *integralItem = (IntegralHistoryItemModel *)item;
    self.functionFiled.text = integralItem.function;
    self.aLimitField.text = integralItem.aLimit;
    self.bLimitField.text = integralItem.bLimit;

    [self calculate];
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
