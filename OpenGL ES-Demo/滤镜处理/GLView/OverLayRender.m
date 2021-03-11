//
//  OverLayRender.m
//  LearnOpenGLES
//
//  Created by 哈哈 on 2021/3/11.
//  Copyright © 2021 loyinglin. All rights reserved.
//

#import "OverLayRender.h"
typedef struct
{
    float position[4];
    float textureCoordinate[2];
} CustomVertex;

enum
{
    ATTRIBUTE_POSITION = 0,
    ATTRIBUTE_INPUT_TEXTURE_COORDINATE,
    TEMP_ATTRIBUTE_POSITION,
    TEMP_ATTRIBUTE_INPUT_TEXTURE_COORDINATE,
    NUM_ATTRIBUTES
};
GLint glViewAttributes[NUM_ATTRIBUTES];

enum
{
    UNIFORM_INPUT_IMAGE_TEXTURE = 0,
    TEMP_UNIFORM_INPUT_IMAGE_TEXTURE,
    UNIFORM_TEMPERATURE,
    UNIFORM_SATURATION,
    NUM_UNIFORMS
};
GLint glViewUniforms[NUM_UNIFORMS];

@interface OverLayRender()

@end

@implementation OverLayRender
-(instancetype)initWith:(EAGLContext *)context myEagLayer:(CAEAGLLayer *)myEagLayer{
    self = [super init];
    if (self) {
        _eaglLayer = myEagLayer;
        _context = context;
    }
    return self;
}

- (void)setup {
  
    [self setupRenderBuffer];
    [self setupFrameBuffer];
    NSError *error;
  //  NSAssert1([self checkFramebuffer:&error], @"%@",error.userInfo[@"ErrorMessage"]);
    [self compileShaders];
    [self compileTempShaders];
    [self setupVBOs];
    [self setupTemp];
}



- (void)setupRenderBuffer {
    // 释放旧的 renderbuffer
    if (_renderbuffer) {
        glDeleteRenderbuffers(1, &_renderbuffer);
        _renderbuffer = 0;
    }
    // 生成renderbuffer ( renderbuffer = 用于展示的窗口 )
    glGenRenderbuffers(1, &_renderbuffer);
    // 绑定renderbuffer
    glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
    // GL_RENDERBUFFER 的内容存储到实现 EAGLDrawable 协议的 CAEAGLLayer
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
}

- (void)setupFrameBuffer {
    // 释放旧的 framebuffer
    if (_framebuffer) {
        glDeleteFramebuffers(1, &_framebuffer);
        _framebuffer = 0;
    }
    // 生成 framebuffer ( framebuffer = 画布 )
    glGenFramebuffers(1, &_framebuffer);
    // 绑定 fraembuffer
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    // framebuffer 不对绘制的内容做存储, 所以这一步是将 framebuffer 绑定到 renderbuffer ( 绘制的结果就存在 renderbuffer )
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                              GL_RENDERBUFFER, _renderbuffer);
}

- (void)setupVBOs {
    static const CustomVertex vertices[] =
    {
        { .position = { -1.0, -1.0, 0, 1 }, .textureCoordinate = { 0.0, 0.0 } },
        { .position = {  1.0, -1.0, 0, 1 }, .textureCoordinate = { 1.0, 0.0 } },
        { .position = { -1.0,  1.0, 0, 1 }, .textureCoordinate = { 0.0, 1.0 } },
        { .position = {  1.0,  1.0, 0, 1 }, .textureCoordinate = { 1.0, 1.0 } }
    };
    
    GLuint vertexBuffer;
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
}

