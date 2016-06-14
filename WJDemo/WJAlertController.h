//
//  AlertController.h
//  Model
//
//  Created by hanzhong ye on 15/12/4.
//  Copyright © 2015年 jie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WJAlertController : UIAlertController

+ (void)alertWithTitle:(NSString *)title anMessage:(NSString *)message andUIViewController:(UIViewController *)controller;

+ (void)alertOnlyShowTitle:(NSString *)title andUIViewController:(UIViewController *)controller;


@end
