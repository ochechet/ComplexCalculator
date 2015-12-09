//
//  Brain.m
//  Calculator
//
//  Created by Olexander_Chechetkin on 11/23/15.
//  Copyright © 2015 Olexander_Chechetkin. All rights reserved.
//

#import "Brain.h"

@interface Brain()


-(NSString*)SplitTheOperations:(NSArray*)values;
-(NSString*)chousinOperationWhith:(NSString*)FirstOperand :(NSString*)Operation :(NSString*)SecondOperation;
-(double) anylog:(double)base :(double)x;
-(double) factr:(double)x;
-(BOOL)isNum:(NSString*)string;

@end

@implementation Brain

-(double) anylog:(double)base :(double)x
{
    return(log(x) / log(base));
}

-(double) factr:(double)x
{
    if (x == 0)
        return 1;
    else
        return x * [self factr:(x-1)];
}
//-------------------------------------------------------------------------------Validation
-(NSString*)Validate
{
    NSMutableArray *givenArray = [[self.resultBefore componentsSeparatedByString:@" "] mutableCopy];
    NSString *result = [[NSString alloc] init];
    NSSet *unaryOperations = [[NSSet alloc] initWithObjects:@"sin",@"cos",@"tg",@"ctg",@"ln",@"lg",@"exp", nil];
    NSSet *binaryOperations = [[NSSet alloc] initWithObjects:@"+",@"-",@"*",@"/",@"v",@"log",@"^", nil];
   // NSSet *allOperations = [[NSSet alloc] initWithObjects:@"sin",@"cos",@"tg",@"ctg",@"ln",@"lg",@"exp",@"+",@"-",@"*",@"/",@"v",@"log",@"^", nil];
    
    for (int i = 0; i < [givenArray count]; i++)
    {
        
        
        //for unary Operatons
        if([unaryOperations containsObject:givenArray[i]])
        {
            if (
                ([unaryOperations containsObject:givenArray[0]] || [givenArray[i-1] isEqualToString:@"("])
                && [self isNum:givenArray[i+1]]){}//sin9
            
            else if (
                     ([unaryOperations containsObject:givenArray[0]] || [givenArray[i-1] isEqualToString:@"("])
                     && [givenArray[i+1] isEqualToString:@"("]){}//sin(
            
            else if (
                     ([binaryOperations containsObject:givenArray[i-1]] || [givenArray[i-1] isEqualToString:@"("])
                     && [self isNum:givenArray[i+1]]){}//+sin9
            
            else if (
                     ([binaryOperations containsObject:givenArray[i-1]] || [givenArray[i-1] isEqualToString:@"("])
                     && [givenArray[i+1] isEqualToString:@"("]){}//+sin(
                
            else //error
                result = [NSString stringWithFormat:@"%@ %@",result,@"Operation UnaryOperation Value\n"];
        }
        //for factr
        if([givenArray[i] isEqualToString:@"!"])
        {
            if (i != 0)
            {
                if ([self isNum:givenArray[i-1]] && ([givenArray[i+1] isEqualToString:@""]||[givenArray[i+1] isEqualToString:@")"])){}//5!
                
                else if ([givenArray[i-1] isEqualToString:@")"] && ([givenArray[i+1] isEqualToString:@""]||[givenArray[i+1] isEqualToString:@")"])){}//)!
                
                else if ([self isNum:givenArray[i-1]] && [binaryOperations containsObject:givenArray[i+1]]){}//5!+
                
                else if ([givenArray[i-1] isEqualToString:@")"] && [binaryOperations containsObject:givenArray[i+1]]){}//)!+
                
                else //error
                    result = [NSString stringWithFormat:@"%@ %@",result,@"value ! operation\n"];
            }
            else //error
                result = [NSString stringWithFormat:@"%@ %@",result,@"value ! operation\n"];
        }
        //for binary operations
        if([binaryOperations containsObject:givenArray[i]])
        {
            if (i != 0 && ![givenArray[i-1]  isEqualToString: @"("])
            {
                if([self isNum:givenArray[i-1]] && [self isNum:givenArray[i+1]]){}//1+1
                
                else if([givenArray[i-1] isEqualToString:@")"] && [givenArray[i+1] isEqualToString:@"("]){}//)+(
                
                else if([self isNum:givenArray[i-1]] && [givenArray[i+1] isEqualToString:@"("]){}//1+(
                
                else if([givenArray[i-1] isEqualToString:@")"] && [self isNum:givenArray[i+1]]){}//)+1
                
                else
                    result = [NSString stringWithFormat:@"%@ %@",result,@"Value BinaryOperation Value\n"];
            }
            else
                result = [NSString stringWithFormat:@"%@ %@",result,@"Value BinaryOperation Value\n"];
        }
    }
    //for brackets
    if ([self checkBrackets:givenArray])
        result = [NSString stringWithFormat:@"%@ %@",result,[self checkBrackets:givenArray]];

    return result;
}

