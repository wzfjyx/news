//
//  BaseTabBarController.m
//  Headlines
//
//  Created by mac12 on 16/9/18.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "BaseTabBarController.h"

#define KScreenWidth [UIScreen mainScreen].bounds.size.width

@interface BaseTabBarController ()
{
    UIButton *_btn;
}
@end

@implementation BaseTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createSubViews];
        [self createCustomTabBar];
        
    }
    return self;
}

-(void)createSubViews
{
    NSArray *storyBoardNames = @[ @"Home", @"Search", @"Personal"];
    
    NSMutableArray *names = [[NSMutableArray alloc]init];
    for (NSString *name in storyBoardNames) {
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
        
        UINavigationController *nav = [story instantiateInitialViewController];
        nav.navigationBar.barTintColor = [UIColor redColor];
        nav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [names addObject:nav];
    }
    
    self.viewControllers = [names copy];
    
    
    
}

-(void)createCustomTabBar
{
    self.tabBar.barTintColor = [UIColor lightGrayColor];
    self.tabBar.alpha = 0.9;
    _btn = nil;
    
    for (UIView *view in self.tabBar.subviews) {
        Class button = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:button]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat buttonWidth = KScreenWidth / 3;
    NSArray *imageArray = @[@"tab_sy@2x",@"tab_ss@2x",@"tab_gr@2x"];
    NSArray *imageLightArray = @[@"tab_sy_pre@2x",@"tab_ss_pre@2x",@"tab_gr_pre@2x"];
    NSArray *nameArray = @[@"首页",@"搜索",@"我的"];
    
    for (int i = 0; i<3; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, 49);
        
        NSString *iamgeName = [NSString stringWithFormat:@"%@",imageArray[i]];
        UIImage *image = [UIImage imageNamed:iamgeName];
        [button setImage:image forState:UIControlStateNormal];
        
        NSString *imageSelect = [NSString stringWithFormat:@"%@",imageLightArray[i]];
        UIImage *image1 = [UIImage imageNamed:imageSelect];
        [button setImage:image1 forState:UIControlStateSelected];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-20, 12, button.titleLabel.bounds.size.height, 0.0)];
        [button addTarget:self action:@selector(tabSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
        button.tag = i;
        
        NSString *name = nameArray[i];
        [button setTitle:name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:11];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height, -30, 0.0, 0.0)];
        
       button.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    }
    
    self.tabBar.shadowImage = [[UIImage alloc]init];
}

-(void)tabSelectAction:(UIButton *)button
{
    if (_btn == nil) {
        button.selected = YES;
        _btn = button;
        self.selectedIndex = button.tag;
    }else if(_btn != nil && _btn == button){
        button.selected = YES;
        self.selectedIndex = button.tag;
    }else if (_btn != nil && _btn != button){
        _btn.selected = NO;
        button.selected = YES;
        self.selectedIndex = button.tag;
        _btn = button;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
