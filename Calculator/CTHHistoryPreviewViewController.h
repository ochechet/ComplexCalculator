//
//  CTHHistoryPreviewViewController.h
//  Calculator
//
//  Created by AlexCheetah on 3/12/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IpHistoryItemModel;
@protocol HistoryItemModelProtocol;
@protocol HistoryControllerDelegate;

@interface CTHHistoryPreviewViewController : UIViewController

@property (weak, nonatomic) UIViewController<HistoryControllerDelegate> *delegate;
@property (strong, nonatomic) id<HistoryItemModelProtocol> item;

@end
