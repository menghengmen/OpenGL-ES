//
//  FilterBarCell.h
//  滤镜处理
//
//  Created by fenwei on 2020/8/10.
//  Copyright © 2020 sxcoal.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterBarCell : UICollectionViewCell
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
