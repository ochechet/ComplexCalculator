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
                              info:(NSString *)info
                              meta:(NSData *)meta {
    IpHistoryItem *item = [NSEntityDescription insertNewObjectForEntityForName:IpHistoryItemCoreDataName
                                                        inManagedObjectContext:self.context];
    item.image = UIImageJPEGRepresentation(image, 1.0);
    item.title = title;
    item.info = info;
    item.metaData = meta;
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
        NSDictionary *metaDict = [NSJSONSerialization JSONObjectWithData:item.metaData options:0 error:nil];
        CTHIpHistoryItemModel *model = [[CTHIpHistoryItemModel alloc] initWithImage:[UIImage imageWithData:item.image]
                                                                             title:item.title
                                                                              info:item.info
                                                                                 ip:[metaDict objectForKey:@"ip"]
                                                                               mask:[metaDict objectForKey:@"mask"]];
        [result addObject:model];
    }
    return result;
}

- (BOOL) itemWithMetaExist:(NSData *)meta {
    
   /* NSDictionary *metaDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    item.ip, @"ip",
                                    item.mask, @"mask", nil];
    NSData *meta = [NSJSONSerialization dataWithJSONObject:metaDictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];*/
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription * description =
    [NSEntityDescription entityForName:IpHistoryItemCoreDataName
                inManagedObjectContext:self.context];
    [request setEntity:description];
    [request setPredicate:[NSPredicate predicateWithFormat:@"metaData == %@", meta]];
    NSArray *fetchResult = [self.context executeFetchRequest:request error:nil];
    return [fetchResult count] > 0;
}

@end