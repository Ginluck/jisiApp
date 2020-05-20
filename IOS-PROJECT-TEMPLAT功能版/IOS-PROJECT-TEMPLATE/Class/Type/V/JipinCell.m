//
//  JipinCell.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/12.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "JipinCell.h"
#import "JipinView.h"
@implementation JipinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCell:(NSInteger)count
{
    UIScrollView * scroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width/4+35)];
    scroll.contentSize =CGSizeMake(Screen_Width/4*count+20, 0);
    scroll.contentOffset =CGPointMake(0, 0);
    scroll.showsHorizontalScrollIndicator=NO;
    [self.contentView addSubview:scroll];
    
    UIImageView * image =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width/4*count+20,  Screen_Width/4+35)];
    image.image =KImageNamed(@"木材");
    [scroll addSubview:image];
    
    for (int i=0; i<count; i++)
    {
        JipinView * jipin =[[JipinView alloc]initWithFrame:CGRectMake(i*Screen_Width/4, 0, Screen_Width/4, Screen_Width/4+35)];
        
        jipin.proImage.image =KImageNamed(@"商品占位图");
        jipin.topLab.text =[NSString stringWithFormat:@"商品%d",i];
        jipin.bottomLab.text =@"$123";
         [scroll addSubview:jipin];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
