//
//  SetHeadViewController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/13.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "SetHeadViewController.h"
#import "MyIntroductionViewController.h"
#import "SheZhiNameViewController.h"
#import "GusetChooseCityView.h"
@interface SetHeadViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImagePickerController *imagePickerVC;
@property(nonatomic,strong)GusetChooseCityView *GCCView;
@property(nonatomic,strong)UIView *BackGroundView;
@end

@implementation SetHeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetBackGroundView];
    // Do any additional setup after loading the view from its nib.
}
-(void)GetBackGroundView
{
    _BackGroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
           _BackGroundView.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [[[UIApplication sharedApplication]keyWindow]addSubview:self.BackGroundView];
           UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
           btn.frame =CGRectMake(0, 0, Screen_Width, Screen_Height);
           btn.backgroundColor =[UIColor clearColor];
           [btn addTarget:self action:@selector(removeBtnClick) forControlEvents:UIControlEventTouchUpInside];
           [_BackGroundView addSubview:btn];
           _BackGroundView.hidden=YES;
    _GCCView=[[NSBundle mainBundle]loadNibNamed:@"GusetChooseCityView" owner:nil options:nil][0];
          [_GCCView.CencelBtn addTarget:self action:@selector(removeBtnClick) forControlEvents:UIControlEventTouchUpInside];
          _GCCView.frame=CGRectMake(0, Screen_Height, Screen_Width, 0);
          [_BackGroundView addSubview:_GCCView];
}
- (IBAction)Click:(UIButton *)sender {
     WS(weakSelf);
    switch (sender.tag) {
        case 100:
        {UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"选择图片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self selectImageFromCamera];
            }];
            
            UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self selectImageFromAlbum];
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertVc addAction:cameraAction];
            [alertVc addAction:photoAction];
            [alertVc addAction:cancelAction];
            [self presentViewController:alertVc animated:YES completion:nil];
              
        }
            break;
            case 101:
            {
                SheZhiNameViewController *SZNVC=[SheZhiNameViewController new];
                [self.navigationController pushViewController:SZNVC animated:YES];
            }
                break;
            case 102:
            {
                              self.editing =YES;
                              self.BackGroundView.hidden=NO;
                              self.GCCView.hidden=NO;
                              [UIView animateWithDuration:0.5 animations:^{
                                  self.GCCView.frame = CGRectMake(0,Screen_Height-(Screen_Height-kNavagationBarH-kBottomLayout)/2-50, Screen_Width,(Screen_Height-kNavagationBarH-kBottomLayout)/2+50);
                                  
                              }];
                              self.GCCView.CMBlock = ^(NSString * _Nonnull shengId, NSString * _Nonnull shengName, NSString * _Nonnull shiId, NSString * _Nonnull shiName, NSString * _Nonnull xianId, NSString * _Nonnull xianName) {
               //                           [weakSelf.GetDataDic setObject:shengId forKey:@"provinceId"];
               //                           [weakSelf.GetDataDic setObject:shiId forKey:@"cityId"];
               //                           [weakSelf.GetDataDic setObject:xianId forKey:@"areaId"];
               //                          [sender setTitle:[NSString stringWithFormat:@"%@%@%@",shengName,shiName,xianName] forState:UIControlStateNormal];
               //                   [sender setTitleColor:COLOR_HEX(0x666666) forState:UIControlStateNormal];
                                        [weakSelf removeBtnClick];
                                      };

            }
                break;
            case 103:
            {
                MyIntroductionViewController *SZNVC=[MyIntroductionViewController new];
                [self.navigationController pushViewController:SZNVC animated:YES];
            }
                break;
            
        default:
            break;
    }
}
#pragma mark 拍摄
-(void)selectImageFromCamera{
    //2
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 设置资源来源
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置可用的媒体类型、默认只包含kUTTypeImage，如果想选择视频，请添加kUTTypeMovie
        self.imagePickerVC.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
        
        // 如果选择的是视屏，允许的视屏时长为20秒
        self.imagePickerVC.videoMaximumDuration = 20;
        // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
        self.imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
        // 相机获取媒体的类型（照相、录制视屏）
        self.imagePickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        // 使用前置还是后置摄像头
        self.imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 是否看起闪光灯
        self.imagePickerVC.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        // 设置是否显示系统的相机页面
        self.imagePickerVC.showsCameraControls = YES;
        // model出控制器
        [self presentViewController:self.imagePickerVC animated:YES completion:nil];
    }
}
- (void)selectImageFromAlbum{
    //6
    // 判断当前的sourceType是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        // 设置资源来源（相册、相机、图库之一）
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置可用的媒体类型、默认只包含kUTTypeImage，如果想选择视频，请添加kUTTypeMovie
        // 如果选择的是视屏，允许的视屏时长为20秒
        self.imagePickerVC.videoMaximumDuration = 20;
        // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
        self.imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
        self.imagePickerVC.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
        // model出控制器
        [self presentViewController:self.imagePickerVC animated:YES completion:nil];
    }
}
// 选择图片成功调用此方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //3
    [self dismissViewControllerAnimated:YES completion:nil];
    //如果是拍照
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    /***
     */
    [self uploadImage:image];
    if(picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary){
        
    }else{
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
//保存图片到本地相册
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    //4
    if (error == nil) {
        NSLog(@"成功");
    }
    else{
        NSLog(@"失败");
    }
}

// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //5
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)uploadImage:(UIImage * )image
{
    ShowMaskStatus(@"正在上传");
    NSData * data =UIImagePNGRepresentation(image);
    [RequestHelp uploadPhotoData:data success:^(id result) {
        DLog(@"%@",result);
        DismissHud();
//        if ([self.imgIndex isEqualToString:@"1"]) {
//            [self.Btn1 sd_setBackgroundImageWithURL:result[@"url"] forState:UIControlStateNormal];
//            [self.ImgDic setObject:result[@"url"] forKey:@"image1"];
//        }
       
    } failure:^(NSError *error) {
        DismissHud();
    }];
}
-(void)removeBtnClick
{
    [UIView animateWithDuration:0.5 animations:^{
        self.BackGroundView.hidden=YES;
         self.GCCView.frame =CGRectMake(0,Screen_Height, Screen_Width, 0);
    }];
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
