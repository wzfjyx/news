//
//  Hangzhou.m
//  Headlines
//
//  Created by mac12 on 16/9/24.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "Hangzhou.h"
#import "RecommendCell.h"
#import "RecommendCellLayout.h"
#import "WebRecViewController.h"
#define KHangzhouViewAPI @"http://newsapi.roboo.com/news/categoryJson.htm?uid=0743C16F-9B71-457D-912C-371BB1581470&p=1&ps=15&isapp=yes&c=%E6%9C%AC%E5%9C%B0&city=%E6%9D%AD%E5%B7%9E&userId=FBzwYEDSAENpH3FJ7pAq6K7GwGQkngos3c8EDPOlHZiK0PPLNg/6t7zfhaLVlHK9E0EBW+6DWGt3NhHoVkKMXR4A4F5psoEH+g4gVZIAbu4Ls1T0RkgrtnhSx41SR/86/XqcnVlmrJTizQ59duUxLIzg73GQwAJdj1LQ2RxHu9Y="

#define KDownPullAPI @"http://newsapi.roboo.com/news/categoryJson.htm?uid=0743C16F-9B71-457D-912C-371BB1581470&p=2&ps=15&isapp=yes&c=%E6%9C%AC%E5%9C%B0&city=%E6%9D%AD%E5%B7%9E&userId=M0eo0+Eir6mUy+PRjUtkFCU2/AmUCnBG4sDcGo+rJmBzufxJQaJbZUeP6CZoEotxssy2bgmLfKemtFhMSqvxIKOeih7n8Ndk8nbOGzLdIhibbCvWTuc1duniMBWo3ZfnsXthyNIYFwpvkEXAYpaaPceU10Gd0SFxTlAmNsMgK4A="


#define KUpPullAPI @"http://newsapi.roboo.com/news/categoryJson.htm?uid=0743C16F-9B71-457D-912C-371BB1581470&p=1&ps=15&isapp=yes&c=%E6%9C%AC%E5%9C%B0&city=%E6%9D%AD%E5%B7%9E&userId=quo+4bTRYxMV/Ff8gwRhtgRlDnR99i8kw1eIQsL9qbjxn0uIuDUnWa6h15WipKh+nQ9Idu7jz98DnHPIT4xALM0BmSq1UHVLWgT0YJUvWr5kU/xtC2ptWjh/5dminAJZ7gtrctI4HaGDs2VVJua4in6bmzGTsMJIV7RfqbZvo4k="
@class  AFHTTPSessionManager;
@implementation Hangzhou{
    NSMutableArray *_recommendArray;
    UITableView *_tableView;
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
-(void)loadNewData{
    
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
- (void)loadMoreData{
    
    
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
    //    _tableView.backgroundColor = [UIColor clearColor];
    UINib *nib = [UINib nibWithNibName:@"RecommendCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"RecommendCellID"];
    
    
    
    __weak Hangzhou *weakSelf = self;
    [_tableView addPullDownRefreshBlock:^{
        NSLog(@"发起网络请求");
        __strong Hangzhou *strongSelf = weakSelf;
        [strongSelf loadNewData];
    }];
    
    
    
    [_tableView addInfiniteScrollingWithActionHandler:^{
        __strong Hangzhou *strongSelf = weakSelf;
        [strongSelf loadMoreData];
    }];
    
    
    
    
}

//数据加载
- (void)loadData{
    //创建manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //创建请求对象
    //    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:KRecommendViewAPI]];
    
    [manager GET:KHangzhouViewAPI parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
