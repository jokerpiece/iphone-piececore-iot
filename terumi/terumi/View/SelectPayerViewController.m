//
//  SelectPayerViewController.m
//  terumi
//
//  Created by OhnumaRina on 2016/04/15.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "SelectPayerViewController.h"
#import <BaseViewController.h>
#import "SendPaymentPermitViewController.h"
#import "SettingViewController.h"
#import "LnitialMenuViewController.h"
#import "FindingTerumiIdViewController.h"
#import "SencorViewController.h"

@interface SelectPayerViewController ()

@end

@implementation SelectPayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"決済者選択";
    
    self.payerId.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)moveNextView:(id)sender {
    if(self.othersPayBtn.selected == YES && ![self.payerId.text isEqualToString:@""]){
         self.navigationItem.title = @"";
        SendPaymentPermitViewController *sppvc = [[SendPaymentPermitViewController alloc]init];
        [self.navigationController pushViewController:sppvc animated:YES];
    }else if(self.othersPayBtn.selected == YES && [self.payerId.text isEqualToString:@""]){
        self.errorMessage = @"決済者の照美IDを入力してください";
        [self alertView];
    }else if (self.myselfPayBtn.selected == NO && self.othersPayBtn.selected == NO){
        self.errorMessage = @"決済者を選択してください";
        [self alertView];
    }else{
        //self.navigationItem.title = @"";
        SencorViewController *sppvc = [[SencorViewController alloc]init];
        [self.navigationController pushViewController:sppvc animated:YES];
    }
}
- (IBAction)moveSetting:(id)sender {
    SencorViewController *sppvc = [[SencorViewController alloc]init];
    //[self presentViewController:sppvc animated:YES completion:nil];
    [self.navigationController pushViewController:sppvc animated:YES];
}

- (IBAction)backAction:(id)sender {
    self.navigationItem.title = @"◯　◉　◯　◯";
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)selectMyselfPay:(id)sender {
    if(self.othersPayBtn.selected){
        self.othersPayBtn.selected = !self.othersPayBtn.selected;
    }
    self.myselfPayBtn.selected = !self.myselfPayBtn.selected;
}
- (IBAction)selectOthersPay:(id)sender {
    if(self.myselfPayBtn.selected){
    self.myselfPayBtn.selected = !self.myselfPayBtn.selected;
    }
    self.othersPayBtn.selected = !self.othersPayBtn.selected;
    //[self tutorialView];
    FindingTerumiIdViewController *cti = [[FindingTerumiIdViewController alloc]init];
    [self presentViewController:cti animated:YES completion:nil];
    
    
}

-(void)alertView{
    
    UIAlertController * ac =
    [UIAlertController alertControllerWithTitle:@"入力エラー"
                                        message:self.errorMessage
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                           }];
    
    [ac addAction:okAction];
    [self presentViewController:ac animated:YES completion:nil];

}
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    
    [sender resignFirstResponder];
    
    return TRUE;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // キーボードが表示：消す
    if (self.payerId.isFirstResponder) {
        [self.payerId resignFirstResponder];
        //[self.view endEditing:YES];   // こちらでもOK
    }
    // キーボードが非表示：表示する
    else {
        [self.payerId becomeFirstResponder];
    }
}

-(void)tutorialView {
    UIScreen* screen = [UIScreen mainScreen];
    self.tv = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                         0,
                                                         screen.applicationFrame.size.width,
                                                         screen.applicationFrame.size.height)
                  ];
    self.tv.backgroundColor = [UIColor whiteColor];
    
    UILabel *tLbl = [[UILabel alloc]initWithFrame:CGRectMake(screen.applicationFrame.size.width * 0.05,
                                                             screen.applicationFrame.size.height * 0.05,
                                                             screen.applicationFrame.size.width * 0.9,
                                                             screen.applicationFrame.size.height * 0.4
                                                             )
                     ];
    tLbl.text = @"支払い代行者の照美ID調べ方";
    
    UIImage *img = [UIImage imageNamed:@""];
    
    
    [self.tv addSubview:tLbl];
    [self.view addSubview:self.tv];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    [UIView animateWithDuration:0.3f animations:^{
        self.tv.frame = rect;
    } completion:nil];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(close)];
    [self.tv addGestureRecognizer:ges];

    
}

-(void)close{
    [self.tv removeFromSuperview];
}

@end
