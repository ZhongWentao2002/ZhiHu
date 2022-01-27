//
//  BannerView.m
//  ZhiHu
//
//  Created by SSR on 2022/1/17.
//

#import "BannerView.h"

#pragma mark - Banner方法实现

@implementation BannerView

#pragma mark - 初始化方法

/**重写initWithFrame，应该用initWithFrame*/
- (instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    /**行0间距*/
    layout.minimumLineSpacing = 0;
    /**列0间距*/
    layout.minimumInteritemSpacing = 0;
    /**四周0*/
    layout.sectionInset = UIEdgeInsetsZero;
    /**方向右*/
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [self initWithFrame:frame collectionViewLayout:layout];
    return self;
}

/**重写initWithFrame:collectionViewLayout*/
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        [self registerClass:[BannerCell class] forCellWithReuseIdentifier:@"BannerCell"];
    }
    return self;
}

#pragma mark - bannerCell有关方法

/**注册Cell的方法*/
- (BannerCell *)getReusableBannerCell:(NSIndexPath *)indexPath{
    BannerCell *cell = [self dequeueReusableCellWithReuseIdentifier:BannerCellReuseIdentifier forIndexPath:indexPath];
    return cell.Default;
}

#pragma mark - <UICollectionViewDelegate>

/**选中的代理*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    [self.Banner_delegate BannerView_tapAtIndexPath:indexPath];
}

/**当bannerView停止滚动的时候调用*/
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint p = scrollView.contentOffset;
    NSLog(@"\n\t*****%@", NSStringFromCGPoint(p));
    p.x += 1;
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:p];
    [self.Banner_delegate BannerView_endedScollAtIndexPath:indexPath];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

/**cell大小的代理*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"\n%@ - %s", [self class], __func__);
    
    return self.frame.size;
}

@end
