//
//  CTHIntegralCalculator.h
//  Calculator
//
//  Created by AlexCheetah on 2/19/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IntegralCalculationsResultModel;

@interface CTHIntegralCalculator : NSObject

@property(strong, nonatomic) NSString *function;
@property(strong, nonatomic) NSString *aLimit;
@property(strong, nonatomic) NSString *bLimit;

- (IntegralCalculationsResultModel *) calculateDefinedIntegral;

- (void)refresh;
- (void)persist;

@end
