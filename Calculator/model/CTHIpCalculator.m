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
@property(strong, nonatomic) NSArray *posibleMaskAdresses;

@end

@implementation CTHIpCalculator

- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [CTHPersistantStoreManager sharedManager];
        self.posibleMaskAdresses = @[@"128.0.0.0",@"192.0.0.0",@"224.0.0.0",@"240.0.0.0",@"248.0.0.0",@"252.0.0.0",@"254.0.0.0",@"255.0.0.0",@"255.128.0.0",@"255.192.0.0",@"255.224.0.0",@"255.240.0.0",@"255.248.0.0",@"255.252.0.0",@"255.254.0.0",@"255.255.0.0",@"255.255.128.0",@"255.255.192.0",@"255.255.224.0",@"255.255.240.0",@"255.255.248.0",@"255.255.252.0",@"255.255.254.0",@"255.255.255.0",@"255.255.255.128",@"255.255.255.192",@"255.255.255.224",@"255.255.255.240",@"255.255.255.248",@"255.255.255.252",@"255.255.255.254",@"255.255.255.255"];
        [self refresh];
    }
    return self;
}

- (void)calculateWithCompletion:(void(^)(CTHIpResultModel *model))completion {
    CTHOctetedBinary *octetedIp = [[CTHOctetedBinary alloc] initWithString:self.ipAddressString];
    CTHOctetedBinary *octetedMask = [[CTHOctetedBinary alloc] initWithString:self.mascAdressString];
    [self calculateNetworkInformationWithIpAddress:octetedIp mascAddress:octetedMask completion:^(CTHOctetedBinary *octetedHost, CTHOctetedBinary *octetedNetwork) {
        CTHIpResultModel *model = [self fillModelWithIpAddressBinary:octetedIp
                                                   mascAddressBinary:octetedMask
                                                networkAddressBinary:octetedNetwork
                                                   hostAddressBinary:octetedHost];
        completion(model);
    }];
}

- (void)calculateNetworkInformationWithIpAddress:(CTHOctetedBinary *)ipAddress
                                     mascAddress:(CTHOctetedBinary *)maskAddress
                                    completion:(void(^)(CTHOctetedBinary *octetedHost, CTHOctetedBinary *octetedNetwork))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (!ipAddress || !maskAddress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, nil);
            });
            return ;
        }
        NSString *fullBinaryMask = [maskAddress joinWithoutDots];
        NSString *fullIp = [ipAddress joinWithoutDots];
        if ((fullBinaryMask.length != FULL_BINARY_ADRESS_LENGTH) ||
            (fullIp.length != FULL_BINARY_ADRESS_LENGTH)) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, nil);
            });
            return ;
        }
        
        NSMutableString *networkAddressBinary = [[NSMutableString alloc] init];
        NSMutableString *hostAddressBinary = [[NSMutableString alloc] init];
        for (NSInteger i = 0; i < FULL_BINARY_ADRESS_LENGTH; i++) {
            unichar maskChar = [fullBinaryMask characterAtIndex:i];
            unichar ipChar = [fullIp characterAtIndex:i];
            
            if ([@"1" isEqualToString:[NSString stringWithCharacters:&maskChar length:1]]) {
                [hostAddressBinary appendString:@"0"];
                [networkAddressBinary appendString:[NSString stringWithCharacters:&ipChar length:1]];
            } else {
                [hostAddressBinary appendString:[NSString stringWithCharacters:&ipChar length:1]];
                [networkAddressBinary appendString:@"0"];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            CTHOctetedBinary *octetedNetwork = [[CTHOctetedBinary alloc] initWithBinaryString:[CTHOctetedBinary devideByDots:networkAddressBinary]];
            CTHOctetedBinary *octetedHost = [[CTHOctetedBinary alloc] initWithBinaryString:[CTHOctetedBinary devideByDots:hostAddressBinary]];
            completion(octetedHost, octetedNetwork);
        });
    });
}

- (CTHIpResultModel *)fillModelWithIpAddressBinary:(CTHOctetedBinary *)ipAddressBinary
                        mascAddressBinary:(CTHOctetedBinary *)maskAddressBinary
                        networkAddressBinary:(CTHOctetedBinary *)networkAddressBinary
                        hostAddressBinary:(CTHOctetedBinary *)hostAddressBinary {
    CTHIpResultModel *model = [[CTHIpResultModel alloc] init];
    
    model.ipAddressBinary = [ipAddressBinary joinWithDots];
    model.ipAddress = [ipAddressBinary decimalAddress];
    model.maskAddressBinary = [maskAddressBinary joinWithDots];
    model.maskAddress = [maskAddressBinary decimalAddress];
    model.networkAddressBinary = [networkAddressBinary joinWithDots];
    model.networkAddress = [networkAddressBinary decimalAddress];
    model.hostAddressBinary = [hostAddressBinary joinWithDots];
    model.hostAddress = [hostAddressBinary decimalAddress];
    
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
    [self.manager setStringToPersist:mascAdressString forKey:kMacAddressPersistantString];
    _mascAdressString = mascAdressString;
}

@end
