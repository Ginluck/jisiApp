//
//  ZupuHomeCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/15.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "ZupuHomeCell.h"
@interface ZupuHomeCell()
@property(nonatomic,weak)IBOutlet UILabel * nameLabel;

@end
@implementation ZupuHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)reloadCell:(FamilyListModel *)model
{
    self.nameLabel.text =model.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
