//
//  HistoryControllerDelegate.h
//  Calculator
//
//  Created by AlexCheetah on 3/12/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HistoryControllerDelegate <NSObject>

- (void)historyItemBeenSelectedAtIndex:(NSInteger)index;
- (void)applyHistoryItem:(CTHIpHistoryItemModel *)item;
- (void)shareHistoryItem:(CTHIpHistoryItemModel *)item;

@end
