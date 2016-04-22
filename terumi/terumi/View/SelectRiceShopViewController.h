//
//  SelectRiceShopViewController.h
//  terumi
//
//  Created by OhnumaRina on 2016/04/15.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiceSelectTableViewCell.h"
#import "SelectPayerViewController.h"

static NSString * const TableViewCustomCellIdentifier = @"RiceSelectTableViewCell";



@interface SelectRiceShopViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *riceShopTableView;
@end
