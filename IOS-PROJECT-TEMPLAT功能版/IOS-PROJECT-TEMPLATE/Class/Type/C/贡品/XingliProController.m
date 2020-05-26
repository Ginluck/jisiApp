//
//  XingliProController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/12.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "XingliProController.h"
#import "JipinCell.h"
#import "JipinModel.h"
#import "BuyJPView.h"
#import "JipinView.h"
@class JPButton;
@interface XingliProController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,JPCellClickDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;
@property (nonatomic,strong)BuyJPView * buyView;
@end

@implementation XingliProController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self regisNib];
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self postDate];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page = self.page + 1;
        [self refreshPostData];
        
    }];
    //     Do any additional setup after loading the view from its nib.
}
-(void)JPCellClick:(JPButton*)button
{
    JipinModel* model =self.dataAry[button.row];
    JipinChild * child =model.sacrificeList[button.tag];
    [self.buyView refreshUI:child];
    [self.view addSubview:self.buyView];
    
}


-(BuyJPView *)buyView
{
    if (!_buyView) {
        _buyView =[[[NSBundle mainBundle] loadNibNamed:@"BuyJPView" owner:self options:nil] firstObject];
        _buyView.frame =CGRectMake(0, 0, 200,250);
        _buyView.center =CGPointMake(Screen_Width/2, Screen_Height/2-50);
    }
    return _buyView;
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-K_NaviHeight-40) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource =self;
        _tableView.emptyDataSetDelegate=self;
        _tableView.backgroundColor =kBGViewCOLOR;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

-(void)regisNib
{
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JipinCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([JipinCell class])];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataAry.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Screen_Width/4+35;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JipinCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JipinCell class]) forIndexPath:indexPath];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
    cell.delegate=self;
    JipinModel* model =self.dataAry[indexPath.section];
    [cell setCell:model.sacrificeList row:indexPath.section];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
    
    UILabel * lab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
    lab.textAlignment =NSTextAlignmentCenter;
    [lab setFont:MKFont(15)];
    lab.textColor =K_Prokect_MainColor;
    JipinModel * model =self.dataAry[section];
    lab.text =model.name;
    [view addSubview:lab];
    
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
-(void)endRefresh
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark -- 设置暂无数据背景

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"无数据"];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
-(NSMutableArray *)dataAry
{
    if (!_dataAry) {
        _dataAry =[NSMutableArray new];
    }
    return _dataAry;
}
-(void)postDate
{
    self.page = 1;
    [self.dataAry removeAllObjects];
    [self refreshPostData];
}
-(void)refreshPostData
{
    
        NSDictionary * param =@{@"parentId":@"1"};
        [RequestHelp POST:JS_JIPIN_LIST_URL parameters:param success:^(id result) {
            DLog(@"%@",result);
            [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[JipinModel class] json:result]];
            [self.tableView reloadData];
            [self endRefresh];
        } failure:^(NSError *error) {
            [self endRefresh];
        }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self postDate];
}

@end
