//
//  IpHistoryManager.m
//  Calculator
//
//  Created by AlexCheetah on 3/12/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "HistoryManager.h"
#import "AppDelegate.h"
#import "IpHistoryItem.h"
#import "IpHistoryItemModel.h"
#import "IntegralHistoryItem.h"
#import "IntegralHistoryItemModel.h"

NSString * const kIpHistoryMetaKeyIp = @"ip";
NSString * const kIpHistoryMetaKeyMask = @"mask";

NSString * const kIntegralHistoryMetaKeyFunction = @"function";
NSString * const kIntegralHistoryMetaKeyALimit = @"aLimit";
NSString * const kIntegralHistoryMetaKeyBLimit = @"bLimit";

static NSString *const IpHistoryItemCoreDataName = @"IpHistoryItem";
static NSString *const IntegralHistoryItemCoreDataName = @"IntegralHistoryItem";

@implementation HistoryManager

+ (instancetype) sharedManager
{
    static HistoryManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HistoryManager alloc] init];
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

- (void)saveHistoryItemOfType:(HistoryItemType)type
                    withImage:(UIImage *)image
                        title:(NSString *)title
                         info:(NSString *)info
                         meta:(NSData *)meta {
    
    switch (type) {
        case HistoryItemTypeIp: {
            IpHistoryItem *item = [NSEntityDescription insertNewObjectForEntityForName:IpHistoryItemCoreDataName
                                                                inManagedObjectContext:self.context];
            item.image = UIImageJPEGRepresentation(image, 1.0);
            item.title = title;
            item.info = info;
            item.metaData = meta;
        } break;
           
        case HistoryItemTypeIntegral: {
            IntegralHistoryItem *item = [NSEntityDescription insertNewObjectForEntityForName:IntegralHistoryItemCoreDataName
                                                                inManagedObjectContext:self.context];
            item.image = UIImageJPEGRepresentation(image, 1.0);
            item.title = title;
            item.info = info;
            item.metaData = meta;
        } break;
            
        default:
            break;
    }
    
    
    [self.context save:nil];
}

- (NSArray*)getHistoryInfoArrayForType:(HistoryItemType)type {
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription * description =
    [NSEntityDescription entityForName: ((type == HistoryItemTypeIp) ? IpHistoryItemCoreDataName : IntegralHistoryItemCoreDataName)
                inManagedObjectContext:self.context];
    [request setEntity:description];
    
    NSArray *fetchResult = [self.context executeFetchRequest:request error:nil];
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSManagedObject *item in fetchResult) {
        if (type == HistoryItemTypeIp) {
            IpHistoryItem *ipItem = (IpHistoryItem *)item;
            NSDictionary *metaDict = [NSJSONSerialization JSONObjectWithData:ipItem.metaData options:0 error:nil];
            IpHistoryItemModel *model = [[IpHistoryItemModel alloc] initWithImage:[UIImage imageWithData:ipItem.image]
                                                                                  title:ipItem.title
                                                                                   info:ipItem.info
                                                                                     ip:[metaDict objectForKey:kIpHistoryMetaKeyIp]
                                                                                   mask:[metaDict objectForKey:kIpHistoryMetaKeyMask]];
            [result addObject:model];
        } else {
            IntegralHistoryItem *ipItem = (IntegralHistoryItem *)item;
            NSDictionary *metaDict = [NSJSONSerialization JSONObjectWithData:ipItem.metaData options:0 error:nil];
            IntegralHistoryItemModel *model = [[IntegralHistoryItemModel alloc] initWithImage:[UIImage imageWithData:ipItem.image]
                                                                                        title:ipItem.title
                                                                                         info:ipItem.info
                                                                                     function:[metaDict objectForKey:kIntegralHistoryMetaKeyFunction]
                                                                                       aLimit:[metaDict objectForKey:kIntegralHistoryMetaKeyALimit]
                                                                                       bLimit:[metaDict objectForKey:kIntegralHistoryMetaKeyBLimit]];
            [result addObject:model];
        }
        
    }
    return result;
}

- (BOOL) itemOfType:(HistoryItemType)type
      withMetaExist:(NSData *)meta {
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription * description =
    [NSEntityDescription entityForName: ((type == HistoryItemTypeIp) ? IpHistoryItemCoreDataName : IntegralHistoryItemCoreDataName)
                inManagedObjectContext:self.context];
    [request setEntity:description];
    [request setPredicate:[NSPredicate predicateWithFormat:@"metaData == %@", meta]];
    NSArray *fetchResult = [self.context executeFetchRequest:request error:nil];
    return [fetchResult count] > 0;
}

@end