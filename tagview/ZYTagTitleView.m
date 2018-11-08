//
//  ZYTagTitleView.m
//  Yuemo
//
//  Created by yuandaiyong on 2018/10/23.
//  Copyright © 2018年 zhangby. All rights reserved.
//

#import "ZYTagTitleView.h"
#import "ZYTagTitleCell.h"

#define kColorBgSelected [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1];
#define kColorSelected [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];


@interface ZYTagTitleView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) ZYTagListViewBlock selectedBlock;


@end


@implementation ZYTagTitleView

static NSString * const reuseIdentifier = @"tagTitleItem";

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
}


- (void)setup
{
    _selectedTags = [NSMutableArray array];
    _tags = [NSMutableArray array];
    _tagStrokeColor = [UIColor clearColor];
    _tagBackgroundColor = [UIColor clearColor];
    _tagTextColor = [UIColor darkGrayColor];
    _tagSelectedBackgroundColor = kColorBgSelected;
    _tagSelectedTextColor = kColorSelected
    _tagCornerRadius = 0.0f;
    _selectMaxNum = 999;
    
    _layout = [[ZYTagTitleLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_layout];
//    kWeakSelf(self)
//    [_layout setGetHeithtForColl:^(CGFloat heightForColl) {
//        weakSelf.collectionView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width, heightForColl);
//        [weakSelf.collectionView layoutSubviews];
//        if (weakSelf.blockGetTagH) {
//            weakSelf.blockGetTagH(heightForColl);
//        }
//    }];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[ZYTagTitleCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self addSubview:_collectionView];
}

- (void)setCompletionBlockWithSelected:(ZYTagListViewBlock )completionBlock
{
    self.selectedBlock = completionBlock;
}

#pragma mark - UICollectionViewDelegate | UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYTagTitleLayout *layout = (ZYTagTitleLayout *)collectionView.collectionViewLayout;
    CGSize maxSize = CGSizeMake(collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
    
    
    NSString *title = _tags[indexPath.item];
//    CGFloat width = [title zby_widthForFont:[UIFont systemFontOfSize:14.0]];
//    if (width > collectionView.frame.size.width) {
//        CGFloat height = [title zby_heightForFont:[UIFont systemFontOfSize:14.0] width:maxSize.width];
//        return CGSizeMake(maxSize.width,height);
//    }
    CGRect frame = [title boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]} context:nil];
    
    return CGSizeMake(frame.size.width + 20.0f, layout.itemSize.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYTagTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = self.tagBackgroundColor;
    cell.layer.borderColor = self.tagStrokeColor.CGColor;
    cell.layer.cornerRadius = self.tagCornerRadius;
    cell.titleLabel.text = self.tags[indexPath.item];
    cell.titleLabel.textColor = self.tagTextColor;
    
    if ([self.selectedTags containsObject:self.tags[indexPath.item]]) {
        cell.titleLabel.textColor = self.tagSelectedTextColor;
        cell.backgroundColor = self.tagSelectedBackgroundColor;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.canSelectTags) {
        ZYTagTitleCell *cell = (ZYTagTitleCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        if ([self.selectedTags containsObject:self.tags[indexPath.item]]) {
            cell.backgroundColor = self.tagBackgroundColor;
            cell.titleLabel.textColor = self.tagTextColor;
            [self.selectedTags removeObject:self.tags[indexPath.item]];
        }
        else {
            if (self.selectedTags.count < _selectMaxNum) {
                cell.titleLabel.textColor = self.tagSelectedTextColor;
                cell.backgroundColor = self.tagSelectedBackgroundColor;
                [self.selectedTags addObject:self.tags[indexPath.item]];
            }
        }
    }
    if (self.selectedBlock) {
        self.selectedBlock(indexPath.item);
    }
}

@end
