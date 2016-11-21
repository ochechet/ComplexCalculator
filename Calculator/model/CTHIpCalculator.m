//
//  CTHIpCalculator.m
//  Calculator
//
//  Created by AlexCheetah on 11/5/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHIpCalculator.h"
#import "CTHPersistantStoreManager.h"
#import "CTHBinaryFormatter.h"

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

- (CTHIpResultModel *)calculate {
    NSString *networkAddress = [self networkAddress];
    
    
    
    
    return [self resultModel];
}

- (NSString *)networkAddress {
    NSString *binaryIp = [CTHBinaryFormatter decToBinary:[self.ipAddressString integerValue]];
    NSString *binaryMasc = [CTHBinaryFormatter decToBinary:[self.mascAdressString integerValue]];
    unsigned int len = [binaryMasc length];
    char buffer[len];
    [binaryMasc getCharacters:buffer range:NSMakeRange(0, len)];
    int i;
    for(i = 0; i < len; ++i) {
        if (buffer[i] == 0) {
            break;
        }
    }
    NSString *networkAddressBinary = [binaryIp substringToIndex:i];
    return [NSString stringWithFormat:@"%u",[CTHBinaryFormatter binaryToInt:networkAddressBinary]];
}

- (CTHIpResultModel *)resultModel {
    CTHIpResultModel *model = [[CTHIpResultModel alloc] init];
#warning incomplete
    model.ipAddress = self.ipAddressString;
    model.ipAddressBinary = [CTHBinaryFormatter decToBinary:[self.ipAddressString integerValue]];
    model.mascAdress = [NSString stringWithFormat:@"%u",[CTHBinaryFormatter binaryToInt:model.ipAddressBinary]];
    model.mascAdressBinary = @"MAC00011100011";
    model.networkAddress = @"172.172.172";
    model.networkAddressBinary = @"network00011100011";
    model.hostAddress = @"121";
    model.hostAddressBinary = @"host00011100011";
    return model;
}

#pragma mark - Persistance
- (void)refresh {
    _ipAddressString = [self.manager getPersistedStringForKey:kIpAddressPersistantString];
    _mascAdressString = [self.manager getPersistedStringForKey:kMacAddressPersistantString];
}

- (void)persist {
    [self.manager saveData];
}

- (void)setIpAddressString:(NSString *)ipAddressString {
    [self.manager setStringToPersist:ipAddressString forKey:kIpAddressPersistantString];
    _ipAddressString = ipAddressString;
}

- (void)setMascAdressString:(NSString *)mascAdressString {
    [self.manager setStringToPersist:macAdressString forKey:kMacAddressPersistantString];
    _mascAdressString = macAdressString;
}

@end
