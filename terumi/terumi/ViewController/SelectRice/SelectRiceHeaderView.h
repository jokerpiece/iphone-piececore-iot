//
//  SelectRiceHeaderView.h
//  terumi
//
//  Created by ハマモト  on 2016/08/18.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectRiceHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *itemIv;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
+ (instancetype)headerView;
@end
