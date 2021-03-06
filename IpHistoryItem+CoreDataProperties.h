//
//  IpHistoryItem+CoreDataProperties.h
//  Calculator
//
//  Created by AlexCheetah on 4/22/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "IpHistoryItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface IpHistoryItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSString *info;
@property (nullable, nonatomic, retain) NSData *metaData;
@property (nullable, nonatomic, retain) NSString *title;

@end

NS_ASSUME_NONNULL_END
