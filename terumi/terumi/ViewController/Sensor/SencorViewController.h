//
//  SencorViewController.h
//  terumi
//
//  Created by ハマモト  on 2016/02/09.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "BaseDistanceSencorViewController.h"
#import "RoundView.h"

@interface SencorViewController : BaseDistanceSencorViewController
@property (weak, nonatomic) IBOutlet UIView *orderView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UILabel *orderRemaingLbl;
@property (nonatomic) int distanceTotal;
- (IBAction)onNomalRice:(id)sender;
- (IBAction)onOtherRice:(id)sender;
- (IBAction)closeAction:(id)sender;
- (IBAction)orderAction:(id)sender;
- (IBAction)otherAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *komeIv;
@property (weak, nonatomic) IBOutlet UILabel *komeLbl;
@property (weak, nonatomic) IBOutlet UILabel *remaingLbl;
@property (weak, nonatomic) IBOutlet UILabel *batteryLbl;
@property DistanceSencorData *sencorData;
@property (weak, nonatomic) IBOutlet RoundView *frame1View;
@property (weak, nonatomic) IBOutlet RoundView *frame2View;
@property (weak, nonatomic) IBOutlet RoundView *frame3View;
@property (nonatomic) bool isDispedWarnig;
@property (nonatomic) bool isDispedBackgroundWarnig;
@property (nonatomic) bool isDispedBatteryWarnig;
@property (nonatomic) NSTimer *timer;

@property (weak, nonatomic) IBOutlet RoundView *graff1;
@property (weak, nonatomic) IBOutlet RoundView *graff2;
@property (weak, nonatomic) IBOutlet RoundView *graff3;
@property (weak, nonatomic) IBOutlet RoundView *graff4;
@property (weak, nonatomic) IBOutlet RoundView *graff5;
@property (weak, nonatomic) IBOutlet RoundView *graff6;
@property (weak, nonatomic) IBOutlet RoundView *graff7;
@property (weak, nonatomic) IBOutlet RoundView *graff8;
@property (weak, nonatomic) IBOutlet RoundView *graff9;
@property (weak, nonatomic) IBOutlet RoundView *graff10;
@property (weak, nonatomic) IBOutlet RoundView *graff11;

- (IBAction)deliveryAction:(id)sender;
- (IBAction)settingAction:(id)sender;
- (IBAction)questionAction:(id)sender;
-(void)settinged;
-(void)startScanWithTimer;
-(void)menuAction:(id)sender;

@end
