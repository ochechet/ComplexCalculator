//
//  Constants.m
//  Calculator
//
//  Created by Oleksandr Chechetkin on 10/10/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString * const kUnwindFormMainToIntegralSegue = @"unwindFromMainToIntegralSegue";
NSString * const kToIpViewControllerSegue = @"toIpViewControllerSegue";
NSString * const kUnwindFormIpToMainViewController = @"unwindFromIpToMainSegue";
NSString * const kFromIntegralToMainSegue = @"fromIntegralToMainSegue";
NSString * const kEmbedHistorySegue = @"historySegue";
NSString * const kHistoryItemPreviewSegue = @"historyItemPreviewSegue";

NSString * const kOpenUrlApplicationId = @"alex4eetahFlameCalculator";
NSString * const kOpenUrlActivityTypeKey = @"openActivityType";
NSString * const kOpenUrlActivityTypeIp = @"Ip";
NSString * const kOpenUrlActivityTypeIntegral = @"Integral";
NSString * const kOpenUrlMetaKey = @"meta";

NSString * const kOpenTabKey = @"TabToOpen";
NSString * const kOpenTabTypeIp = @"iPTabToOpen";
NSString * const kIpToUseKey = @"IpToUse";
NSString * const kMaskToUseKey = @"MaskToUse";

NSString * const kTabNeedsRefresh = @"tabNeedsRefresh";

@end
