//
//  CTHHistoryViewController.h
//  Calculator
//
//  Created by AlexCheetah on 3/5/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HistoryControllerDelegate;
@protocol HistoryItemModelProtocol;
@class IpHistoryItemModel;

@interface CTHHistoryViewController : UITableViewController

@property (weak, nonatomic) UIViewController<HistoryControllerDelegate> *delegate;
@property (weak, nonatomic) UIView *historyContainer;
@property (weak, nonatomic) UIBarButtonItem *historyButton;
@property (weak, nonatomic) NSLayoutConstraint *historyContainerLeadingConstraint;
@property (weak, nonatomic) UIView *historyContainerBackgroundView;

@property (strong, nonatomic) NSArray<id<HistoryItemModelProtocol>> *itemsArray;

@end
