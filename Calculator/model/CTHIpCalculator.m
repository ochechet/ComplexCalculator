//
//  CTHIpCalculator.m
//  Calculator
//
//  Created by AlexCheetah on 11/5/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHIpCalculator.h"
#import "CTHPersistantStoreManager.h"

static NSString * const kIpAddressPersistantString = @"ipAddressPersistantString";
static NSString * const kMacAddressPersistantString = @"macAddressPersistantString";

@interface CTHIpCalculator()

@property (strong, nonatomic) CTHPersistantStoreManager *manager;

@end

@implementation CTHIpCalculator

- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [CTHPersistantStoreManager sharedManager];
        [self refresh];
    }
    return self;
}

- (void)refresh {
    _ipAddressString = [self.manager getPersistedStringForKey:kIpAddressPersistantString];
    _macAdressString = [self.manager getPersistedStringForKey:kMacAddressPersistantString];
}

- (void)persist {
    [self.manager saveData];
}

- (void)setIpAddressString:(NSString *)ipAddressString {
    [self.manager setStringToPersist:ipAddressString forKey:kIpAddressPersistantString];
}

- (void)setMacAdressString:(NSString *)macAdressString {
    [self.manager setStringToPersist:macAdressString forKey:kMacAddressPersistantString];
}

@end
