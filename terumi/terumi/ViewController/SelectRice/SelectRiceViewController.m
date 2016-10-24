//
//  SelectRiceViewController.m
//  terumi
//
//  Created by ハマモト  on 2016/02/08.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "SelectRiceViewController.h"
#import "SencorViewController.h"
#import "SelectRiceTableCellTableViewCell.h"
#import "SelectRiceHeaderView.h"

@interface SelectRiceViewController ()

@end

@implementation SelectRiceViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"SelectRiceViewController" owner:self options:nil];
}

- (void)viewDidLoadLogic
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    // NSDateの保存
    NSDate* date = [NSDate date];
    [defaults setObject:date forKey:@"LOGIN_DATE"];
    
    self.selectRicetTable.delegate = self;
    self.selectRicetTable.dataSource = self;
    self.title = @"お米を選択";
    self.code = @"piece:13040";
    self.searchType = category;
    self.selectRicetTable.separatorColor = [UIColor whiteColor];
    UINib *aidollNib = [UINib nibWithNibName:@"SelectRiceTableCellTableViewCell" bundle:nil];
    [self.selectRicetTable registerNib:aidollNib forCellReuseIdentifier:@"SelectRiceTableCellTableViewCell"];
    
    // Do any additional setup after loading the view from its nib.
}

-(NSString *)loadBuyedItemtId{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    NSString* itemId = [defaults objectForKey:@"BuyedItemId"];
    return itemId;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SelectRiceTableCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectRiceTableCellTableViewCell"];
        cell.parnentVc = self;
        
        for (int i = 0; i <= 1; i ++) {
            if (self.itemRecipient.list.count < indexPath.row + i) {
                return cell;
            }
            ItemData *data = [self.itemRecipient.list objectAtIndex:indexPath.row + i];
            
            if (i == 0) {
                cell.data1 = data;
            } else {
                cell.data2 = data;
            }
            
            
            if ([Common isNotEmptyString:data.img_url]) {
                NSURL *imageURL = [NSURL URLWithString:[data.img_url stringByAddingPercentEscapesUsingEncoding:
                                                        NSUTF8StringEncoding]];
                
                if (i == 0) {
                    [cell.itemImg1 setImageWithURL:imageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                } else {
                    [cell.itemImg2 setImageWithURL:imageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                }
                
                
            }
            
            if ([Common isNotEmptyString:data.item_name]) {
                if (i == 0) {
                    cell.item1NameLbl.text = data.item_name;
                } else {
                    cell.item2NameLbl.text = data.item_name;
                }
            }
            
            if ([Common isNotEmptyString:data.item_price]) {
                
                if (i == 0) {
                    cell.item1PriceLbl.text = data.item_price;
                } else {
                    cell.item2PriceLbl.text = data.item_price;
                }
            }
            
//            if ([Common isNotEmptyString:data.stock]) {
//                UILabel *stockLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width - 165,65,60,20)];
//                stockLbl.text = [NSString stringWithFormat:@"%@",data.stock];
//                if ([stockLbl.text isEqualToString:@"売り切れ"]) {
//                    stockLbl.textColor = [UIColor whiteColor];
//                    stockLbl.backgroundColor = [UIColor grayColor];
//                    stockLbl.textAlignment = NSTextAlignmentCenter;
//                } else {
//                    stockLbl.textColor = [UIColor blackColor];
//                    stockLbl.backgroundColor = [UIColor clearColor];
//                    stockLbl.textAlignment = NSTextAlignmentRight;
//                }
//                stockLbl.font = [UIFont boldSystemFontOfSize:10];
//                stockLbl.alpha = 1.0f;
//                
//                [cell.contentView addSubview:stockLbl];
//            }
        }
        
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
            UIImageView *reloadView = [[UIImageView alloc] init];
            reloadView.frame = CGRectMake(80,15, 32, 32);
            reloadView.image = [UIImage imageNamed:@"undo.png"];
            [cell.contentView addSubview:reloadView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125,20,100,25)];
            label.text = @"次を検索する";
            label.font = [UIFont fontWithName:@"AppleGothic" size:16];
            label.alpha = 1.0f;
            label.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label];
        }
        return cell;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.itemRecipient.list.count/2;
    } else {
        if (self.isMore) {
            return 1;
        } else {
            return 0;
        }
        
    }
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//    }
//    if (indexPath.section == 1){
//        //[self sendGetEventList];
//    }
//    
//    
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 275.0f ;
    } else {
        return 60.0f;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.HeaderData != nil && section == 0) {
        return 158.0;
    } else {
        return 0;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.HeaderData != nil) {
        
        SelectRiceHeaderView *view = [SelectRiceHeaderView headerView];
        
        if ([Common isNotEmptyString:self.HeaderData.img_url]) {
            NSURL *imageURL = [NSURL URLWithString:[self.HeaderData.img_url stringByAddingPercentEscapesUsingEncoding:
                                                    NSUTF8StringEncoding]];
            
            
            [view.itemIv setImageWithURL:imageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            
        }
        if ([Common isNotEmptyString:self.HeaderData.item_name]) {
            view.text.text = self.HeaderData.item_name;
            
        }
        
        if ([Common isNotEmptyString:self.HeaderData.item_price]) {
            view.priceLbl.text = self.HeaderData.item_price;
            
        }
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
        [view addGestureRecognizer:recognizer];
        return view;
    } else {
        return nil;
    }

}

