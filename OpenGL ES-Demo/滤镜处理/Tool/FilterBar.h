//
//  FilterBar.h
//  滤镜处理
//
//  Created by fenwei on 2020/8/10.
//  Copyright © 2020 sxcoal.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FilterBar;

@protocol FilterBarDelegate <NSObject>

- (void)filterBar:(FilterBar *)filterBar didScrollToIndex:(NSUInteger)index;

@end

@interface FilterBar : UIView

@property (nonatomic, strong) NSArray <NSString *> *itemList;

@property (nonatomic, weak) id<FilterBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
