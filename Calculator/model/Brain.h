//
//  Brain.h
//  Calculator
//
//  Created by Olexander_Chechetkin on 11/23/15.
//  Copyright © 2015 Olexander_Chechetkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brain : NSObject

@property(nonatomic) BOOL operationPressed;
@property(strong, nonatomic) NSString *resultBefore;
+(Brain*)singleton;

-(NSString*)Validate;
-(NSString*)countResult;
-(void)clearresult;
-(void)deleteLast;
-(void)setTotalResult:(NSString*)result;
@end
