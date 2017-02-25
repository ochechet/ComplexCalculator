//
//  CTHCalculationUtil.m
//  Calculator
//
//  Created by AlexCheetah on 2/19/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "CTHCalculationUtil.h"

@implementation CTHCalculationUtil

+ (BOOL)isNumeric:(NSString *)string {
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [numberFormatter setNumberStyle:NSNumberFormatterScientificStyle];
    NSNumber* number = [numberFormatter numberFromString:string];
    if (number != nil) {
        return true;
    }
    return false;
}

@end
