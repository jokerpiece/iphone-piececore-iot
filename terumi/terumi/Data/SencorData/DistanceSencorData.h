//
//  sencorData.h
//  terumi
//
//  Created by ハマモト  on 2016/03/01.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistanceSencorData : NSObject
@property(nonatomic) int minDistance;
@property(nonatomic) int maxDistance;


-(int)getRemaining:(int)distance;
@end
