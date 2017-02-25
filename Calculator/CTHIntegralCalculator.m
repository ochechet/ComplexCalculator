//
//  CTHIntegralCalculator.m
//  Calculator
//
//  Created by AlexCheetah on 2/19/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "CTHIntegralCalculator.h"

#define N 10000

@implementation CTHIntegralCalculator

//Simpsons' method
- (double) calculateDefinedIntegralWithFunction:(double(^)(double x))function
                                      fromLimit:(double)a
                                        toLimit:(double)b {
    double S = 0, x, h;
    //devide [a, b] to N parts
    h = (b - a)/N;
    x = a + h;
    while (x < b) {
        S = S + 4 * function(x);
        x = x + h;
        //check if x is inside of half-interval bounds [a, b)
        if (x >= b) {
            break;
        }
        S = S + 2 * function(x);
        x = x + h;
    }
    S = (h/3)*(S + function(a) + function(b));
    return S;
}

@end
