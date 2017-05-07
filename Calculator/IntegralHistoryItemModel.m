//
//  HistoryItemModel.m
//  Calculator
//
//  Created by AlexCheetah on 4/22/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "IntegralHistoryItemModel.h"

@interface IntegralHistoryItemModel ()

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *function;
@property (strong, nonatomic) NSString *aLimit;
@property (strong, nonatomic) NSString *bLimit;

@end

@implementation IntegralHistoryItemModel

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                         info:(NSString *)info
                     function:(NSString *)function
                       aLimit:(NSString *)aLimit
                       bLimit:(NSString *)bLimit {
    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
        self.info = info;
        self.function = function;
        self.aLimit = aLimit;
        self.bLimit = bLimit;
    }
    return self;
}

@end