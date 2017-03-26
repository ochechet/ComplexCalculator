//
//  Constants.h
//  Calculator
//
//  Created by Oleksandr Chechetkin on 10/10/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

extern NSString * const kUnwindFormMainToIntegralSegue;
extern NSString * const kToIpViewControllerSegue;
extern NSString * const kUnwindFormIpToMainViewController;
extern NSString * const kFromIntegralToMainSegue;
extern NSString * const kEmbedHistorySegue;
extern NSString * const kHistoryItemPreviewSegue;

extern NSString * const kOpenUrlApplicationId;
extern NSString * const kOpenUrlActivityTypeKey;
extern NSString * const kOpenUrlActivityTypeIp;
extern NSString * const kOpenUrlActivityTypeIntegral;
extern NSString * const kOpenUrlMetaKey;

extern NSString * const kOpenTabKey;
extern NSString * const kOpenTabTypeIp;
extern NSString * const kIpToUseKey;
extern NSString * const kMaskToUseKey;

extern NSString * const kTabNeedsRefresh;

@end
