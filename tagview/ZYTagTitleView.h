//
//  ZYTagTitleView.h
//  Yuemo
//
//  Created by yuandaiyong on 2018/10/23.
//  Copyright © 2018年 zhangby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYTagTitleLayout.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^ZYTagListViewBlock)(NSInteger index);

@interface ZYTagTitleView : UIView
/// 默认: clearColor
@property (nonatomic, strong) UIColor *tagStrokeColor;
/// 默认: darkGrayColor
@property (nonatomic, strong) UIColor *tagTextColor;
/// 默认: clearColor
@property (nonatomic, strong) UIColor *tagBackgroundColor;
/// 默认: rgb(255,255,255)
@property (nonatomic, strong) UIColor *tagSelectedTextColor;
/// 默认: rgb(217,217,217)
@property (nonatomic, strong) UIColor *tagSelectedBackgroundColor;
/// 默认: 0
@property (nonatomic, assign) CGFloat tagCornerRadius;
/// 默认: NO 是否可被选中
@property (nonatomic, assign) BOOL canSelectTags;
/// 默认: 999
@property (nonatomic, assign) NSInteger selectMaxNum;
@property (nonatomic, strong) NSMutableArray *tags;//数据源数组
@property (nonatomic, strong) NSMutableArray *selectedTags;//选中数组
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong)ZYTagTitleLayout *layout;
@property (nonatomic, copy)void(^blockGetTagH)(CGFloat height);


- (void)setCompletionBlockWithSelected:(ZYTagListViewBlock )completionBlock;
@end

NS_ASSUME_NONNULL_END
