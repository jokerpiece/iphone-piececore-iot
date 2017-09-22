//
//  SencorViewController.m
//  terumi
//
//  Created by ハマモト  on 2016/02/09.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "SencorViewController.h"
#import "SVProgressHUD.h"
#import "SettlementViewController.h"
#import "SelectRiceViewController.h"
#import "SensorSettingViewController.h"
#import "infoViewController.h"
#import "BLEConst.h"
#import "LnitialMenuViewController.h"
#import "CutomFlyerViewController.h"

@interface SencorViewController ()

@end

@implementation SencorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"tab_icon_shopping.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(moveFlyer)];
    
    self.navigationItem.leftBarButtonItem = btn;
    
    [self setBLEConnectorWithServiceUuid:JPSENSOR_SERVICE_UUID CharactoristicUuid:JPSENSOR_CHARACTORISTIC_UUID];
    //[self setCentlarManager];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)moveFlyer{
    // ① 2番目のタブのViewControllerを取得する
    UINavigationController *navigationC = self.tabBarController.viewControllers[0];
    // ② 2番目のタブを選択済みにする
    self.tabBarController.selectedViewController = navigationC;
    // ③ UINavigationControllerに追加済みのViewを一旦取り除く
    [navigationC popToRootViewControllerAnimated:NO];
