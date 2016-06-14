//
//  CollectViewController.h
//  WJDemo
//
//  Created by jie wang on 16/2/19.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *context;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
