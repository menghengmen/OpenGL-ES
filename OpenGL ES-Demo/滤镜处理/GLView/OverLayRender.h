//
//  OverLayRender.h
//  LearnOpenGLES
//
//  Created by 哈哈 on 2021/3/11.
//  Copyright © 2021 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OverLayRender : NSObject{
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

@property (nonatomic , strong) EAGLContext* myContext;
@property (nonatomic , strong) CAEAGLLayer* myEagLayer;

@property (nonatomic, assign) CGFloat temperature1;
@property (nonatomic, assign) CGFloat saturation1;


-(instancetype)initWith:(EAGLContext *)context myEagLayer:(CAEAGLLayer *)myEagLayer;

-(void)drawWidth:(int)width height:(int)height;

- (void)layoutGLViewWithImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
