//
//  MHGPUImageBaseFilter.m
//  testPasterImage
//
//  Created by 哈哈 on 2021/1/10.
//  Copyright © 2021 mac. All rights reserved.
//

#import "MHGPUImageBaseFilter.h"

@implementation MHGPUImageBaseFilter
- (id)initWithVertexShaderFromString:(NSString *)vertexShaderString
            fragmentShaderFromString:(NSString *)fragmentShaderString {
    self = [super initWithVertexShaderFromString:vertexShaderString
                        fragmentShaderFromString:fragmentShaderString];
    self.timeUniform = [filterProgram uniformIndex:@"time"];
    self.time = 0.0f;
    self.facesPoints = 0;
    self.facesPointCount = 0;
    
    return self;
}

- (void)setTime:(CGFloat)time {
    _time = time;
    
    [self setFloat:time forUniform:self.timeUniform program:filterProgram];
}
@end
