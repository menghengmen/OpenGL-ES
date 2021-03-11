//
//  GLContainerView.h
//  OpenGLESDemo
//
//  Created by Yue on 17/1/16.
//  Copyright © 2017年 Yue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLContainerView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGFloat  colorTempValue;
@property (nonatomic, assign) CGFloat  saturationValue;

@end
