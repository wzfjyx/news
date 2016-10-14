//
//  MineMessageViewController.m
//  Headlines
//
//  Created by mac12 on 16/9/21.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "MineMessageViewController.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "WeiboModel.h"

@class SinaWeibo;
#define kUserWeibo @"statuses/user_timeline.json"

@interface MineMessageViewController ()<SinaWeiboRequestDelegate>
{
    NSMutableArray *_weiboArray;
}
@end

@implementation MineMessageViewController

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
    
    [self loadData];
    
}

-(void)loadData
{
    SinaWeibo *sina = KSinaWeibo;
    if (![sina isAuthValid]) {
        return;
    }
    NSDictionary *params = @{@"count" : @"1"};
    
    //发送网络请求
    [sina requestWithURL:kUserWeibo
                   params:[params mutableCopy]
               httpMethod:@"GET"
                 delegate:self];
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    //    NSLog(@"%@",result);
    NSArray *array = result[@"statuses"];
    NSMutableArray *marray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in array) {
        
        WeiboModel *weibo = [WeiboModel yy_modelWithJSON:dic];
        [marray addObject:weibo];
    }
    
    _weiboArray = [marray mutableCopy];
    
    [self reload];
}

-(void)reload
{
    WeiboModel *weibo = _weiboArray[0];
    
    //帐号
    UILabel *souce = [self.view viewWithTag:101];
    souce.text = @"来自新浪微博";
    souce.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    souce.textColor = [UIColor grayColor];
    
    //昵称
    UILabel *name = [self.view viewWithTag:102];
    name.text = weibo.user.name;
    name.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:11];
    name.textColor = [UIColor grayColor];
    
    //性别
    UILabel *gender = [self.view viewWithTag:103];
    gender.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    if ([weibo.user.gender isEqualToString:@"m"]) {
        gender.text = @"男";
    }else if ([weibo.user.gender isEqualToString:@"n"])
    {
        gender.text = @"女";
    }else{
        gender.text = @"不详";
    }
    
    //地区
    UILabel *location = [self.view viewWithTag:104];
    location.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    location.text = weibo.user.location;
    
    //出生年月
    UILabel *age = [self.view viewWithTag:105];
    age.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:10];
    age.text = weibo.user.created_at;
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
