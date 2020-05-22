
//
//  PersonCenterController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/12/10.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "PersonCenterController.h"
#import "MineTableViewCell.h"
#import "SettingsViewController.h"
#import "GongFengRecordViewController.h"
#import "SetHeadViewController.h"
#import "RZMessageViewController.h"
@interface PersonCenterController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;

@end

@implementation PersonCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self addNavigationTitleView:@"我的"];
    [self addNavigationItemWithImageName:@"home" itemType:kNavigationItemTypeRight action:@selector(rightClick)];
    ////12345612321323
    // Do any additional setup after loading the view.
}
-(void)rightClick
{
    SettingsViewController *SVC=[SettingsViewController new];
    SVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:SVC animated:YES];
}
-(UITableView*)tableView
{
    if (!_tableView)
    {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, kNavagationBarH, Screen_Width, Screen_Height-kNavagationBarH-kBottomLayout) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor =kBGViewCOLOR;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MineTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MineTableViewCell class])];
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 260;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineTableViewCell class]) forIndexPath:indexPath];
    [cell.GongFeng addTarget:self action:@selector(GongFengClick) forControlEvents:UIControlEventTouchUpInside];
    [cell.HeaderBtn addTarget:self action:@selector(HeaderClick) forControlEvents:UIControlEventTouchUpInside];
    [cell.RZBtn addTarget:self action:@selector(RZClick) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
    return cell;
    
    
}
-(void)GongFengClick
{
    GongFengRecordViewController *GFRVC=[GongFengRecordViewController new];
    GFRVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:GFRVC animated:YES];
}
-(void)HeaderClick
{
    SetHeadViewController *GFRVC=[SetHeadViewController new];
    GFRVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:GFRVC animated:YES];
}
-(void)RZClick
{
    RZMessageViewController *GFRVC=[RZMessageViewController new];
    GFRVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:GFRVC animated:YES];
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