-(void)viewWillAppearLogic{
    self.itemRecipient.list = [NSMutableArray array];
//    if (self.searchType == category) {
//        DLog(@"テーブル縦位置%f",self.table.frame.origin.y);
//        self.table.frame = CGRectMake(0,NavigationHight + self.HeaderHeight,self.viewSize.width,self.viewSize.height - self.HeaderHeight -TabbarHight -NavigationHight);
//        DLog(@"テーブル縦位置%f",self.table.frame.origin.y);
//    }
    
}
-(void)setHeaderImg{
//    if (self.searchType != category) {
//        return;
//    }
//    UIView *uv = [[UIView alloc]initWithFrame:CGRectMake(0, NavigationHight, self.viewSize.width, self.HeaderHeight)];
//    uv.backgroundColor = [UIColor grayColor];
//    UIImageView *iv = [[UIImageView alloc] init];
//    iv.frame = CGRectMake(0, 0, self.viewSize.width, self.viewSize.width * 0.28);
//    NSURL *imageURL = [NSURL URLWithString:self.headerImgUrl];
//    
//    [iv setImageWithURL:imageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [uv addSubview:iv];
//    
//    self.quanitityLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,uv.frame.size.height * 0.78,300,25)];
//    
//    self.quanitityLbl.text = [NSString stringWithFormat:@"アイテム数："];
//    self.quanitityLbl.textColor = [UIColor whiteColor];
//    self.quanitityLbl.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
//    
//    [uv addSubview:self.quanitityLbl];
//    
//    [self.view addSubview:uv];
//    //self.table.tableHeaderView = uv;
}

-(void)setDataWithRecipient:(ItemRecipient *)recipient sendId:(NSString *)sendId{
    
    if (self.isSearchedMore) {
        [self.itemRecipient.list addObjectsFromArray: recipient.list];
    } else {
        self.itemRecipient = recipient;
        
        NSString *buyedItemnId = [self loadBuyedItemtId];
        if (buyedItemnId != nil) {
            for (ItemData *data in self.itemRecipient.list) {
                if ([data.item_id isEqualToString:buyedItemnId]) {
                    self.HeaderData = data;
                }
            }
        }
        
    }
    if (recipient.more_flg) {
        self.isMore = YES;
    } else {
        self.isMore = NO;
    }
    self.isSearchedMore = NO;
    if (self.itemRecipient.list.count == 1) {
        if (self.isNext) {
            self.isNext = NO;
            ItemData *data = [self.itemRecipient.list objectAtIndex:0];
            [self pushNextViewWidhData:data];
        } else {
            NSInteger count = self.navigationController.viewControllers.count - 2;
            CategoryViewController *vc = [self.navigationController.viewControllers objectAtIndex:count];
            [self.navigationController popToViewController:vc animated:YES];
        }
        
        
        //    self.quanitityLbl.text = [NSString stringWithFormat:@"アイテム数：%@",self.itemRecipient.quantity];
        
    }
    [self.selectRicetTable reloadData];
}

-(void)pushNextViewWidhData:(ItemData*)data{
    
    
    if (![PieceCoreConfig isLinePay] && ![PieceCoreConfig isPayPal]) {
        
        
        WebViewController *vc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:data.item_url];
        [self presentViewController:vc animated:YES completion:nil];
        self.isCloseWebview = YES;
    } else if ([PieceCoreConfig isLinePay]) {
        [self moveLinepayViewWithItemData:data];
        return;
    } else if ([PieceCoreConfig isPayPal]) {
        //paypalテストようにlainpayを使っている
        PaypalViewController *vc = [[PaypalViewController alloc] initWithNibName:@"PaypalViewController" bundle:nil];
        
        //商品の名前を格納
        vc.item_name = data.item_name;
        vc.item_id = data.item_id;
        //商品画像格納
        vc.img_url = data.img_url;
        UIImageView *item_Image = [[UIImageView alloc] init];
        NSURL *imageURL = [NSURL URLWithString:[data.img_url stringByAddingPercentEscapesUsingEncoding:
                                                NSUTF8StringEncoding]];
        item_Image.frame = CGRectMake(60, 150, 200, 200);
        [item_Image setImageWithURL:imageURL
                   placeholderImage:nil
                            options:SDWebImageCacheMemoryOnly
        usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //vc.itemImgUrl = data.img_url;
        
        //商品説明格納
        vc.item_text = data.item_text;
        
        //商品価格格納
        vc.item_price = data.item_price;
        
        //画面遷移格納
        [self.navigationController pushViewController:vc  animated:YES];
        
    }
}
-(void)moveLinepayViewWithItemData:(ItemData *)data{
    linepay_ViewController *vc = [[linepay_ViewController alloc] initWithNibName:@"linepay_ViewController" bundle:nil];
    
    //商品の名前を格納
    vc.itemName = data.item_name;
    vc.productId = data.item_id;
    //商品画像格納
    vc.imgUrl = data.img_url;
    UIImageView *item_Image = [[UIImageView alloc] init];
    NSURL *imageURL = [NSURL URLWithString:[data.img_url stringByAddingPercentEscapesUsingEncoding:
                                            NSUTF8StringEncoding]];
    item_Image.frame = CGRectMake(60, 150, 200, 200);
    [item_Image setImageWithURL:imageURL
               placeholderImage:nil
                        options:SDWebImageCacheMemoryOnly
    usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    vc.itemImgUrl = data.img_url;
    
    //商品説明格納
    vc.itemText = data.item_text;
    
    //商品価格格納
    vc.itemPrice = data.item_price;
    
    //画面遷移格納
    [self.navigationController pushViewController:vc  animated:YES];
    
}

- (void)onTapped:(UITapGestureRecognizer *)recognizer {
    [self moveLinepayViewWithItemData:self.HeaderData];
}

@end
