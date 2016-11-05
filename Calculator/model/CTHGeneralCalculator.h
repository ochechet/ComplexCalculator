//
//  Brain.h
//  Calculator
//
//  Created by Olexander_Chechetkin on 11/23/15.
//  Copyright © 2015 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTHCalculatorBase.h"

@interface CTHGeneralCalculator : NSObject//CTHCalculatorBase

+ (CTHGeneralCalculator *) sharedCalculator;

@property(nonatomic) BOOL operationPressed;
@property(strong, nonatomic) NSString *result;

-(NSString*)Validate;
-(NSString*)countResult;
-(void)clearresult;
-(void)deleteLast;
-(void)setTotalResult:(NSString*)result;

@end
