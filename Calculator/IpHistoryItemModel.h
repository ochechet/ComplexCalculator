//
//  CTHIpHistoryItemModel.h
//  Calculator
//
//  Created by AlexCheetah on 3/12/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HistoryItemModelProtocol.h"

@interface IpHistoryItemModel : NSObject<HistoryItemModelProtocol>

@property (strong, nonatomic, readonly) UIImage *image;
@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *info;
@property (strong, nonatomic, readonly) NSString *ip;
@property (strong, nonatomic, readonly) NSString *mask;

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                         info:(NSString *)info
                           ip:(NSString *)ip
                         mask:(NSString *)mask;

@end
