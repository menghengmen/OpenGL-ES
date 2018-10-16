//
//  LMCameraFilters.h
//  GPUImageDemo
//
//  Created by xx11dragon on 15/9/22.
//  Copyright © 2015年 xx11dragon. All rights reserved.
//

#import "GPUImage.h"

@interface LMCameraFilters : NSObject

//    正常
+ (GPUImageFilterGroup *)normal;

+ (GPUImageFilterGroup *)saturation;

+ (GPUImageFilterGroup *)exposure;

+ (GPUImageFilterGroup *)contrast;

+ (GPUImageFilterGroup *)testGroup1;
///素描
+(GPUImageFilterGroup*)sketchFilter;
///水晶球
+(GPUImageFilterGroup*)sphereFilter;
///t凸起
+(GPUImageFilterGroup*)bulgeDistortionFilter;
///卡通
+(GPUImageFilterGroup*)toonFilter;
///浮雕
+(GPUImageFilterGroup*)embossFilter;
///高斯m模糊
+(GPUImageFilterGroup*)selectiveBlurFilter;
///扭曲
+(GPUImageFilterGroup*)swirlFilter;
///马赛克
+(GPUImageFilterGroup*)mosaicFilter;

@end

