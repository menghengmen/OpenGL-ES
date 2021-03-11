//
//  GLView.h
//  OpenGLESDemo
//
//  Created by Yue on 17/1/13.
//  Copyright © 2017年 Yue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLView : UIView
{
    CAEAGLLayer *_eaglLayer;
    EAGLContext *_context;
    GLuint       _framebuffer;
    GLuint       _renderbuffer;

    GLuint       _texture;
    
    GLuint       _tempFramebuffer;
    GLuint       _tempTexture;
    GLuint       _tempRenderBuffer;
    
    GLuint       _programHandle;
    GLuint       _tempProgramHandle;

}

@property (nonatomic, assign) CGFloat temperature;
@property (nonatomic, assign) CGFloat saturation;

- (void)layoutGLViewWithImage:(UIImage *)image;

@end
