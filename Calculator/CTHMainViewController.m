//
//  CTHMainViewController.m
//  Calculator
//
//  Created by Oleksandr Chechetkin on 10/10/16.
//  Copyright © 2016 Olexander_Chechetkin. All rights reserved.
//

#import "CTHMainViewController.h"
#import "CTHGeneralCalculator.h"
#import "Constants.h"

@interface CTHMainViewController ()

@property (strong, nonatomic) CTHGeneralCalculator *generalCalculator;

@property (strong, nonatomic) IBOutlet UILabel *labelResult;

@property (strong, nonatomic) IBOutlet UIButton *numericButtons7;
@property (strong, nonatomic) IBOutlet UIButton *numericButton8;
@property (strong, nonatomic) IBOutlet UIButton *numericButton9;
@property (strong, nonatomic) IBOutlet UIButton *numericButton4;
@property (strong, nonatomic) IBOutlet UIButton *numericButton5;
@property (strong, nonatomic) IBOutlet UIButton *numericButton6;
@property (strong, nonatomic) IBOutlet UIButton *numericButton1;
@property (strong, nonatomic) IBOutlet UIButton *numericButton2;
@property (strong, nonatomic) IBOutlet UIButton *numericButton3;
@property (strong, nonatomic) IBOutlet UIButton *numericButtonDot;
@property (strong, nonatomic) IBOutlet UIButton *numericButton0;
@property (strong, nonatomic) IBOutlet UIButton *numericButtonPi;

@property (strong, nonatomic) IBOutlet UIButton *operationButtonDivide;
@property (strong, nonatomic) IBOutlet UIButton *operationButtonMultiply;
@property (strong, nonatomic) IBOutlet UIButton *operationButtonMinus;
@property (strong, nonatomic) IBOutlet UIButton *operationButtonPlus;
@property (strong, nonatomic) IBOutlet UIButton *operationButtonSqr;
@property (strong, nonatomic) IBOutlet UIButton *operationButtonPow;
@property (strong, nonatomic) IBOutlet UIButton *operationButtonLog;
@property (strong, nonatomic) IBOutlet UIButton *operationButtonLeftBrack;
@property (strong, nonatomic) IBOutlet UIButton *operationButtonRightBrack;

@property (strong, nonatomic) IBOutlet UIButton *unaryOperationButtonsSqrt;
@property (strong, nonatomic) IBOutlet UIButton *unaryOperationButtonPow2;
@property (strong, nonatomic) IBOutlet UIButton *unaryOperationButtonSin;
@property (strong, nonatomic) IBOutlet UIButton *unaryOperationButtonCos;
@property (strong, nonatomic) IBOutlet UIButton *unaryOperationButtonTg;
@property (strong, nonatomic) IBOutlet UIButton *unaryOperationButtonCtg;
@property (strong, nonatomic) IBOutlet UIButton *unaryOperationButtonLn;
@property (strong, nonatomic) IBOutlet UIButton *unaryOperationButtonLg;
@property (strong, nonatomic) IBOutlet UIButton *unaryOperationButtonFactr;
@property (strong, nonatomic) IBOutlet UIButton *unaryOperationButtonExp;


- (IBAction)divideButton:(id)sender;
- (IBAction)multiplyButton:(id)sender;
- (IBAction)minusButton:(id)sender;
- (IBAction)plusButton:(id)sender;
- (IBAction)resultButton:(id)sender;
- (IBAction)clearButton:(id)sender;
- (IBAction)deleteButton:(id)sender;

- (IBAction)dotButtClick:(id)sender;
- (IBAction)sqrt:(id)sender;
- (IBAction)sin:(id)sender;

- (IBAction)cos:(id)sender;
- (IBAction)tg:(id)sender;
- (IBAction)ctg:(id)sender;
- (IBAction)ln:(id)sender;
- (IBAction)lg:(id)sender;
- (IBAction)log:(id)sender;
- (IBAction)factr:(id)sender;
- (IBAction)exp:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *resultButton;

@end

@implementation CTHMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.generalCalculator = [CTHGeneralCalculator sharedCalculator];
    self.labelResult.text = [self.generalCalculator result];
    [self.operationButtonSqr setTitle:@"\u221a" forState:UIControlStateNormal];
    [self.unaryOperationButtonsSqrt setTitle:@"²\u221a" forState:UIControlStateNormal];
    [self.unaryOperationButtonPow2 setTitle:@"^²" forState:UIControlStateNormal];
    [self.numericButtonPi setTitle:@"\u220f" forState:UIControlStateNormal];
    [self operationbuttonDisabeling];
    [self bracketsDisabeling:@"right"];
    [self leftOperandunaryOperationbuttonDisabeling];
    
    
}

