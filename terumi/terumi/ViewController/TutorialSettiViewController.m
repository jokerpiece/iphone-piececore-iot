//
//  TutorialSettiViewController.m
//  terumi
//
//  Created by OhnumaRina on 2016/04/15.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "TutorialSettiViewController.h"
#import "ShippingAddressViewController.h"

@interface TutorialSettiViewController ()

@end

@implementation TutorialSettiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)moveShoppingAddress:(id)sender {
    
    ShippingAddressViewController *savc = [[ShippingAddressViewController alloc]init];
   // [self presentViewController:savc animated:YES completion:nil];
    [self.navigationController pushViewController:savc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
