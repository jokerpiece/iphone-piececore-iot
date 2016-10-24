//
//  SelectRiceViewController.h
//  terumi
//
//  Created by ハマモト  on 2016/02/08.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "ItemListViewController.h"
@interface SelectRiceViewController : ItemListViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
- (IBAction)btn1Action:(id)sender;
- (IBAction)btn2Action:(id)sender;
- (IBAction)btn3Action:(id)sender;
- (IBAction)btn4Action:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *selectRicetTable;
@property (nonatomic) ItemData *HeaderData;
@end
