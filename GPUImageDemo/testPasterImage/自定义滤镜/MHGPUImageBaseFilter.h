//
//  MHGPUImageBaseFilter.h
//  testPasterImage
//
//  Created by 哈哈 on 2021/1/10.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHGPUImageBaseFilter : GPUImageFilter
@property (nonatomic, assign) GLint timeUniform;
@property (nonatomic, assign) CGFloat time;

@property (nonatomic, assign) CGFloat beginTime;  // 滤镜开始应用的时间

@property (nonatomic, assign) GLfloat *facesPoints;
@property (nonatomic, assign) int facesPointCount;
@end

NS_ASSUME_NONNULL_END
