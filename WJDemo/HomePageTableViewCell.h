//
//  HomePageTableViewCell.h
//  WJDemo
//
//  Created by jie wang on 16/1/28.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostsModel;

@interface HomePageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *alphaView;

- (void)cellInitWithModel:(PostsModel *)model;
- (CGFloat)cellOffset;
@end
