//
//  WorshipController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/29.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "WorshipController.h"
#import "AddPersonCitangController.h"
#import "AddFamilyCitangController.h"
#import "JisiProController.h"
#import "CitangDetailModel.h"
#import "NSString+Fit.h"
#import "ImageBigger.h"
@interface WorshipController ()
@property(nonatomic,strong)UIImageView * backImage;
@property(nonatomic,strong)CitangDetailModel * DetailModel;
@property(nonatomic,strong)UIImageView * jisiImage;
@end

@implementation WorshipController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self reloadUICompoents];
    [self requestData];
}


-(void)reloadUICompoents
{
    [self addNavigationItemWithTitle:@"修改" itemType:kNavigationItemTypeRight action:@selector(updateClick)];
    [self.view addSubview:self.backImage];
    
    
    UIButton * btn_1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_1 setNormalTitle:@"点长明灯" font:MKFont(15) titleColor:[UIColor whiteColor]];
    btn_1.backgroundColor =K_Prokect_MainColor;
    btn_1.frame =CGRectMake(30, Screen_Height-60, Screen_Width/2-40, 40);
    btn_1.layer.cornerRadius =4.f;
    btn_1.layer.masksToBounds =YES;
    [self.view addSubview:btn_1];
    
    UIButton * btn_2 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_2 setNormalTitle:@"我要祭拜" font:MKFont(15) titleColor:[UIColor whiteColor]];
    btn_2.backgroundColor =K_Prokect_MainColor;
    btn_2.frame =CGRectMake(Screen_Width/2+10, Screen_Height-60, Screen_Width/2-40, 40);
    btn_2.layer.cornerRadius =4.f;
    btn_2.layer.masksToBounds =YES;
    [btn_2 addTarget:self action:@selector(buyProClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_2];
    
//
//    CGFloat image_Width =245*Screen_Width /1080;
//    CGFloat image_Height =310*(Screen_Height-K_NaviHeight)/1560;
    
//    UIImageView * image =[[UIImageView alloc]initWithImage:KImageNamed(@"背景1")];
//    image.bounds =CGRectMake(0, 0, image_Width, image_Height);
//    image.center =CGPointMake(Screen_Width/2,K_NaviHeight+(Screen_Height-K_NaviHeight)/(1560/113)+image_Height/2);
//    [self.view addSubview:image];
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"发光gif" ofType:@"gif"];
//    NSData *gifData = [NSData dataWithContentsOfFile:path];
//    UIWebView *webView  = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
//    webView.center =CGPointMake(Screen_Width/2, 200);
//    webView.scalesPageToFit = YES;
//    [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    webView.backgroundColor = [UIColor clearColor];
//    webView.opaque = NO;
//    [self.view addSubview:webView];
    [self showGifByImageView];
}
- (void)showGifByImageView {
    NSURL *gifUrl = [[NSBundle mainBundle] URLForResource:@"发光gif" withExtension:@"gif"];
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)gifUrl, NULL);
    size_t imageCount = CGImageSourceGetCount(gifSource);
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (size_t i = 0; i < imageCount; i++) {
        //获取源图片
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [mutableArray addObject:image];
        CGImageRelease(imageRef);
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    imageView.center =CGPointMake(Screen_Width/2, 200);
    imageView.animationImages = mutableArray;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.animationDuration = 2;
    [imageView startAnimating];
    [self.view addSubview:imageView];
    CFRelease(gifSource);
}
-(UIImageView *)backImage
{
    if (!_backImage) {
        _backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-K_NaviHeight)];
        _backImage .image =KImageNamed(@"背景1");
    }
    return _backImage;
}

-(void)requestData
{
    [RequestHelp POST:JS_CITANG_DETAIL_URL parameters:@{@"id":self.model.id} success:^(id result) {
        MKLog(@"%@",result);
        self.DetailModel =[CitangDetailModel yy_modelWithJSON:result];
        for (int i=0; i<self.DetailModel.zpList2.count; i++)
        {
            FamilyTreeModel * model=self.DetailModel.zpList2[i];
            model.lisCount= [NSString stringWithFormat:@"%ld",model.list.count];
        }
        [self refreshPaiWei];
    } failure:^(NSError *error) {
        
    }];
}
-(void)updateClick
{
    if ([self.model.type isEqualToString:@"1"])
    {
        AddPersonCitangController * avc =[AddPersonCitangController new];
        avc.model =self.model;
        [self.navigationController pushViewController:avc animated:YES];
    }
    else if ([self.model.type isEqualToString:@"2"])
    {
        AddFamilyCitangController * avc =[AddFamilyCitangController new];
        avc.model=self.model;
        [self.navigationController pushViewController:avc animated:YES];
    }
}


