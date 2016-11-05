//
//  CTHCalculatorBase.m
//  Calculator
//
//  Created by AlexCheetah on 10/30/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHCalculatorBase.h"
#import "CTHPersistantStoreManager.h"

@interface CTHCalculatorBase ()

@property (strong, nonatomic) NSString *resultSavingKey;
@property (strong, nonatomic) CTHPersistantStoreManager *manager;

@end

@implementation CTHCalculatorBase

- (instancetype)initWithResultSavingKey:(NSString *)key {
    self = [super init];
    if (self) {
        self.resultSavingKey = key;
        self.manager = [CTHPersistantStoreManager sharedManager];
        _result = [self.manager getPersistedStringForKey:key];
    }
    return self;
}

- (void)setResult:(NSString *)result {
    [self.manager setStringToPersist:result forKey:self.resultSavingKey];
    _result = result;
}

@end
