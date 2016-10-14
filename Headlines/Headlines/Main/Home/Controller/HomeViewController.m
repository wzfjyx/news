//
//  HomeViewController.m
//  Headlines
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "HomeViewController.h"

#import "Hot.h"
#import "Hangzhou.h"
#import "RecommendView.h"
#import "PassageView.h"
//#import "PassageView.h"
//@class Hotview;

@interface HomeViewController (){
    UIButton *recommend1;
    UIButton *hot1;
    UIButton *hangzhou1;
    UIButton *passage1;// navigationItem上的4个按钮
    
    RecommendView *recommendView; // 4个view
    Hot *_hotView;
    Hangzhou *_hangView;
    PassageView *_passageView;
    
    UITableView *recommendTabView;//tableview
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];

    [self createNavigationItemButton];
    
    

    
}

- (void)createTableView{
 
}

- (void)createView{
    recommendView = [[RecommendView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64 - 44)];
    [self.view addSubview:recommendView];
    
    _hotView = [[Hot alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64 - 44)];
    [self.view addSubview:_hotView];
    _hotView.hidden = YES;
    
    _hangView = [[Hangzhou alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64- 44)];
    [self.view addSubview:_hangView];
    _hangView.hidden = YES;
    
    _passageView = [[PassageView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64- 44)];
    [self.view addSubview:_passageView];
    _passageView.hidden = YES;
//
//    passageView = [[PassageView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 44)];
//    [self.view addSubview:passageView];
//    passageView.hidden = YES;
    
//    [self.view addSubview:hotView];
//    [self.view addSubview:hangzhouView];
//    [self.view addSubview:passageView];
//    [self.view addSubview:recommendView];
//    hangzhouView.hidden = YES;
//    passageView.hidden = YES;
//    hotView.hidden = YES;
}

- (void)createNavigationItemButton{
    
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    
    recommend1 = [UIButton buttonWithType:UIButtonTypeCustom];
    recommend1.frame = CGRectMake(0, 0, 35, 35);
    [recommend1 setTitle:@"推荐" forState:UIControlStateNormal];
    recommend1.titleLabel.font = [UIFont systemFontOfSize:17];
    recommend1.titleLabel.alpha = 1;
    recommend1.tag = 1;
    [recommend1 addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];    UIBarButtonItem *recommend = [[UIBarButtonItem alloc]initWithCustomView:recommend1];
    [mArray addObject:recommend];
    
    hot1 = [UIButton buttonWithType:UIButtonTypeCustom];
    hot1.frame = CGRectMake(0, 0, 35, 35);
    [hot1 setTitle:@"热点" forState:UIControlStateNormal];
    hot1.titleLabel.font = [UIFont systemFontOfSize:16];
    hot1.titleLabel.alpha = 0.6;
    hot1.tag = 2;
    [hot1 addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *hot = [[UIBarButtonItem alloc]initWithCustomView:hot1];
    [mArray addObject:hot];
    
    hangzhou1 = [UIButton buttonWithType:UIButtonTypeCustom];
    hangzhou1.frame = CGRectMake(0, 0, 35, 35);
    [hangzhou1 setTitle:@"杭州" forState:UIControlStateNormal];
    hangzhou1.titleLabel.font = [UIFont systemFontOfSize:16];
    hangzhou1.titleLabel.alpha = 0.6;
    hangzhou1.tag = 3;
    [hangzhou1 addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *hangzhou = [[UIBarButtonItem alloc]initWithCustomView:hangzhou1];
    [mArray addObject:hangzhou];
    
    passage1 = [UIButton buttonWithType:UIButtonTypeCustom];
    passage1.frame = CGRectMake(0, 0, 35, 35);
    [passage1 setTitle:@"段子" forState:UIControlStateNormal];
    passage1.titleLabel.font = [UIFont systemFontOfSize:16];
    passage1.titleLabel.alpha = 0.6;
    passage1.tag = 4;
    [passage1 addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *passage = [[UIBarButtonItem alloc]initWithCustomView:passage1];
    [mArray addObject:passage];
    
    self.navigationItem.leftBarButtonItems = mArray;
}
- (void)Action:(UIButton *)button{


    recommend1.titleLabel.font = [UIFont systemFontOfSize:16];
    recommend1.titleLabel.alpha = 0.6;
    hot1.titleLabel.font = [UIFont systemFontOfSize:16];
    hot1.titleLabel.alpha = 0.6;
    hangzhou1.titleLabel.font = [UIFont systemFontOfSize:16];
    hangzhou1.titleLabel.alpha = 0.6;
    passage1.titleLabel.font = [UIFont systemFontOfSize:16];
    passage1.titleLabel.alpha = 0.6;
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.titleLabel.alpha = 1.0;
    
        if (button.tag == 1) {
            recommendView.hidden = NO;
            _hotView.hidden = YES;
            _hangView.hidden = YES;
            _passageView.hidden = YES;
        }
    
        if (button.tag == 2) {
            recommendView.hidden = YES;
            _hotView.hidden = NO;
            _hangView.hidden = YES;
            _passageView.hidden = YES;
        }
    
        if (button.tag == 3) {
            recommendView.hidden = YES;
            _hotView.hidden = YES;
            _hangView.hidden = NO;
            _passageView.hidden = YES;
        }
    
        if (button.tag == 4) {
            recommendView.hidden = YES;
            _hotView.hidden = YES;
            _hangView.hidden = YES;
            _passageView.hidden = NO;
        }
    

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
