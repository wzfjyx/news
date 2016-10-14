//
//  LoginViewController.m
//  Headlines
//
//  Created by mac12 on 16/9/18.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "LoginViewController.h"
#import "SignViewController.h"
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
@class SignViewController;

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"登录";
    
    
    //导航栏左边按钮
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(0, 0, 30, 30);
    [leftbutton setImage:[UIImage imageNamed:@"nav_back@2x"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = left;
    
    
    //右边注册按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 30);
    [rightButton setTitle:@"注册" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:13];
    [rightButton addTarget:self action:@selector(toSignViewAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
    
    [self createView];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)toSignViewAction
{
    SignViewController *sign = [[SignViewController alloc]init];
    [self.navigationController pushViewController:sign animated:YES];
}

-(void)createView
{
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(0, 84, KScreenWidth, 200)];
    subView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:subView];
    
    //用户名
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_xm@3x"]];
    imageview.frame = CGRectMake(0, 0, 30, 30);
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, KScreenWidth -10, 40)];
    textField.leftView = imageview;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.placeholder = @"用户名";
    textField.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:13];
    textField.textColor = [UIColor blackColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.clearsOnBeginEditing = YES;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = self;
    [subView addSubview:textField];
    UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_all@2x.png"]];
    line.frame = CGRectMake(40, 40, KScreenWidth - 60, 2);
    [subView addSubview:line];
    
    
    //密码
    UIImageView *imageview1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_mm.png"]];
    imageview1.frame = CGRectMake(0, 0, 30, 30);
    UITextField *passwordText = [[UITextField alloc]initWithFrame:CGRectMake(10, 45, KScreenWidth -10, 40)];
    passwordText.leftView = imageview1;
    passwordText.leftViewMode = UITextFieldViewModeAlways;
    passwordText.placeholder = @"密码";
    passwordText.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:13];
    passwordText.textColor = [UIColor blackColor];
    passwordText.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordText.clearsOnBeginEditing = YES;
    passwordText.textAlignment = NSTextAlignmentLeft;
    passwordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordText.delegate = self;
    [subView addSubview:passwordText];
    UIImageView *line1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_all@2x.png"]];
    line1.frame = CGRectMake(40, 90, KScreenWidth - 60, 2);
    [subView addSubview:line1];
    
    
    //登录按钮
    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enterButton.frame = CGRectMake((KScreenWidth - 300)/2, 100, 300, 40);
    [enterButton setImage:[UIImage imageNamed:@"btn_dl_pre.png"] forState:UIControlStateNormal];
    [enterButton setImage:[UIImage imageNamed:@"btn_dl.png"] forState:UIControlStateHighlighted];
    [subView addSubview:enterButton];
    
    
    //QQ按钮
    UIButton *QQButton = [UIButton buttonWithType:UIButtonTypeCustom];
    QQButton.frame = CGRectMake(50, 150, 131, 45);
    [QQButton setImage:[UIImage imageNamed:@"login_qq_pre_new.png"] forState:UIControlStateNormal];
    [QQButton setImage:[UIImage imageNamed:@"login_qq_new.png"] forState:UIControlStateHighlighted];
    [subView addSubview:QQButton];
    //微博按钮
    UIButton *WbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    WbButton.frame = CGRectMake((KScreenWidth - 50 - 131), 150, 131, 45);
    [WbButton setImage:[UIImage imageNamed:@"login_wb_pre.png"] forState:UIControlStateNormal];
    [WbButton setImage:[UIImage imageNamed:@"login_wb.png"] forState:UIControlStateHighlighted];
    [WbButton addTarget:self action:@selector(WbButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:WbButton];
    
}

-(void)WbButtonAction
{
    SinaWeibo *sina = ((AppDelegate *)[UIApplication sharedApplication].delegate).sina;
    
    [sina logIn];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
