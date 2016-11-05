//
//  CTHIpCalculator.h
//  Calculator
//
//  Created by AlexCheetah on 11/5/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHCalculatorBase.h"

@interface CTHIpCalculator : NSObject//CTHCalculatorBase

@property(strong, nonatomic) NSString *ipAddressString;
@property(strong, nonatomic) NSString *macAdressString;

- (void)refresh;
- (void)persist;

@end
