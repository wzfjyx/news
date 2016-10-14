//
//  SignViewController.m
//  Headlines
//
//  Created by mac50 on 16/9/19.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "SignViewController.h"
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
@interface SignViewController ()

@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createSubView];
    
    //导航栏左边按钮
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(0, 0, 30, 30);
    [leftbutton setImage:[UIImage imageNamed:@"nav_back@2x"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = left;
}


-(void)createSubView
{
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(0, 84, KScreenWidth, 300)];
    subView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:subView];
    
    //用户名
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 30)];
    userName.text = @"用户名:";
    userName.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    [subView addSubview:userName];
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(80, 10, KScreenWidth -80, 30)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.placeholder = @"6-14位（以字母开头，只能包含字符、数字和下划线）";
    textField.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:10];
    textField.textColor = [UIColor grayColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.clearsOnBeginEditing = YES;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = self;
    [subView addSubview:textField];
    UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_all@2x.png"]];
    line.frame = CGRectMake(40, 50, KScreenWidth - 10, 2);
    [subView addSubview:line];
    
    //登录密码
    UILabel *passWord = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 60, 30)];
    passWord.text = @"登录密码:";
    passWord.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    [subView addSubview:passWord];
    UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectMake(80, 60, KScreenWidth -80, 30)];
    textField1.leftViewMode = UITextFieldViewModeAlways;
    textField1.placeholder = @"6-14位（只能包含字符、数字和下划线）";
    textField1.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:10];
    textField1.textColor = [UIColor grayColor];
    textField1.autocorrectionType = UITextAutocorrectionTypeNo;
    textField1.clearsOnBeginEditing = YES;
    textField1.textAlignment = NSTextAlignmentLeft;
    textField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField1.delegate = self;
    [subView addSubview:textField1];
    UIImageView *line1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_all@2x.png"]];
    line1.frame = CGRectMake(40, 100, KScreenWidth - 10, 2);
    [subView addSubview:line1];
    
    //确认密码
    UILabel *passWord1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 60, 30)];
    passWord1.text = @"确认密码:";
    passWord1.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    [subView addSubview:passWord1];
    UITextField *textField2 = [[UITextField alloc]initWithFrame:CGRectMake(80, 110, KScreenWidth -80, 30)];
    textField2.leftViewMode = UITextFieldViewModeAlways;
    textField2.placeholder = @"6-14位（只能包含字符、数字和下划线）";
    textField2.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:10];
    textField2.textColor = [UIColor grayColor];
    textField2.autocorrectionType = UITextAutocorrectionTypeNo;
    textField2.clearsOnBeginEditing = YES;
    textField2.textAlignment = NSTextAlignmentLeft;
    textField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField2.delegate = self;
    [subView addSubview:textField2];
    UIImageView *line2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_all@2x.png"]];
    line2.frame = CGRectMake(40, 150, KScreenWidth - 10, 2);
    [subView addSubview:line2];
    
    
    //手机号码
    UILabel *tele = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, 60, 30)];
    tele.text = @"手机号码:";
    tele.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    [subView addSubview:tele];
    UITextField *textField3 = [[UITextField alloc]initWithFrame:CGRectMake(80, 160, KScreenWidth -80, 30)];
    textField3.leftViewMode = UITextFieldViewModeAlways;
    textField3.placeholder = @"(可不填写)";
    textField3.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:10];
    textField3.textColor = [UIColor grayColor];
    textField3.autocorrectionType = UITextAutocorrectionTypeNo;
    textField3.clearsOnBeginEditing = YES;
    textField3.textAlignment = NSTextAlignmentLeft;
    textField3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField3.delegate = self;
    [subView addSubview:textField3];
    UIImageView *line3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_all@2x.png"]];
    line3.frame = CGRectMake(40, 200, KScreenWidth - 10, 2);
    [subView addSubview:line3];
    
    //注册按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake((KScreenWidth - 300)/2, 220, 300, 40);
    [loginButton setImage:[UIImage imageNamed:@"btn_zc_pre"] forState:UIControlStateNormal];
    [loginButton setImage:[UIImage imageNamed:@"btn_zc.png"] forState:UIControlStateHighlighted];
    [subView addSubview:loginButton];
}


-(void)back
{
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
