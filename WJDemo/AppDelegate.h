//
//  AppDelegate.h
//  WJDemo
//
//  Created by jie wang on 16/1/28.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly,strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly,strong,nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly,strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void) saveContext;
- (NSURL *) applicationDocumentsDirectory;

@end

