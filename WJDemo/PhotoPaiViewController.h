//
//  PhotoPaiViewController.h
//  WJDemo
//
//  Created by jie wang on 16/2/2.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostsModel.h"

@interface PhotoPaiViewController : UIViewController

//@property (nonatomic, strong) NSString *urlString;
//@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) PostsModel *model;

@property (nonatomic, strong) NSManagedObjectContext *context;

@end
