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

typedef NS_ENUM(NSInteger, HistoryItemType) {
    HistoryItemTypeIp,
    HistoryItemTypeIntegral
};

@interface HistoryManager : NSObject

+ (instancetype) sharedManager;

@property (nonatomic, strong) NSManagedObjectContext *context;

- (void)saveHistoryItemOfType:(HistoryItemType)type
                    withImage:(UIImage *)image
                        title:(NSString *)title
                         info:(NSString *)info
                         meta:(NSData *)meta;

- (NSArray*)getHistoryInfoArrayForType:(HistoryItemType)type;

- (BOOL) itemOfType:(HistoryItemType)type
      withMetaExist:(NSData *)meta;

@end
