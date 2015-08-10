//
//  LoginController.m
//  私人通讯录
//
//  Created by JinWei on 15/8/4.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import "LoginController.h"
#import "MBProgressHUD+MJ.h"


@interface LoginController ()

@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch *remeberSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogin;

- (IBAction)remeberSwitchChange;
- (IBAction)autoLoginSwitchChange;
- (IBAction)loginBtnClick;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textValveChanged) name:UITextFieldTextDidChangeNotification object:self.accountField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textValveChanged) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    
    
}
//移除通知
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter ] removeObserver:self];
    
    
}
-(void)textValveChanged{
    
    
    self.loginBtn.enabled = (self.accountField.text.length&&self.pwdField.text.length);
    
    
    
}

- (IBAction)remeberSwitchChange {
    if (self.remeberSwitch.isOn == NO) {
        self.autoLogin.on = NO;
    }
    
    
}

- (IBAction)autoLoginSwitchChange {
    if (self.autoLogin.isOn) {
        self.remeberSwitch.on = YES;
    }
    
}

- (IBAction)loginBtnClick {
    
    if (![self.accountField.text isEqualToString:@"123"]){
        [MBProgressHUD showError:@"账号不存在"];
        return;
    }
    if (![self.pwdField.text isEqualToString:@"123"]){
        [MBProgressHUD showError:@"密码错误"];
        return;
    }
    [MBProgressHUD showMessage:@"正在努力加载"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self performSegueWithIdentifier:@"login2Contents" sender:nil];
        
    });
    
}

//

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    UIViewController * vc = segue.destinationViewController;
    vc.title=[NSString stringWithFormat:@"%@的通讯录",self.accountField.text];



}


-(void)viewDidDisappear:(BOOL)animated{
    
    
    [self.view endEditing:YES];
    
    
}

@end
