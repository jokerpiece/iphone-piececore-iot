//
//  SendPaymentPermitViewController.m
//  terumi
//
//  Created by OhnumaRina on 2016/04/15.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "SendPaymentPermitViewController.h"
#import "SettingViewController.h"
#import "SencorViewController.h"

@interface SendPaymentPermitViewController ()

@end

@implementation SendPaymentPermitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"設定完了";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }

- (IBAction)moveSetting:(id)sender {
   // [self.navigationController popToRootViewControllerAnimated:YES];
    SencorViewController *svc = [[SencorViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];

   // SettingViewController *svc = [[SettingViewController alloc]init];
    //    //[self presentViewController:sppvc animated:YES completion:nil];
  //  [self.navigationController pushViewController:svc animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES]; // ナビゲーションバー非表示
}
@end
