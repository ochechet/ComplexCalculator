//
//  PersistantStoreManager.h
//  Calculator
//
//  Created by AlexCheetah on 10/30/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHPersistantStoreManager : NSObject

+ (instancetype)sharedManager;

- (void)setStringToPersist:(NSString *)string forKey:(NSString *)key;
- (NSString *)getPersistedStringForKey:(NSString *)key;

- (void)saveData;

@end
