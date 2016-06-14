//
//  CollectedCell.m
//  WJDemo
//
//  Created by jie wang on 16/2/19.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "CollectedCell.h"
#import <UIImageView+WebCache.h>
#import "PostsModel.h"
#import "WJBackgroundView.h"

@implementation CollectedCell

- (void)awakeFromNib {
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [WJBackgroundView addBackgroundColorToTextWithBackgroundView:self.titleLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellInitWithModel:(PostsModel *)model{
    
    self.imgView.image = [UIImage imageWithData:model.imgData];
//    [self.imgView sd_setImageWithURL:url];
    self.titleLabel.text = model.title;
    
    //    cell.imgView.image = [UIImage imageNamed:_dataArr[indexPath.row]];
    
}

@end
