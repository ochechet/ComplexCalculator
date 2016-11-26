//
//  CTHIpCalculator.h
//  Calculator
//
//  Created by AlexCheetah on 11/5/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHCalculatorBase.h"
#import "CTHIpResultModel.h"

@interface CTHIpCalculator : NSObject

@property(strong, nonatomic) NSString *ipAddressString;
@property(strong, nonatomic) NSString *mascAdressString;

- (void)refresh;
- (void)persist;
- (void)calculateWithCompletion:(void(^)(CTHIpResultModel *model))completion;

@end
