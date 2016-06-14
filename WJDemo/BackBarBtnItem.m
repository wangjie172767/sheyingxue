//
//  BackBarBtnItem.m
//  ICUE
//
//  Created by APPLE on 15-2-3.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "BackBarBtnItem.h"

static BackBarBtnItem *backItem = nil;

@implementation BackBarBtnItem

+ (BackBarBtnItem *)shareBackItem
{
    @synchronized(self)
    {
        if (backItem ==nil)
        {
            backItem = [[BackBarBtnItem alloc] init];
        }
    }
    
    return backItem;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.title = @"";
    }
    
    return self;
}

- (void)allasset{
    
    
}

@end
