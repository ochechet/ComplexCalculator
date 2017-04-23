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
@property (strong, nonatomic) NSString *ip;
@property (strong, nonatomic) NSString *mask;

@end

@implementation IntegralHistoryItemModel

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                         info:(NSString *)info
                           ip:(NSString *)ip
                         mask:(NSString *)mask {
    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
        self.info = info;
        self.ip = ip;
        self.mask = mask;
    }
    return self;
}

@end