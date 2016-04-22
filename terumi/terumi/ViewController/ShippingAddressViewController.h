//
//  ShippingAddressViewController.h
//  terumi
//
//  Created by OhnumaRina on 2016/04/15.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaseViewController.h>

@interface ShippingAddressViewController : BaseViewController<UIScrollViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIButton *searchPostCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *tapNextBtn;
@property (weak, nonatomic) IBOutlet UIButton *tapSkipBtn;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigation;
@property (weak, nonatomic) IBOutlet UITextField *postCode;
@property (weak, nonatomic) IBOutlet UITextView *streetAddress;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

- (IBAction)moveSelectRiceShop:(id)sender;
- (IBAction)moveSelectPayer:(id)sender;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *onSignalTap;

@end