//    // ④ SecondViewの画面遷移処理を呼び出す
//    CutomFlyerViewController *vc = [[CutomFlyerViewController alloc] initWithNibName:@"CutomFlyerViewController" bundle:nil];
//    [navigationC pushViewController:vc animated:YES];
}
-(void)viewDidAppearLogic{
    
    DistanceSencorData *data = [self loadSencorData];
    
    if (data.minDistance == 0 &&
        data.maxDistance == 0) {
        SensorSettingViewController *vc = [[SensorSettingViewController alloc]init];
        vc.parnentView = self;
        
        self.distanceTotal = 0;
        self.orderView.alpha = 0;
        self.maskView.alpha = 0;
        
        self.isDispedWarnig = NO;
        self.isDispedBatteryWarnig = NO;
        self.isDispedBackgroundWarnig = NO;
        
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        if (self.isNoReload) {
            self.isNoReload = NO;
        } else {
            self.sencorData = [self loadSencorData];
            //        [self startScan:@"sencor"];
            self.distanceTotal = 0;
            self.orderView.alpha = 0;
            self.maskView.alpha = 0;
            
            self.isDispedWarnig = NO;
            self.isDispedBatteryWarnig = NO;
            self.isDispedBackgroundWarnig = NO;
            [self startScanWithTimer];
        }
        
        
        
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *pid =[ud stringForKey:@"BUY_PID"];
    
    if ([Common isNotEmptyString:pid]) {
        self.orderBtn.alpha = 1;
    } else {
        self.orderBtn.alpha = 0;
    }
    
}


-(void)startScanWithTimer{
    
    self.distanceTotal = 0;
    self.effectSeachCount = 0;
    self.totalSeachCount = 0;
    [self startScanWithIdentifer:@"sencor" retryTime:TIMER_RETRY retryCount:RETRY_COUNT];
    
}

-(void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
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

-(void)updateAction{
    
    if (self.totalSeachCount >= SERACH_COUNT) {
        [SVProgressHUD dismiss];
        //[self cancelPeripheralConnection];
        
        self.remaingLbl.text = [NSString stringWithFormat:@"%d%%",[self getRemaining:self.distanceTotal / self.effectSeachCount]];
        self.distanceTotal = 0;
        self.effectSeachCount = 0;
        self.totalSeachCount = 0;
        
    } else {
        self.totalSeachCount ++;
        if (self.distance < LOW_DISTANCE) {
            //極端に数値が低いため、ノーカン
            return;
        }
        
        self.effectSeachCount ++;
        self.distanceTotal += self.distance;
    }
    self.batteryLbl.text =[NSString stringWithFormat:@"%d%%",self.battery];
    
    
}

-(int)getRemaining:(int)distance{
    
    if (!self.isDispedBatteryWarnig) {
        if (self.battery < LOW_BATTERY) {
            [self showAlert:@"電池が少なくなっています。" message:@"今すぐセンサーの電池を交換して下さい。"];
            self.isDispedBatteryWarnig = YES;
            return 0;
        }
    }
    
    
    
    
    int splitDistance = (self.sencorData.maxDistance - self.sencorData.minDistance) / 5;
    if (splitDistance * 4 < distance - self.sencorData.minDistance) {
        self.remaingLbl.textColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.55 alpha:1.0];
        self.graff1.alpha = 1.0;
        self.graff2.alpha = 1.0;
        self.graff3.alpha = 1.0;
        self.graff4.alpha = 1.0;
        self.graff5.alpha = 1.0;
        self.graff6.alpha = 1.0;
        self.graff7.alpha = 1.0;
        self.graff8.alpha = 1.0;
        self.graff9.alpha = 1.0;
        self.graff10.alpha = 1.0;
        self.graff11.alpha = 1.0;
        self.frame1View.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.80 alpha:1.0];
        self.frame2View.backgroundColor =[UIColor colorWithRed:0.00 green:0.00 blue:0.55 alpha:1.0];
        self.frame3View.backgroundColor = [UIColor colorWithRed:0.12 green:0.56 blue:1.00 alpha:1.0];
        self.alertMessage.text = @"";
        self.orderRemaingLbl.text = [NSString stringWithFormat:@"100%%"];
        return 100;
    } else if (splitDistance * 3 < distance - self.sencorData.minDistance){
        self.graff1.alpha = 0.3;
        self.graff2.alpha = 0.3;
        self.graff3.alpha = 0.3;
        self.graff4.alpha = 1.0;
        self.graff5.alpha = 1.0;
        self.graff6.alpha = 1.0;
        self.graff7.alpha = 1.0;
        self.graff8.alpha = 1.0;
        self.graff9.alpha = 1.0;
        self.graff10.alpha = 1.0;
        self.graff11.alpha = 1.0;
        self.remaingLbl.textColor = [UIColor colorWithRed:0.00 green:0.39 blue:0.00 alpha:1.0];
        self.frame1View.backgroundColor = [UIColor colorWithRed:0.00 green:0.55 blue:0.55 alpha:1.0];
        self.frame2View.backgroundColor =[UIColor colorWithRed:0.00 green:0.00 blue:0.55 alpha:1.0];
        self.frame3View.backgroundColor = [UIColor colorWithRed:0.00 green:1.00 blue:0.50 alpha:1.0];
        self.alertMessage.text = @"";
        self.orderRemaingLbl.text = [NSString stringWithFormat:@"75%%"];
        return 75;
    } else if (splitDistance * 2 < distance- self.sencorData.minDistance){
        self.graff1.alpha = 0.3;
        self.graff2.alpha = 0.3;
        self.graff3.alpha = 0.3;
        self.graff4.alpha = 0.3;
        self.graff5.alpha = 0.3;
        self.graff6.alpha = 1.0;
        self.graff7.alpha = 1.0;
        self.graff8.alpha = 1.0;
        self.graff9.alpha = 1.0;
        self.graff10.alpha = 1.0;
        self.graff11.alpha = 1.0;
        self.remaingLbl.textColor = [UIColor colorWithRed:0.42 green:0.56 blue:0.14 alpha:1.0];
        self.frame1View.backgroundColor = [UIColor colorWithRed:0.00 green:0.55 blue:0.55 alpha:1.0];
        self.frame2View.backgroundColor =[UIColor colorWithRed:0.20 green:0.80 blue:0.20 alpha:1.0];
        self.frame3View.backgroundColor = [UIColor colorWithRed:0.68 green:1.00 blue:0.18 alpha:1.0];
        self.alertMessage.text = @"";
        self.orderRemaingLbl.text = [NSString stringWithFormat:@"50%%"];
        return 50;
    } else if (splitDistance <distance- self.sencorData.minDistance) {
        self.graff1.alpha = 0.3;
        self.graff2.alpha = 0.3;
        self.graff3.alpha = 0.3;
        self.graff4.alpha = 0.3;
        self.graff5.alpha = 0.3;
        self.graff6.alpha = 0.3;
        self.graff7.alpha = 0.3;
        self.graff8.alpha = 0.3;
        self.graff9.alpha = 1.0;
        self.graff10.alpha = 1.0;
        self.graff11.alpha = 1.0;
        self.remaingLbl.textColor = [UIColor colorWithRed:0.33 green:0.42 blue:0.18 alpha:1.0];
        self.frame1View.backgroundColor = [UIColor colorWithRed:0.85 green:0.65 blue:0.13 alpha:1.0];
        self.frame2View.backgroundColor =[UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0];
        self.frame3View.backgroundColor = [UIColor colorWithRed:0.96 green:0.64 blue:0.38 alpha:1.0];
        self.orderRemaingLbl.text = [NSString stringWithFormat:@"25%%"];
        self.alertMessage.text = @"もう少しでお米がなくなります。\n注文しておきますか？";
        [self dispWarning];
        
        
        return 25;
    } else {
        self.graff1.alpha = 0.3;
        self.graff2.alpha = 0.3;
        self.graff3.alpha = 0.3;
        self.graff4.alpha = 0.3;
        self.graff5.alpha = 0.3;
        self.graff6.alpha = 0.3;
        self.graff7.alpha = 0.3;
        self.graff8.alpha = 0.3;
        self.graff9.alpha = 0.3;
        self.graff10.alpha = 0.3;
        self.graff11.alpha = 1.0;
        self.remaingLbl.textColor = [UIColor colorWithRed:0.50 green:0.00 blue:0.00 alpha:1.0];
        self.frame1View.backgroundColor = [UIColor colorWithRed:0.80 green:0.36 blue:0.36 alpha:1.0];
        self.frame2View.backgroundColor =[UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0];
        self.frame3View.backgroundColor = [UIColor colorWithRed:1.00 green:0.71 blue:0.76 alpha:1.0];
        self.orderRemaingLbl.text = [NSString stringWithFormat:@"0%%"];
        self.alertMessage.text = @"もう少しでお米がなくなります。\n注文しておきますか？";
        [self dispWarning];
        
        return 0;
    }
    
    return 0;
}

