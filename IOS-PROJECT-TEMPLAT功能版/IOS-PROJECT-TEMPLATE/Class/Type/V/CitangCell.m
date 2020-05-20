//
//  CitangCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/8.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "CitangCell.h"

@implementation CitangCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius =5.f;
    self.bgView.layer.masksToBounds=YES;
    
    
    self.shaDowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.shaDowView.layer.shadowRadius = 3.0f;
    self.shaDowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shaDowView.layer.shadowOpacity = .5;
}
-(void)reloadCell:(CitangListModel*)model
{
    if ([model.type isEqualToString:@"0"])
    {
        [self.familyImage sd_setImageWithURL:[NSURL URLWithString:model.img2]];
        self.familyName.text =model.name2;
        self.familyDesc.text =model.ctJs2;
    }
    else if ([model.type isEqualToString:@"1"])
    {
        [self.familyImage sd_setImageWithURL:[NSURL URLWithString:model.img]];
        self.familyName.text =model.name;
        self.familyDesc.text =model.ctJs;
    }
    else
    {
        [self.familyImage sd_setImageWithURL:[NSURL URLWithString:model.img2]];
        self.familyName.text =model.name2;
        self.familyDesc.text =model.ctJs2;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
