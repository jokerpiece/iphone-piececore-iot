//
//  LnitialMenuViewController.h
//  terumi
//
//  Created by OhnumaRina on 2016/04/14.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDistanceSencorViewController.h"
#import <BaseViewController.h>
#import "SencorViewController.h"
#import "TutorialBatteryView.h"

@interface LnitialMenuViewController : BaseViewController
@property (nonatomic) SencorViewController *parnentView;

@property (weak, nonatomic) IBOutlet UIButton *itemButton;

- (IBAction)tapItem:(id)sender;

@end
