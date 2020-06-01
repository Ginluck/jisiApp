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
@interface WorshipController ()
@property(nonatomic,strong)UIImageView * backImage;
@property(nonatomic,strong)CitangDetailModel * DetailModel;
@end

@implementation WorshipController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self reloadUICompoents];
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

-(void)requestData
{
    [RequestHelp POST:JS_CITANG_DETAIL_URL parameters:@{@"id":self.model.id} success:^(id result) {
        self.DetailModel =[CitangDetailModel yy_modelWithJSON:result];
      
    } failure:^(NSError *error) {
        
    }];
}

-(void)refreshPaiWei
{
    
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
