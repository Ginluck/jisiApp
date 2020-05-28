//
//  AddNewMemberController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/9.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "AddNewMemberController.h"
#import "UITextView+WJPlaceholder.h"
#import "ValuePickerView.h"
#import "LYSDatePickerController.h"
@interface AddNewMemberController ()<LYSDatePickerSelectDelegate>
@property(nonatomic,weak)IBOutlet UITextField * nameTF;
@property(nonatomic,weak)IBOutlet UIButton * sexBtn;
@property(nonatomic,strong) NSString * sexValue;
@property(nonatomic,weak)IBOutlet UIButton * stateBtn;
@property(nonatomic,strong) NSString * stateValue;
@property(nonatomic,weak)IBOutlet UIButton * birthBtn;
@property(nonatomic,strong) NSString * birth;
@property(nonatomic,weak)IBOutlet UIButton * deathBtn;
@property(nonatomic,strong) NSString * death;
@property(nonatomic,weak)IBOutlet UITextView * indtroduceTV;
@property(nonatomic,strong)ValuePickerView *pickerView ;
@property(nonatomic,strong) NSDate *currentDate;
@end

@implementation AddNewMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavigationTitleView:@"添加成员"];
    [self setUICompoents];
}
-(ValuePickerView*)pickerView
{
    if (!_pickerView) {
        _pickerView =[ValuePickerView new];
    }
    return _pickerView;
}
-(void)setUICompoents
{
    self.indtroduceTV.placeholdFont =MKFont(13);
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate  * date =[NSDate date];
    _currentDate =date;
}


-(IBAction)btnClick:(UIButton*)sender
{
    switch (sender.tag) {
        case 10:
        {
            WS(weakSelf);
            self.pickerView.pickerTitle =@"选择性别";
            self.pickerView.dataSource=@[@"男",@"女"];
            [self.pickerView show];
            self.pickerView.valueDidSelect = ^(NSString *value){
                [weakSelf.sexBtn setTitle:value forState:UIControlStateNormal];
                weakSelf.sexValue =[NSString stringWithFormat:@"%lu",(unsigned long)[weakSelf.pickerView.dataSource indexOfObject:value]];
            };
        }
            break;
        case 11:
        {
               WS(weakSelf);
            self.pickerView.pickerTitle =@"选择在世状态";
            self.pickerView.dataSource=@[@"在世",@"离世"];
            [self.pickerView show];
            self.pickerView.valueDidSelect = ^(NSString *value){
                [weakSelf.stateBtn setTitle:value forState:UIControlStateNormal];
                weakSelf.stateValue =[NSString stringWithFormat:@"%lu",(unsigned long)[weakSelf.pickerView.dataSource indexOfObject:value]];
            };
        }
            break;
        case 12:
        {
            WS(weakSelf);
            [LYSDatePickerController alertDatePickerInWindowRootVCWithType:(LYSDatePickerTypeDay) selectDate:_currentDate];
            [LYSDatePickerController customPickerDelegate:self];
            [LYSDatePickerController customdidSelectDatePicker:^(NSDate *date) {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
                weakSelf.currentDate = date;
                [sender setTitle:[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]] forState:UIControlStateNormal];
                weakSelf.birth =[dateFormat stringFromDate:date];
            }];
        }
            break;
        case 13:
        {
            WS(weakSelf);
            [LYSDatePickerController alertDatePickerInWindowRootVCWithType:(LYSDatePickerTypeDay) selectDate:_currentDate];
            [LYSDatePickerController customPickerDelegate:self];
            [LYSDatePickerController customdidSelectDatePicker:^(NSDate *date) {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
                weakSelf.currentDate = date;
                [sender setTitle:[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]] forState:UIControlStateNormal];
                weakSelf.death =[dateFormat stringFromDate:date];
            }];
        }
            break;
            
        default:
            break;
    }
}



-(IBAction)commitClick:(id)sender
{
    NSMutableDictionary * param =[NSMutableDictionary dictionary];
    if (!self.nameTF.text.length)
    {
        ShowMessage(@"请输入姓名");return;
    }
    else
    {
        [param setValue:self.nameTF.text forKey:@"name"];
    }
    if (!self.sexValue.length)
    {
         ShowMessage(@"请选择性别");return;
    }
    else
    {
        [param setValue:self.sexValue forKey:@"sex"];
    }
    if (!self.stateValue.length)
    {
        ShowMessage(@"请选择在世状态");return;
    }
    else
    {
        [param setValue:self.stateValue forKey:@"state"];
    }
    if (!self.birth.length)
    {
        ShowMessage(@"请选择出生日期");return;
    }
    else
    {
        [param setValue:self.birth forKey:@"birthTime"];
    }
    if (!self.indtroduceTV.text.length)
    {
        ShowMessage(@"请输入个人简介");return;
    }
    else
    {
        [param setValue:self.indtroduceTV.text forKey:@"introduce"];
    }
    if ([self.stateValue isEqualToString:@"1"])
    {
        if (!self.death.length)
        {
            ShowMessage(@"请选择离世日期");return;
        }
        else
        {
            [param setValue:self.death forKey:@"deathTime"];
        }

    }

    if ([self.type isEqualToString:@"1"])
    {
        [param setValue:self.member.id forKey:@"id"];
        [param setValue:self.member.jzId forKey:@"jzId"];
        [RequestHelp POST:JS_UPDATE_MEMBER_URL parameters:param success:^(id result) {
            MKLog(@"%@",result);
            ShowMessage(@"操作成功");
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {}];
    }
    else if ([self.type isEqualToString:@"2"])
    {
        [param setValue:@"0" forKey:@"type"];
        [param setValue:self.member.id forKey:@"coverId"];
        [param setValue:self.member.jzId forKey:@"jzId"];
        [RequestHelp POST:JS_ADD_NEWMEMBER_URL parameters:param success:^(id result) {
            MKLog(@"%@",result);
            ShowMessage(@"操作成功");
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {}];
    }
    else if ([self.type isEqualToString:@"3"])
    {
        [param setValue:@"1" forKey:@"type"];
        [param setValue:self.member.id forKey:@"coverId"];
        [param setValue:self.member.jzId forKey:@"jzId"];
        [RequestHelp POST:JS_ADD_NEWMEMBER_URL parameters:param success:^(id result) {
            MKLog(@"%@",result);
            ShowMessage(@"操作成功");
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {}];
    }
    

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
