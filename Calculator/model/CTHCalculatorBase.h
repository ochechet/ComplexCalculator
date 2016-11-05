//
//  CTHCalculatorBase.h
//  Calculator
//
//  Created by AlexCheetah on 10/30/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHCalculatorBase : NSObject

@property(strong, nonatomic) NSString *result;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithResultSavingKey:(NSString *)key;

@end
