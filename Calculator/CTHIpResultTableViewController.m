//
//  CTHIpResultTableViewController.m
//  Calculator
//
//  Created by AlexCheetah on 11/5/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHIpResultTableViewController.h"

@interface CTHIpResultTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ipAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipAddressLabelBinary;
@property (weak, nonatomic) IBOutlet UILabel *maskAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *maskAddressLabelBinary;

@property (weak, nonatomic) IBOutlet UILabel *networkAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *networkAddressLabelBinary;
@property (weak, nonatomic) IBOutlet UILabel *hostAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostAddressLabelBinary;

@end

@implementation CTHIpResultTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.ipAddressLabel.text = self.resultModel.ipAddress;
    self.ipAddressLabelBinary.text = self.resultModel.ipAddressBinary;
    self.maskAddressLabel.text = self.resultModel.mascAdress;
    self.maskAddressLabelBinary.text = self.resultModel.mascAdressBinary;
    self.networkAddressLabel.text = self.resultModel.networkAddress;
    self.networkAddressLabelBinary.text = self.resultModel.networkAddressBinary;
    self.hostAddressLabel.text = self.resultModel.hostAddress;
    self.hostAddressLabelBinary.text = self.resultModel.hostAddressBinary;
}

@end
