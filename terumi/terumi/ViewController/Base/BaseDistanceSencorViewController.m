//
//  BaseDistanceSencorViewController.m
//  terumi
//
//  Created by ハマモト  on 2016/03/25.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "BaseDistanceSencorViewController.h"

@implementation BaseDistanceSencorViewController

-(void)updateActionWithData:(NSData *)data{
    const uint8_t *reportData = (uint8_t *)[data bytes];
    self.distance = reportData[0]*256 + reportData[1];
    self.battery = reportData[2];
    self.temperature = reportData[3] * 165/256 -40;
    self.humidity = reportData[4] * 100/256;
    DLog(@"--------------");
    DLog(@"距離:%d",self.distance);
//    DLog(@"電池:%d",self.battery);
//    DLog(@"温度:%d",self.temperature);
//    DLog(@"湿度:%d",self.humidity);
    
    [self updateAction];
}

-(void)updateAction{
    
}

-(void)saveSencorData:(DistanceSencorData *)sencorData
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSNumber numberWithInt:sencorData.maxDistance] forKey:@"MAXSDISTANC"];
    [dic setValue:[NSNumber numberWithInt:sencorData.minDistance] forKey:@"MINSDISTANC"];
    
    [ud setObject:dic forKey:@"SENSOR"];
    [ud synchronize];
    
}

-(DistanceSencorData *)loadSencorData
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"SENSOR"];
    DistanceSencorData *data = [[DistanceSencorData alloc]init];
    data.minDistance = (int)[[dic objectForKey:@"MINSDISTANC"] integerValue];
    data.maxDistance = (int)[[dic objectForKey:@"MAXSDISTANC"] integerValue];
    return data;
    
}

@end
