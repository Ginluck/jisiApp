//
//  BuyJPView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/25.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "BuyJPView.h"
@interface BuyJPView()
@property(nonatomic,weak)IBOutlet UIImageView *JPImage;
@property(nonatomic,weak)IBOutlet UILabel *JPName;
@property(nonatomic,weak)IBOutlet UILabel *JPPrice;
@property(nonatomic,weak)IBOutlet UILabel *JPYuYi;
@property(nonatomic,weak)IBOutlet UILabel *JPTime;
@property(nonatomic,weak)IBOutlet UITextField *JPCount;

@end
@implementation BuyJPView

-(IBAction)btnClick:(UIButton *)sender
{
    NSString * text  =self.JPCount.text ;
    NSInteger value = [text integerValue];
    if (sender.tag==10)
    {
        value =value -1;
        if (value<0)
        {
            value =0;
        }
    }
    else
    {
        value =value+1;
    }
    self.JPCount.text =[NSString stringWithFormat:@"%ld",(long)value];
}


-(IBAction)actionClick:(UIButton *)sender
{
    if (self.delegate) {
        [self.delegate buyViewDelegate:sender value:self.JPCount.text];
    }
}

-(void)refreshUI:(JipinChild *)model
{
    [self.JPImage sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    self.JPName.text =model.name;
    self.JPPrice.text =model.price;
    self.JPTime.text =[NSString stringWithFormat:@"时间:%@小时",model.useLength];
    self.JPYuYi.text =[NSString stringWithFormat:@"寓意:%@",model.moral];
    
}
@end
