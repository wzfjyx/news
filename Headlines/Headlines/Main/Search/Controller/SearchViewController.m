//
//  SearchViewController.m
//  Headlines
//
//  Created by mac12 on 16/9/22.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "SearchViewController.h"
#import "WebViewController.h"
#import "SearchCache.h"
#import "SearchMessageViewController.h"

#define fontCOLOR [UIColor colorWithRed:163/255.0f green:163/255.0f blue:163/255.0f alpha:1]
@class WebViewController;

@interface SearchViewController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tabView;
}
@property (nonatomic,strong)NSMutableArray * searchHistory;
@property (nonatomic,strong)NSArray *myArray;//搜索记录的数组
@end

@implementation SearchViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self readNSUserDefaults];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //搜索栏
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, 50)];
    searchBar.backgroundImage = [UIImage imageNamed:@"cityListSearchBarBg.png"];
    searchBar.barStyle = UISearchBarStyleDefault;
    searchBar.placeholder = @"请输入关键字";
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    //创建tableView
    tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, KScreenWidth, KScreenHeight - 64-50-49)];
    tabView.backgroundColor = [UIColor whiteColor];
    tabView.userInteractionEnabled = YES;
    tabView.pagingEnabled = YES;
    tabView.delegate = self;
    tabView.dataSource = self;
    [self.view addSubview:tabView];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    headView.backgroundColor = [UIColor grayColor];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40)];
    title.text = @"大家都在搜:";
    title.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:14];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    [headView addSubview:title];
    tabView.tableHeaderView = headView;
    
    
    
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length > 0) {
        
        SearchMessageViewController *searchV = [[SearchMessageViewController alloc]init];
        searchV.text = searchBar.text;
        [SearchCache SearchText:searchBar.text];//缓存搜索记录
        [self readNSUserDefaults];
        [self.navigationController pushViewController:searchV animated:YES];
        
    }else{
        NSLog(@"请输入查找内容");
    }

}

#pragma mark - 缓存
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        if (_myArray.count>0) {
            return _myArray.count+1+1;
        }else{
            return 1;
        }
    }else{
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if(indexPath.row ==0){
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
            cell.textLabel.text = @"历史搜索";
            cell.textLabel.textColor = fontCOLOR;
            return cell;
        }else if (indexPath.row == _myArray.count+1){
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
            cell.textLabel.text = @"清除历史记录";
            cell.textLabel.textColor = fontCOLOR;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            return cell;
        }else{
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
            NSArray* reversedArray = [[_myArray reverseObjectEnumerator] allObjects];
            cell.textLabel.text = reversedArray[indexPath.row-1];
            cell.tag = indexPath.row - 1;
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tarAction:)];
            [cell addGestureRecognizer:tgr];
            return cell;
        }
    }else{
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else{
        return 10;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    tabView.estimatedRowHeight = 44.0f;
    //    self.searchTableView.estimatedRowHeight = 44.0f;
    return UITableViewAutomaticDimension;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tabView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == _myArray.count+1) {//清除所有历史记录
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除历史记录" message:@"" preferredStyle: UIAlertControllerStyleAlert];
        
        //@“ UIAlertControllerStyleAlert，改成这个就是中间弹出"
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [SearchCache removeAllArray];
            _myArray = nil;
            [tabView reloadData];
        }];
        //            UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancelAction];
        [alertController addAction:deleteAction];
        //            [alertController addAction:archiveAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        
    }
}


-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
    self.myArray = myArray;
    [tabView reloadData];
//    NSLog(@"myArray======%@",myArray);
}

-(void)tarAction:(UITapGestureRecognizer *)tap
{
    SearchMessageViewController *searchV = [[SearchMessageViewController alloc]init];
    UITableViewCell *cell = (UITableViewCell *)[tap view];
    searchV.text = cell.textLabel.text;
    [self.navigationController pushViewController:searchV animated:YES];
    
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
