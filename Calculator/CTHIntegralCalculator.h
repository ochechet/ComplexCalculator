//
//  CTHIntegralCalculator.h
//  Calculator
//
//  Created by AlexCheetah on 2/19/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHIntegralCalculator : NSObject

- (double) calculateDefinedIntegralWithFunction:(double(^)(double x))function
                                      fromLimit:(double)a
                                        toLimit:(double)b;

@end
