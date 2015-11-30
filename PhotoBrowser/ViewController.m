//
//  ViewController.m
//  PhotoBrowser
//
//  Created by Thomson on 15/11/30.
//  Copyright © 2015年 Kemi. All rights reserved.
//

#import "ViewController.h"

#import "UIImageView+WebCache.h"

#import "PhotoBrowser.h"
#import "Photo.h"
#import "UtilsMacors.h"

static NSString * const collectionCellIdentifier = @"collectionCellIdentifier";

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *itemsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.itemsArray = @[
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr0nly5j20pf0gygo6.jpg",
                        @"http://ww4.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr1d0vyj20pf0gytcj.jpg",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
                        @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                        @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                        @"http://ww4.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg"
                        ];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.itemsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];

    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:101];

    NSString *URLString = _itemsArray[indexPath.row];

    [imageView sd_setImageWithURL:[NSURL URLWithString:URLString]];

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *photos = [[NSMutableArray alloc] initWithCapacity:0];
    for (int index = 0; index < _itemsArray.count; index++)
    {
        NSIndexPath *imageIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:imageIndexPath];
        UIImageView *imageView = [cell.contentView viewWithTag:101];
        CGRect bounds = [cell convertRect:imageView.frame toView:self.view.window];

        NSString *url = _itemsArray[index];

        Photo *photo = [[Photo alloc] init];
        photo.url = [NSURL URLWithString:url];
        photo.originBounds = bounds;

        [photos addObject:photo];
    }

    // 2.显示相册
    PhotoBrowser *browser = [[PhotoBrowser alloc] initWithPhotos:photos];
    browser.currentPhotoIndex = indexPath.row; // 弹出相册时显示的第一张图片是？
    [browser show];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat collectionItemSize = (kScreenWidth - 20) / 3;

    return CGSizeMake(collectionItemSize, collectionItemSize);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}

@end
