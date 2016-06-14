//
//  CollectedInfo+CoreDataProperties.h
//  WJDemo
//
//  Created by jie wang on 16/2/19.
//  Copyright © 2016年 jie wang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CollectedInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectedInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *imgurl;
@property (nullable, nonatomic, retain) NSString *likeID;
@property (nullable, nonatomic, retain) NSData *imgData;

@end

NS_ASSUME_NONNULL_END
