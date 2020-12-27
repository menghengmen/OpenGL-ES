//
//  FilterBarCell.h
//  滤镜处理
//
//  Created by 哈哈 on 2020/12/27.
//  Copyright © 2020 OpenGL ES . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterBarCell : UICollectionViewCell
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