-(NSString*)checkBrackets: (NSArray*)givenArray
{
    NSSet *allOperations = [[NSSet alloc] initWithObjects:@"sin",@"cos",@"tg",@"ctg",@"ln",@"lg",@"exp",@"+",@"-",@"*",@"/",@"v",@"log",@"^", nil];
    NSString *tempresult;
    NSMutableArray *stack = [[NSMutableArray alloc] init];
    for (int i = 0; i < [givenArray count]; i++)
    {
        if ([givenArray[i] isEqualToString:@"("])
        {
            [stack addObject:@"("];
            if ([givenArray[i+1] isEqualToString:@")"])
                tempresult = @" No value in brackets!\n";
            else if (i != 0)
            {
                if ([givenArray[i-1] isEqualToString:@""]){}
                    
                else if (![allOperations containsObject:givenArray[i-1]])
                    tempresult = @" No operation before brackets!\n";
            }
            
        }
        if ([givenArray[i] isEqualToString:@")"])
        {
            if ([stack count])
                [stack removeLastObject];
            else if (![stack count])
                tempresult = @" Brackets are uneven!\n";
        }
    }
    if ([stack count])
        tempresult = @" Brackets are uneven!\n";
    return tempresult;
}

-(BOOL)isNum:(NSString*)string
{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber* number = [numberFormatter numberFromString:string];
    
    if (number != nil)
        return YES;
    else
        return NO;
}
//------------------------------------------------------------------------------setting result
-(void)setResultBefore:(NSString *)taga
{
    NSSet *binaryOperations = [[NSSet alloc] initWithObjects:@"+",@"-",@"*",@"/",@"v",@"log",@"^", nil];
    if (!_operationPressed&&(_resultBefore == nil||[_resultBefore isEqualToString:@""]))//8
    {
        if ([taga isEqualToString:@"."])
            _resultBefore = [NSString stringWithFormat:@"0%@",taga];
        else
            _resultBefore = [NSString stringWithFormat:@"%@",taga];
    }
    
    else if (_operationPressed&&(_resultBefore == nil||[_resultBefore isEqualToString:@""]))//+8
    {
        if ([binaryOperations containsObject:taga])
            _resultBefore = [NSString stringWithFormat:@"0 %@ ",taga];
        else
            _resultBefore = [NSString stringWithFormat:@"%@ ",taga];
    }
    
    else if (_operationPressed&&(_resultBefore != nil||![_resultBefore isEqualToString:@""])&&![_resultBefore hasSuffix:@" "])//8+
        _resultBefore = [NSString stringWithFormat:@"%@ %@ ",_resultBefore,taga];
    
    else if (_operationPressed&&(_resultBefore != nil||![_resultBefore isEqualToString:@""])&&[_resultBefore hasSuffix:@" "])//+ + e.g. in right side of operations there is " "
        _resultBefore = [NSString stringWithFormat:@"%@%@ ",_resultBefore,taga];
    
    else
        _resultBefore = [NSString stringWithFormat:@"%@%@",_resultBefore,taga];
}

-(void)clearresult
{
    _operationPressed = false;
    _resultBefore = @"";
}

-(void)deleteLast
{
    NSMutableArray *givenArray = [[self.resultBefore componentsSeparatedByString:@" "] mutableCopy];
    [givenArray removeObject:@""];
    if ([_resultBefore length] > 0)
    {
        if ([[_resultBefore substringFromIndex:[_resultBefore length]-1] isEqualToString: @" "])
        {
            [givenArray removeObjectAtIndex:[givenArray count]-1];
            _resultBefore = [givenArray componentsJoinedByString:@" "];
        }
        
        
        else
            _resultBefore = [_resultBefore substringToIndex:[_resultBefore length] - 1];
    }
}

-(void)setTotalResult:(NSString*)result
{
    _operationPressed = false;
    _resultBefore = result;
}

//-----------------------------------------------------------singleton
+(Brain*)singleton
{
    static Brain* thisBrain = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        thisBrain = [[self alloc] init];
   });
    
    return thisBrain;
}


//=====================================================================================
//count result

-(NSString*)countResult
{
    NSMutableArray *values = [[self.resultBefore componentsSeparatedByString:@" "] mutableCopy];
        for (NSString* value in values)
        {
            if (values.count == 1)
                return value;
            else if(values.count > 1)
                return [self SplitTheOperations:values];
            else //(values.count == 0)
                return @"0";
        }
    return 0;
}

