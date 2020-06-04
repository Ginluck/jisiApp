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
#import <AVFoundation/AVFoundation.h> //音频视频框架
#import "JisiProController.h"
#import "AddPersonCitangController.h"
#import "AddFamilyCitangController.h"
#import "WorshipController.h"
#import "SJActionSheet.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray  * dataAry ;
@property(nonatomic,assign)NSInteger  page;
@property(nonatomic,strong)HomeTableHeaderView  * headerView;
@property(nonatomic,strong)AVAudioPlayer *player;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitleView:@"祠堂"];
    [self addNavigationItemWithImageName:@"音乐图标" itemType:kNavigationItemTypeLeft action:@selector(soundClick)];
    [self.view addSubview:self.tableView];
    [self regisNib];
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self postDate];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page = self.page + 1;
        [self refreshPostData];
        
    }];
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(Screen_Width-50, Screen_Height-K_BottomHeight-85, 30, 30);
    [button setImage:KImageNamed(@"add1") forState:UIControlStateNormal];
    button.backgroundColor =[UIColor whiteColor];
    button.layer.cornerRadius =15.f;
    button.layer.masksToBounds=YES;
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //     Do any additional setup after loading the view from its nib.
}

-(void)click
{
    SJActionSheet *actionSheet = [[SJActionSheet alloc] initSheetWithTitle:nil style:SJSheetStyleDefault itemTitles:@[@"创建个人祠堂",@"创建家族私人祠堂"]];
    actionSheet.itemTextFont =MKFont(13);
    actionSheet.cancelTextFont =MKFont(13);
    actionSheet.itemTextColor =K_Prokect_MainColor;
    actionSheet.cancleTextColor=K_PROJECT_GARYTEXTCOLOR;
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        if ([title isEqualToString:@"创建个人祠堂"])
        {
            AddPersonCitangController * avc =[AddPersonCitangController new];
            avc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:avc animated:YES];
        }
        else if ([title isEqualToString:@"创建家族私人祠堂"])
        {
            AddFamilyCitangController * avc =[AddFamilyCitangController new];
            avc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:avc animated:YES];
        }
    }];
//    //显示弹出框列表选择
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"创建祠堂"
//                                                                   message:nil
//                                                            preferredStyle:UIAlertControllerStyleActionSheet];
//
//    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
//                                                         handler:^(UIAlertAction * action) {
//                                                             //响应事件
//                                                             NSLog(@"action = %@", action);
//                                                         }];
//    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"新增个人祠堂" style:UIAlertActionStyleDestructive
//                                                         handler:^(UIAlertAction * action) {
//                                                             //响应事件
//                                                             AddPersonCitangController * avc =[AddPersonCitangController new];
//                                                             avc.hidesBottomBarWhenPushed =YES;
//                                                             [self.navigationController pushViewController:avc animated:YES];
//
//                                                         }];
//    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"新增家族祠堂" style:UIAlertActionStyleDefault
//                                                       handler:^(UIAlertAction * action) {
//                                                           //响应事件
//                                                           AddFamilyCitangController * avc =[AddFamilyCitangController new];
//                                                           avc.hidesBottomBarWhenPushed =YES;
//                                                           [self.navigationController pushViewController:avc animated:YES];
//                                                       }];
//    [alert addAction:saveAction];
//    [alert addAction:cancelAction];
//    [alert addAction:deleteAction];
//    [self presentViewController:alert animated:YES completion:nil];
}
-(AVAudioPlayer *)player
{
    if (!_player) {
          NSURL *url = [[NSBundle mainBundle] URLForResource:@"洪真英-活着 (Cheer Up).mp3" withExtension:nil];
        _player =[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    }
    return _player;
}
-(void)soundClick
{
    [self.player prepareToPlay];
    if (self.player.isPlaying) {
        [self.player pause];
    }
    else
    {
        [self.player play];
    }
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
    CitangListModel * model =self.dataAry[indexPath.row];
    WorshipController * jvc  =[WorshipController new];
    jvc.model =model;
    jvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:jvc animated:YES];
    
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
        ShowMessage(@"您暂时还没有加入家族");
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
