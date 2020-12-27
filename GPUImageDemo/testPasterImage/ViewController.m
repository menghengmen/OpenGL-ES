//
//  ViewController.m
//  testPasterImage
//
//  Created by 王迎博 on 16/9/5.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "ViewController.h"
#import "YBPasterImageVC.h"
#import "UIViewController+Swizzling.h"
#import "FWButton.h"
#import "GPUImageCameraViewController.h"
#define kPadding     10
#define kBigPadding  30
#define kWidth       103
#define kHeight      105
#define kArrowWidth  30
#define kArrowHeight 50
#define kLogoWidth  250
#define kLogoHeight 79
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *imagePicker;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES] ;
    [[UIApplication sharedApplication] setStatusBarHidden:YES] ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUi];
}

-(void)configUi{
    NSArray *imageViewImageArr = [NSArray arrayWithObjects:
                                  @"icon_home_beauty",
                                  @"icon_home_camera" ,
                                  nil];
    NSArray *textArr = [NSArray arrayWithObjects:@"美化图片", @"万能相机", nil];
    
    FWButton *btnHome = nil;
    CGFloat padding = 0;
    if (WIDTH == 320)
        padding = kPadding;
    else
        padding = kBigPadding;
    
    CGFloat startX = WIDTH /  2 - padding / 2 - kWidth;
    CGFloat startY = HEIGHT / 2 - padding - kHeight / 2 - kHeight -  61;
    for (int i = 0; i < 2; i++) {
        NSInteger row  = i % 2;
        NSInteger col  = i / 2;
        NSInteger page = i / 6;
        
        if (col == 3) {
            col = 0;
        }
        
        btnHome = [FWButton button];
        [btnHome setTitle:[textArr objectAtIndex:i] forState:UIControlStateNormal];
        [btnHome setImage:[UIImage imageNamed:[imageViewImageArr objectAtIndex:i]] forState:UIControlStateNormal];
        btnHome.cornerRadius = 56;
        btnHome.clipsToBounds = YES;
        if (i == 0) {
            btnHome.backgroundColor = [UIColor orangeColor];

        } else {
            btnHome.backgroundColor = [UIColor purpleColor];

        }
        btnHome.frame = CGRectMake(row * (kWidth + padding) + page * WIDTH + startX, col * (kHeight + padding) + startY, kWidth, kHeight);
        [btnHome.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [btnHome addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btnHome.topPading = 0.5;
        [self.view addSubview:btnHome];
    }
    
}

#pragma mark action
-(void)btnClicked:(UIButton*)sender{
    if ([[(UIButton *)sender titleLabel].text isEqualToString:@"美化图片"]) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            imagePicker = [[UIImagePickerController alloc] init];
            
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                        [self presentViewController:imagePicker animated:NO completion:^{
                [[UIApplication sharedApplication] setStatusBarHidden:YES];

            }
             ];
        }
    } else {
        [self.navigationController pushViewController:[GPUImageCameraViewController new] animated:YES];

        
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    YBPasterImageVC *pasterVC = [[YBPasterImageVC alloc]init];
    pasterVC.originalImage = selectedImage;
    [self.navigationController pushViewController:pasterVC animated:YES];

    [self dismissViewControllerAnimated:NO completion:^{
       
    }];
 
}

@end
