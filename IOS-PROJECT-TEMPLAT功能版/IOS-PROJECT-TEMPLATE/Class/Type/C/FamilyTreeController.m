//
//  FamilyTreeController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/7.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "FamilyTreeController.h"
#import "FamilyTreeCell.h"
#import "FamilyLineController.h"
#import "SJActionSheet.h"
#import "FamilyMemberInfoController.h"
#import "AddNewMemberController.h"
#import "MemberDetailController.h"
#import "FamilyTreeModel.h"
@interface FamilyTreeController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,FamilyCellClickDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;

@end

@implementation FamilyTreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"族谱"];
    [self addNavigationItemWithTitle:@"look" itemType:kNavigationItemTypeRight action:@selector(llook)];
    [self.view addSubview:self.tableView];
    [self regisNib];
    [self postDate];
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self postDate];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page = self.page + 1;
        [self refreshPostData];
        
    }];
    // Do any additional setup after loading the view from its nib.
}
-(void)llook
{
    FamilyLineController * fvc =[FamilyLineController new];
    fvc.dataAry =self.dataAry;
    [self.navigationController pushViewController:fvc animated:YES];
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-K_NaviHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource =self;
        _tableView.emptyDataSetDelegate=self;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
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
       [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FamilyTreeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([FamilyTreeCell class])];
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
    
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FamilyTreeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FamilyTreeCell class]) forIndexPath:indexPath];
    FamilyTreeModel *model =self.dataAry[indexPath.row];
    [cell setCell:model.list index:indexPath.row];
    cell.delegate=self;
    cell.selectionStyle  =UITableViewCellSeparatorStyleNone;
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

-(void)familyBtnClick:(FamliyTreeButton *)button
{
    FamilyTreeModel *model =self.dataAry[button.row];
    FamilyTreeMember * member=(FamilyTreeMember*)model.list[button.tag];
    SJActionSheet *actionSheet = [[SJActionSheet alloc] initSheetWithTitle:nil style:SJSheetStyleDefault itemTitles:@[@"查看成员信息",@"编辑成员信息",@"添加上一代",@"添加下一代",@"删除"]];
    actionSheet.itemTextFont =MKFont(13);
    actionSheet.cancelTextFont =MKFont(13);
    actionSheet.cancleTextColor=K_PROJECT_GARYTEXTCOLOR;
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        NSString *text = [NSString stringWithFormat:@"第%ld行,%@",index, title];
        if (index == 0) {
            MemberDetailController * dc =[[MemberDetailController alloc]init];
            [self.navigationController pushViewController:dc animated:YES];
        }
        if (index==1) {
            AddNewMemberController * fvc =[[AddNewMemberController alloc]init];
            fvc.member =member;
            fvc.type =@"1";
            [self.navigationController pushViewController:fvc animated:YES];
        }
        if (index == 2) {
            AddNewMemberController * fvc =[[AddNewMemberController alloc]init];
            fvc.member =member;
            fvc.type =@"2";
            [self.navigationController pushViewController:fvc animated:YES];
        }
        if (index == 3) {
            AddNewMemberController * fvc =[[AddNewMemberController alloc]init];
            fvc.member =member;
            fvc.type =@"3";
            [self.navigationController pushViewController:fvc animated:YES];
        }
        if (index == 4) {
          
        }
        MKLog(@"%@",text);
    }];
}

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
        NSDictionary * param =@{@"jzId":model.jzId,@"spouseId":@"1",@"firstGeneration":@"1"};
        [RequestHelp POST:JS_SELECT_ZPLIST_URL parameters:param success:^(id result) {
            DLog(@"%@",result);
            [self.dataAry addObjectsFromArray:[NSArray yy_modelArrayWithClass:[FamilyTreeModel class] json:result]];
            [self.tableView reloadData];
            [self endRefresh];
        } failure:^(NSError *error) {
            [self endRefresh];
        }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
  
}

@end
