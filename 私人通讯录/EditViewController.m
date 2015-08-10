//
//  EditViewController.m
//  私人通讯录
//
//  Created by JinWei on 15/8/7.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *itemBtn;

- (IBAction)saveClick;

- (IBAction)editClick:(id)sender;

@end

@implementation EditViewController

- (void)viewDidLoad {
//    [super viewDidLoad];
    self.nameField.text = self.model.name;
    self.phoneNumField.text = self.model.phoneNum;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textValveChanged) name:UITextFieldTextDidChangeNotification object:self.nameField  ];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textValveChanged) name:UITextFieldTextDidChangeNotification object:self.phoneNumField];
    
    
}
//移除通知
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter ] removeObserver:self];
    
    
}
-(void)textValveChanged{
    
    
    self.saveBtn.enabled = (self.nameField.text.length&&self.phoneNumField.text.length);
    
    
    
}
- (IBAction)editClick:(id)sender {
    
    if (self.nameField.enabled) {//取消
        self.nameField.enabled = NO;
        self.phoneNumField.enabled = NO;
        [self.view resignFirstResponder];
        self.saveBtn.hidden = YES;
        self.itemBtn.title = @"编辑";
        self.nameField.text = self.model.name;
        self.phoneNumField.text = self.model.phoneNum;
        
    }else{//编辑
        
        self.nameField.enabled = YES;
        self.phoneNumField.enabled = YES;
        [self.phoneNumField becomeFirstResponder];
        self.saveBtn.hidden = NO;
        self.itemBtn.title = @"取消";
        
    }
    
    
}
- (IBAction)saveClick {
    [self.navigationController popViewControllerAnimated:YES];
    
    
    if ([self.delegate respondsToSelector:@selector(editViewController:saveContentsWithContant:)]) {
    
       self.model.name = self.nameField.text;
       self.model.phoneNum = self.phoneNumField.text;
        [self.delegate editViewController:self saveContentsWithContant:self.model];
    }
    
    
    
    
}
@end
