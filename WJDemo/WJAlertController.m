//
//  AlertController.m
//  Model
//
//  Created by hanzhong ye on 15/12/4.
//  Copyright © 2015年 jie. All rights reserved.
//

#import "WJAlertController.h"

@interface WJAlertController ()

@property (nonatomic, strong) UIAlertController *onlyShowTitleAlertCtl;

@end



@implementation WJAlertController

+ (void)alertWithTitle:(NSString *)title anMessage:(NSString *)message andUIViewController:(UIViewController *)controller{
    
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction*action) {
        
    }];
    
    [alertCtl addAction:cancelAction];
    [controller presentViewController:alertCtl animated:YES completion:nil];
}


+ (void)alertOnlyShowTitle:(NSString *)title andUIViewController:(UIViewController *)controller{

    WJAlertController *alertCtl = [WJAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
  
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction*action) {
//    }];
//    
//    [alertCtl addAction:cancelAction];

    [controller presentViewController:alertCtl animated:YES completion:^{
        
        
        [alertCtl contrlWith:alertCtl];
    }];
}


- (void)contrlWith:(UIAlertController *)alertCtl{
 
    [self performSelector:@selector(alertDismiss) withObject:nil afterDelay:1.0f];
    self.onlyShowTitleAlertCtl = alertCtl;
    

}

- (void)alertDismiss{

    [self.onlyShowTitleAlertCtl dismissViewControllerAnimated:YES completion:nil];
    self.onlyShowTitleAlertCtl = nil;
}


@end
