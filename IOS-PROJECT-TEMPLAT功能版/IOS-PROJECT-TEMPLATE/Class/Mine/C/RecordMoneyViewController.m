//
//  RecordMoneyViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/6/15.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "RecordMoneyViewController.h"
#import "HongBaoView.h"
#import "CalendarView.h"
@interface RecordMoneyViewController ()
@property(nonatomic,weak)IBOutlet UIView * hongBaoView;
@property(nonatomic,weak)IBOutlet UILabel * moneyLabel;
@property(nonatomic,weak)IBOutlet UILabel * signLabel;

@property(nonatomic,weak)IBOutlet UIView * calendarView;
@property(nonatomic,strong)CalendarView  * cView;
@end

@implementation RecordMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat margin_x =(Screen_Width -256)/7;
    
    NSArray * ary =@[@"3天",@"7天",@"10天",@"15天",@"20天",@"25天"];
    
    for ( int i =0; i<ary.count; i++)
    {
        HongBaoView * hongbao =[[HongBaoView alloc]initWithFrame:CGRectMake(margin_x+(margin_x +40)*i, 10, 70, 40)];
        hongbao.days.text =ary[i];
        [self.hongBaoView addSubview:hongbao];
    }
    [self.calendarView addSubview:self.cView];
}
-(CalendarView *)cView
{
    if (!_cView) {
        _cView =[[CalendarView alloc]initWithFrame:CGRectMake(10, 10, Screen_Width-52, Screen_Width-52)];
        _cView.center =CGPointMake(Screen_Width/2, 170);
    }
    return _cView;
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
