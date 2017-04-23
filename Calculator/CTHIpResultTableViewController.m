//
//  CTHIpResultTableViewController.m
//  Calculator
//
//  Created by AlexCheetah on 11/5/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHIpResultTableViewController.h"
#import "HistoryManager.h"

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self saveHistory];
}
- (void)saveHistory {
    UIImage *image = [[UIImage alloc] init];
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 1); //making image from view
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSString *infoString = [NSString stringWithFormat:@"Ip: %@\nMask: %@\nNetwork: %@\nHost: %@\nBroadcast: %@\nFirst host: %@\nLast host: %@",self.resultModel.ipAddress, self.resultModel.maskAddress, self.resultModel.networkAddress, self.resultModel.hostAddress, self.resultModel.broadcast, self.resultModel.minimalHost, self.resultModel.maximalHost];
    
    NSDictionary *metaDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.resultModel.ipAddress, @"ip",
                                    self.resultModel.maskAddress, @"mask", nil];
    NSData *meta = [NSJSONSerialization dataWithJSONObject:metaDictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    HistoryManager *manager = [HistoryManager sharedManager];
    if (![manager itemOfType:HistoryItemTypeIp withMetaExist:meta]) {
        [manager saveHistoryItemOfType:HistoryItemTypeIp
                             withImage:image
                                 title:self.resultModel.ipAddress
                                  info:infoString
                                  meta:meta];
    }
}

@end
