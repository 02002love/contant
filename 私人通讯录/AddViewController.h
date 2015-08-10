//
//  AddViewController.h
//  私人通讯录
//
//  Created by JinWei on 15/8/7.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContantModel.h"

@class AddViewController;
@protocol AddViewControllerDelegate <NSObject>

@optional

-(void)addViewController:(AddViewController *)vc  didAddContactWithContantModel:(ContantModel *)contant;
@end

@interface AddViewController : UIViewController
@property (nonatomic,weak)id<AddViewControllerDelegate> delegate;
@end
