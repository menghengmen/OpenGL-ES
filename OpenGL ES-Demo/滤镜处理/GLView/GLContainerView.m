//
//  GLContainerView.m
//  OpenGLESDemo
//
//  Created by Yue on 17/1/16.
//  Copyright © 2017年 Yue. All rights reserved.
//

#import "GLContainerView.h"
#import <AVFoundation/AVFoundation.h>
#import "GLView.h"

@interface GLContainerView()

@property (nonatomic, strong) GLView *glView;

@end

@implementation GLContainerView

#pragma mark - Life Cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupGLView];
}

#pragma mark - Setup
- (void)setupGLView {
    self.glView = [[GLView alloc] initWithFrame:self.bounds];
    [self addSubview:self.glView];
}

#pragma mark - Private
- (void)layoutGlkView {
    CGSize imageSize = self.image.size;
    CGRect frame = AVMakeRectWithAspectRatioInsideRect(imageSize, self.bounds);
    self.glView.frame = frame;
    self.glView.contentScaleFactor = imageSize.width / frame.size.width;
}

#pragma mark - Public
- (void)setImage:(UIImage *)image {
    _image = image;
    [self layoutGlkView];
    [self.glView layoutGLViewWithImage:_image];
}

- (void)setColorTempValue:(CGFloat)colorTempValue {
    _colorTempValue = colorTempValue;
    self.glView.temperature = colorTempValue;
}

- (void)setSaturationValue:(CGFloat)saturationValue {
    _saturationValue = saturationValue;
    self.glView.saturation = saturationValue;
}


@end
