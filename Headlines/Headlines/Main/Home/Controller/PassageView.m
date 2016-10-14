//
//  PassageView.m
//  Headlines
//
//  Created by apple on 16/9/25.
//  Copyright © 2016年 wxhl. All rights reserved.
//


#import "PassageView.h"
#import "PassageCell.h"
#import "PassageModel.h"
#import "PassageCellLayout.h"

#define KRecommendViewAPI @"http://mobileapi1.roboo.com/joke/hotJson.do?p=1&ps=15&sort=yes&noimg=ture&acc=qvMuN3041BEm3Ls+y+NVv7PmQr+sJyiJMzrMOdiWojcAky6k2W/TUiyx5kAnFZvOHU8TtjssTd20iUPwsg+VEIMDisqfeb+W+z+0StmS7uhpF9AQEHKXcpl/LPfqRBlAMeAIUGzVEEwjGH4Jr5+rvi+RGLtiQqkKVEUfEHSUHo4="
#define KDownPullAPI @"http://mobileapi1.roboo.com/joke/hotJson.do?p=3&ps=15&sort=yes&noimg=ture&acc=WK7STnOYbZiZZ6icB7THGuDKfDf7R2hLbjGeXgi39iQlLezR/aD76C/kRPrTTJXmuaL+RYe9rIg6Wg9rWtdpJuK6HSHmlN/4X/VbCUdOZtHiw4w9xGTGgL0nAjjXECpgDp3mNqSgqGaSn858BtITyPQMkCMliN8zt+FflCnVz90="
#define KUpPullAPI @"http://mobileapi1.roboo.com/joke/hotJson.do?p=1&ps=15&sort=yes&noimg=ture&acc=YZYWF9Tq5tiPU4oSOdBNRE3LvhCyzfK/8SY4CnK9vkjQRjpAemQokXGx7zfD4UgiRSvhpFI8liMfTQR5nraZ5N8j1A7P+ShIk4mw0wCiUg9eNrCVEjs3GoGPXGmhlSwPnBHRCERqhOxZBDhyeALrwACCm3IXzDUD1d5U3eFUg/g="
@implementation PassageView{
    NSMutableArray *_passageArray;
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
    [_tableView.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:10];
    [_tableView.pullToRefreshView startAnimating];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:KDownPullAPI parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = responseObject[@"items"];
        if (responseObject == nil) {
            [_tableView.pullToRefreshView stopAnimating];
            return;
        }else{
            NSMutableArray *mArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                PassageModel *reModel = [PassageModel yy_modelWithJSON:dic];
                
                [mArray addObject:reModel];
            }
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, mArray.count)];
            
            [_passageArray insertObjects:mArray atIndexes:indexSet];
            
            
            [_tableView reloadData];
            [_tableView.pullToRefreshView stopAnimating];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

////下拉刷新
//-(void)reloadRecommend{
//     [_tableView.pullToRefreshView startAnimating];
//
//    [self loadNewData];
//}

//上拉刷新
- (void)loadMoreData{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:KUpPullAPI parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *array = responseObject[@"items"];
        NSMutableArray *mArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in array) {
            
            PassageModel *paModel = [PassageModel yy_modelWithJSON:dic];
            
            [mArray addObject:paModel];
        }
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(_passageArray.count - 1, mArray.count)];
        
        [_passageArray insertObjects:mArray atIndexes:indexSet];
        [_tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"上啦刷新失败");
    }];
    
}


//tableView
- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.bounds.size.height )];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.backgroundColor = [UIColor clearColor];
    UINib *nib = [UINib nibWithNibName:@"PassageCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"PassageCellID"];
    __weak PassageView *weakSelf = self;
    [_tableView addPullDownRefreshBlock:^{
        __strong PassageView *strongSelf = weakSelf;
        [strongSelf loadNewData];
    }];
    
    [_tableView addInfiniteScrollingWithActionHandler:^{
        __strong PassageView *strongSelf = weakSelf;
        [strongSelf loadMoreData];
    }];
    [self addSubview:_tableView];
}

//数据加载
- (void)loadData{
    //创建manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //创建请求对象
    //    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:KRecommendViewAPI]];
    [manager GET:KRecommendViewAPI parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //        NSLog(@"%@",responseObject);
        NSArray *array = responseObject[@"items"];
        NSMutableArray *mArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in array) {
            PassageModel *reModel = [PassageModel yy_modelWithJSON:dic];
            
            [mArray addObject:reModel];
        }
        _passageArray = [mArray mutableCopy];
        
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败");
    }];
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _passageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PassageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PassageCellID"];
    PassageModel *passageModel = _passageArray[indexPath.row];
    [cell setPassage:passageModel];
    return cell;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PassageCellLayout *layout = [PassageCellLayout layoutWithModel:_passageArray[indexPath.row]];
    
    
    return [layout cellhight];
}




@end
