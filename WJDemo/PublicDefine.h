//
//  PublicDefine.h
//  WJDemo
//
//  Created by jie wang on 16/2/1.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#ifndef PublicDefine_h
#define PublicDefine_h

//#define URL @"http://qwapi.quwan.com/zhuanti/zhuanti/zhuanti_list_v14"




#pragma mark ======URL======
#define APIURL @"http://tips.photopai.com/ppapi/get_recent_posts"




#pragma mark ======Default======
#define DefaultIcon [UIImage imageNamed:@"default_icon"]
#define Page_Default 1




#pragma mark ======color======
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define RGB_NavigationBarColor [UIColor whiteColor]
#define RGB_NavigationTitleColor RGB(55.0f,52.0f,71.0f)



#pragma mark ======屏幕宽高======
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

#pragma mark ======IOSVersion======
#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS8                         (!(IOSVersion < 8.0))
#define IOS7ANDIOS8                  (!(IOSVersion < 7.0))
#define IOS6                         (!(IOSVersion < 6.0))&&(IOSVersion < 7.0)
#define IOS5                         (IOSVersion < 6.0)
#define IOS7ONLE                     (IOSVersion >=7.0)&&(IOSVersion <8.0)



#endif /* PublicDefine_h */
