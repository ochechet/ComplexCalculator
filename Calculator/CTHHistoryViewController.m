//
//  CTHHistoryViewController.m
//  Calculator
//
//  Created by AlexCheetah on 3/5/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "CTHHistoryViewController.h"
#import "CTHHistoryTableViewCell.h"
#import "IpHistoryManager.h"
#import "CTHIpHistoryItemModel.h"
#import "HistoryControllerDelegate.h"

static NSString *const cellReusableIdentifier = @"historyCell";

@implementation CTHHistoryViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTHIpHistoryItemModel *infoModel = [self cellInfoForIndexPath:indexPath];
    CTHHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReusableIdentifier];
    
    cell.historyImageView.image = infoModel.image;
    cell.title.text = infoModel.title;
    cell.info.text = infoModel.info;
    
    return cell;
}

- (CTHIpHistoryItemModel *)cellInfoForIndexPath:(NSIndexPath *)indexPath {
    return [self.itemsArray objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate) {
        [self.delegate historyItemBeenSelectedAtIndex:indexPath.row];
    }
}

@end
