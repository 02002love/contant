//
//  AddViewController.m
//  私人通讯录
//
//  Created by JinWei on 15/8/7.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import "AddViewController.h"



@interface AddViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)add;

@end

@implementation AddViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneNumField.delegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textValveChanged) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textValveChanged) name:UITextFieldTextDidChangeNotification object:self.phoneNumField];
    
    
}
//移除通知
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter ] removeObserver:self];
    
    
}
-(void)textValveChanged{
    
    self.addBtn.enabled = (self.nameField.text.length&&self.phoneNumField.text.length);
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]){
        
        return YES;
        
    }
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.phoneNumField == textField)
        
    {
        
        if ([aString length] > 11) {
            
            textField.text = [aString substringToIndex:11];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"电话号码不能超过11位" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            
            [alert show];
            
            return NO;
            
        }
        
    }
    
    return YES;
    
    
    
}

- (IBAction)add {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(addViewController:didAddContactWithContantModel:)]) {
        ContantModel * model = [[ContantModel alloc]init];
        model.name = self.nameField.text;
        model.phoneNum =  self.phoneNumField.text;
        [self.delegate addViewController:self didAddContactWithContantModel:model];
    }
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.nameField becomeFirstResponder];
    
    
}

@end
