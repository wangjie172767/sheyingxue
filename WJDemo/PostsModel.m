//
//  PostsModel.m
//  WJDemo
//
//  Created by jie wang on 16/2/2.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "PostsModel.h"

@implementation PostsModel

+ (NSMutableArray *)sharedDataWithDic:(NSDictionary *)dic{

    NSMutableArray *dataArr = [NSMutableArray array];
    
    NSArray *postsArr = dic[@"posts"];
    for (NSInteger i = 0; i<postsArr.count; i++) {
        
        PostsModel *model = [[PostsModel alloc] initWithDictionary:postsArr[i]];
        [dataArr addObject:model];
    }
    
    return dataArr;
}


- (PostsModel *)initWithDictionary:(NSDictionary *)dic{

    PostsModel *model = [[PostsModel alloc] init];
//    model.caseid = [dic objectForKey:@"id"] ?[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]:@"--";
    
    model.ID = [[dic objectForKey:@"id"] integerValue];
    model.url = [dic objectForKey:@"url"];
    model.title = [dic objectForKey:@"title"];
    model.excerpt = [dic objectForKey:@"excerpt"];
    model.time = [[dic objectForKey:@"time"] integerValue];
    model.comment_count = [dic objectForKey:@"comment_count"];
    model.thumbnail = [dic objectForKey:@"thumbnail"];
    model.subscribe = [dic objectForKey:@"subscribe"];
    model.imgData = [dic objectForKey:@"imgData"];
    
    return model;
}

@end
