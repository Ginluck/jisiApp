//
//  LoginViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/12/10.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "LoginViewController.h"
#import "NSString+Encryption.h"
#import "RegisterViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideNavigationBar:YES animated:NO];
}
-(void)setNumberView:(UIView *)NumberView
{
     NumberView.layer.masksToBounds=YES;
       
       NumberView.layer.shadowColor =COLOR(225, 225, 225, 1).CGColor;
       
       NumberView.layer.shadowOffset = CGSizeMake(1, 1);
       
       NumberView.layer.shadowOpacity = 1;
       
       NumberView.layer.shadowRadius = 3.0;
       
       NumberView.layer.cornerRadius = 30.0;
       
       NumberView.clipsToBounds = NO;
}
-(void)setPwdView:(UIView *)PwdView
{
     PwdView.layer.masksToBounds=YES;
       
       PwdView.layer.shadowColor =COLOR(225, 225, 225, 1).CGColor;
       
       PwdView.layer.shadowOffset = CGSizeMake(1, 1);
       
       PwdView.layer.shadowOpacity = 1;
       
       PwdView.layer.shadowRadius = 3.0;
       
       PwdView.layer.cornerRadius = 30.0;
       
       PwdView.clipsToBounds = NO;
}
-(void)setLoginBtn:(UIButton *)LoginBtn
{
          LoginBtn.layer.masksToBounds=YES;
          
       
          
          LoginBtn.layer.cornerRadius = 30.0;
          
         
}
- (IBAction)LoginClick:(id)sender {
//    [ViewControllerManager showMainViewController];
    NSDictionary * dic = @{@"userPhone":self.NumberTF.text,@"password":[self.PwdTF.text encryptAESWithkey:[UIUtils getCurrentTimes]]};
    [RequestHelp POST:login_url parameters:dic success:^(id result) {
//        DLog(@"%@",result);
        [self.view endEditing:YES];
        UserModel * modal  = [UserModel yy_modelWithJSON:result];
        [[UserManager shareInstance]saveUser:modal];
        [[UserManager shareInstance]saveToken:result[@"token"]];
        [ViewControllerManager showMainViewController];
//        [JPUSHService setAlias:modal.id completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//
//        } seq:5];
        [[EMClient sharedClient] loginWithUsername:modal.ringLetterId password:modal.password completion:^(NSString *aUsername, EMError *aError) {
            if (!aError) {
                NSLog(@"登录成功");
            } else {
                NSLog(@"登录失败的原因---%@", aError.errorDescription);
            }
        }];
    } failure:^(NSError *error) {

    }];
}
- (IBAction)ForgetClick:(id)sender {
}
- (IBAction)RegisterClick:(id)sender {
    RegisterViewController *RVC=[RegisterViewController new];
    [self.navigationController pushViewController:RVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
