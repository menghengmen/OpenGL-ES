//
//  GLView.m
//  OpenGLESDemo
//
//  Created by Yue on 17/1/13.
//  Copyright © 2017年 Yue. All rights reserved.
//

#import "GLView.h"
#import "OverLayRender.h"
@import OpenGLES;

@interface GLView()

@property (nonatomic,strong) OverLayRender *overRender;

@end


@implementation GLView


#pragma mark - Override
// 想要显示 OpenGL 的内容, 需要把它缺省的 layer 设置为一个特殊的 layer(CAEAGLLayer).
+ (Class)layerClass {
    return [CAEAGLLayer class];
}


- (void)setupData {
    _temperature = 0.5;
    _saturation = 0.5;
}

- (void)setupLayer {
    // 用于显示的layer
    _eaglLayer = (CAEAGLLayer *)self.layer;
    //  CALayer默认是透明的，而透明的层对性能负荷很大。所以将其关闭。
    _eaglLayer.opaque = YES;
}

- (void)setupContext {
    if (!_context) {
        // 创建GL环境上下文
        // EAGLContext 管理所有通过 OpenGL 进行 Draw 的信息.
        _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    NSAssert(_context && [EAGLContext setCurrentContext:_context], @"初始化GL环境失败");
}



#pragma mark - Public 
- (void)layoutGLViewWithImage:(UIImage *)image {
   [self setupLayer];
     [self setupContext];
    self.overRender = [[OverLayRender alloc] initWith:_context myEagLayer:_eaglLayer];
    [self.overRender layoutGLViewWithImage:image];
    //    [self setup];
//    [self setupTextureWithImage:image];
//    [self render];
}

- (void)setTemperature:(CGFloat)temperature {
    _temperature = temperature;
    self.overRender.temperature1 = temperature;
}

- (void)setSaturation:(CGFloat)saturation {
    _saturation = saturation;
    self.overRender.saturation1 = saturation;

}

@end
