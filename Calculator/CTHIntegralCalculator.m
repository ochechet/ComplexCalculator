//
//  CTHIntegralCalculator.m
//  Calculator
//
//  Created by AlexCheetah on 2/19/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "CTHIntegralCalculator.h"
#import "CTHPersistantStoreManager.h"
#import "CTHCalculationUtil.h"
#import "CTHFunctionParser.h"
#import "IntegralCalculationsResultModel.h"

#define N 10000

static NSString * const kFunctionPersistantString = @"functionPersistantString";
static NSString * const kALimitPersistantString = @"aLimitPersistantString";
static NSString * const kBLimitPersistantString = @"bLimitPersistantString";

@interface CTHIntegralCalculator ()

@property (strong, nonatomic) CTHPersistantStoreManager *manager;

@end

@implementation CTHIntegralCalculator

- (instancetype) init {
    self = [super init];
    if (self) {
        self.manager = [CTHPersistantStoreManager sharedManager];
    }
    return self;
}

//Simpsons' method
- (IntegralCalculationsResultModel *) calculateDefinedIntegral {
    
    IntegralCalculationsResultModel *result = [[IntegralCalculationsResultModel alloc] init];
    double a = getDouble(self.aLimit);
    double b = getDouble(self.bLimit);
    CTHFunctionParser *parser = [[CTHFunctionParser alloc] init];
    double(^function)(double x) = [parser getFunctionFromString:self.function];
    
    if (!self.function.length || !function) {
        result.success = NO;
        result.failReason = FailReasonNoFunction;
        return result;
    } else if (![CTHCalculationUtil isNumeric:self.aLimit]) {
        result.success = NO;
        result.failReason = FailReasonNoALimit;
        return result;
    } else if (![CTHCalculationUtil isNumeric:self.bLimit]) {
        result.success = NO;
        result.failReason = FailReasonNoBLimit;
        return result;
    } else if (a >= b) {
        result.success = NO;
        result.failReason = FailReasonWrongLimits;
        return result;
    }
    
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
    
    result.success = YES;
    result.result = S;
    return result;
}

#pragma mark - Persistance
- (void)refresh {
    _aLimit = [self.manager getPersistedStringForKey:kALimitPersistantString];
    _bLimit = [self.manager getPersistedStringForKey:kBLimitPersistantString];
    _function = [self.manager getPersistedStringForKey:kFunctionPersistantString];
}

- (void)persist {
    [self.manager saveData];
}

- (void)setFunction:(NSString *)function {
    [self.manager setStringToPersist:function forKey:kFunctionPersistantString];
    _function = function;
}

- (void)setALimit:(NSString *)aLimit {
    [self.manager setStringToPersist:aLimit forKey:kALimitPersistantString];
    _aLimit = aLimit;
}

- (void)setBLimit:(NSString *)bLimit {
    [self.manager setStringToPersist:bLimit forKey:kBLimitPersistantString];
    _bLimit = bLimit;
}

@end
