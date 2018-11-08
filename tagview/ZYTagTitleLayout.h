//
//  ZYTagTitleLayout.h
//  Yuemo
//
//  Created by yuandaiyong on 2018/10/23.
//  Copyright © 2018年 zhangby. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYTagTitleLayout : UICollectionViewFlowLayout

@property(nonatomic,assign)CGSize itemSizeZ;
@property(nonatomic,assign)UICollectionViewScrollDirection scrollDirectionZ;
@property(nonatomic,assign)CGFloat minimumSpacingZ;
@property(nonatomic,assign)CGFloat minimumLineSpacingZ;
@property(nonatomic,assign)UIEdgeInsets sectionInsetZ;

@property(nonatomic,copy)void (^getHeithtForColl)(CGFloat heightForColl);

@end

NS_ASSUME_NONNULL_END
