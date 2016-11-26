//
//  CTHBinaryFormatter.m
//  Calculator
//
//  Created by AlexCheetah on 11/6/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHBinaryFormatter.h"

@implementation CTHBinaryFormatter

+ (NSString *)decToBinary:(NSUInteger)decInt {
    NSString *string = @"" ;
    NSUInteger x = decInt;
    
    while (x > 0) {
        string = [[NSString stringWithFormat: @"%u", x&1] stringByAppendingString:string];
        x = x >> 1;
    }
    while (string.length < 8) {
        string = [NSString stringWithFormat: @"%@%d", string, 0];
    }
    return string;
}

+ (NSUInteger)binaryToInt:(NSString*)binaryString {
    unichar aChar;
    int value = 0;
    int index;
    for (index = 0; index<[binaryString length]; index++)
    {
        aChar = [binaryString characterAtIndex: index];
        if (aChar == '1')
            value += 1;
        if (index+1 < [binaryString length])
            value = value<<1;
    }
    return value;
}

@end