#pragma mark - UI state configuration
- (void)bracketsDisabeling:(NSString*)which
{
    if ([which isEqualToString:@"right"])
        self.operationButtonRightBrack.enabled = NO;
    else if ([which isEqualToString:@"left"])
        self.operationButtonLeftBrack.enabled = NO;
}
- (BOOL)isRightBracketMissing
{
    NSArray *content = [self.generalCalculator.result componentsSeparatedByString:@" "];
    NSInteger leftcounter = 0;
    NSInteger rightcounter = 0;
    for (int i = 0; i < [content count]-1; i++)
    {
        if ([content[i] isEqualToString:@"("])
        {
            if ([content[i+1] isEqualToString:@""])
                return NO;
            leftcounter++;
        }
        else if ([content[i] isEqualToString:@")"])
            rightcounter++;
    }
    if (leftcounter > rightcounter)
        return YES;
    else
        return NO;
    
}
- (void)bracketsEnabeling:(NSString*)which
{
    if ([which isEqualToString:@"right"])
    {
        if ([self isRightBracketMissing])
            self.operationButtonRightBrack.enabled = YES;
        else
            self.operationButtonRightBrack.enabled = NO;
    }
    
    else if ([which isEqualToString:@"left"])
        self.operationButtonLeftBrack.enabled = YES;
}

- (void)inputingNumbersDisabeling
{
    NSArray *numerics = @[
                          self.numericButton0,
                          self.numericButton1,
                          self.numericButton2,
                          self.numericButton3,
                          self.numericButton4,
                          self.numericButton5,
                          self.numericButton6,
                          self.numericButtons7,
                          self.numericButton8,
                          self.numericButton9,
                          self.numericButtonDot,
                          self.numericButtonPi
                          ];
    
    [self setEnabled:NO forArray:numerics];
}
- (void)inputingNumbersEnabeling
{
    NSArray *numerics = @[
                          self.numericButton0,
                          self.numericButton1,
                          self.numericButton2,
                          self.numericButton3,
                          self.numericButton4,
                          self.numericButton5,
                          self.numericButton6,
                          self.numericButtons7,
                          self.numericButton8,
                          self.numericButton9,
                          self.numericButtonDot,
                          self.numericButtonPi
                          ];
    
    [self setEnabled:YES forArray:numerics];
}



- (void)operationbuttonDisabeling
{
    NSArray *binaryOperations = @[
                                  self.operationButtonDivide,
                                  self.operationButtonMultiply,
                                  self.operationButtonMinus,
                                  self.operationButtonPlus,
                                  self.operationButtonSqr,
                                  self.operationButtonPow,
                                  self.operationButtonLog
                                  ];
    
    [self setEnabled:NO forArray:binaryOperations];
}
- (void)operationbuttonEnabeling
{
    NSArray *binaryOperations = @[
                                  self.operationButtonDivide,
                                  self.operationButtonMultiply,
                                  self.operationButtonMinus,
                                  self.operationButtonPlus,
                                  self.operationButtonSqr,
                                  self.operationButtonPow,
                                  self.operationButtonLog
                                  ];
    
    [self setEnabled:YES forArray:binaryOperations];
}

- (void)unaryOperationbuttonDisabeling
{
    NSArray *unaryOperations = @[
                                 self.unaryOperationButtonSin,
                                 self.unaryOperationButtonCos,
                                 self.unaryOperationButtonTg,
                                 self.unaryOperationButtonCtg,
                                 self.unaryOperationButtonLn,
                                 self.unaryOperationButtonLg,
                                 self.unaryOperationButtonsSqrt,
                                 self.unaryOperationButtonPow2,
                                 self.unaryOperationButtonExp
                                 ];
    
    [self setEnabled:NO forArray:unaryOperations];
}
- (void)unaryOperationbuttonEnabeling
{
    NSArray *unaryOperations = @[
                                 self.unaryOperationButtonSin,
                                 self.unaryOperationButtonCos,
                                 self.unaryOperationButtonTg,
                                 self.unaryOperationButtonCtg,
                                 self.unaryOperationButtonLn,
                                 self.unaryOperationButtonLg,
                                 self.unaryOperationButtonsSqrt,
                                 self.unaryOperationButtonPow2,
                                 self.unaryOperationButtonExp
                                 ];
    
    [self setEnabled:YES forArray:unaryOperations];
}

