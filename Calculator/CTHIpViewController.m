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

#import "HistoryManager.h"
#import "CTHHistoryViewController.h"
#import "HistoryControllerDelegate.h"
#import "CTHHistoryPreviewViewController.h"
#import "IpHistoryItemModel.h"

static NSString *const kToIpResultSegue = @"toIpResultSegue";

typedef NS_ENUM(NSInteger, HistoryOpenState) {
    HistoryOpenStateOpen,
    HistoryOpenStateClosed,
    HistoryOpenStateToggle
};

@interface CTHIpViewController () <UIPickerViewDataSource, UIPickerViewDelegate, HistoryControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ipAddressField;
@property (weak, nonatomic) IBOutlet UIPickerView *maAddressPicker;

@property (strong, nonatomic) CTHIpCalculator *calculator;
@property (strong, nonatomic) CTHIpResultModel *resultModel;

@property (weak, nonatomic) CTHHistoryViewController *historyController;
@property (weak, nonatomic) IBOutlet UIView *historyContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *historyContainerLeadingConstraint;
@property (weak, nonatomic) IBOutlet UIView *historyContainerBackgroundView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *historyButton;

@end

@implementation CTHIpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calculator = [[CTHIpCalculator alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *storage = [NSUserDefaults standardUserDefaults];
    NSString *ipToUse = [storage valueForKey:kIpToUseKey];
    NSString *maskToUse = [storage valueForKey:kMaskToUseKey];
    
    self.historyController.itemsArray = [[HistoryManager sharedManager] getHistoryInfoArrayForType:HistoryItemTypeIp];
    
    if (ipToUse && maskToUse) {
        IpHistoryItemModel *item = [[IpHistoryItemModel alloc] initWithImage:nil title:nil info:nil ip:ipToUse mask:maskToUse];
        [storage removeObjectForKey:kIpToUseKey];
        [storage removeObjectForKey:kMaskToUseKey];
        [storage synchronize];

        [self applyHistoryItem:item];
        
    } else {
        [self.calculator refresh];
        self.ipAddressField.text = self.calculator.ipAddressString;
        [self selectMaskAddress:self.calculator.mascAdressString];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.calculator persist];
}

- (IBAction)ipAdressFieldDidChanged:(UITextField *)sender {
    self.calculator.ipAddressString = sender.text;
}

- (IBAction)calculateButtonPressed:(id)sender {
    [self performCalculation];
}

- (void)performCalculation {
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

#pragma mark - HistoryControllerDelegate
- (void)applyHistoryItem:(IpHistoryItemModel *)item {
    self.ipAddressField.text = item.ip;
    [self selectMaskAddress:item.mask];
    
    self.calculator.ipAddressString = item.ip;
    self.calculator.mascAdressString = item.mask;
    [self performCalculation];
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

- (void)selectMaskAddress:(NSString *)mask {
    NSInteger maskAddressRow = ([self.calculator.posibleMaskAdresses indexOfObject:mask] != NSNotFound)? [self.calculator.posibleMaskAdresses indexOfObject:mask]: 0;
    [self.maAddressPicker selectRow:maskAddressRow inComponent:0 animated:YES];
    [self pickerView:self.maAddressPicker didSelectRow:maskAddressRow inComponent:0];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kToIpResultSegue]) {
        CTHIpResultTableViewController *controller = segue.destinationViewController;
        controller.resultModel = self.resultModel;
    } else if ([segue.identifier isEqualToString:kIpEmbedHistorySegue]) {
        self.historyController = segue.destinationViewController;
        self.historyController.delegate = self;
        self.historyController.itemsArray = [[HistoryManager sharedManager] getHistoryInfoArrayForType:HistoryItemTypeIp];
        self.historyController.historyContainer = self.historyContainer;
        self.historyController.historyButton = self.historyButton;
        self.historyController.historyContainerLeadingConstraint = self.historyContainerLeadingConstraint;
        self.historyController.historyContainerBackgroundView = self.historyContainerBackgroundView;
    }
}

@end
