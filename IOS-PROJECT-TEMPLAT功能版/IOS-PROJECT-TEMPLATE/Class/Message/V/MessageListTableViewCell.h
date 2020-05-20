//
//  MessageListTableViewCell.h
//  RentHouseApp
//
//  Created by Apple on 2019/4/2.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "TPBaseTableViewCell.h"
//#import "MessageModelList.h"
//#import "SystemMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageListTableViewCell : TPBaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView * headerImage;
@property(nonatomic,weak)IBOutlet UILabel * nameLabel;
@property(nonatomic,weak)IBOutlet UILabel * messageLabel;
@property(nonatomic,weak)IBOutlet UILabel * timeLabel;
@property(nonatomic,weak)IBOutlet UILabel * isRead;
//-(void)refresh:(MessageModelList *)model;
//-(void)refreshSystem:(SystemMessageModel *)model;
//-(void)refreshHouse:(SystemMessageModel *)model;
@end

NS_ASSUME_NONNULL_END