- (void)setupTextureWithImage:(UIImage *)image {
    size_t width = CGImageGetWidth(image.CGImage);
    size_t height = CGImageGetHeight(image.CGImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    void *imageData = malloc( height * width * 4 );
    
    CGContextRef context = CGBitmapContextCreate(imageData,
                                                 width,
                                                 height,
                                                 8,
                                                 4 * width,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease( colorSpace );
    CGContextClearRect( context, CGRectMake( 0, 0, width, height ) );
    CGContextTranslateCTM(context, 0, height);
    CGContextScaleCTM (context, 1.0,-1.0);
    CGContextDrawImage( context, CGRectMake( 0, 0, width, height ), image.CGImage );
    CGContextRelease(context);
    glActiveTexture(GL_TEXTURE1);
    glGenTextures(1, &_texture);
    glBindTexture(GL_TEXTURE_2D, _texture);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER,GL_LINEAR);
    glTexImage2D(GL_TEXTURE_2D,
                 0,
                 GL_RGBA,
                 (GLint)width,
                 (GLint)height,
                 0,
                 GL_RGBA,
                 GL_UNSIGNED_BYTE,
                 imageData);
    free(imageData);
}

- (void)setupTemp {
    glGenFramebuffers(1, &_tempFramebuffer);
    glActiveTexture(GL_TEXTURE0);
    glGenTextures(1, &_tempTexture);
    glBindTexture(GL_TEXTURE_2D, _tempTexture);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 414 *1.2367149758454106, 414 *1.2367149758454106, 0, GL_RGBA, GL_UNSIGNED_BYTE, NULL);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glBindFramebuffer(GL_FRAMEBUFFER, _tempFramebuffer);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, _tempTexture, 0);
}

#pragma mark - Private
- (BOOL)checkFramebuffer:(NSError *__autoreleasing *)error {
    // 检查 framebuffer 是否创建成功
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    NSString *errorMessage = nil;
    BOOL result = NO;
    switch (status)
    {
        case GL_FRAMEBUFFER_UNSUPPORTED:
            errorMessage = @"framebuffer不支持该格式";
            result = NO;
            break;
        case GL_FRAMEBUFFER_COMPLETE:
            NSLog(@"framebuffer 创建成功");
            result = YES;
            break;
        case GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT:
            errorMessage = @"Framebuffer不完整 缺失组件";
            result = NO;
            break;
        case GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS:
            errorMessage = @"Framebuffer 不完整, 附加图片必须要指定大小";
            result = NO;
            break;
        default:
            // 一般是超出GL纹理的最大限制
            errorMessage = @"未知错误 error !!!!";
            result = NO;
            break;
    }
    NSLog(@"%@",errorMessage ? errorMessage : @"");
    *error = errorMessage ? [NSError errorWithDomain:@"com.Yue.error"
                                                code:status
                                            userInfo:@{@"ErrorMessage" : errorMessage}] : nil;
    return result;
}

- (GLuint)compileShader:(NSString *)shaderName withType:(GLenum)shaderType {
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:nil];
    NSError *error;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString) {
        exit(1);
    }
    GLuint shaderHandle = glCreateShader(shaderType);
    const char* shaderStringUFT8 = [shaderString UTF8String];
    int shaderStringLength = (int)[shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUFT8, &shaderStringLength);
    
    glCompileShader(shaderHandle);
    
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"glGetShaderiv ShaderIngoLog: %@", messageString);
        exit(1);
    }
    return shaderHandle;
}

- (void)compileShaders {
    GLuint vertexShader = [self compileShader:@"OpenGLESDemo.vsh" withType:GL_VERTEX_SHADER];
    GLuint fragmentShader = [self compileShader:@"Temperature.fsh" withType:GL_FRAGMENT_SHADER];
    
    _programHandle = glCreateProgram();
    glAttachShader(_programHandle, vertexShader);
    glAttachShader(_programHandle, fragmentShader);
    glLinkProgram(_programHandle);
    
    GLint linkSuccess;
    glGetProgramiv(_programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(_programHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"glGetProgramiv ShaderIngoLog: %@", messageString);
        exit(1);
    }
    glUseProgram(_programHandle);
    glViewAttributes[ATTRIBUTE_POSITION] = glGetAttribLocation(_programHandle, "position");
    glViewAttributes[ATTRIBUTE_INPUT_TEXTURE_COORDINATE]  = glGetAttribLocation(_programHandle, "inputTextureCoordinate");
    glViewUniforms[UNIFORM_INPUT_IMAGE_TEXTURE] = glGetUniformLocation(_programHandle, "inputImageTexture");
    glViewUniforms[UNIFORM_TEMPERATURE] = glGetUniformLocation(_programHandle, "temperature");
    glEnableVertexAttribArray(glViewAttributes[ATTRIBUTE_POSITION]);
    glEnableVertexAttribArray(glViewAttributes[ATTRIBUTE_INPUT_TEXTURE_COORDINATE]);
}

