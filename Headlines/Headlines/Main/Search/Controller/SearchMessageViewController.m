//
//  SearchMessageViewController.m
//  Headlines
//
//  Created by mac12 on 16/9/23.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "SearchMessageViewController.h"
#import "AFNetworking.h"
#import "RecommendModel.h"
#import "RecommendCell.h"
#import "RecommendCellLayout.h"
#import "WebRecViewController.h"

@class AFHTTPSessionManager;
@class WebRecViewController;

#define kSearchAPI @"http://newsapi.roboo.com/news/searchNewsJson.htm"

@interface SearchMessageViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
}
@end

@implementation SearchMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _text;
    
    [self loadData];
    [self createTableView];
    
    //导航栏左边按钮
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(0, 0, 30, 30);
    [leftbutton setImage:[UIImage imageNamed:@"nav_back@2x"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = left;

    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)loadData
{
    NSDictionary *dic = @{
                          @"p" : @1,
                          @"ps" : @15,
                          @"uid" : @"0743C16F-9B71-457D-912C-371BB1581470",
                          @"q" : _text
                          };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:kSearchAPI parameters:[dic copy] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"发送网络请求");
        NSArray *array = responseObject[@"items"];
        NSMutableArray *mArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in array) {
            
            RecommendModel *reModel = [RecommendModel yy_modelWithJSON:dic];
            
            [mArray addObject:reModel];
        }
        _dataArray = [mArray mutableCopy];
        
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"关键字请求失败");
        
    }];
    
}

-(void)createTableView
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, KScreenWidth, self.view.bounds.size.height + 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //    _tableView.backgroundColor = [UIColor clearColor];
    UINib *nib = [UINib nibWithNibName:@"RecommendCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"RecommendCellID"];
    
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendCellID"];
    RecommendModel *recommendModel = _dataArray[indexPath.row];
    [cell setRecommend:recommendModel];
    //    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GestureAction:)];
    //    ges.numberOfTapsRequired = 1;
    //    cell.tag = indexPath.row;
    //    ges.numberOfTouchesRequired = 1;
    //    [cell addGestureRecognizer:ges];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendModel *recommendModel = _dataArray[indexPath.row];
    RecommendCellLayout *layout = [RecommendCellLayout layoutWithWeiboModel:recommendModel];
    
    return layout.cellhight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendModel *reModel = _dataArray[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:reModel.detailPath];
    WebRecViewController *web = [[WebRecViewController alloc] initWithUrl: url];
    web.hidesBottomBarWhenPushed = YES;
    
    //使用响应者连 查找导航控制器
    UIResponder *nextResponder = self.nextResponder;
    while (nextResponder) {
        
        //判断对象 是否是导航控制器
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController *navi = (UINavigationController *)nextResponder;
            
            navi.tabBarController.hidesBottomBarWhenPushed = YES;
            [navi pushViewController:web animated:YES];
            break;
        }
        nextResponder = nextResponder.nextResponder;
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
