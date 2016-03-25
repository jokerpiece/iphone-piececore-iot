//
//  BaseDistanceSencorViewController.h
//  terumi
//
//  Created by ハマモト  on 2016/03/25.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "BaseSencorViewController.h"

@interface BaseDistanceSencorViewController : BaseSencorViewController
@property (nonatomic)uint16_t distance;
@property (nonatomic)uint16_t battery;
@property (nonatomic)uint16_t temperature;
@property (nonatomic)uint16_t humidity;
@property (nonatomic)uint16_t min_distance;
@property (nonatomic)uint16_t max_distance;

@property (nonatomic) int totalSeachCount;
@property (nonatomic) int effectSeachCount;
-(void)updateAction;
-(void)saveSencorData:(DistanceSencorData *)sencorData;
-(DistanceSencorData *)loadSencorData;
@end
