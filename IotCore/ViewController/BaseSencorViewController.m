//
//  BaseSencorViewController.m
//  terumi
//
//  Created by ハマモト  on 2016/03/01.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "BaseSencorViewController.h"
#import "SVProgressHUD.h"

@interface BaseSencorViewController ()

@end

@implementation BaseSencorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)setBLEConnectorWithServiceUuid:(NSString *)serviceUuid CharactoristicUuid:(NSString *)charactoristicUuid{
    self.ble = [[BLEConnector alloc]initWithServideUuid:serviceUuid charactoristicUuid:charactoristicUuid];
    //self.ble = [BLEConnector sharedManager];
    self.ble.delegate = self;
}

-(void)startScanWithIdentifer:(NSString*)identifer retryTime:(float)retryTime retryCount:(int)retryCount{
    //DLog(@"startscan:%@",identifer);
    
    [SVProgressHUD showWithStatus:@"接続中" maskType:SVProgressHUDMaskTypeBlack];
    [self.ble startScanWithIdentifer:identifer retryTimer:retryTime retryCount:retryCount];
    
    
}

-(void)startScanWithTimer{
}

-(void)updateActionWithData:(NSData *)data{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)cancelPeripheralConnection{
    [self.ble cancelPeripheralConnection];
}
-(void)connectPeripheral{
    [self.ble connectPeripheral];
}

-(void)fieldActionWithBLEErrType:(BLEErrType *)errType{
    [self.ble cancelPeripheralConnection];
    [SVProgressHUD dismiss];
    UIAlertView *alert =
    [[UIAlertView alloc]
     initWithTitle:@"エラー"
     message:@"センサーとの接続ができませんでした。"
     delegate:nil
     cancelButtonTitle:@"キャンセル"
     otherButtonTitles:@"再接続", nil
     ];
    alert.delegate = self;
    [alert show];
    
    
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            // cancelボタンが押された時の処理
            break;
        case 1:
            // otherボタンが押されたときの処理
            [self startScanWithTimer];
            break;
    }
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
