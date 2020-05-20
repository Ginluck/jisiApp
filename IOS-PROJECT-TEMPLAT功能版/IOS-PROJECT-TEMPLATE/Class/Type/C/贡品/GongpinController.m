//
//  GongpinController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/12.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "GongpinController.h"
#import "JipinCell.h"
@interface GongpinController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;

@end

@implementation GongpinController

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
    return 4;
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
    [cell setCell:6];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    
    UILabel * lab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    lab.textAlignment =NSTextAlignmentCenter;
    [lab setFont:MKFont(15)];
    lab.textColor =K_Prokect_MainColor;
    lab.text =[NSString stringWithFormat:@"分类%d",section];
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
    
    //    NSDictionary * param =@{@"pageNum":@(self.page),@"pageRow":@"10",@"status":@"1",@"isApp":@"1"};
    //    [RequestHelp POST:GET_HOUSESALE_URL parameters:param success:^(id result) {
    //        DLog(@"%@",result);
    //        [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[HouseSaleInfo class] json:result[@"list"]]];
    //        [self.tableView reloadData];
    //        [self endRefresh];
    //    } failure:^(NSError *error) {
    //        [self endRefresh];
    //    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
}

@end
