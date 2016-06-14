//
//  ZoomViewController.m
//  WJDemo
//
//  Created by jie wang on 16/3/1.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "ZoomViewController.h"
#import <UIImageView+WebCache.h>

@interface ZoomViewController ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.urlStr]];
    [self.view addSubview:self.imgView];
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
