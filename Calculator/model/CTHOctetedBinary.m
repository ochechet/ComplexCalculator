//
//  CTHOctetedBinary.m
//  Calculator
//
//  Created by AlexCheetah on 11/26/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHOctetedBinary.h"
#import "CTHBinaryFormatter.h"

#define OCTET_LENGHT 8
#define COMPONENTS_NEEDED 4
#define DECIMAL_COMPONENT_LENGTH 3

@interface CTHOctetedBinary ()

@property (strong, nonatomic) NSMutableArray<NSString *> *octets;

@end

@implementation CTHOctetedBinary

- (instancetype)initWithString:(NSString *)fullString {
    self = [super init];
    if (self) {
        _octets = [[NSMutableArray alloc] init];
        NSArray *componentsArray = [fullString componentsSeparatedByString:@"."];
        if (componentsArray.count != COMPONENTS_NEEDED) {
            return nil;
        }
        for (NSString *component in componentsArray) {
            NSString *binary = [CTHBinaryFormatter decToBinary:[component integerValue]];
            if (!binary) {
                return nil;
            }
            [_octets addObject:binary];
        }
    }
    return self;
}

- (instancetype)initWithBinaryString:(NSString *)binaryString {
    self = [super init];
    if (self) {
        _octets = [[NSMutableArray alloc] init];
        NSArray *componentsArray = [binaryString componentsSeparatedByString:@"."];
        if (componentsArray.count != COMPONENTS_NEEDED) {
            return nil;
        }
        for (NSString *component in componentsArray) {
            if (component.length != OCTET_LENGHT) {
                return nil;
            }
            [_octets addObject:component];
        }
    }
    return self;
}

+ (NSString *)devideByDots:(NSString *)binaryString {
    if (binaryString.length != FULL_BINARY_ADRESS_LENGTH) {
        return nil;
    }
    NSMutableString *result = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < FULL_BINARY_ADRESS_LENGTH; i++) {
        unichar c = [binaryString characterAtIndex:i];
        if ((i % OCTET_LENGHT == 0) && i != 0) {
            [result appendString:[NSString stringWithFormat:@".%@",[NSString stringWithCharacters:&c length:1]]];
        } else {
            [result appendString:[NSString stringWithCharacters:&c length:1]];
        }
    }
    return result;
}

- (NSString *)decimalAddress {
    NSMutableString *decimalAddress = [[NSMutableString alloc] init];
    for (NSInteger index = 0; index < self.octets.count; index++) {
        NSString *octet = [self.octets objectAtIndex:index];
        NSUInteger decimal = [CTHBinaryFormatter binaryToInt:octet];
        if (index == self.octets.count - 1) {
            [decimalAddress appendFormat:@"%ld",(long)decimal];
        } else {
            [decimalAddress appendFormat:@"%ld.",(long)decimal];
        }
    }
    return decimalAddress;
}

- (NSString *)joinWithoutDots {
    return [self.octets componentsJoinedByString:@""];
}

- (NSString *)joinWithDots {
    return [self.octets componentsJoinedByString:@"."];
}

@end
