//
//  SettingViewController.m
//  terumi
//
//  Created by ハマモト  on 2016/02/09.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "SettingViewController.h"
#import "BLEConst.h"
#import "SVProgressHUD.h"

typedef enum {
    minSearh = 0,
    maxSearch,
    none
} seachType;

@interface SettingViewController ()
@property (nonatomic) seachType seachType;
@property (nonatomic) int minDistanceTotal;
@property (nonatomic) int maxDistanceTotal;
@end



@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBLEConnectorWithServiceUuid:JPSENSOR_SERVICE_UUID CharactoristicUuid:JPSENSOR_CHARACTORISTIC_UUID];
    self.data = [self loadSencorData];
    self.seachType = none;
    self.maxlbl.text = [NSString stringWithFormat:@"%d",self.data.maxDistance];
    self.minlbl.text = [NSString stringWithFormat:@"%d",self.data.minDistance];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)onMaxSetting:(id)sender {
    [self startScanWithIdentifer:@"setting" retryTime:TIMER_RETRY retryCount:RETRY_COUNT];
    self.totalSeachCount = 0;
    self.effectSeachCount = 0;
    self.seachType = maxSearch;
    [SVProgressHUD showWithStatus:@"測定中・・・" maskType:SVProgressHUDMaskTypeBlack];
    
}



- (IBAction)onMinSetting:(id)sender {
    //[self setCentlarManager];
    [self startScanWithIdentifer:@"setting" retryTime:TIMER_RETRY retryCount:RETRY_COUNT];
    self.totalSeachCount = 0;
    self.effectSeachCount = 0;
    self.seachType = minSearh;
    
    [SVProgressHUD showWithStatus:@"測定中・・・" maskType:SVProgressHUDMaskTypeBlack];
    
}


-(void)updateAction{
    
    
    if (self.seachType == none) {
        return;
    }
    
    self.totalSeachCount ++;
    self.distanceLbl.text = [NSString stringWithFormat:@"%d",self.distance];
    //    if (self.battery < 25) {
    //        [SVProgressHUD dismiss];
    //        [self showAlert:@"エラー" message:@"バッテリーが少なくなっています。電池を交換してから再度お試し下さい。"];
    //        self.seachType = none;
    //        return;
    //    }
    //
    
    if (self.totalSeachCount >= SERACH_COUNT) {
        [self cancelPeripheralConnection];
        [SVProgressHUD dismiss];
        if (self.seachType == minSearh) {
            
            self.data.minDistance = self.minDistanceTotal / self.effectSeachCount;
            self.minlbl.text = [NSString stringWithFormat:@"%d",self.data.minDistance];
            DLog(@"MIN:%d",self.data.minDistance);
            
        } else if(self.seachType == maxSearch) {
            
            self.data.maxDistance = self.maxDistanceTotal / self.effectSeachCount;
            self.maxlbl.text = [NSString stringWithFormat:@"%d",self.data.maxDistance];
            DLog(@"MAX:%d",self.data.maxDistance);
        }
        
        if (self.data.maxDistance == 0 ||
            self.data.minDistance == 0) {
            
            if ((self.seachType == maxSearch && self.data.maxDistance == 0) ||
                (self.seachType == minSearh && self.data.minDistance == 0)) {
                [self showAlert:@"エラー" message:@"距離を測定できませんでした。設置状況をお確かめ下さい。"];
            }
            
            self.seachType = none;
            return;
        } else {
            self.seachType = none;
            //            if (self.data.maxDistance - self.data.minDistance < LOW_DIFF_DISTANCE) {
            //                [self showAlert:@"エラー" message:@"十分な距離を取得できませんでした。お米の量を確認して下さい。"];
            //            } else {
            [self saveSencorData:self.data];
            [self cancelPeripheralConnection ];
            [self dismissViewControllerAnimated:YES completion:^{
                [self.parnentView settinged];
            }];
            //            }
            
        }
        
    } else {
        if (self.distance < LOW_DISTANCE) {
            //極端に数値が低いため、ノーカン
            return;
        }
        
        self.effectSeachCount ++;
        if (self.seachType == minSearh) {
            self.minDistanceTotal += self.distance;
            self.effDistanceLbl.text = [NSString stringWithFormat:@"%d",self.minDistanceTotal / self.effectSeachCount] ;
        } else if(self.seachType == maxSearch) {
            self.maxDistanceTotal += self.distance;
            self.effDistanceLbl.text = [NSString stringWithFormat:@"%d",self.maxDistanceTotal / self.effectSeachCount] ;
        }
    }
    
    
    
    
}
-(BOOL)distanceValidation{
    if (self.battery < LOW_BATTERY) {
        //        [self showAlert:@"エラー" message:@"バッテリーが少なくなっています。電池を交換してから再度お試し下さい。"];
        //        return NO;
        return YES;
    } else if (self.distance < 50){
        [self showAlert:@"エラー" message:@"距離が正確にとれていません。設置状況をお確かめ下さい。"];
        return NO;
    }
    return YES;
}
- (IBAction)closeAction:(id)sender {
    [self cancelPeripheralConnection ];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.parnentView settinged];
    }];
}
@end
