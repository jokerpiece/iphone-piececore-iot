//
//  LnitialMenuViewController.m
//  terumi
//
//  Created by OhnumaRina on 2016/04/14.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "LnitialMenuViewController.h"
#import "ConfirmationTerumiIdViewController.h"
#import "TutorialBatteryViewController.h"


@interface LnitialMenuViewController ()

@end

@implementation LnitialMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* back = [[UIBarButtonItem alloc]
                              initWithTitle:@""
                              style:UIBarButtonItemStyleBordered
                              target:self
                              action:nil];
    self.navigationItem.leftBarButtonItems = @[back];
    self.navigationItem.title = @"メニュー";
    
    UIBarButtonItem *setting = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tab_icon_setting.png"]
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self
                                                              action:@selector(settingAction:)];
    
    self.navigationItem.rightBarButtonItems = @[setting];
    

    
    // 戻るボタンの横の矢印(<)の色が変わる
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:113/255.0 green:198/255.0 blue:193/255.0 alpha:1.0];
    
    // ナビゲーションバーのタイトルの文字色の変更
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:113/255.0 green:198/255.0 blue:193/255.0 alpha:1.0]};

    
    // CGRectMakeの引数の最後の3で太さを調整しています。
    CGRect r = CGRectMake(0, 42, self.navigationController.navigationBar.frame.size.width, 3);
    UILabel *line = [[UILabel alloc]initWithFrame:r];
    line.backgroundColor = [UIColor colorWithRed:113/255.0 green:198/255.0 blue:193/255.0 alpha:1.0];
    // ナビゲーションコントローラの、ナビゲーションバーに対して addSubviewするのがポイント。
    // selfのviewにaddしたら子のviewに遷移した時にアンダーラインが消えた。　←アホす
    [self.navigationController.navigationBar addSubview:line];
    
                              
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES]; // ナビゲーションバー表示
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapItem:(id)sender {
    
//    TutorialBatteryView *tbvc = [TutorialBatteryView myView];
//    [self.view addSubview:tbvc];
    
    TutorialBatteryViewController *mv = [[TutorialBatteryViewController alloc] init];
//    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:mv]; // mvにNavigationController を新たに付与
//    [self presentModalViewController:nc animated:YES];
    //[self presentViewController:mv animated:YES completion:nil];
    [self.navigationController pushViewController:mv animated:YES];
//    ShippingAddressViewController *sad = [[ShippingAddressViewController alloc]init];
//    [self.navigationController presentViewController:sad animated:YES completion:nil];
    
}

-(void)settingAction:(id)sender{
    ConfirmationTerumiIdViewController *ctivc = [[ConfirmationTerumiIdViewController alloc]init];
    [self.navigationController pushViewController:ctivc animated:YES];
}


@end
