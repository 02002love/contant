//
//  EditViewController.h
//  私人通讯录
//
//  Created by JinWei on 15/8/7.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContantModel.h"

@class EditViewController;
@protocol EditViewControllerDelegate <NSObject>

@optional
-(void)editViewController:(EditViewController * )edit saveContentsWithContant:(ContantModel *)contant;

@end

@interface EditViewController : UIViewController

@property (nonatomic,strong)ContantModel * model;
@property (nonatomic,weak)id<EditViewControllerDelegate> delegate;

@end
