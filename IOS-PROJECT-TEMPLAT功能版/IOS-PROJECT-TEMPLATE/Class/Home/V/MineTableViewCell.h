//
//  MineTableViewCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/8.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineTableViewCell : TPBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *CustomerBtn;
@property (weak, nonatomic) IBOutlet UIButton *GongFeng;
@property (weak, nonatomic) IBOutlet UIButton *HeaderBtn;

@end

NS_ASSUME_NONNULL_END
