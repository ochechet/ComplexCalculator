//
//  PersistantStoreManager.m
//  Calculator
//
//  Created by AlexCheetah on 10/30/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHPersistantStoreManager.h"
#import <UIKit/UIKit.h>

@interface CTHPersistantStoreManager ()

@property (strong, nonatomic) NSMutableDictionary *persistantDictionary;

@end

@implementation CTHPersistantStoreManager

+ (instancetype)sharedManager {
    static CTHPersistantStoreManager *instance = nil;
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[CTHPersistantStoreManager alloc] init];
            if (instance) {
                [[NSNotificationCenter defaultCenter] addObserver:instance
                                                         selector:@selector(saveData)
                                                             name:UIApplicationDidEnterBackgroundNotification
                                                           object:nil];
                [[NSNotificationCenter defaultCenter] addObserver:instance
                                                         selector:@selector(saveData)
                                                             name:UIApplicationWillTerminateNotification
                                                           object:nil];
                [[NSNotificationCenter defaultCenter] addObserver:instance
                                                         selector:@selector(restoreData)
                                                             name:UIApplicationDidFinishLaunchingNotification
                                                           object:nil];
                [[NSNotificationCenter defaultCenter] addObserver:instance
                                                         selector:@selector(restoreData)
                                                             name:UIApplicationWillEnterForegroundNotification
                                                           object:nil];
                [instance restoreData];
            }

        });
    }
    return instance;
}

- (NSMutableDictionary *)persistantDictionary {
    if (!_persistantDictionary) {
        _persistantDictionary = [[NSMutableDictionary alloc] init];
    }
    return _persistantDictionary;
}

- (void)setStringToPersist:(NSString *)string forKey:(NSString *)key; {
    [self.persistantDictionary setValue:string forKey:key];
}

- (NSString *)getPersistedStringForKey:(NSString *)key {
    return [self.persistantDictionary objectForKey:key];
}

- (void)saveData
{
    NSUserDefaults *storage = [NSUserDefaults standardUserDefaults];
    for (NSString *key in self.persistantDictionary.allKeys) {
        NSString *value = [self.persistantDictionary valueForKey:key];
        [storage setObject:value forKey:key];
    }
    [storage synchronize];
}

- (void)restoreData
{
    NSUserDefaults *storage = [NSUserDefaults standardUserDefaults];
    for (NSString *key in [[storage dictionaryRepresentation] allKeys]) {
        NSString *value = [storage stringForKey:key];
        [self.persistantDictionary setValue:value forKey:key];
    }
}

@end
