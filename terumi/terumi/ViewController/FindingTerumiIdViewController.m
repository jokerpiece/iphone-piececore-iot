//
//  FindingTerumiIdViewController.m
//  terumi
//
//  Created by OhnumaRina on 2016/04/21.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "FindingTerumiIdViewController.h"

@interface FindingTerumiIdViewController ()

@end

@implementation FindingTerumiIdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
