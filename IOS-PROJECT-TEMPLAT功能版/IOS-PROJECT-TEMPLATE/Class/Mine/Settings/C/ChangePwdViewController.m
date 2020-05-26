//
//  ChangePwdViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/9.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "NSString+Encryption.h"
@interface ChangePwdViewController ()

@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self addNavigationTitleView:@"修改密码"];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)Submit:(id)sender {
    if ([self.NewTF.text isEqualToString:self.AgainTF.text]&&self.NewTF.text.length>0) {
         UserModel * model =[[UserManager shareInstance]getUser];
        [RequestHelp POST:UPDATE_PC_url parameters:@{@"userPhone":model.userPhone,@"password":model.password,@"newPassword":[self.NewTF.text encryptAESWithkey:[UIUtils getCurrentTimes]]} success:^(id result){
                 DLog(@"%@",result);
                  ShowMessage(@"修改成功");
            [self logOut];
              } failure:^(NSError *error) {

             }];
    }else
    {
       ShowMessage(@"两次密码输入的不一致");
    }
   
    
}
-(void)logOut
{


    UserModel * model =[[UserManager shareInstance]getUser];
    [RequestHelp POST:exit_url parameters:@{@"userPhone":model.userPhone} success:^(id result){
       DLog(@"%@",result);
        [[UserManager shareInstance]removeUserId];
        [[UserManager shareInstance]removeToken];
        [[UserManager shareInstance]removeUser];
        [ViewControllerManager showLoginViewController];
    } failure:^(NSError *error) {

   }];
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
