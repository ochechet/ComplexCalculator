//
//  CTHBinaryFormatter.h
//  Calculator
//
//  Created by AlexCheetah on 11/6/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHBinaryFormatter : NSObject

+ (NSString *)decToBinary:(NSUInteger)decInt;
+ (NSUInteger)binaryToInt:(NSString*)binaryString;

@end
