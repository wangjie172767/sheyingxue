//
//  WJProgressHUD.m
//  易建模
//
//  Created by jie wang on 16/4/6.
//  Copyright © 2016年 wangxudong. All rights reserved.
//

#import "WJProgressHUD.h"
#import <MBProgressHUD.h>

#define HideDelayTime 1.5

static WJProgressHUD *wjProgressHUD = nil;

@interface WJProgressHUD ()

@property (nonatomic, strong) MBProgressHUD *HUD;

@end
@implementation WJProgressHUD

//只显示text 马上消失
+ (void)showHUDInView:(UIView *)view dismissWithText:(NSString *)text{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:view animated:YES];
        mbp.mode = MBProgressHUDModeText;
        mbp.labelText = text;
        [mbp hide:YES afterDelay:HideDelayTime];
    });

}


//请求加载可显示文字
+ (void)showHUDInView:(UIView *)view withText:(NSString *)text{

    wjProgressHUD = [[WJProgressHUD alloc] init];
    [wjProgressHUD showWJHUDInView:view andText:text];
}

//消失附带文字
+ (void)dismissHUDWithText:(NSString *)text{
    
    [wjProgressHUD dismissWJHUDWithText:text];
}

//消失不带文字
+ (void)dismissHUD{
    [wjProgressHUD dismissWJHUD];
}

- (void)showWJHUDInView:(UIView *)view andText:(NSString *)text{

    dispatch_async(dispatch_get_main_queue(), ^{
        self.HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        self.HUD.labelText = text;
    });
    
}


- (void)dismissWJHUDWithText:(NSString *)text{

    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.HUD) {
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.labelText = text;
            [self.HUD hide:YES afterDelay:HideDelayTime];
        }
        
        
//        [self.HUD removeFromSuperview];
//        [wjProgressHUD removeFromSuperview];
        
        self.HUD = nil;
        wjProgressHUD = nil;
    });
    
    
}

- (void)dismissWJHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.HUD) {
            [self.HUD hide:YES afterDelay:0];
//            [self.HUD hide:YES];
        }
        
//        [self.HUD removeFromSuperview];
//        [wjProgressHUD removeFromSuperview];
        self.HUD = nil;
        wjProgressHUD = nil;
    });
}


+ (void)dismissAllHUDsForView:(UIView *)view{
    
    [wjProgressHUD dismissAllWJHUDsForView:view];
}

- (void)dismissAllWJHUDsForView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
        [self.HUD removeFromSuperview];
        [wjProgressHUD removeFromSuperview];
        self.HUD = nil;
        wjProgressHUD = nil;
        
    });
}

@end