-(NSString*)SplitTheOperations:(NSMutableArray*)values
{
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++ for brackets
    if ([values containsObject:@"("]&&[values containsObject:@")"])
    {
        // TO make an array of indexes or so on
        //NSMutableArray* Indexes = [[NSMutableArray alloc] init]; //start,middle,end,start2...ect
        NSInteger startElement=0;
        NSInteger endElement=0;
        NSMutableArray *thatValues = [[NSMutableArray alloc] init];
        bool isfirst = false,issecond = false;
        NSInteger ierarchyOfBrackets = 0;
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"("])
            {
                if (isfirst)
                {
                    ierarchyOfBrackets++;
                    continue;
                }
                startElement = i;
                isfirst = true;
            }
            if ([values [i] isEqualToString: @")"])
            {
                if (ierarchyOfBrackets)
                {
                    ierarchyOfBrackets--;
                    continue;
                }
                endElement = i;
                issecond = true;
            }
            
            if (isfirst&&issecond)
                break;
        }

        for(int i = startElement+1; i < endElement; i++)//logic without brackets
        {
                [thatValues addObject:values[i]];
        }
        
        values[startElement]=[self SplitTheOperations:thatValues];
        for (int i = endElement; i > startElement; i--)
        {
                [values removeObjectAtIndex:i];
        }
        if ([values containsObject:@"("]&&[values containsObject:@")"]) {
            NSString* temp = [self SplitTheOperations:values];
            values = [[NSMutableArray alloc] init];
            [values addObject:temp];
        }
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++ for sqr
    if ([values containsObject:@"v"])
    {
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"v"])
            {
                values[i] = [self chousinOperationWhith/*Degree*/:values[i-1] :values[i] :values[i+1]];
                [values removeObjectAtIndex:i-1];
                [values removeObjectAtIndex:i];
                i--;
            }
        }

    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++ for pow
    if ([values containsObject:@"^"])
    {
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"^"])
            {
                values[i] = [self chousinOperationWhith:values[i-1] :values[i] :values[i+1]];
                [values removeObjectAtIndex:i-1];
                [values removeObjectAtIndex:i];
                i--;
            }
        }
        
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++ for sin/cos/tg/ctg

    
    if ([values containsObject:@"sin"])
    {
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"sin"])
            {
                values[i] = [self chousinOperationWhith:@"" :values[i] :values[i+1]];
                [values removeObjectAtIndex:i+1];
            }
        }
    }
    if ([values containsObject:@"cos"])
    {
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"cos"])
            {
                values[i] = [self chousinOperationWhith:@"" :values[i] :values[i+1]];
                [values removeObjectAtIndex:i+1];
            }
        }
    }
    if ([values containsObject:@"tg"])
    {
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"tg"])
            {
                values[i] = [self chousinOperationWhith:@"" :values[i] :values[i+1]];
                [values removeObjectAtIndex:i+1];
            }
        }
    }
    if ([values containsObject:@"ctg"])
    {
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"ctg"])
            {
                values[i] = [self chousinOperationWhith:@"" :values[i] :values[i+1]];
                [values removeObjectAtIndex:i+1];
            }
        }
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++ for ln/lg/log/!exp
    if ([values containsObject:@"ln"])
    {
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"ln"])
            {
                values[i] = [self chousinOperationWhith:@"" :values[i] :values[i+1]];
                [values removeObjectAtIndex:i+1];
            }
        }
    }
    if ([values containsObject:@"lg"])
    {
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"lg"])
            {
                values[i] = [self chousinOperationWhith:@"" :values[i] :values[i+1]];
                [values removeObjectAtIndex:i+1];
            }
        }
    }
    if ([values containsObject:@"log"])
    {
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"log"])
            {
                values[i] = [self chousinOperationWhith:values[i-1] :values[i] :values[i+1]];
                [values removeObjectAtIndex:i-1];
                [values removeObjectAtIndex:i];
                i--;
            }
        }
    }
    if ([values containsObject:@"!"])
    {
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"!"])
            {
                values[i-1] = [self chousinOperationWhith:values[i-1] :values[i] :@""];
                [values removeObjectAtIndex:i];
            }
        }
    }
    if ([values containsObject:@"exp"])
    {
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"exp"])
            {
                values[i] = [self chousinOperationWhith:@"" :values[i] :values[i+1]];
                [values removeObjectAtIndex:i+1];
            }
        }
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++ for * & /
    if ([values containsObject:@"*"]||[values containsObject:@"/"])
    {
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"*"]||[values [i] isEqualToString: @"/"])
            {
                values[i] = [self chousinOperationWhith:values[i-1] :values[i] :values[i+1]];
                [values removeObjectAtIndex:i-1];
                [values removeObjectAtIndex:i];
                i--;
            }
        }
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++ for + & -
    if ([values containsObject:@"+"]||[values containsObject:@"-"])
    {
        for(int i = 0; i < values.count; i++)
        {
            if ([values [i] isEqualToString: @"+"]||[values [i] isEqualToString: @"-"])
            {
                values[i] = [self chousinOperationWhith:values[i-1] :values[i] :values[i+1]];
                [values removeObjectAtIndex:i-1];
                [values removeObjectAtIndex:i];
                i--;
            }
        }
    }
    return values[0];
}

