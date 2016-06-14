//
//  CollectedCell.h
//  WJDemo
//
//  Created by jie wang on 16/2/19.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostsModel;

@interface CollectedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)cellInitWithModel:(PostsModel *)model;

@end
