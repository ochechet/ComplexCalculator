//
//  CTHFunctionParser.m
//  Calculator
//
//  Created by AlexCheetah on 2/21/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "CTHFunctionParser.h"
#import "CTHCalculationUtil.h"

@interface CTHFunctionParser ()

@property(strong, nonatomic) NSArray *functionkeys;
@property(strong, nonatomic) NSArray *functionBlocks;
@property(strong, nonatomic) NSDictionary *functionsDict;

@end

@implementation CTHFunctionParser

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.functionkeys = @[@"sin", @"cos", @"tg", @"ctg", @"ln", @"lg", @"log", @"exp"];
    self.functionBlocks = @[
                            //sin---------------------------
                            ^(double x) {
                                return sin(x);
                            },
                             //cos---------------------------
                             ^(double x) {
                                 return cos(x);
                             },
                             //tan---------------------------
                             ^(double x) {
                                 return tan(x);
                             },
                             //ctan---------------------------
                             ^(double x) {
                                 return cos(x) / sin(x);
                             },
                             //ln---------------------------
                             ^(double x) {
                                 return log(x);
                             },
                             //lg--------------------------
                             ^(double x) {
                                 return log(x) / log(10);
                             },
                             //log---------------------------
                             ^(double x, double y) {
                                 return log(x) / log(y);
                             },
                             //exp---------------------------
                             ^(double x) {
                                 return exp(x);
                             }
     ];
    self.functionsDict = [[NSDictionary alloc] initWithObjects:self.functionBlocks forKeys:self.functionkeys];
}

- (double(^)(double x))getFunctionFromString:(NSString *) string {
    double(^block)(double arg);
    
    unsigned int len = [string length];
    unichar buffer[len];
    [string getCharacters:buffer range:NSMakeRange(0, len)];
    
    for(int i = 0; i < len; ++i) {
        NSString *s = [NSString stringWithCharacters:buffer length:i+1];
        if ([self.functionkeys indexOfObject:s] != NSNotFound) {
            block = [self.functionsDict objectForKey:s];
            if (len >= i+3 &&
                buffer[i+1] == '(' &&
                buffer[i+2] >= 'A' && buffer[i+2] <= 'z' &&
                buffer[i+3] == ')') {
                return block;
            } else {
                return nil;
            }
        }
    }
    return nil;
}

@end
