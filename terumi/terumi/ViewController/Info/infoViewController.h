//
//  infoViewController.h
//  terumi
//
//  Created by ハマモト  on 2016/03/03.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "BaseSencorViewController.h"
#import "SencorViewController.h"

@interface infoViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic) SencorViewController *parnentView;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@end
