//
//  ZYTagTitleLayout.m
//  Yuemo
//
//  Created by yuandaiyong on 2018/10/23.
//  Copyright © 2018年 zhangby. All rights reserved.
//

#import "ZYTagTitleLayout.h"
@interface ZYTagTitleLayout()

@property (nonatomic, weak) id<UICollectionViewDelegateFlowLayout> delegate;
@property (nonatomic, strong) NSMutableArray *itemAttributes;
@property (nonatomic, assign) CGFloat contentHeight;

@end


@implementation ZYTagTitleLayout

- (id)init
{
    self = [super init];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    _itemSizeZ =  CGSizeMake(100.0f, 26.0f);
    _scrollDirectionZ = UICollectionViewScrollDirectionHorizontal;
    _minimumSpacingZ = 10.0f;
    _minimumLineSpacingZ = 10.0f;
    _sectionInsetZ = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    _itemAttributes = [NSMutableArray array];
}


#pragma mark -
// 准备开始布局
- (void)prepareLayout
{
    self.itemSize = _itemSizeZ;
    self.scrollDirection = _scrollDirectionZ;
    self.minimumInteritemSpacing = _minimumSpacingZ;
    self.minimumLineSpacing = _minimumLineSpacingZ;
    self.sectionInset = _sectionInsetZ;
    
    [self.itemAttributes removeAllObjects];
    self.contentHeight = self.sectionInset.top + self.itemSize.height;
    
    CGFloat originX = self.sectionInset.left;
    CGFloat originY = self.sectionInset.top;
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGSize itemSize = [self itemSizeForIndexPath:indexPath];
        
        if ((originX + itemSize.width + self.sectionInset.right/2) > self.collectionView.frame.size.width) {
            originX = self.sectionInset.left;
            originY += itemSize.height + self.minimumLineSpacing;
            
            self.contentHeight += itemSize.height + self.minimumLineSpacing;
        }
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(originX, originY, itemSize.width, itemSize.height);
        [self.itemAttributes addObject:attributes];
        
        originX += itemSize.width + self.minimumInteritemSpacing;
    }
    
    self.contentHeight += self.sectionInset.bottom;
    if(_getHeithtForColl) {
        _getHeithtForColl(self.contentHeight);
    }
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}

#pragma mark -

- (id<UICollectionViewDelegateFlowLayout>)delegate
{
    if (_delegate == nil) {
        _delegate =  (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    }
    
    return _delegate;
}

- (CGSize)itemSizeForIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        self.itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    
    return self.itemSize;
}

@end
