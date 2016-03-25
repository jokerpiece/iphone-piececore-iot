//
//  SettlementViewController.h
//  terumi
//
//  Created by ハマモト  on 2016/02/08.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"

@interface SettlementViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *ricenameLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property(nonatomic)NSString *riceName;
@property(nonatomic)NSString *price;


@end