-(void)buyProClick
{
    JisiProController * jvc =[JisiProController new];
    jvc.model=self.model;
    [self.navigationController pushViewController:jvc animated:YES];
}


-(void)refreshPaiWei
{
    NSMutableArray * countArr =[NSMutableArray array];
    
    for (int i=0; i<self.DetailModel.zpList2.count; i++)
    {
        FamilyTreeModel * model=self.DetailModel.zpList2[i];
        
        [countArr addObject:model.lisCount];
    }
    CGFloat width =40.f;
    
    CGFloat height =64.f;
    
    CGFloat  margin_y =20;
    
    CGFloat Margin_x =(Screen_Width -8*width)/9;
    
    
    UIView * bgView =[[UIView alloc]initWithFrame:CGRectMake(0, K_NaviHeight, Screen_Width, Screen_Height-K_NaviHeight)];
   
    UIScrollView * scView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(bgView.frame))];
    [bgView addSubview:scView];
    
    for (int i=0; i<self.DetailModel.zpList2.count; i++)
    {
        FamilyTreeModel * model =self.DetailModel.zpList2[i];
        
        for (int j=0; j<model.list.count;j++)
        {
            FamilyTreeMember * member =model.list[j];
            if ([model.lisCount isEqualToString:@"1"])
            {
                UIButton * button =[UIButton new];
                button.frame =CGRectMake(0, 0, width, height);
//                [button setBackgroundImage:KImageNamed(@"牌位1") forState:UIControlStateNormal];
                button.backgroundColor =[UIColor redColor];
                [button setNormalTitle:member.name font:MKFont(20) titleColor:[UIColor whiteColor]];
                button.titleLabel.numberOfLines =0;
                button.titleLabel.textAlignment =NSTextAlignmentCenter;
//                button.contentMode =UIViewContentModeScaleAspectFill;
                button.center= CGPointMake(Screen_Width/2, margin_y+height/2);
                [scView addSubview:button];
            }
            if ([model.lisCount integerValue]>1 &&[model.lisCount integerValue]<9)
            {
            
                 Margin_x =(Screen_Width -[model.lisCount integerValue]*width)/([model.lisCount integerValue]+1);
                UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
                button.frame =CGRectMake(Margin_x +(width +Margin_x)*j, margin_y+(height +margin_y)*i, width, height);
                  [button setBackgroundImage:KImageNamed(@"牌位1") forState:UIControlStateNormal];
                 [button setNormalTitle:member.name font:MKFont(24) titleColor:[UIColor whiteColor]];
                button.titleLabel.numberOfLines =0;
               
                 button.titleLabel.textAlignment =NSTextAlignmentCenter;
                [scView addSubview:button];
            }
            else if ([model.lisCount integerValue]>8)
            {
                Margin_x =(Screen_Width -8*width)/9;
                UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
                button.frame =CGRectMake(Margin_x +(width +Margin_x)*j, margin_y+(height +margin_y)*i, width, height);
                  [button setBackgroundImage:KImageNamed(@"牌位1") forState:UIControlStateNormal];
                  [button setNormalTitle:member.name font:MKFont(24) titleColor:[UIColor whiteColor]];
                button.titleLabel.numberOfLines =0;
                 button.titleLabel.textAlignment =NSTextAlignmentCenter;
              
                scView.contentSize =CGSizeMake(Margin_x+(width+Margin_x)*[model.lisCount integerValue], 0);
                [scView addSubview:button];
            }
        }
    }
//    [self.view addSubview:bgView];
        CGFloat image_Width =245*Screen_Width /1080;
        CGFloat image_Height =310*(Screen_Height-K_NaviHeight)/1560;

        UIImageView * image =[[UIImageView alloc]initWithImage:[self shotShareImage:bgView]];
        image.bounds =CGRectMake(0, 0, image_Width, image_Height);
        image.center =CGPointMake(Screen_Width/2,K_NaviHeight+(Screen_Height-K_NaviHeight)/(1560/113)+image_Height/2);
         image.userInteractionEnabled = YES;

        [self.view addSubview:image];
        _jisiImage =image;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage)];
    [image addGestureRecognizer:tap];

}
-(void)magnifyImage
{
    [ImageBigger showImage:_jisiImage];
}
- (UIImage *)shotShareImage:(UIView * )bgView {
    //模糊方法
//    UIGraphicsBeginImageContext(CGSizeMake(self.layer.bounds.size.width, self.layer.bounds.size.height));
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self.layer renderInContext:context];
//    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return tImage;
    
    //高清方法
    //第一个参数表示区域大小 第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    CGSize size = CGSizeMake(Screen_Width, Screen_Height-K_NaviHeight);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [bgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
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