-(void)dispWarning{
    
    
    UIApplicationState applicationState = [[UIApplication sharedApplication] applicationState];
    if (applicationState == UIApplicationStateActive) {
        if (self.isDispedWarnig) {
            return;
        }
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *pid =[ud stringForKey:@"BUY_PID"];
        
        if ([Common isNotEmptyString:pid]) {
            NetworkConecter *conector = [NetworkConecter alloc];
            conector.delegate = self;
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:pid forKey:@"item_id"];
            [conector sendActionSendId:SendIdItem param:param];
        }
        
        self.isDispDeliverPushed = YES;
        self.orderView.alpha = 1.0;
        self.maskView.alpha = 0.5;
        self.isDispedWarnig = YES;
        
    }else if(applicationState == UIApplicationStateBackground){
        if (self.isDispedBackgroundWarnig) {
            return;
        }
        // バックグラウンドのとき
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        // 5分後に通知をする（設定は秒単位）
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
        // タイムゾーンの設定
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 通知時に表示させるメッセージ内容
        notification.alertBody = @"お米が少なくなってます！";
        // 通知に鳴る音の設定
        notification.soundName = UILocalNotificationDefaultSoundName;
        
        // 通知の登録
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        self.isDispedBackgroundWarnig = YES;
        
    } else if(applicationState == UIApplicationStateInactive){
        // アクティブじゃないとき
        DLog(@"activeではないよ");
    }
}

- (IBAction)onNomalRice:(id)sender {
}

- (IBAction)onOtherRice:(id)sender {
}

- (IBAction)closeAction:(id)sender {
    self.orderView.alpha = 0;
    self.maskView.alpha = 0;
}

