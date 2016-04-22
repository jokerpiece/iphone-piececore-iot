//
//  SelectRiceShopViewController.m
//  terumi
//
//  Created by OhnumaRina on 2016/04/15.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "SelectRiceShopViewController.h"

@interface SelectRiceShopViewController ()

@end

@implementation SelectRiceShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"米屋選択";
    
    
    self.riceShopTableView.delegate = self;
    self.riceShopTableView.dataSource = self;
//
    UINib *nib = [UINib nibWithNibName:@"RiceSelectTableViewCell" bundle:nil];
    [self.riceShopTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [RiceSelectTableViewCell rowHeight];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"section%ld", (long)section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //IDをstatic変数で宣言
    static NSString *CellIdentifier = @"Cell";
    
    //使用可能なセルを取得
    RiceSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //registerClass:forCellReuseIdentifier:メソッドを使った場合はチェック不要
    //if (cell == nil) {//再利用できるセルがなければ新規作成
    //cell = [[HogeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //}
    
    //ここから実際のセルのアップデート処理を書く
    cell.riceShopName.text = @"西川米殻点";
    cell.riceShopStreetAddress.text = @"大阪府大阪市平野区";
    
    //セットアップしたセルを返す
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectPayerViewController *spvc = [[SelectPayerViewController alloc]init];
    [self.navigationController pushViewController:spvc animated:YES];
    self.navigationItem.title = @"";
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
