//
//  WJTimeStamp.h
//  WJDemo
//
//  Created by jie wang on 16/2/3.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJTimeStamp : NSObject

//时间戳转时间
+ (NSString *)timeFormatter:(NSTimeInterval )timeInterval;
@end
