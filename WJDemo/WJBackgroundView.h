//
//  WJBackgroundView.h
//  WJDemo
//
//  Created by jie wang on 16/1/29.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WJBackgroundView : NSObject

+ (UIColor *)randomColor;


//加图片遮罩
+ (void)addFullOverlayWithBackgroundView:(UIView *)backgroundView;
//加毛玻璃
+ (void)addBlurViewWithBackgroundView:(UIView *)backgroundView;
//加暗色渐变
+ (void)addGradientOverlayWithBackgroundView:(UIView *)backgroundView;
//加文字背景
+ (void)addBackgroundColorToTextWithBackgroundView:(UIView *)backgroundView
;


@end
