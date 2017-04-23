//
//  IpHistoryViewController.m
//  Calculator
//
//  Created by AlexCheetah on 4/23/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "IpHistoryViewController.h"
#import "CTHHistoryPreviewViewController.h"
#import "IpHistoryItemModel.h"
#import "Constants.h"

@interface IpHistoryViewController ()

@property (assign, nonatomic) NSInteger selectedHistoryItemIndex;

@end

@implementation IpHistoryViewController

#pragma mark Table view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedHistoryItemIndex = indexPath.row;
    [self performSegueWithIdentifier:kIpHistoryItemPreviewSegue sender:self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kIpHistoryItemPreviewSegue]) {
        IpHistoryItemModel *item = [self.itemsArray objectAtIndex:self.selectedHistoryItemIndex];
        CTHHistoryPreviewViewController *preview = ((CTHHistoryPreviewViewController *)segue.destinationViewController);
        preview.item = item;
        preview.delegate = self.delegate;
    }
}

@end
