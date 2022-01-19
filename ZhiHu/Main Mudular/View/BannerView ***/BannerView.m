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
        [self registerClass:[BannerCell class] forCellWithReuseIdentifier:@"BannerCell"];
    }
    return self;
}

#pragma mark - bannerCell有关方法

/**注册Cell的方法*/
- (BannerCell *(^)(NSIndexPath *))ReusableBannerCell_atIndexPath{
    return ^BannerCell *(NSIndexPath *indexPath){
        BannerCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"BannerCell" forIndexPath:indexPath];
        
        return cell;
    };
}

#pragma mark - <UICollectionViewDelegate>



@end
