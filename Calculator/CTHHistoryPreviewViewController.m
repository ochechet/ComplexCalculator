//
//  CTHHistoryPreviewViewController.m
//  Calculator
//
//  Created by AlexCheetah on 3/12/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "CTHHistoryPreviewViewController.h"
#import "HistoryControllerDelegate.h"
#import "CTHIpHistoryItemModel.h"

@interface CTHHistoryPreviewViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;

@end

@implementation CTHHistoryPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.item.image;
    self.titleLabel.text = self.item.title;
    self.infoTextView.text = self.item.info;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (IBAction)applyButtonBeenTapped:(id)sender {
    [self.navigationController popToViewController:self.delegate animated:YES];
    [self.delegate applyHistoryItem:self.item];
}

- (IBAction)shareButtonBeenTapped:(id)sender {
    [self.delegate shareHistoryItem:self.item];
}

@end