- (IBAction)orderAction:(id)sender {
//    [SVProgressHUD showWithStatus:@"決済処理中・・・" maskType:SVProgressHUDMaskTypeBlack];
//    [self performSelector:@selector(complete) withObject:nil afterDelay:3.0];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *pid =[ud stringForKey:@"BUY_PID"];
    
    if ([Common isNotEmptyString:pid]) {
        NetworkConecter *conector = [NetworkConecter alloc];
        conector.delegate = self;
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:pid forKey:@"item_id"];
        [conector sendActionSendId:SendIdItem param:param];
    }
    
}

- (IBAction)otherAction:(id)sender {
    FlyerViewController *fv=[[FlyerViewController alloc] initWithNibName:@"FlyerViewController" bundle:nil];
    fv.isSearchBtnInvisible = YES;
    [self.navigationController pushViewController:fv animated:YES];
}

-(void)complete {
    [SVProgressHUD dismiss];
    self.orderView.alpha = 0;
    self.maskView.alpha = 0;
    SettlementViewController *vc = [[SettlementViewController alloc]init];
    vc.riceName = self.komeLbl.text;
    vc.imgV=self.komeIv;
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (IBAction)deliveryAction:(id)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *pid =[ud stringForKey:@"BUY_PID"];
    
    if ([Common isNotEmptyString:pid]) {
        self.isDispDeliverPushed = YES;
        NetworkConecter *conector = [NetworkConecter alloc];
        conector.delegate = self;
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:pid forKey:@"item_id"];
        [conector sendActionSendId:SendIdItem param:param];
    }
    self.orderView.alpha = 1;
    self.maskView.alpha = 0.5;
}

- (IBAction)settingAction:(id)sender {
    
    [self cancelPeripheralConnection];
    [self stopTimer];
    SensorSettingViewController *vc = [[SensorSettingViewController alloc]init];
    vc.parnentView = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)questionAction:(id)sender {
    [self stopTimer];
    infoViewController *vc = [[infoViewController alloc]init];
    vc.parnentView = self;
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)settinged{
    
    self.sencorData = [self loadSencorData];
    self.distanceTotal = 0;
    [self startScanWithTimer];
}

-(void)menuAction:(id)sender
{
    LnitialMenuViewController *lmvc = [[LnitialMenuViewController alloc]init];
    lmvc.parnentView = self;
    //[self presentViewController:lmvc animated:YES completion:nil];
    [self.navigationController pushViewController:lmvc animated:YES];
}

-(void)syncItemdataAction{
    NetworkConecter *conector = [NetworkConecter alloc];
    conector.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.itemId forKey:@"item_id"];
    [conector sendActionSendId:SendIdItem param:param];
}


-(void)setDataWithRecipient:(BaseRecipient *)recipient sendId:(NSString *)sendId{
    
    if([sendId isEqualToString:SendIdItem]){
        self.itemRecipient = (ItemRecipient *)recipient;
        NSArray *itemList = [self.itemRecipient.resultset objectForKey:@"itemLists"];
        
        if(itemList.firstObject != NULL){
            
            if (self.isDispDeliverPushed) {
                self.isDispDeliverPushed = NO;
                [self.komeIv setImageWithURL:itemList[0][@"img_url"] placeholderImage:nil options:SDWebImageCacheMemoryOnly usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                self.komeLbl.text = itemList[0][@"item_name"];
            } else {
                linepay_ViewController *lvc = [[linepay_ViewController alloc]
                                               initWithNibName:@"linepay_ViewController" bundle:nil];
                lvc.itemName = itemList[0][@"item_name"];
                lvc.productId = itemList[0][@"item_id"];
                lvc.imgUrl = itemList[0][@"img_url"];
                lvc.itemText = itemList[0][@"text"];
                lvc.itemPrice = itemList[0][@"price"];
                lvc.itemStock = itemList[0][@"stocks"];
                
                [self.navigationController pushViewController:lvc animated:YES];
            }
            
        }
        
    }
    
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    if([sendId isEqualToString:SendIdItem]){
        return [ItemRecipient alloc];
    } else {
        return [BaseRecipient alloc];
    }
}

@end
