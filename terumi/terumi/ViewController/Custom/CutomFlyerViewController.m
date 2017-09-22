//
//  CutomFlyerViewController.m
//  terumi
//
//  Created by ハマモト  on 2017/02/02.
//  Copyright © 2017年 jokerpiece. All rights reserved.
//

#import "CutomFlyerViewController.h"
#import "SencorViewController.h"

@interface CutomFlyerViewController ()

@end

@implementation CutomFlyerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"grafficon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(moveSensor)];
    
    self.navigationItem.rightBarButtonItem = btn;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moveSensor{
    // ① 2番目のタブのViewControllerを取得する
    UINavigationController *navigationC = self.tabBarController.viewControllers[1];
    // ② 2番目のタブを選択済みにする
    self.tabBarController.selectedViewController = navigationC;
    // ③ UINavigationControllerに追加済みのViewを一旦取り除く
    [navigationC popToRootViewControllerAnimated:NO];
    // ④ SecondViewの画面遷移処理を呼び出す
//    SencorViewController *vc = [[SencorViewController alloc] initWithNibName:@"SencorViewController" bundle:nil];
//    [navigationC pushViewController:vc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
