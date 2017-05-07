//
//  HidtoryItemModelProtocol.h
//  Calculator
//
//  Created by AlexCheetah on 4/23/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HistoryItemModelProtocol <NSObject>

@property (strong, nonatomic, readonly) UIImage *image;
@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *info;

@optional
@property (strong, nonatomic, readonly) NSString *ip;
@property (strong, nonatomic, readonly) NSString *mask;

@property (strong, nonatomic, readonly) NSString *function;
@property (strong, nonatomic, readonly) NSString *aLimit;
@property (strong, nonatomic, readonly) NSString *bLimit;

@end