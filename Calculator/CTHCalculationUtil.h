//
//  CTHCalculationUtil.h
//  Calculator
//
//  Created by AlexCheetah on 2/19/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define isNum(string) [CTHCalculationUtil isNumeric:string]
#define getDouble(string) [CTHCalculationUtil getDouble:string]

@interface CTHCalculationUtil : NSObject

+ (BOOL)isNumeric:(NSString *)string;
+ (double)getDouble:(NSString *)string;

@end
