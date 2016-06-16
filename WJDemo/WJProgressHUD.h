//
//  WJProgressHUD.h
//  易建模
//
//  Created by jie wang on 16/4/6.
//  Copyright © 2016年 wangxudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJProgressHUD : UIView

//只显示text 马上消失
+ (void)showHUDInView:(UIView *)view dismissWithText:(NSString *)text;



//请求加载可显示文字
+ (void)showHUDInView:(UIView *)view withText:(NSString *)text;
//消失附带文字
+ (void)dismissHUDWithText:(NSString *)text;
//消失不带文字
+ (void)dismissHUD;
//消失所有的HUD
+ (void)dismissAllHUDsForView:(UIView *)view;

@end

