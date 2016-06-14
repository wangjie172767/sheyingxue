//
//  DetailCollectionViewCell.m
//  WJDemo
//
//  Created by jie wang on 16/1/29.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "DetailCollectionViewCell.h"
#import "PostsModel.h"
#import "WJTimeStamp.h"

@implementation DetailCollectionViewCell

- (void)setBackView:(UIView *)backView{
    backView.layer.cornerRadius = 4;
}

- (void)cellInitWithModel:(PostsModel *)model{

    self.titleLabel.text = model.title;
    self.excerptLabel.text = model.excerpt;
    NSString *time = [WJTimeStamp timeFormatter:model.time];
    self.bottomLabel.text = time;

    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail]];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
}

@end
