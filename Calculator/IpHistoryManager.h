//
//  IpHistoryManager.h
//  Calculator
//
//  Created by AlexCheetah on 3/12/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "IpHistoryItem.h"
#import "CTHIpHistoryItemModel.h"

@interface IpHistoryManager : NSObject

+ (instancetype) sharedManager;

@property (nonatomic, strong) NSManagedObjectContext *context;

- (void)saveIpHistoryItemWithImage:(UIImage *)image
                             title:(NSString *)title
                              info:(NSString *)info
                              meta:(NSData *)meta;
- (NSArray<CTHIpHistoryItemModel *> *)getHistoryInfoArray;
- (BOOL) itemWithMetaExist:(NSData *)meta;

@end
