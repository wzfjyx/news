//
//  WebRecViewController.m
//  Headlines
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "WebRecViewController.h"

@interface WebRecViewController ()

@end

@implementation WebRecViewController

- (instancetype)initWithUrl:(NSURL *)url{
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"头版头条";
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [self.view addSubview:web];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:self.url];
    [web loadRequest:request];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button addTarget:self action:@selector(buttonAciton) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"nav_back_pre@3x.png"] forState:UIControlStateNormal];
    button.tintColor = [UIColor blackColor];
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = button1;
}


- (void)buttonAciton{
    [self.navigationController popViewControllerAnimated:YES];
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

@end