- (void)leftOperandunaryOperationbuttonDisabeling
{
    NSArray *leftOperandunaryOperations = @[
                                            self.unaryOperationButtonPow2,
                                            self.unaryOperationButtonFactr
                                            ];
    
    [self setEnabled:NO forArray:leftOperandunaryOperations];
}
- (void)leftOperandunaryOperationbuttonEnabeling
{
    NSArray *leftOperandunaryOperations = @[
                                            self.unaryOperationButtonPow2,
                                            self.unaryOperationButtonFactr
                                            ];
    
    [self setEnabled:YES forArray:leftOperandunaryOperations];
}


- (void)setEnabled:(BOOL)enabled forArray:(NSArray*)array
{
    for (UIButton *element in array)
    {
        element.enabled = enabled;
    }
}

#pragma mark - Actions
- (IBAction)clearButton:(id)sender
{
    [self.generalCalculator clearresult];
    self.labelResult.text = [self.generalCalculator result];
    [self operationbuttonDisabeling];
    [self bracketsEnabeling:@"left"];
    [self bracketsDisabeling:@"right"];
    [self inputingNumbersEnabeling];
    [self unaryOperationbuttonEnabeling];
    [self leftOperandunaryOperationbuttonDisabeling];
}

- (IBAction)deleteButton:(id)sender
{
    [self.generalCalculator deleteLast];
    self.labelResult.text = [self.generalCalculator result];
    if ([self.labelResult.text isEqualToString:@""])
    {
        [self operationbuttonDisabeling];
        [self bracketsDisabeling:@"right"];
        [self inputingNumbersEnabeling];
        [self leftOperandunaryOperationbuttonDisabeling];
    }
    
}

- (IBAction)numbers:(UIButton *)sender
{
    if (sender.tag == 314)
    {
        double taga = M_PI;
        [self.generalCalculator setResult:[NSString stringWithFormat:@"%f", taga]];
    }
    else
    {
        long taga;
        taga = sender.tag;
        [self.generalCalculator setResult:[NSString stringWithFormat:@"%li", taga]];
    }
    
    self.labelResult.text = [self.generalCalculator result];
    
    [self operationbuttonEnabeling];
    [self unaryOperationbuttonDisabeling];
    [self bracketsDisabeling:@"left"];
    [self bracketsEnabeling:@"right"];
    [self leftOperandunaryOperationbuttonEnabeling];
    
}
- (IBAction)dotButtClick:(id)sender
{
    [self.generalCalculator setResult:[NSString stringWithFormat:@"%@", @"."]];
    self.labelResult.text = [self.generalCalculator result];
    [self operationbuttonDisabeling];
    [self unaryOperationbuttonDisabeling];
    [self bracketsDisabeling:@"left"];
    [self bracketsDisabeling:@"right"];
    [self leftOperandunaryOperationbuttonDisabeling];
}

-(void)setsettingsForOperations:(NSString*)operationTag
{
    [self.generalCalculator setOperationPressed:true];
    [self.generalCalculator setResult:[NSString stringWithFormat:@"%@", operationTag]];
    self.labelResult.text = [self.generalCalculator result];
    [self.generalCalculator setOperationPressed:false];
}
-(void)setbehaviorForBinaryOperations
{
    [self bracketsEnabeling:@"left"];
    [self bracketsDisabeling:@"right"];
    [self operationbuttonDisabeling];
    [self unaryOperationbuttonEnabeling];
    [self inputingNumbersEnabeling];
    [self leftOperandunaryOperationbuttonDisabeling];
}

#pragma mark Binary operations
- (IBAction)plusButton:(id)sender
{
    [self setsettingsForOperations:@"+"];
    [self setbehaviorForBinaryOperations];
}
- (IBAction)minusButton:(id)sender
{
    [self setsettingsForOperations:@"-"];
    [self setbehaviorForBinaryOperations];
    
}
- (IBAction)multiplyButton:(id)sender
{
    [self setsettingsForOperations:@"*"];
    [self setbehaviorForBinaryOperations];
}
- (IBAction)divideButton:(id)sender
{
    [self setsettingsForOperations:@"/"];
    [self setbehaviorForBinaryOperations];
}
- (IBAction)sqr:(id)sender
{
    [self setsettingsForOperations:@"v"];
    [self setbehaviorForBinaryOperations];
}
- (IBAction)log:(id)sender
{
    [self setsettingsForOperations:@"log"];
    [self setbehaviorForBinaryOperations];
}
- (IBAction)pow:(id)sender
{
    [self setsettingsForOperations:@"^"];
    [self setbehaviorForBinaryOperations];
}

