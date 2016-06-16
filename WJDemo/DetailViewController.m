//
//  DetailViewController.m
//  WJDemo
//
//  Created by jie wang on 16/1/28.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "DetailViewController.h"
#import "WJBackgroundView.h"
#import "DetailCollectionViewCell.h"
#import "PhotoPaiViewController.h"
#import "PostsModel.h"
#import <MBProgressHUD.h>
#import "EGORefreshTableHeaderView.h"

#define CATEGOLRY_URL @"http://tips.photopai.com/ppapi/get_category_posts?slug=###&page=***"

@interface DetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,EGORefreshTableHeaderDelegate>{
    
    MBProgressHUD *HUD;
    EGORefreshTableHeaderView* _PullRightRefreshView;
    EGORefreshTableHeaderView* _PullLeftRefreshView;
    BOOL _reloading;
}

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImgView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger page;

@end

@implementation DetailViewController

- (void)CategoryGet{

    NSString *url = [CATEGOLRY_URL stringByReplacingOccurrencesOfString:@"###" withString:_slug];
    NSString *newUrl = [url stringByReplacingOccurrencesOfString:@"***" withString:[NSString stringWithFormat:@"%ld",(long)_page]];

    [WJAFNRequestManager GET:newUrl paramerters:nil success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        NSArray *arr = [PostsModel sharedDataWithDic:dic];
        for (NSInteger i =0; i<arr.count; i++) {
            [self.dataArr addObject:arr[i]];
        }
        
        //在主线程中刷新UI
        [self performSelectorOnMainThread:@selector(reloadUI)
                               withObject:nil
                            waitUntilDone:NO];
        [HUD hide:YES];
    } failure:^(id error) {
        [HUD hide:YES];
    }];

}

- (void)setImagWithURLString:(NSString *)string{

    NSURL *url = [NSURL URLWithString:string];
    [self.backgroundImgView sd_setImageWithURL:url];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.page = 1;
    self.dataArr = [NSMutableArray array];
    
    self.navigationItem.backBarButtonItem = [BackBarBtnItem shareBackItem];
    self.backgroundImgView.contentMode = UIViewContentModeScaleAspectFill;

    self.backgroundImgView.backgroundColor = self.preColor;
    [WJBackgroundView addFullOverlayWithBackgroundView:self.backgroundImgView];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD show:YES];
    [self CategoryGet];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    PostsModel *model = self.dataArr[indexPath.row];
    [cell cellInitWithModel:model];
    return cell;

}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(20, 30, 0, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width-70, collectionView.frame.size.height-30);
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    
    PhotoPaiViewController *viewCtl = [segue destinationViewController];
    UICollectionViewCell *cell = sender;
    NSInteger selectedRow = [[_collectionView indexPathForCell:cell] row];
    PostsModel *model = self.dataArr[selectedRow];
    viewCtl.model = model;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_PullLeftRefreshView egoRefreshScrollViewDidScroll:self.collectionView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_PullLeftRefreshView egoRefreshScrollViewDidEndDragging:self.collectionView];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (_PullLeftRefreshView) {
        [_PullLeftRefreshView removeFromSuperview];
    }
    _PullLeftRefreshView = [[EGORefreshTableHeaderView alloc] initWithScrollView:self.collectionView orientation:EGOPullOrientationLeft];
    _PullLeftRefreshView.delegate = self;
}

#pragma mark - EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    [self performSelector:@selector(refreshDone) withObject:nil afterDelay:1.0f];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
    return _reloading;
}


- (void)refreshDone {
    
    _reloading = YES;
    //新建一个线程来加载数据
    [NSThread detachNewThreadSelector:@selector(requestData)
                             toTarget:self
                           withObject:nil];
}

- (void)requestData{
    //在主线程中刷新UI
    self.page += Page_Default;
    [self CategoryGet];
}

- (void)reloadUI{
    
    _reloading = NO;
    //停止下拉的动作
   [_PullLeftRefreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.collectionView];
    //更新界面
    [self.collectionView reloadData];
}



@end
