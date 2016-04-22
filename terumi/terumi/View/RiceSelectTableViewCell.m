//
//  RiceSelectTableViewCell.m
//  terumi
//
//  Created by OhnumaRina on 2016/04/20.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "RiceSelectTableViewCell.h"

@implementation RiceSelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowHeight
{
    return 60.0f;
}

@end
