//
//  ClassCollectionViewCell.m
//  WJDemo
//
//  Created by jie wang on 16/2/2.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "ClassCollectionViewCell.h"
#import "WJBackgroundView.h"

@implementation ClassCollectionViewCell

- (void)setImgView:(UIImageView *)imgView{

//    [WJBackgroundView addFullOverlayWithBackgroundView:imgView];

    _imgView = imgView;
    _imgView.backgroundColor = [WJBackgroundView randomColor];
    
}

- (void)cellInitWithTitle:(NSString *)title{

    self.label.textColor = RGB_NavigationTitleColor;
    self.label.text = [NSString stringWithFormat:@"%@",title];
    
}



@end
