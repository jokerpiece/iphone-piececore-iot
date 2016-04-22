//
//  ShippingAddressViewController.m
//  terumi
//
//  Created by OhnumaRina on 2016/04/15.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "ShippingAddressViewController.h"
#import "SelectRiceShopViewController.h"
#import "SelectPayerViewController.h"

@interface ShippingAddressViewController ()

@end

@implementation ShippingAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem* back = [[UIBarButtonItem alloc]
                              initWithTitle:@""
                              style:UIBarButtonItemStyleBordered
                              target:self
                              action:nil];
    self.navigationItem.leftBarButtonItems = @[back];
    self.navigationItem.title = @"お届け先住所";
    [self registerForKeyboardNotifications];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES]; // ナビゲーションバー表示
}

-(void)viewDidLayoutSubviews {
    self.scroll.contentSize = CGSizeMake(300,900);
    [self.scroll flashScrollIndicators];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moveSelectRiceShop:(id)sender {
    SelectRiceShopViewController *savc = [[SelectRiceShopViewController alloc]init];
    //[self presentViewController:savc animated:YES completion:nil];
    if(![self.postCode.text isEqualToString:@""] &&
       ![self.userName.text isEqualToString:@""] &&
       ![self.phoneNumber.text isEqualToString:@""] &&
       ![self.streetAddress.text isEqualToString:@""]
       ){
        [self.navigationController pushViewController:savc animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"入力エラー"
                                                        message:@"未入力の項目があります"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
}

- (IBAction)moveSelectPayer:(id)sender {
    SelectPayerViewController *spvc = [[SelectPayerViewController alloc]init];
   // [self presentViewController:spvc animated:YES completion:nil];
    [self.navigationController pushViewController:spvc animated:YES];
}

- (IBAction)searchPostCodeBtn:(id)sender{
    int max_post_Length = 7;
    NSMutableString *str = [self.postCode.text mutableCopy];
    //住所検索ボタンを押した時の処理
    self.streetAddress.text = nil;
    //[self endEditing:YES];
    //郵便番号未入力かどうかの判別
    if([str length] == 0)
    {
        //未入力の場合
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"入力エラー"
                                                        message:@"郵便番号を入力してください。"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    } else if([str length] == max_post_Length){
        NSString *origin = @"http://zipcloud.ibsnet.co.jp/api/search?zipcode=";
        NSString *url = [NSString stringWithFormat:@"%@%@",origin,self.postCode.text];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
        DLog(@"%@",[array valueForKeyPath:@"results"]);
        NSString *json_str = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
        DLog(@"%@",json_str);
        //
        if(array[@"results"] == [NSNull null]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"入力エラー"
                                                            message:@"住所が確認できませんでした。郵便番号を確認してください。"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
            return;
        }
        for(NSDictionary *cor2 in array[@"results"])
        {
            DLog(@"%@,%@,%@",cor2[@"address1"],cor2[@"address2"],cor2[@"address3"]);
            self.streetAddress.text = [NSString stringWithFormat:@"%@%@%@",cor2[@"address1"],cor2[@"address2"],cor2[@"address3"]];
        }
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"入力エラー"
                                                        message:@"7桁の数字を入力してください"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
        
    }

}

- (IBAction)onSignalTap:(id)sender {
    [self.view endEditing:YES];
}


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.scroll convertRect:keyboardRect fromView:nil];
    
    if (CGRectGetMaxY(self.streetAddress.frame) < CGRectGetMinY(keyboardRect)) {
        return;
    }
    
    CGFloat nowOffsetY = self.scroll.contentOffset.y;
    
    // スクロールさせる距離を算出
    CGFloat offsetY = CGRectGetMaxY(self.streetAddress.frame) - CGRectGetMinY(keyboardRect);
    
    // scrollView の contentInset と scrollIndicatorInsets の bottom に追加
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, offsetY, 0.0);
    self.scroll.contentInset = contentInsets;
    self.scroll.scrollIndicatorInsets = contentInsets;

    
    CGPoint scrollPoint = CGPointMake(0.0,200.0);
    [self.scroll setContentOffset:scrollPoint animated:YES];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self.scroll setContentOffset:CGPointZero animated:YES];
}

@end
