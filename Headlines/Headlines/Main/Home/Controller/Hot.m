//
//  Hot.m
//  Headlines
//
//  Created by mac12 on 16/9/24.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "Hot.h"
#import "RecommendCell.h"
#import "RecommendCellLayout.h"
#import "WebRecViewController.h"
#define KHotViewAPI @"http://newsapi.roboo.com/news/hotJson.htm?uid=0743C16F-9B71-457D-912C-371BB1581470&p=1&ps=15&isapp=yes&userId=NrSmeadzbXY9SxzNC+sTOUAxaryOP0zSYlWntdKxF8BD2ojl4DSMWNz1EmjVrRdFuS7zV0dZILPlfHHykHeYGWkfUR3PamwcDx+9RPnRD4cfTgQVGl9oEW1uWhUmIBjCACTJbsZyqLRWTmWkS/u0kxzeIGQb4T3A6z7qiTSY/xY="

#define KDownPullAPI @"http://newsapi.roboo.com/news/hotJson.htm?uid=0743C16F-9B71-457D-912C-371BB1581470&p=1&ps=15&isapp=yes&userId=AMF5T9iMyKNqPHCvvkmCoXZ81w2dXr5ljorg82BsdoXgvzsBP/T4hSmVJwoZEzzMLRnrQIjIj5jValJMWFJTY3XZ6f0AXfoU6d8kkg3C36XEDX5GQn71sO2MOno5jXquy4kR0mxO8VKtLAndCtkSmN2Wh0q5sCNXjLrULEPQFP4="


#define KUpPullAPI @"http://newsapi.roboo.com/news/hotJson.htm?uid=0743C16F-9B71-457D-912C-371BB1581470&p=4&ps=15&isapp=yes&userId=XU2FY+4isFEuxhf5X8OYNAahBZ2lNJRgwTin5H9XC5zu+OmqOeIg4P5T9Sqm3ajzFslhryFxdyKJepve2RNCK3gxbpPGSCBXAe/jHjunHY7IhhbS5bWyFfs7KxtV/sU3lHZyURe7TLvFltPUK3QsPVU93nYv7fhkdqB6hWzvJNQ="

@class AFHTTPSessionManager;

@implementation Hot
{
    UITableView *_tableView;
    NSMutableArray *_recommendArray;
}




- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        [self createTableView];
        
        [self loadData];
        
        
    }
    return self;
    
}


// 下拉加载更多数据
-(void)loadHotNewData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:KDownPullAPI parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = responseObject[@"items"];
        if (array.count == 0) {
            NSLog(@"没有新数据");
            [_tableView.pullToRefreshView stopAnimating];
            
        }else{
            NSMutableArray *mArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                RecommendModel *reModel = [RecommendModel yy_modelWithJSON:dic];
                
                [mArray addObject:reModel];
            }
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, mArray.count)];
            
            [_recommendArray insertObjects:mArray atIndexes:indexSet];
            
            [_tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败：%@",error);
    }];
    
    [_tableView reloadData];
}



//上拉刷新
- (void)loadHotMoreData{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:KUpPullAPI parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *array = responseObject[@"items"];
        NSMutableArray *mArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in array) {
            RecommendModel *reModel = [RecommendModel yy_modelWithJSON:dic];
            
            [mArray addObject:reModel];
        }
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(_recommendArray.count, mArray.count)];
        
        [_recommendArray insertObjects:mArray atIndexes:indexSet];
        [_tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"上啦刷新失败");
    }];
    
}


//tableView
- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, KScreenWidth, self.bounds.size.height + 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    UINib *nib = [UINib nibWithNibName:@"RecommendCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"RecommendCellID"];
    
    
    
    __weak Hot *weakSelf = self;
    [_tableView addPullDownRefreshBlock:^{
        NSLog(@"发起网络请求");
        __strong Hot *strongSelf = weakSelf;
        [strongSelf loadHotNewData];
        
    }];
    
    
    
    [_tableView addInfiniteScrollingWithActionHandler:^{
        __strong Hot *strongSelf = weakSelf;
        [strongSelf loadHotMoreData];
    }];
    
    
    
    
}

//数据加载
- (void)loadData{
    //创建manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:KHotViewAPI parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //        NSLog(@"%@",responseObject);
        NSArray *array = responseObject[@"items"];
        NSMutableArray *mArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in array) {
            
            RecommendModel *reModel = [RecommendModel yy_modelWithJSON:dic];
            
            [mArray addObject:reModel];
        }
        _recommendArray = [mArray mutableCopy];
        
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败");
    }];
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _recommendArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendCellID"];
    RecommendModel *recommendModel = _recommendArray[indexPath.row];
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
    RecommendModel *recommendModel = _recommendArray[indexPath.row];
    RecommendCellLayout *layout = [RecommendCellLayout layoutWithWeiboModel:recommendModel];
    
    return layout.cellhight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendModel *reModel = _recommendArray[indexPath.row];
    
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



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
