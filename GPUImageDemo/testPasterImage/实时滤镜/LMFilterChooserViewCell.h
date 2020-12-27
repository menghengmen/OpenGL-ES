//
//  LMFilterChooserViewCell.h
//  LMUpLoadPhoto
//
//  Created by xx11dragon on 15/8/31.
//  Copyright (c) 2015年 xx11dragon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPUImageFilterGroup;
@interface LMFilterChooserViewCell : UIView


- (void)setFilter:(GPUImageFilterGroup *)filter;

- (GPUImageFilterGroup *)getFilter;

- (void)setState:(UIControlState)state;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com