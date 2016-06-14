//
//  ClassViewController.m
//  WJDemo
//
//  Created by jie wang on 16/2/2.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "ClassViewController.h"
#import "ClassCollectionViewCell.h"
#import "DetailViewController.h"

@interface ClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectinView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.backBarButtonItem = [BackBarBtnItem shareBackItem];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)dataArr{

    if (!_dataArr) {
       _dataArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ClassList" ofType:@"plist"]];
    }
    return _dataArr;
}



#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"classCell" forIndexPath:indexPath];
   
    NSString *string = self.dataArr[indexPath.row][@"name"];
    [cell cellInitWithTitle:string];
    
    return cell;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width/2-15, collectionView.frame.size.width/2-15);
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ClassCollectionViewCell *cell = sender;
    NSInteger selecteRow = [[_collectinView indexPathForCell:cell] row];
    DetailViewController *viewCtl = [segue destinationViewController];
  
    viewCtl.slug = self.dataArr[selecteRow][@"slug"];
    viewCtl.preColor = cell.imgView.backgroundColor;
    viewCtl.title = cell.label.text;
    
//    PostsModel *model = _dataArr[selecteRow];
//    viewCtl.urlString = model.url;
//    viewCtl.ID = model.ID;
    
}


@end
