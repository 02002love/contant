//
//  ContantCell.h
//  私人通讯录
//
//  Created by JinWei on 15/8/7.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContantModel.h"
@interface ContantCell : UITableViewCell

@property (nonatomic,strong)ContantModel * model;
+(instancetype)cellWithTableView:(UITableView *)tableView;


@end
