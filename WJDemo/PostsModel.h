//
//  PostsModel.h
//  WJDemo
//
//  Created by jie wang on 16/2/2.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostsModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *excerpt;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) NSString *comment_count;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *subscribe;

@property (nonatomic, strong) NSData *imgData;

+ (NSMutableArray *)sharedDataWithDic:(NSDictionary *)dic;
@end
