//
//  SendSuggestViewController.m
//  Headlines
//
//  Created by mac12 on 16/9/21.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "SendSuggestViewController.h"

#define KScreenWidth [UIScreen mainScreen].bounds.size.width

@interface SendSuggestViewController () <UITextViewDelegate, UITextFieldDelegate>

@end

@implementation SendSuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.tabBarController.tabBar.hidden = YES;
    
    //导航栏左边按钮
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(0, 0, 30, 30);
    [leftbutton setImage:[UIImage imageNamed:@"nav_back@2x"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = left;
    
    
    //导航栏右边按钮
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbutton.frame = CGRectMake(0, 0, 50, 30);
    [rightbutton setTitle:@"发送" forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = right;
    
    
    [self createView];
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)createView
{
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64 + 10, KScreenWidth, 200)];
    textView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:textView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+10+200, KScreenWidth, 20)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = @"留下联系方式以便于我们联系你";
    label.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    //姓名
    UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+10+200+20, 50, 30)];
    Name.backgroundColor = [UIColor whiteColor];
    Name.text = @"姓名:";
    Name.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    [self.view addSubview:Name];
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(50, 64+10+200+20, KScreenWidth -50, 30)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = @"非必填项";
    textField.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    textField.textColor = [UIColor grayColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.clearsOnBeginEditing = YES;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = self;
    [self.view addSubview:textField];
    UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_all@2x.png"]];
    line.frame = CGRectMake(10, 64+10+200+20, KScreenWidth - 10, 2);
    [self.view addSubview:line];
    
    //电话号码
    UILabel *tele = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+10+200+20+30, 50, 30)];
    tele.backgroundColor = [UIColor whiteColor];
    tele.text = @"电话:";
    tele.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    [self.view addSubview:tele];
    UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectMake(50, 64+10+200+20+30, KScreenWidth -50, 30)];
    textField1.backgroundColor = [UIColor whiteColor];
    textField1.placeholder = @"非必填项";
    textField1.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    textField1.textColor = [UIColor grayColor];
    textField1.autocorrectionType = UITextAutocorrectionTypeNo;
    textField1.clearsOnBeginEditing = YES;
    textField1.textAlignment = NSTextAlignmentLeft;
    textField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField1.delegate = self;
    [self.view addSubview:textField1];
    
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
