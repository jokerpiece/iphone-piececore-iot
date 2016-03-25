//
//  SelectRiceViewController.m
//  terumi
//
//  Created by ハマモト  on 2016/02/08.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "SelectRiceViewController.h"
#import "SencorViewController.h"

@interface SelectRiceViewController ()

@end

@implementation SelectRiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"お米を選択";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews {
    self.scroll.contentSize = CGSizeMake(320,990);
    [self.scroll flashScrollIndicators];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn1Action:(id)sender {
    SencorViewController *sencorV = [self.navigationController.viewControllers objectAtIndex:0];
    sencorV.komeIv.image =  [UIImage imageNamed:@"kome2.png"];
    sencorV.komeLbl.text = @"山口県産白米ひとめぼれ\n5kg\n¥1580";
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn2Action:(id)sender {
    SencorViewController *sencorV = [self.navigationController.viewControllers objectAtIndex:0];
    sencorV.komeIv.image =  [UIImage imageNamed:@"kome3.png"];
    sencorV.komeLbl.text = @"得々ごはん\n10kg\n¥2681";
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn3Action:(id)sender {
    SencorViewController *sencorV = [self.navigationController.viewControllers objectAtIndex:0];
    sencorV.komeIv.image =  [UIImage imageNamed:@"kome4.png"];
    sencorV.komeLbl.text = @"北海道白米きらら\n10kg\n¥2980";
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn4Action:(id)sender {
    SencorViewController *sencorV = [self.navigationController.viewControllers objectAtIndex:0];
    sencorV.komeIv.image =  [UIImage imageNamed:@"kome5.png"];
    sencorV.komeLbl.text = @"岩手県産白米ひとめぼれ\n5kg\n¥3540";
    [self.navigationController popViewControllerAnimated:YES];
}
@end
