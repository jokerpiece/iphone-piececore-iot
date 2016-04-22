//
//  RiceSelectTableViewCell.h
//  terumi
//
//  Created by OhnumaRina on 2016/04/20.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RiceSelectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *riceShopName;
@property (weak, nonatomic) IBOutlet UILabel *riceShopStreetAddress;
+ (CGFloat)rowHeight;

@end
