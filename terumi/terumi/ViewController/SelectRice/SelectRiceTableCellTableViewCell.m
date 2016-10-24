//
//  SelectRiceTableCellTableViewCell.m
//  terumi
//
//  Created by ハマモト  on 2016/08/17.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "SelectRiceTableCellTableViewCell.h"
#import "linepay_ViewController.h"

@implementation SelectRiceTableCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    self.item1View.tag = 1;
    self.item2View.tag = 2;
    [self.item1View addGestureRecognizer:recognizer];
    [self.item2View addGestureRecognizer:recognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)onTapped:(UITapGestureRecognizer *)recognizer {
    
    linepay_ViewController *vc = [[linepay_ViewController alloc] initWithNibName:@"linepay_ViewController" bundle:nil];
    //ここにタップされた際のアクションを記述
    NSLog(@"%@",recognizer);
    long tag =[(UITapGestureRecognizer *)recognizer view].tag;
    
    ItemData *data;
    
    if (tag == 1) {

        data = self.data1;
    } else {
        data = self.data2;
    }
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
    [self.parnentVc.navigationController pushViewController:vc  animated:YES];
}
@end
