//
//  ConfirmationTerumiIdViewController.m
//  terumi
//
//  Created by OhnumaRina on 2016/04/18.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "ConfirmationTerumiIdViewController.h"

@interface ConfirmationTerumiIdViewController ()

@end

@implementation ConfirmationTerumiIdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"照美ID";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapIdCopy:(id)sender {
    //クリップボードに照美IDをコピー
    [[UIPasteboard generalPasteboard] setValue:self.terumiIdLbl.text forPasteboardType:@"public.utf8-plain-text"];
    
    UIAlertController * ac =
    [UIAlertController alertControllerWithTitle:@"IDコピー"
                                        message:@"照美IDをクリップボードにコピーしました"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                           }];
    
    [ac addAction:okAction];
    [self presentViewController:ac animated:YES completion:nil];
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
