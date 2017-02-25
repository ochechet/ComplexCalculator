//
//  CTHFunctionParser.h
//  Calculator
//
//  Created by AlexCheetah on 2/21/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHFunctionParser : NSObject

- (double(^)(double x))getFunctionFromString:(NSString *) string;

@end
