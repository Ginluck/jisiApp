//
//  FamilyDetailController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/9.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "FamilyDetailController.h"
#import "HomeHeaderView.h"
#import "HomePeopleCollectionViewCell.h"
#import "JYEqualCellSpaceFlowLayout.h"
#import "JisiProController.h"
#import "FamilyTreeController.h"
@interface FamilyDetailController ()
<UICollectionViewDataSource,UICollectionViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,HeaderViewDelegate>

@property(nonatomic,strong)UICollectionView *myCollectionView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;
@property(nonatomic,strong)HomeHeaderView *HHView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UILabel *introduceLab;
@end

@implementation FamilyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"族谱详情"];
    [self.view addSubview:self.HHView];
    [self.view addSubview:self.bottomView];
  
}
-(void)headerViewClick:(UIButton *)button
{
    if (button.tag ==10)
    {
        FamilyTreeController * fvc =[FamilyTreeController new];
        [self.navigationController pushViewController:fvc animated:YES];
    }
    else
    {
        
    }
}

-(HomeHeaderView *)HHView
{
    if (!_HHView) {
        _HHView=[[NSBundle mainBundle]loadNibNamed:@"HomeHeaderView" owner:nil options:nil][0];
        _HHView.frame =CGRectMake(0, kNavagationBarH, Screen_Width, 320);
        [_HHView setArrBanners:@[@""]];
        _HHView.delegate=self;
        _HHView.allLab.text=[NSString stringWithFormat:@"总人口:%@",self.model.jzNum];
        _HHView.zsLab.text=[NSString stringWithFormat:@"在世:%@",self.model.jzZsNum];
        _HHView.lsLab.text=[NSString stringWithFormat:@"离世:%@",self.model.jzLsNum];
    }
    return _HHView;
}
-(UIView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, 320, Screen_Width, Screen_Height-kNavagationBarH-320)];
        
        _introduceLab  =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, Screen_Width-20, CGRectGetHeight(_bottomView.frame)-20)];
        _introduceLab.font =MKFont(14);
        _introduceLab.textColor =K_PROJECT_GARYTEXTCOLOR;
        _introduceLab.text =self.model.introduce;
        _introduceLab.numberOfLines =0;
        [_bottomView addSubview:_introduceLab];
    
    }
    return _bottomView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    //    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