- (void)compileTempShaders {
    GLuint vertexShader = [self compileShader:@"OpenGLESDemo.vsh" withType:GL_VERTEX_SHADER];
    GLuint fragmentShader = [self compileShader:@"Saturation.fsh" withType:GL_FRAGMENT_SHADER];
    _tempProgramHandle = glCreateProgram();
    glAttachShader(_tempProgramHandle, vertexShader);
    glAttachShader(_tempProgramHandle, fragmentShader);
    glLinkProgram(_tempProgramHandle);
    GLint linkSuccess;
    glGetProgramiv(_tempProgramHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(_tempProgramHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"glGetProgramiv ShaderIngoLog: %@", messageString);
        exit(1);
    }
    glUseProgram(_tempProgramHandle);
    glViewAttributes[TEMP_ATTRIBUTE_POSITION] = glGetAttribLocation(_tempProgramHandle, "position");
    glViewAttributes[TEMP_ATTRIBUTE_INPUT_TEXTURE_COORDINATE]  = glGetAttribLocation(_tempProgramHandle, "inputTextureCoordinate");
    glViewUniforms[TEMP_UNIFORM_INPUT_IMAGE_TEXTURE] = glGetUniformLocation(_tempProgramHandle, "inputImageTexture");
    glViewUniforms[UNIFORM_SATURATION] = glGetUniformLocation(_tempProgramHandle, "saturation");
    glEnableVertexAttribArray(glViewAttributes[TEMP_ATTRIBUTE_POSITION]);
    glEnableVertexAttribArray(glViewAttributes[TEMP_ATTRIBUTE_INPUT_TEXTURE_COORDINATE]);
}

- (void)render {
    // 绘制第一个滤镜
    glUseProgram(_tempProgramHandle);
    glBindFramebuffer(GL_FRAMEBUFFER, _tempFramebuffer);
    glViewport(0, 0, 414 *1.2367149758454106, 414 *1.2367149758454106);
    glClearColor(0, 0, 1, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    glUniform1i(glViewUniforms[TEMP_UNIFORM_INPUT_IMAGE_TEXTURE], 1);
    glUniform1f(glViewUniforms[UNIFORM_SATURATION], _saturation1);
    glVertexAttribPointer(glViewAttributes[TEMP_ATTRIBUTE_POSITION], 4, GL_FLOAT, GL_FALSE, sizeof(CustomVertex), 0);
    glVertexAttribPointer(glViewAttributes[TEMP_ATTRIBUTE_INPUT_TEXTURE_COORDINATE], 2, GL_FLOAT, GL_FALSE, sizeof(CustomVertex), (GLvoid *)(sizeof(float) * 4));
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    // 绘制第二个滤镜
    glUseProgram(_programHandle);
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderbuffer);
    glClearColor(1, 0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    glViewport(0, 0, 414 *1.2367149758454106, 414 *1.2367149758454106);
    glUniform1i(glViewUniforms[UNIFORM_INPUT_IMAGE_TEXTURE], 0);
    glUniform1f(glViewUniforms[UNIFORM_TEMPERATURE],_temperature1);
    glVertexAttribPointer(glViewAttributes[ATTRIBUTE_POSITION], 4, GL_FLOAT, GL_FALSE, sizeof(CustomVertex), 0);
    glVertexAttribPointer(glViewAttributes[ATTRIBUTE_INPUT_TEXTURE_COORDINATE], 2, GL_FLOAT, GL_FALSE, sizeof(CustomVertex), (GLvoid *)(sizeof(float) * 4));
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

#pragma mark - Public
- (void)layoutGLViewWithImage:(UIImage *)image {
    [self setup];
    [self setupTextureWithImage:image];
    [self render];
}

-(void)setSaturation1:(CGFloat)saturation1{
    _saturation1 = saturation1;
    [self render];
}

-(void)setTemperature1:(CGFloat)temperature1{
    _temperature1 = temperature1;
    [self render];
}
@end
