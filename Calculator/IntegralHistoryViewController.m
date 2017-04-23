//
//  IntegralHistoryViewController.m
//  Calculator
//
//  Created by AlexCheetah on 4/23/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "IntegralHistoryViewController.h"
#import "CTHHistoryPreviewViewController.h"
#import "Constants.h"

@interface IntegralHistoryViewController ()

@property (assign, nonatomic) NSInteger selectedHistoryItemIndex;

@end

@implementation IntegralHistoryViewController

#pragma mark Table view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedHistoryItemIndex = indexPath.row;
    [self performSegueWithIdentifier:kIntegralHistoryItemPreviewSegue sender:self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kIntegralHistoryItemPreviewSegue]) {
        id<HistoryItemModelProtocol> item = [self.itemsArray objectAtIndex:self.selectedHistoryItemIndex];
        CTHHistoryPreviewViewController *preview = ((CTHHistoryPreviewViewController *)segue.destinationViewController);
        preview.item = item;
        preview.delegate = self.delegate;
    }
}

@end