-(void)setbehaviorForUnaryOperations
{
    [self operationbuttonDisabeling];
    [self bracketsDisabeling:@"right"];
    [self bracketsEnabeling:@"left"];
    [self unaryOperationbuttonDisabeling];
    [self leftOperandunaryOperationbuttonDisabeling];
}

#pragma mark Unary operations
- (IBAction)sqrt:(id)sender
{
    [self setsettingsForOperations:@"( 2 ) v"];
    [self setbehaviorForUnaryOperations];
}
- (IBAction)sin:(id)sender
{
    [self setsettingsForOperations:@"sin"];
    [self setbehaviorForUnaryOperations];
}
- (IBAction)cos:(id)sender
{
    [self setsettingsForOperations:@"cos"];
    [self setbehaviorForUnaryOperations];
}
- (IBAction)tg:(id)sender
{
    [self setsettingsForOperations:@"tg"];
    [self setbehaviorForUnaryOperations];
}
- (IBAction)ctg:(id)sender
{
    [self setsettingsForOperations:@"ctg"];
    [self setbehaviorForUnaryOperations];
}
- (IBAction)ln:(id)sender
{
    [self setsettingsForOperations:@"ln"];
    [self operationbuttonDisabeling];
    [self bracketsEnabeling:@"left"];
    [self unaryOperationbuttonEnabeling];
}
- (IBAction)lg:(id)sender
{
    [self setsettingsForOperations:@"lg"];
    [self setbehaviorForUnaryOperations];
}
- (IBAction)exp:(id)sender
{
    [self setsettingsForOperations:@"exp"];
    [self setbehaviorForUnaryOperations];
}

#pragma mark Left operand unary operations
- (IBAction)pow2:(id)sender
{
    [self setsettingsForOperations:@"^ ( 2 )"];
    [self operationbuttonEnabeling];
    [self bracketsDisabeling:@"left"];
    [self inputingNumbersDisabeling];
}
- (IBAction)factr:(id)sender
{
    [self setsettingsForOperations:@"!"];
    [self operationbuttonEnabeling];
    [self bracketsDisabeling:@"left"];
    [self inputingNumbersDisabeling];
}

#pragma mark Breakets
- (IBAction)leftBreaketButton:(id)sender
{
    [self setsettingsForOperations:@"("];
    [self operationbuttonDisabeling];
    [self inputingNumbersEnabeling];
    [self unaryOperationbuttonEnabeling];
    [self leftOperandunaryOperationbuttonDisabeling];
    [self bracketsEnabeling:@"right"];
}
- (IBAction)rightBreaketButton:(id)sender
{
    [self.generalCalculator setOperationPressed:true];
    [self.generalCalculator setResult:[NSString stringWithFormat:@"%@", @")"]];
    self.labelResult.text = [self.generalCalculator result];
    [self bracketsDisabeling:@"left"];
    [self bracketsEnabeling:@"right"];
    [self inputingNumbersDisabeling];
    [self operationbuttonEnabeling];
}

- (IBAction)resultButton:(id)sender
{
    NSString* expectionmess;
#warning BAD DESIGN !!!!!
    @try
    {
        expectionmess = [self.generalCalculator Validate];
    }
    @catch (NSException *exception)
    {
        expectionmess = [NSString stringWithFormat:@"%@", @"That's not right!"];
        [self ShowMessage:expectionmess];
    }
    @finally
    {
        if ([expectionmess isEqualToString:@""])
        {
            @try
            {
                [self.generalCalculator setTotalResult:[self.generalCalculator countResult]];
                self.labelResult.text = [self.generalCalculator result];
            }
            @catch (NSString* error)
            {
                [self ShowMessage:error];
            }
        }
        else
        {
            [self ShowMessage:expectionmess];
        }
    }
}

-(void)ShowMessage:(NSString*)message
{
    
    [self.labelResult setBackgroundColor:[UIColor redColor]];
    [self.resultButton setTitle:message forState:normal];
    
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    __weak __typeof(self) weakSelf = self;
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       [weakSelf.labelResult setBackgroundColor:[UIColor lightGrayColor]];
                       [weakSelf.resultButton setTitle:@"=" forState:normal];
                   });
    
}


@end
