//
//  HistoryItemModel.h
//  Calculator
//
//  Created by AlexCheetah on 4/22/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HistoryItemModelProtocol.h"

@interface IntegralHistoryItemModel : NSObject<HistoryItemModelProtocol>

@property (strong, nonatomic, readonly) UIImage *image;
@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *info;
@property (strong, nonatomic, readonly) NSString *function;
@property (strong, nonatomic, readonly) NSString *aLimit;
@property (strong, nonatomic, readonly) NSString *bLimit;

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                         info:(NSString *)info
                     function:(NSString *)function
                       aLimit:(NSString *)aLimit
                       bLimit:(NSString *)bLimit;

@end
