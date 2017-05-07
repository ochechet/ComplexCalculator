//
//  CTHHistoryViewController.m
//  Calculator
//
//  Created by AlexCheetah on 3/5/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "CTHHistoryViewController.h"
#import "HistoryItemModelProtocol.h"
#import "CTHHistoryTableViewCell.h"
#import "HistoryManager.h"
#import "HistoryControllerDelegate.h"
#import "UIViewController+ToggleLeftMenu.h"

#define ANIMATION_DURATION 0.8
#define DARK_BACKGROUND 0.6

typedef NS_ENUM(NSInteger, HistoryOpenState) {
    HistoryOpenStateOpen,
    HistoryOpenStateClosed,
    HistoryOpenStateToggle
};

static NSString *const cellReusableIdentifier = @"historyCell";

@implementation CTHHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.historyButton.target = self;
    self.historyButton.action = @selector(historyButtonBeenTapped);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self closeMenu:self.historyContainer
withLeadingConstraint:self.historyContainerLeadingConstraint
             onView:self.delegate.view
 withBackgroundView:self.historyContainerBackgroundView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<HistoryItemModelProtocol> infoModel = [self cellInfoForIndexPath:indexPath];
    CTHHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReusableIdentifier];
    
    cell.historyImageView.image = infoModel.image;
    cell.title.text = infoModel.title;
    cell.info.text = infoModel.info;
    
    return cell;
}

- (id<HistoryItemModelProtocol>)cellInfoForIndexPath:(NSIndexPath *)indexPath {
    return [self.itemsArray objectAtIndex:indexPath.row];
}

#pragma mark - History actions
- (void)toggleHistoryOpenState:(HistoryOpenState)state {
    switch (state) {
        case HistoryOpenStateOpen:
            [self openMenu:self.historyContainer
     withLeadingConstraint:self.historyContainerLeadingConstraint
                    onView:self.delegate.view
        withBackgroundView:self.historyContainerBackgroundView];
            break;
            
        case HistoryOpenStateClosed:
            [self closeMenu:self.historyContainer
      withLeadingConstraint:self.historyContainerLeadingConstraint
                     onView:self.delegate.view
         withBackgroundView:self.historyContainerBackgroundView];
            break;
            
        case HistoryOpenStateToggle:
            [self toggleMenu:self.historyContainer
       withLeadingConstraint:self.historyContainerLeadingConstraint
                      onView:self.delegate.view
          withBackgroundView:self.historyContainerBackgroundView];
            break;
            
        default:
            break;
    }
}

- (void)historyButtonBeenTapped {
    [self.tableView reloadData];
    [self toggleHistoryOpenState:HistoryOpenStateToggle];
}



@end
