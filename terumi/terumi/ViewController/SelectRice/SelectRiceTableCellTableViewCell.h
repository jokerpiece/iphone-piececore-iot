//
//  SelectRiceTableCellTableViewCell.h
//  terumi
//
//  Created by ハマモト  on 2016/08/17.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemData.h"

@interface SelectRiceTableCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemImg1;
@property (weak, nonatomic) IBOutlet UIImageView *itemImg2;
@property (weak, nonatomic) IBOutlet UILabel *item1NameLbl;
@property (weak, nonatomic) IBOutlet UILabel *item2NameLbl;
@property (weak, nonatomic) IBOutlet UILabel *item1PriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *item2PriceLbl;
@property (weak, nonatomic) IBOutlet UIView *item1View;
@property (weak, nonatomic) IBOutlet UIView *item2View;
@property (nonatomic) ItemData *data1;
@property (nonatomic) ItemData *data2;
@property (nonatomic) UIViewController *parnentVc;

@end
