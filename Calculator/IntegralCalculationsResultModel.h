//
//  IntegralCalculationsResultModel.h
//  Calculator
//
//  Created by AlexCheetah on 5/7/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FailReason) {
    FailReasonNoFunction,
    FailReasonNoALimit,
    FailReasonNoBLimit,
    FailReasonWrongLimits
};

@interface IntegralCalculationsResultModel : NSObject

@property(assign, nonatomic) BOOL success;
@property(assign, nonatomic) double result;
@property(assign, nonatomic) FailReason failReason;

@end
