//
//  AppDelegate.m
//  terumi
//
//  Created by ハマモト  on 2016/02/08.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "AppDelegate.h"
#import "SelectRiceViewController.h"
#import "SettingViewController.h"
#import "SencorViewController.h"
#import <AudioToolbox/AudioServices.h>

@interface AppDelegate ()
@property (strong, nonatomic) SencorViewController *sencorViewController;
@property (nonatomic,strong) CBPeripheral *peripheral;

@end


@implementation AppDelegate


-(void)setConfig{
    //[self startScan:@"appdelagate"];
    [PieceCoreConfig setShopId:@"otonagokoro"];
    [PieceCoreConfig setAppKey:@"ba2b6159bfac1f3f22486b2c32a0b29d"];
    [PieceCoreConfig setAppId:@""];
    
    
}


- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    
    NSLog(@"performFetchWithCompletionHandler");
    if (self.sencorViewController != nil) {
        self.sencorViewController.totalSeachCount = 0;
        self.sencorViewController.effectSeachCount = 0;
        self.sencorViewController.distanceTotal = 0;
        [self.sencorViewController connectPeripheral];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)setTabBarController
{
    self.window =  [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tabBarController = [[TabbarViewController alloc] init];
    NSMutableArray *navigationControllerList = [NSMutableArray array];
    NSMutableArray *tabbarDataList = [self getTabbarDataList];
    
    int i = 0;
    for (TabbarData *tabbarData in tabbarDataList) {
        if (tabbarData.viewController != nil) {
            [self setTabbarNumberWithVc:tabbarData.viewController index:i];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabbarData.viewController];
            //            navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:tabbarData.tabTitle
            //                                                                            image:[[UIImage imageNamed:tabbarData.imgName] imageWithRenderingMode:UIImageRenderingModeAutomatic]
            //                                                                    selectedImage:[[UIImage imageNamed:tabbarData.selectImgName] imageWithRenderingMode:UIImageRenderingModeAutomatic]];
            //            navigationController.tabBarItem.title = tabbarData.tabTitle;
            [navigationControllerList addObject:navigationController];
            i++;
        }
    }
    
    
    
    //タブのタイトル位置設定
    //    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -1)];
    //    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f],
    //                                 NSForegroundColorAttributeName : self.theme.tabTitleNomalColor};
    //
    //    NSDictionary *attributes2 = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f],
    //                                  NSForegroundColorAttributeName : self.theme.tabTitleSelectColor};
    //
    //    [[UITabBarItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    //    [[UITabBarItem appearance] setTitleTextAttributes:attributes2 forState:UIControlStateSelected];
    //    [UITabBar appearance].tintColor = self.theme.tabBarSelectColor;
    //    [UITabBar appearance].barTintColor = self.theme.tabBarBackColor;
    //    [(UITabBarController *)self.tabBarController setViewControllers:navigationControllerList animated:NO];
    [self.window setRootViewController:[navigationControllerList objectAtIndex:0]];
    [self.window makeKeyAndVisible];
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //    [self.sencorViewController startScanWithTimer];
    self.sencorViewController.totalSeachCount = 0;
    self.sencorViewController.effectSeachCount = 0;
    self.sencorViewController.distanceTotal = 0;
    self.peripheral = self.sencorViewController.ble.peripheral;
    //[self.sencorViewController connectPeripheral];
}
//UITabBarController初期化
- (NSMutableArray *)getTabbarDataList
{
    NSMutableArray *tabbarDataList = [NSMutableArray array];
    self.sencorViewController =[[SencorViewController alloc] initWithNibName:@"SencorViewController" bundle:nil];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               self.sencorViewController
                                                                imgName:@"kometubu.png"
                                                          selectImgName:@"kometubu.png"
                                                               tabTitle:@"米びつ"
                                                                  title:@"米びつセンサー"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil]
                                                                imgName:@"tab_icon_shopping.png"
                                                          selectImgName:@"tab_icon_shopping.png"
                                                               tabTitle:@"Shopping"
                                                                  title:@"SHOPPING"]];
    [tabbarDataList addObject:[[TabbarData alloc]initWithViewController:
                               [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil]
                                                                imgName:@"tab_icon_shopping.png"
                                                          selectImgName:@"tab_icon_shopping.png"
                                                               tabTitle:@"Shopping"
                                                                  title:@"SHOPPING"]];
    return tabbarDataList;
}

-(void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    if(application.applicationState == UIApplicationStateActive) {
        
        //アプリがフォアグラウンドで動いている状態だった
        NSLog(@"[1-0]");
        //UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
        UINavigationController* nc = (UINavigationController *)self.window.rootViewController;
        SencorViewController *sencorV = [nc.viewControllers objectAtIndex:0];
        sencorV.orderView.alpha = 1;
        sencorV.maskView.alpha = 0.5;
        
    }
    else if (application.applicationState == UIApplicationStateInactive) {
        
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        if (application.applicationState == UIApplicationStateInactive)
        {//アプリがバックグラウンドで起動している時に、PUSH通知からアクティブになった場合
            
            // UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
            UINavigationController* nc = (UINavigationController *)self.window.rootViewController;
            SencorViewController *sencorV = [nc.viewControllers objectAtIndex:0];
            sencorV.orderView.alpha = 1;
            sencorV.maskView.alpha = 0.5;
            //遷移先へ移動
            //[tabController setSelectedViewController: nc];
        }
        
        
        
        UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
        UINavigationController* nc = (UINavigationController *)self.window.rootViewController;
        
        
        //遷移先へ移動
        //[tabController setSelectedViewController: nc];
        return;
        
    }
}


// プッシュ通知を受信した際の処理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    NSString *alert = [apsInfo objectForKey:@"alert"];
    NSNumber *badge = [apsInfo objectForKey:@"badge"];
    UIAlertView *alertView = [[UIAlertView alloc] init];
    [alertView setTitle:@"お知らせ"];
    [alertView setMessage:alert];
    [alertView addButtonWithTitle:@"OK"];
    [alertView show];
    
    NSDictionary *info = [userInfo objectForKey:@"info"];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    if (application.applicationState == UIApplicationStateInactive)
    {//アプリがバックグラウンドで起動している時に、PUSH通知からアクティブになった場合
        
        UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
        UINavigationController* nc = [tabController.viewControllers objectAtIndex:0];
        
        
        //遷移先へ移動
        [tabController setSelectedViewController: nc];
        
    }
    
    if (application.applicationState == UIApplicationStateActive)
    {//アプリがフォアグラウンドで起動している時にPUSH通知を受信した場合
        UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
        [[tabController.viewControllers objectAtIndex:[PieceCoreConfig tabnumberInfo].intValue] tabBarItem].badgeValue = badge.stringValue;
        
    }
    
    DLog(@"サーバーから届いている中身一覧: %@",[userInfo description]);
    
    
    if(application.applicationState == UIApplicationStateInactive)
    {
        //バックグラウンドにいる状態
        UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
        UINavigationController* nc = [tabController.viewControllers objectAtIndex:0];
        
        
        //遷移先へ移動
        [tabController setSelectedViewController: nc];
        return;
    } else if(application.applicationState == UIApplicationStateActive){
        //アクティブ
    }
    
    
    DLog(@"%@ %@ %@",[info objectForKey:@"title"],[info objectForKey:@"type"],[info objectForKey:@"id"]);
    
    //application.applicationIconBadgeNumber = 0;
}

@end
