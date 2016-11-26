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
            if (component.length != DECIMAL_COMPONENT_LENGTH) {
                return nil;
            }
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

+ (NSString *)devideBinaryByDots:(NSString *)binaryString {
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

- (NSString *)joinWithoutDots {
    return [self.octets componentsJoinedByString:@""];
}

- (NSString *)joinWithDots {
    return [self.octets componentsJoinedByString:@"."];
}

+ (NSString *)devideDecimalByDots:(NSString *)decimalString {
    return nil;
}

@end
