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
#import "CTHOctetedBinary.h"

static NSString * const kIpAddressPersistantString = @"ipAddressPersistantString";
static NSString * const kMacAddressPersistantString = @"macAddressPersistantString";

@interface CTHIpCalculator()

@property (strong, nonatomic) CTHPersistantStoreManager *manager;
@property (strong, nonatomic) CTHOctetedBinary *octetedIp;
@property (strong, nonatomic) CTHOctetedBinary *octetedMask;
@property (strong, nonatomic) CTHOctetedBinary *octetedNetworkAddress;

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

- (void)calculateWithCompletion:(void(^)(CTHIpResultModel *model))completion {
    __weak typeof (self) weakSelf = self;
    [self calculateNetworkInformation:^(NSString *binaryIp, CTHOctetedBinary *octetedNetwork) {
#warning HERE we are
    }];
}

- (void)calculateNetworkInformation:(void(^)(NSString *binaryIp, CTHOctetedBinary *octetedNetwork))completion {
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (!weakSelf.octetedIp || !weakSelf.octetedMask) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, nil);
            });
        }
        NSString *fullBinaryMask = [weakSelf.octetedMask joinWithoutDots];
        NSString *fullIp = [weakSelf.octetedIp joinWithoutDots];
        if ((fullBinaryMask.length != FULL_BINARY_ADRESS_LENGTH) ||
            (fullIp.length != FULL_BINARY_ADRESS_LENGTH)) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, nil);
            });
        }
        
        NSMutableString *networkAddressBinary = [[NSMutableString alloc] init];
        NSMutableString *ipAddressBinary = [[NSMutableString alloc] init];
        for (NSInteger i = 0; i < FULL_BINARY_ADRESS_LENGTH; i++) {
            unichar maskChar = [fullBinaryMask characterAtIndex:i];
            unichar ipChar = [fullIp characterAtIndex:i];
            
            if ([@"1" isEqualToString:[NSString stringWithCharacters:&maskChar length:1]]) {
                [networkAddressBinary appendString:[NSString stringWithCharacters:&ipChar length:1]];
            } else {
                [ipAddressBinary appendString:[NSString stringWithCharacters:&ipChar length:1]];
                [networkAddressBinary appendString:@"0"];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            CTHOctetedBinary *octetedNetwork = [[CTHOctetedBinary alloc] initWithBinaryString:[CTHOctetedBinary devideBinaryByDots:networkAddressBinary]];
            completion(ipAddressBinary, octetedNetwork);
        });
    });
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
    self.octetedIp = [[CTHOctetedBinary alloc] initWithString:self.ipAddressString];
    self.octetedMask = [[CTHOctetedBinary alloc] initWithString:self.mascAdressString];
}

- (void)persist {
    [self.manager saveData];
}

- (void)setIpAddressString:(NSString *)ipAddressString {
    [self.manager setStringToPersist:ipAddressString forKey:kIpAddressPersistantString];
    _ipAddressString = ipAddressString;
}

- (void)setMascAdressString:(NSString *)mascAdressString {
    [self.manager setStringToPersist:mascAdressString forKey:kMacAddressPersistantString];
    _mascAdressString = mascAdressString;
}

@end
