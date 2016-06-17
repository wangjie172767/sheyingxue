//
//  HomePageTableViewCell.m
//  WJDemo
//
//  Created by jie wang on 16/1/28.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "HomePageTableViewCell.h"
#import "WJBackgroundView.h"
#import "PostsModel.h"
#import <UIImageView+WebCache.h>


#pragma mark - 屏幕宽高
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

@interface HomePageTableViewCell ()

@end

@implementation HomePageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.alphaView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
//    [WJBackgroundView addGradientOverlayWithBackgroundView:self.alphaView];
    
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

    
    // Configure the view for the selected state
}

- (void)cellInitWithModel:(PostsModel *)model{

    NSURL *url = [NSURL URLWithString:model.thumbnail];
    [self.imgView sd_setImageWithURL:url placeholderImage:Firstpage_DefaultImage];
    self.label.text = model.title;
    
    //    cell.imgView.image = [UIImage imageNamed:_dataArr[indexPath.row]];
    
}

- (CGFloat)cellOffset {
    
    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY = CGRectGetMidY(centerToWindow);
    CGPoint windowCenter = self.superview.center;
    
    CGFloat cellOffsetY = centerY - windowCenter.y;
    
    CGFloat offsetDig =  cellOffsetY / self.superview.frame.size.height *2;
    CGFloat offset =  -offsetDig * (ScreenHeight/1.7 - 250)/2;
    
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
    
    //    self.titleLabel.transform = transY;
    //    self.littleLabel.transform = transY;
    
    self.imgView.transform = transY;
    
    return offset;
}

@end
