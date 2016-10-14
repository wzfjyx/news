//
//  PersonalViewController.m
//  Headlines
//
//  Created by mac12 on 16/9/18.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "PersonalViewController.h"
#import "LoginViewController.h"
#import "CollectViewController.h"
#import "SubscriptViewController.h"
#import "AppDelegate.h"
#import "YYModel.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"

@class LoginViewController;
@class CollectViewController;
@class SubscriptViewController;

//获取用户的微博
#define kUserWeibo @"statuses/user_timeline.json"
#define KScreenWidth [UIScreen mainScreen].bounds.size.width

@interface PersonalViewController ()<SinaWeiboRequestDelegate>
{
    SinaWeibo *_sina;
    NSString *enterText;
    NSString *userText;
    NSInteger *_tag;
    NSMutableArray *_weiboArray;
}

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWeibo];
//    NSArray *names = [UIFont familyNames];
//    NSLog(@"%@",names);
    [self.tableView reloadData];
}


-(void)loadWeibo
{
    _sina = ((AppDelegate *)[UIApplication sharedApplication].delegate).sina;
    if (![_sina isAuthValid]) {
        _tag = 0;
        
        [self createHeadView];
    }else{
        
        NSDictionary *params = @{@"count" : @"1"};
        //发送网络请求
        [_sina requestWithURL:kUserWeibo
                  params:[params mutableCopy]
              httpMethod:@"GET"
                delegate:self];
        _tag = 1;
//        [_sina logOut];
    }
    
//    [self createHeadView];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.tabBarController.tabBar.hidden = NO;
    
    [self loadWeibo];
    
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
    
    [self.tableView reloadData];
    [self createHeadView];
    [self createCache];
}

#pragma mark - 创建头视图
-(void)createHeadView
{
    //头视图
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 210)];
    headView.backgroundColor = [UIColor cyanColor];
    self.tableView.tableHeaderView = headView;
    
    WeiboModel *weibo = _weiboArray[0];
    
    //头像
    UIImageView *imagView = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth - 80)/2, 20, 80, 80)];
    if (_tag == 0) {
        
        imagView.image = [UIImage imageNamed:@"DefaultHeaderImage.png"];
        [headView addSubview:imagView];
        
    }else{
        
//        [imagView sd_setImageWithURL:weibo.user.profile_image_url];
        imagView.image = [UIImage imageNamed:@"DefaultHeaderImage.png"];
        [headView insertSubview:imagView atIndex:1];
    }
    
    
    
    //用户名
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake((KScreenWidth - 50)/2 - 15, 105, 80, 20)];
    
    if (_tag == 0) {
        nameLabel.text = @"未登录";
    }else{
        nameLabel.text = weibo.user.name;
        UIImageView *genImage = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth - 50)/2 - 15 + 70, 105, 20, 20)];
        if ([weibo.user.gender isEqualToString:@"m"]) {
            genImage.image = [UIImage imageNamed:@"list_xbn.png"];
        }else if ([weibo.user.gender isEqualToString:@"n"]){
            genImage.image = [UIImage imageNamed:@"list_xbnv.png"];
        }else{
            genImage.image = [UIImage imageNamed:@"list_sch_pre.png"];
        }
        [headView addSubview:genImage];
    }
    
    
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont fontWithName:@"Zapfino" size:12];
    [headView addSubview:nameLabel];
    
    //登入按钮
    UIButton *enter = [UIButton buttonWithType:UIButtonTypeCustom];
    enter.frame = CGRectMake((KScreenWidth - 50)/2 - 15, 130, 80, 30);
    enter.backgroundColor = [UIColor whiteColor];
    enter.titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    enter.titleLabel.textAlignment = NSTextAlignmentCenter;
    [enter setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [enter.layer setBorderWidth:1.0];
    enter.layer.borderColor = [UIColor redColor].CGColor;
    if (_tag == 0) {
        [enter setTitle:@"还未登陆" forState:UIControlStateNormal];
        [enter addTarget:self action:@selector(enterAction) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [enter setTitle:@"退出登陆" forState:UIControlStateNormal];
        [enter addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    [headView addSubview:enter];
    
    //收藏、订阅按钮
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 170, KScreenWidth, 40)];
    buttonView.backgroundColor = [UIColor lightGrayColor];
    [headView addSubview:buttonView];
    
    UIButton *collect = [UIButton buttonWithType:UIButtonTypeCustom];
    collect.frame = CGRectMake(40, 5, 100, 30);
    [collect setImage:[UIImage imageNamed:@"list_wdsc.png"] forState:UIControlStateNormal];
    [collect setTitle:@"我的收藏" forState:UIControlStateNormal];
    collect.titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:13];
    [collect addTarget:self action:@selector(collectAction) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:collect];
    
    UIButton *subscript = [UIButton buttonWithType:UIButtonTypeCustom];
    subscript.frame = CGRectMake(KScreenWidth - 140, 5, 100, 30);
    [subscript setImage:[UIImage imageNamed:@"list_wddy2.png"] forState:UIControlStateNormal];
    [subscript setTitle:@"我的订阅" forState:UIControlStateNormal];
    subscript.titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:13];
    [subscript addTarget:self action:@selector(subscriptAction) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:subscript];
}

//登入按钮响应
-(void)enterAction
{
    LoginViewController *login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
    
}
-(void)logoutAction
{
    [_sina logOut];
    [self.tableView reloadData];
    [self loadWeibo];
}

//我的收藏按钮响应
-(void)collectAction
{
    if (_tag == 0) {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }else{
        CollectViewController *coll = [[CollectViewController alloc]init];
        [self.navigationController pushViewController:coll animated:YES];
    }
    
}


//我的订阅按钮响应
-(void)subscriptAction
{
    SubscriptViewController *sub = [[SubscriptViewController alloc]init];
    [self.navigationController pushViewController:sub animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 清除缓存


-(float)folderSizeAtPath:(NSString *)path  //整个目录的缓存大小
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
        
    }
    
    return 0;
}


-(void)clearCache:(NSString *)path   //清除缓存文件
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}

-(void)createCache
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory , NSUserDomainMask,YES);
    NSString *cacheDir = [paths objectAtIndex:0];
    NSString *filepath = [cacheDir stringByAppendingPathComponent:@"myCache"];
    
    UILabel *cacheLabel = [self.view viewWithTag:110];
    CGFloat count = [self folderSizeAtPath:cacheDir];
    NSString *cache = [NSString stringWithFormat:@"%f",count];
    cacheLabel.text = [NSString stringWithFormat:@"%@ MB",cache];
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
