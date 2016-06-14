//
//  WJBackgroundView.m
//  WJDemo
//
//  Created by jie wang on 16/1/29.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "WJBackgroundView.h"

@implementation WJBackgroundView


+ (UIColor *)randomColor{
    
    CGFloat r = arc4random()%255 / 255.0;
    CGFloat g = arc4random()%255 / 255.0;
    CGFloat b = arc4random()%255 / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:0.7];
    
}

//加图片遮罩
+ (void)addFullOverlayWithBackgroundView:(UIView *)backgroundView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backgroundView.frame.size.width, backgroundView.frame.size.height+64*3)];
    view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [backgroundView addSubview:view];
}

//加毛玻璃
+ (void)addBlurViewWithBackgroundView:(UIView *)backgroundView{
    
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    blurView.frame = CGRectMake(0, 0, backgroundView.frame.size.width, backgroundView.frame.size.height);
    //    blurView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    [backgroundView addSubview:blurView];
}

//加暗色渐变
+ (void)addGradientOverlayWithBackgroundView:(UIView *)backgroundView{
    
    UIColor *opaqueBlackColor = [UIColor blackColor];
    UIColor *transparentBlackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = backgroundView.bounds;
    [backgroundView.layer addSublayer:gradientLayer];
    
    //设置渐变颜色方向
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    //设定颜色组
    gradientLayer.colors = @[(__bridge id)transparentBlackColor.CGColor,
                             (__bridge id)opaqueBlackColor.CGColor];

}

//加文字背景
+ (void)addBackgroundColorToTextWithBackgroundView:(UIView *)backgroundView{
//    UIColor *color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    UIColor *color = [UIColor colorWithWhite:0.3 alpha:0.5];
    backgroundView.backgroundColor = color;
    
}


@end
