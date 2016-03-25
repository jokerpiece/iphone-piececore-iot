//
//  sencorData.m
//  terumi
//
//  Created by ハマモト  on 2016/03/01.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "DistanceSencorData.h"

@implementation DistanceSencorData

-(int)getRemaining:(int)distance{
    int splitDistance = distance > (self.maxDistance - self.minDistance) / 5;
    if (splitDistance * 4 < distance) {
        return 100;
    } else if (splitDistance * 3 < distance){
        return 75;
    } else if (splitDistance * 2 < distance){
        return 50;
    } else if (splitDistance <distance) {
        return 25;
    } else {
        return 0;
    }
        
    return 0;
}
@end
