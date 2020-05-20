//
//  HomeViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/12/10.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#import "HomeViewController.h"
#import "CitangCell.h"
#import "HomeTableHeaderView.h"
#import "CitangListModel.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;
@property(nonatomic,strong)HomeTableHeaderView  * headerView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"祠堂"];
   
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
-(HomeTableHeaderView *)headerView
{
    if (!_headerView) {
        _headerView =[[[NSBundle mainBundle] loadNibNamed:@"HomeTableHeaderView" owner:self options:nil] firstObject];
    }
    return _headerView;
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-K_NaviHeight-K_TabbarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView=self.headerView;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        UIImageView * imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(_tableView.frame))];
        imageV.image =KImageNamed(@"祠堂背景");
        _tableView.backgroundView =imageV;
        _tableView.emptyDataSetSource =self;
        _tableView.emptyDataSetDelegate=self;
        _tableView.backgroundColor =[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

-(void)regisNib
{
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CitangCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CitangCell class])];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataAry.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 111;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitangCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CitangCell class]) forIndexPath:indexPath];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
    cell.backgroundView .backgroundColor =[UIColor clearColor];
    cell.backgroundColor =[UIColor clearColor];
    [cell reloadCell:self.dataAry[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
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
    UserModel * model =[[UserManager shareInstance]getUser];
    
    if (!model.jzId.length) {
        ShowMessage(@"没有家族id");
        return;
    }

        NSDictionary * param =@{@"pageNum":@(self.page),@"pageRow":@"10",@"status":@"0",@"jzId":model.jzId};
        [RequestHelp POST:JS_SELECT_CTLIST_URL parameters:param success:^(id result) {
            DLog(@"%@",result);
            [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[CitangListModel class] json:result[@"list"]]];
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
