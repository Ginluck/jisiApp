//
//  MineTableViewCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/8.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "MineTableViewCell.h"
#import "MineDataModel.h"
@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self requsetData];
    // Initialization code
}
-(void)requsetData
{
    UserModel * model =[[UserManager shareInstance]getUser];
       NSDictionary* param_dic =@{@"userPhone":model.userPhone};
       [RequestHelp POST:SELECT_USERINFO_url parameters:param_dic success:^(id result) {
           MKLog(@"%@",result);
         MineDataModel *model =[MineDataModel yy_modelWithJSON:result];
            [self.HeadImg sd_setImageWithURL:[NSURL URLWithString:model.headAddress] placeholderImage:[UIImage imageNamed:@"临时占位图"]];
            self.PhoneLab.text=model.userPhone;
           self.NameLab.text=model.realName;
       } failure:^(NSError *error) {
           
       }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
