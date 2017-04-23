//
//  CTHHistoryPreviewViewController.m
//  Calculator
//
//  Created by AlexCheetah on 3/12/17.
//  Copyright © 2017 Olexander_Chechetkin. All rights reserved.
//

#import "CTHHistoryPreviewViewController.h"
#import "HistoryControllerDelegate.h"
#import "HistoryItemModelProtocol.h"
#import "Constants.h"


@interface CTHHistoryPreviewViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;

@end

@implementation CTHHistoryPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.item.image;
    self.titleLabel.text = self.item.title;
    self.infoTextView.text = self.item.info;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (IBAction)applyButtonBeenTapped:(id)sender {
    [self.delegate applyHistoryItem:self.item];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareButtonBeenTapped:(UIButton *)sender {
   // [self.delegate shareHistoryItem:self.item];
   // NSString *str = @"Image form My app";


   /* activityVC.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         UIActivityTypeMessage,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo];*/

    
    NSString *openUrlString = [NSString stringWithFormat:@"%@://%@=%@/%@=%@/", kOpenUrlApplicationId, kOpenUrlActivityTypeKey, kOpenUrlActivityTypeIp, kOpenUrlMetaKey, [self.item.info stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]]];
    
    NSArray *activityItems = @[@"Flame Calculator shared content\n\n", openUrlString, @"\nCopy whole this link and paste into web brauser to open in the app", self.item.image]; //skype trouble!
    NSArray *applicationActivities = nil;
    NSArray *excludeActivities = nil;
    
    UIActivityViewController * activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    activityController.excludedActivityTypes = excludeActivities;
    
    //[activityViewController setValue:@"VK SDK" forKey:@"subject"];
    if (UIUserInterfaceIdiomPad == [[UIDevice currentDevice] userInterfaceIdiom]) {
        UIPopoverPresentationController *popover = activityController.popoverPresentationController;
        popover.sourceView = sender;
        popover.barButtonItem = self.navigationItem.rightBarButtonItem;
    }
    
    [self presentViewController:activityController animated:YES completion:^{
        
    }];
    
    
}
- (IBAction)closeButtonBeenTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
