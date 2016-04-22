//
//  SettingViewController.h
//  terumi
//
//  Created by ハマモト  on 2016/02/09.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "BaseDistanceSencorViewController.h"
#import "DistanceSencorData.h"
#import "SencorViewController.h"



@interface SettingViewController : BaseDistanceSencorViewController
- (IBAction)onMaxSetting:(id)sender;
- (IBAction)onMinSetting:(id)sender;
@property (nonatomic)DistanceSencorData *data;
@property (nonatomic) SencorViewController *parnentView;
@property (weak, nonatomic) IBOutlet UILabel *maxlbl;
@property (weak, nonatomic) IBOutlet UILabel *distanceLbl;
@property (weak, nonatomic) IBOutlet UILabel *effDistanceLbl;
@property (weak, nonatomic) IBOutlet UILabel *minlbl;
@property (nonatomic) NSUInteger count;

- (IBAction)closeAction:(id)sender;

@end
