//
//  SystemMessageController.m
//  RentHouseApp
//
//  Created by ginluck on 2019/7/24.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "SystemMessageController.h"
#import "MessageListTableViewCell.h"
//#import "SystemMessageModel.h"
#import "NSString+Fit.h"

@interface SystemMessageController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry;
@property (assign, nonatomic) NSInteger page;
@end

@implementation SystemMessageController
-(NSMutableArray *)dataAry
{
    if (!_dataAry) {
        _dataAry=[[NSMutableArray alloc]init];
    }
    return _dataAry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"系统消息"];
    [self.view addSubview:self.tableView];
     [self postdata];
       self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
           [self postdata];
       }];
       self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           self.page = self.page + 1;
           [self refreshPostData];
           
       }];
    // Do any additional setup after loading the view.
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-kNavagationBarH ) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MessageListTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MessageListTableViewCell class])];
        
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SystemMessageModel * model =self.dataAry[indexPath.section];
//    if ([model.isOpen isEqualToString:@"1"])
//    {
//        CGFloat height =[model.content getHeightWithFont:13.f withWidth:Screen_Width-83];
//        return 80-12+height;
//    }
//    else
//    {
            return 80;
//    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    MessageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageListTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
//    [cell refreshSystem:self.dataAry[indexPath.section]];
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30.f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
//    SystemMessageModel * model =self.dataAry[section];
//    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
//    UIButton * button =[UIButton  buttonWithType:UIButtonTypeCustom];
//    button.tag =section;
//    button.backgroundColor =[UIColor whiteColor];
//    button.frame =CGRectMake(0, 0, Screen_Width, 30);
//    if ([model.isOpen isEqualToString:@"1"]) {
//        [button setTitle:@"收起" forState:UIControlStateNormal];
//    }
//   else
//   {
//        [button setTitle:@"查看更多" forState:UIControlStateNormal];
//   }
//    button.titleLabel.font =[UIFont systemFontOfSize:13.f];
//    button.titleLabel.textAlignment =NSTextAlignmentRight;
//    [button setTitleColor:COLOR_HEX(0X02B7E6) forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(showUp:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:button];
    return nil;
}
//-(void)showUp:(UIButton *)button
//{
//    SystemMessageModel * model =self.dataAry[button.tag];
//    if ([model.isOpen isEqualToString:@"1"])
//    {
//        model.isOpen =@"0";
//    }
//    else
//    {
//        model.isOpen =@"1";
//    }
//    [self.tableView reloadData];
//}
-(void)endRefresh
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
-(void)postdata
{
    self.page = 1;
    [self.dataAry removeAllObjects];
    [self refreshPostData];
}
-(void)refreshPostData
{
//    WS(weakSelf);
//    NSDictionary * param =@{@"pageRow":@"99",@"pageNum":[NSString stringWithFormat:@"%ld",(long)self.page],@"type":@"2"};
//    [RequestHelp POST:SELECT_PUSH_RECORD_URL parameters:param success:^(id result) {
//        DLog(@"%@",result);
//        [weakSelf.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[SystemMessageModel class] json:result[@"list"]]];
//         [self setupNotData];
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//        
//    }];
}
- (void)setupNotData
{
    //加载背景
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"无数据"];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
@end
