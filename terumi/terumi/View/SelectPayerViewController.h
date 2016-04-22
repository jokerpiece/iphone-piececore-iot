//
//  SelectPayerViewController.h
//  terumi
//
//  Created by OhnumaRina on 2016/04/15.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPayerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *myselfPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *othersPayBtn;
@property (weak, nonatomic) IBOutlet UITextField *payerId;
@property (strong, nonatomic) UIView *tv;

@property (nonatomic, strong) NSString *errorMessage;

@end
