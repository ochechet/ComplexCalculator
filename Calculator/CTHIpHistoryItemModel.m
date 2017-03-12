//
//  CTHIpHistoryItemModel.m
//  Calculator
//
//  Created by AlexCheetah on 3/12/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "CTHIpHistoryItemModel.h"

@interface CTHIpHistoryItemModel ()

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *info;

@end

@implementation CTHIpHistoryItemModel

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                         info:(NSString *)info {
    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
        self.info = info;
    }
    return self;
}

@end
