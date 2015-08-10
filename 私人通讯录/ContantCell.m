//
//  ContantCell.m
//  私人通讯录
//
//  Created by JinWei on 15/8/7.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import "ContantCell.h"

@interface ContantCell()

@property (nonatomic,weak)UIView * lineView;

@end
@implementation ContantCell


//相当于 init 方法 只是对子控件进行初始化
- (void)awakeFromNib {
    
    UIView * lineView1=[[UIView alloc]init];
    lineView1.backgroundColor = [UIColor blackColor];
    lineView1.alpha = 0.3;
    self.lineView = lineView1;
    
    [self.contentView addSubview:self.lineView];
    
}


//子控件的 frame 设置是在此函数中
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.lineView.frame = CGRectMake(0, self.frame.size.height -1, self.frame.size.width, 1);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



-(void)setModel:(ContantModel *)model{
    
    _model = model;
    self.textLabel.text = model.name;
    self.detailTextLabel.text = model.phoneNum;
    
}


+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString * ID = @"contant";
    return [tableView dequeueReusableCellWithIdentifier:ID];
    
    
}
@end
