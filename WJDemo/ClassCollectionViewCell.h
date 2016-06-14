//
//  ClassCollectionViewCell.h
//  WJDemo
//
//  Created by jie wang on 16/2/2.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *label;

- (void)cellInitWithTitle:(NSString *)title;


@end
