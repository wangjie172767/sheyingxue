//
//  CollectViewController.m
//  WJDemo
//
//  Created by jie wang on 16/2/19.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "CollectViewController.h"
//#import "CollectedInfo.h"
#import "PostsModel.h"
#import "AppDelegate.h"
#import "CollectedCell.h"
#import "PhotoPaiViewController.h"

@interface CollectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation CollectViewController

@synthesize context;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
//
    self.navigationItem.backBarButtonItem = [BackBarBtnItem shareBackItem];
    self.tableView.rowHeight = ScreenHeight/3;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectedCell" bundle:nil] forCellReuseIdentifier:@"collectedCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.dataArr = [NSMutableArray array];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.context = delegate.managedObjectContext;
    //
    //    CollectedInfo *info = [NSEntityDescription insertNewObjectForEntityForName:@"CollectedInfo" inManagedObjectContext:context];
    //    info.title = @"1234444";
    //    info.imgurl = @"http://timg.photopai.com/media/2013/12/01bea582910de82c4ba92b.jpg";
    //
    //
    //
    
    NSError *error = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CollectedInfo" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchObj = [context executeFetchRequest:fetchRequest error:&error];
    for(NSManagedObject *info in fetchObj){
        
        PostsModel *model = [[PostsModel alloc] init];
        model.ID = [[info valueForKey:@"likeID"] integerValue];
        model.thumbnail = [info valueForKey:@"imgurl"];
        model.title = [info valueForKey:@"title"];
        model.imgData = [info valueForKey:@"imgData"];
        [self.dataArr addObject:model];
    }

    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectedCell"];
    PostsModel *infoModel = self.dataArr[indexPath.row];
    [cell cellInitWithModel:infoModel];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PhotoPaiViewController *viewCtl = [storyboard instantiateViewControllerWithIdentifier:@"photoPaiVC"];
//    [self.navigationController pushViewController:viewCtl animated:YES];
    
    PostsModel *model = _dataArr[indexPath.row];
    viewCtl.model = model;
    [self.navigationController pushViewController:viewCtl animated:YES];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
}


@end
