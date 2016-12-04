//
//  CTHIpResultModel.h
//  Calculator
//
//  Created by AlexCheetah on 11/6/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CTHOctetedBinary;

@interface CTHIpResultModel : NSObject

@property(strong, nonatomic) NSString *ipAddress;
@property(strong, nonatomic) NSString *ipAddressBinary;
@property(strong, nonatomic) NSString *maskAddress;
@property(strong, nonatomic) NSString *maskAddressBinary;
@property(strong, nonatomic) NSString *networkAddress;
@property(strong, nonatomic) NSString *networkAddressBinary;
@property(strong, nonatomic) NSString *hostAddress;
@property(strong, nonatomic) NSString *hostAddressBinary;

@end
