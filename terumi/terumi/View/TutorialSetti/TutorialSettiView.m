//
//  TutorialSettiView.m
//  terumi
//
//  Created by ハマモト  on 2016/03/09.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "TutorialSettiView.h"
#import "ShippingAddressViewController.h"

@implementation TutorialSettiView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)_init
{
    // initialize
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 初期設定など
}

+ (instancetype)setSettiView
{
    // xib ファイルから MyView のインスタンスを得る
    UINib *nib = [UINib nibWithNibName:@"TutorialSettiView" bundle:nil];
    TutorialSettiView *view = [nib instantiateWithOwner:self options:nil][0];
    return view;
}


- (IBAction)tapNextBtn:(id)sender {
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
}

- (void)willRemoveSubview:(UIView *)subview {
    
}

@end
