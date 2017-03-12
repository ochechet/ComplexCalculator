//
//  CTHHistoryViewController.h
//  Calculator
//
//  Created by AlexCheetah on 3/5/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HistoryControllerDelegate;
@class CTHIpHistoryItemModel;

@interface CTHHistoryViewController : UITableViewController

@property (weak, nonatomic) id<HistoryControllerDelegate> delegate;
@property (strong, nonatomic) NSArray<CTHIpHistoryItemModel *> *itemsArray;

@end
