//
//  CTHOctetedBinary.h
//  Calculator
//
//  Created by AlexCheetah on 11/26/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FULL_BINARY_ADRESS_LENGTH 32
#define FULL_DECIMAL_ADRESS_LENGTH 12

@interface CTHOctetedBinary : NSObject

@property (strong, nonatomic, readonly) NSMutableArray<NSString *> *octets;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithString:(NSString *)fullString;
- (instancetype)initWithBinaryString:(NSString *)binaryString;

- (NSString *)joinWithoutDots;
- (NSString *)joinWithDots;

+ (NSString *)devideBinaryByDots:(NSString *)binaryString;
+ (NSString *)devideDecimalByDots:(NSString *)decimalString;

@end
