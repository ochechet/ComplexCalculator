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
@property (weak, nonatomic) IBOutlet UILabel *broadcastAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *broadcastAddressLabelBinary;
@property (weak, nonatomic) IBOutlet UILabel *firstHostAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstHostAddressLabelBinary;
@property (weak, nonatomic) IBOutlet UILabel *lastHostAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastHostAddressLabelBinary;

@end

@implementation CTHIpResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ipAddressLabel.text = self.resultModel.ipAddress;
    self.ipAddressLabelBinary.text = self.resultModel.ipAddressBinary;
    self.maskAddressLabel.text = self.resultModel.maskAddress;
    self.maskAddressLabelBinary.text = self.resultModel.maskAddressBinary;
    self.networkAddressLabel.text = self.resultModel.networkAddress;
    self.networkAddressLabelBinary.text = self.resultModel.networkAddressBinary;
    self.hostAddressLabel.text = self.resultModel.hostAddress;
    self.hostAddressLabelBinary.text = self.resultModel.hostAddressBinary;
    self.broadcastAddressLabel.text = self.resultModel.broadcast;
    self.broadcastAddressLabelBinary.text = self.resultModel.broadcastBinary;
    self.firstHostAddressLabel.text = self.resultModel.minimalHost;
    self.firstHostAddressLabelBinary.text = self.resultModel.minimalHostBinary;
    self.lastHostAddressLabel.text = self.resultModel.maximalHost;
    self.lastHostAddressLabelBinary.text = self.resultModel.maximalHostBinary;
}

@end