-(NSString*)chousinOperationWhith:(NSString*)FirstOperand :(NSString*)Operation :(NSString*)SecondOperand
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];//to escape wrong representing of 0 in float numbers
    
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setAllowsFloats:YES];
    [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [formatter setMinimumFractionDigits:0];
    [formatter setMaximumFractionDigits:10];
    
    if ([Operation isEqualToString: @"+"])
        return [NSString stringWithFormat:@"%g",[FirstOperand floatValue] + [SecondOperand floatValue]];
    
    if ([Operation isEqualToString: @"-"])
        return [NSString stringWithFormat:@"%g",[FirstOperand floatValue] - [SecondOperand floatValue]];
    
    if ([Operation isEqualToString: @"*"])
        return [NSString stringWithFormat:@"%g",[FirstOperand floatValue] * [SecondOperand floatValue]];
    
    if ([Operation isEqualToString: @"/"])
        return [NSString stringWithFormat:@"%g",[FirstOperand floatValue] / [SecondOperand floatValue]];
    
    if ([Operation isEqualToString: @"v"])
        return [NSString stringWithFormat:@"%g",pow([SecondOperand doubleValue],1/[FirstOperand doubleValue])];
    
    if ([Operation isEqualToString: @"^"])
        return [NSString stringWithFormat:@"%g",pow([FirstOperand floatValue], [SecondOperand floatValue]) ];
    
    if ([Operation isEqualToString: @"sin"])
    {
        NSNumber *numberResult = [NSNumber numberWithDouble:sin(([SecondOperand floatValue]*M_PI)/180)];
        
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        return [NSString stringWithFormat:@"%@",[formatter stringFromNumber:numberResult]  ];
    }
    
    if ([Operation isEqualToString: @"cos"])
    {
        NSNumber *numberResult = [NSNumber numberWithDouble:cos(([SecondOperand floatValue]*M_PI)/180)];
        
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        return [NSString stringWithFormat:@"%@",[formatter stringFromNumber:numberResult]  ];
    }
    
    
    if ([Operation isEqualToString: @"tg"])
    {
        if ([SecondOperand isEqualToString:@"90"]||[SecondOperand isEqualToString:@"270"])
        {
            @throw @"Infinity";
        }
        else
        {
            NSNumber *numberResult = [NSNumber numberWithDouble:tan(([SecondOperand floatValue]*M_PI)/180)];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            
            return [NSString stringWithFormat:@"%@",[formatter stringFromNumber:numberResult]  ];
        }
    }
    
    if ([Operation isEqualToString: @"ctg"])
    {
        if ([SecondOperand floatValue] == M_PI)
        {
            @throw @"Infinity";
        }
        else
        {
            NSNumber *numberResult = [NSNumber numberWithDouble:cos(([SecondOperand floatValue]*M_PI)/180) /sin(([SecondOperand floatValue]*M_PI)/180)];
            
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            return [NSString stringWithFormat:@"%@",[formatter stringFromNumber:numberResult]  ];
        }
    }
    
    if ([Operation isEqualToString: @"ln"])
        return [NSString stringWithFormat:@"%g",log([SecondOperand floatValue])];
    
    if ([Operation isEqualToString: @"lg"])
        return [NSString stringWithFormat:@"%g",[self anylog:10:([SecondOperand floatValue])]];
    
    if ([Operation isEqualToString: @"log"])
        return [NSString stringWithFormat:@"%g",[self anylog:([FirstOperand floatValue]):([SecondOperand floatValue])]];
    
    if ([Operation isEqualToString: @"!"])
        return [NSString stringWithFormat:@"%g",[self factr:[FirstOperand floatValue]]];
    
    if ([Operation isEqualToString: @"exp"])
        return [NSString stringWithFormat:@"%g",exp([SecondOperand floatValue])];
    else return 0;
}

@end
