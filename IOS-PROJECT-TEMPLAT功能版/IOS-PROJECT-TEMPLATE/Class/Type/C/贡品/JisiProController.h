//
//  JisiProController.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/12.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "TPBaseViewController.h"
#import "DLTabedSlideView.h"
NS_ASSUME_NONNULL_BEGIN

@interface JisiProController : TPBaseViewController
@property (weak, nonatomic) IBOutlet DLTabedSlideView *tabedSlideView;
@property(assign,nonatomic)NSInteger selectedIndex;
@end

NS_ASSUME_NONNULL_END
