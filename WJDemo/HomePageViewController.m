//
//  HomePageViewController.m
//  WJDemo
//
//  Created by jie wang on 16/1/28.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageTableViewCell.h"
#import "PhotoPaiViewController.h"
#import "PostsModel.h"

#define RECENT_URL @"http://tips.photopai.com/ppapi/get_recent_posts/?page="

@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) NSInteger page;

@end

@implementation HomePageViewController

- (void)homePageGet{

    NSString *url = [NSString stringWithFormat:@"%@%ld",RECENT_URL,(long)_page];
    [LORequestManger GET:url success:^(id response) {
        
        NSDictionary *dic = (NSDictionary *)response;
        NSArray *arr = [PostsModel sharedDataWithDic:dic];
        
        for (NSInteger i = 0; i<arr.count; i++) {
            [self.dataArr addObject:arr[i]];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - MJRefresh
- (void)initMJRefresh{
    
    __unsafe_unretained UITableView *tableView = self.tableView;
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = Page_Default;
            [_dataArr removeAllObjects];
            [self homePageGet];
        }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page += Page_Default;
        
        [self homePageGet];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;

    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    self.tableView.rowHeight = ScreenHeight/3;
    self.tableView.tableFooterView = [UIView new];
    _dataArr = [NSMutableArray array];
    
    [self initMJRefresh];
    [self.tableView.mj_header beginRefreshing];
    
//    NSURL *url = [NSURL URLWithString:@"http://appshop.csmall.com/brand/"];
//    NSString *htmlOrigin = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *htmlFilePath = [documentsPath stringByAppendingPathComponent:@"my.html"];
//    [htmlOrigin writeToFile:htmlFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"htmlFilePath == %@",htmlFilePath);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homepageCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_dataArr.count>0) {
        [cell cellInitWithModel:_dataArr[indexPath.row]];
    }
    
//    [cell cellOffset];
    return cell;
}

#pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     UITableViewCell *cell = sender;
     NSInteger selecteRow = [[_tableView indexPathForCell:cell] row];
     PhotoPaiViewController *viewCtl = [segue destinationViewController];
     
     PostsModel *model = _dataArr[selecteRow];
     viewCtl.model = model;
//     viewCtl.urlString = model.url;
//     viewCtl.ID = model.ID;

 }


@end
