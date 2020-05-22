//
//  FamilyDescController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/22.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "FamilyDescController.h"
#import "ApplyController.h"
@interface FamilyDescController ()
@property(nonatomic,weak)IBOutlet UIButton * addrBtn;
@property(nonatomic,weak)IBOutlet UITextField * nameTF;
@property(nonatomic,weak)IBOutlet UIButton * detailAddr;
@property(nonatomic,weak)IBOutlet UITextView * contentTV;
@end

@implementation FamilyDescController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUICompoents];
    [self addNavigationItemWithTitle:@"申请查看" itemType:kNavigationItemTypeRight action:@selector(jumpClick)];
}

-(void)setUICompoents
{
    self.nameTF.text =self.model.name;
    [self.addrBtn setTitle:self.model.pcaName forState:UIControlStateNormal];
    [self.detailAddr setTitle:self.model.address forState:UIControlStateNormal];
    self.contentTV.text =self.model.introduce;
}
-(void)jumpClick
{
    ApplyController * AVC =[ApplyController new];
    AVC.model =self.model;
    [self.navigationController pushViewController:AVC animated:YES];
}

@end
