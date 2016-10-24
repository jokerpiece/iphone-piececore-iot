//
//  SelectRiceHeaderView.m
//  terumi
//
//  Created by ハマモト  on 2016/08/18.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "SelectRiceHeaderView.h"

@implementation SelectRiceHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)headerView
{
    // xib ファイルから MyView のインスタンスを得る
    UINib *nib = [UINib nibWithNibName:@"SelectRiceHeaderView" bundle:nil];
    SelectRiceHeaderView *view = [nib instantiateWithOwner:self options:nil][0];
    return view;
}
@end
