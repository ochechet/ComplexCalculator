//
//  IpHistoryManager.m
//  Calculator
//
//  Created by AlexCheetah on 3/12/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "IpHistoryManager.h"
#import "AppDelegate.h"

static NSString *const IpHistoryItemCoreDataName = @"IpHistoryItem";

@implementation IpHistoryManager

+ (instancetype) sharedManager
{
    static IpHistoryManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IpHistoryManager alloc] init];
    });
    return instance;
}

- (NSManagedObjectContext *)context
{
    if (!_context)
    {
        AppDelegate *delegate = [AppDelegate sharedDelegate];
        _context = delegate.managedObjectContext;
    }
    return _context;
}

- (void)saveIpHistoryItemWithImage:(UIImage *)image
                             title:(NSString *)title
                              info:(NSString *)info {
    IpHistoryItem *item = [NSEntityDescription insertNewObjectForEntityForName:IpHistoryItemCoreDataName
                                                        inManagedObjectContext:self.context];
    item.image = UIImageJPEGRepresentation(image, 1.0);
    item.title = title;
    item.info = info;
    [self.context save:nil];
}

- (NSArray<CTHIpHistoryItemModel *> *) getHistoryInfoArray {
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription * description =
    [NSEntityDescription entityForName:IpHistoryItemCoreDataName
                inManagedObjectContext:self.context];
    [request setEntity:description];
    
    NSArray *fetchResult = [self.context executeFetchRequest:request error:nil];
    NSMutableArray *result = [NSMutableArray array];
    
    for (IpHistoryItem *item in fetchResult) {
        CTHIpHistoryItemModel *model = [[CTHIpHistoryItemModel alloc] initWithImage:[UIImage imageWithData:item.image]
                                                                             title:item.title
                                                                              info:item.info];
        [result addObject:model];
    }
    return result;
}

@end