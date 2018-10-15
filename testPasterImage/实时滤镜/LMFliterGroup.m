//
//  LMFliterGroup.m
//  Test1030
//
//  Created by xx11dragon on 15/11/4.
//  Copyright © 2015年 xx11dragon. All rights reserved.
//

#import "LMFliterGroup.h"
#import <objc/runtime.h>

static char GPUImageFilterGroupTitleKey;
static char GPUImageFilterGroupColorKey;

@implementation GPUImageFilterGroup(addTitleColor)

-(void)setTitle:(NSString *)title {
    [self willChangeValueForKey:@"GPUImageFilterGroupTitleKey"];
    objc_setAssociatedObject(self, &GPUImageFilterGroupTitleKey,
                             title,
                             OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"GPUImageFilterGroupTitleKey"];
}

- (NSString *)title {
    return objc_getAssociatedObject(self, &GPUImageFilterGroupTitleKey);
}

- (void)setColor:(UIColor *)color {
    [self willChangeValueForKey:@"GPUImageFilterGroupColorKey"];
    objc_setAssociatedObject(self, &GPUImageFilterGroupColorKey,
                             color,
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"GPUImageFilterGroupColorKey"];
}

-(UIColor *)color {
    return objc_getAssociatedObject(self, &GPUImageFilterGroupColorKey);
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com