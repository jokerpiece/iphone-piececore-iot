//
//  infoViewController.m
//  terumi
//
//  Created by ハマモト  on 2016/03/03.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "infoViewController.h"

@interface infoViewController ()

@end

@implementation infoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UIWebViewのインスタンス初期化
//    self.webview = [[UIWebView alloc]init];
//    
//    // デリゲート
//    self.webView.delegate = self;
    
    // Webページの大きさを画面に合わせる
//    CGRect rect = self.view.frame;
//    webView.frame = rect;
//    webView.scalesPageToFit = YES;
//    
//    // インスタンスをビューに追加する
//    [self.view addSubview:webView];
    
    // URLを指定
    NSURL *url = [NSURL URLWithString:@"http://jokapi.jp/pieceContents/mylife/credit.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // リクエストを投げる
    [self.webview loadRequest:request];
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.parnentView settinged];
    }];
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
