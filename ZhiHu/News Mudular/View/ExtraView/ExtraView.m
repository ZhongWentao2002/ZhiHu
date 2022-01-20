//
//  ExtraView.m
//  ZhiHu
//
//  Created by SSR on 2022/1/20.
//

#import "ExtraView.h"

#pragma mark - ExtraView方法实现

@implementation ExtraView

#pragma mark - 初始化

/**重写initWithFrame*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backBtn];
        [self addSubview:self.line];
        [self addSubview:self.commentBtn];
        [self addSubview:self.relayBtn];
        [self addSubview:self.likeBtn];
        [self addSubview:self.collectBtn];
        
        [self addSubview:self.commentNumLab];
        [self addSubview:self.popularNumLab];
    }
    return self;
}

#pragma mark - 懒加载

/**懒加载backBtn*/
- (UIButton *)backBtn{
    if (_backBtn == nil) {
        CGFloat content = 20;
        CGRect rect = CGRectMake(content, 10, 30, 30);
        _backBtn = [[UIButton alloc] initWithFrame:rect];
        [_backBtn setImage:[UIImage imageNamed:@"BackItem"] forState:UIControlStateNormal];
        [_backBtn addTarget:self.delegate action:@selector(ExtraView_tapBackItem) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

/**加载短线*/
- (UILabel *)line{
    if (_line == nil) {
        CGRect rect = self.backBtn.frame;
        rect.origin.x += rect.size.width + 20;
        rect.size.width = 3;
        _line = [[UILabel alloc] initWithFrame:rect];
        _line.userInteractionEnabled = NO;
        _line.backgroundColor = [UIColor grayColor];
    }
    return _line;
}

/**懒加载comment*/
- (UIButton *)commentBtn{
    if (_commentBtn == nil) {
        CGRect rect = self.backBtn.frame;
        rect.origin.x = self.line.frame.origin.x + self.line.frame.size.width + 20;
        _commentBtn = [[UIButton alloc] initWithFrame:rect];
        [_commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        [_commentBtn addTarget:self.delegate action:@selector(ExtraView_tapCommentItem) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}


/**懒加载转发Relay*/
- (UIButton *)relayBtn{
    if (_relayBtn == nil) {
        CGRect rect = self.backBtn.frame;
        CGRect aRect = self.frame;
        rect.origin.x = aRect.size.width - rect.size.width - 30;
        _relayBtn = [[UIButton alloc] initWithFrame:rect];
        [_relayBtn setImage:[UIImage imageNamed:@"relay_default"] forState:UIControlStateNormal];
        [_relayBtn addTarget:self.delegate action:@selector(ExtraView_tapRelayItem) forControlEvents:UIControlEventTouchUpInside];
    }
    return _relayBtn;
}

/**懒加载点赞*/
- (UIButton *)likeBtn{
    if (_likeBtn == nil) {
        CGRect cRect = self.commentBtn.frame;
        CGRect rRect = self.relayBtn.frame;
        cRect.origin.x += (rRect.origin.x - cRect.origin.x) * 1 / 3;
        _likeBtn = [[UIButton alloc] initWithFrame:cRect];
        [_likeBtn setImage:[UIImage imageNamed:@"popular_default"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"popular_light"] forState:UIControlStateSelected];
        [_likeBtn addTarget:self action:@selector(TapLike:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

/**懒加载收藏*/
- (UIButton *)collectBtn{
    if (_collectBtn == nil) {
        CGRect cRect = self.commentBtn.frame;
        CGRect rRect = self.relayBtn.frame;
        cRect.origin.x += (rRect.origin.x - cRect.origin.x) * 2 / 3;
        _collectBtn = [[UIButton alloc] initWithFrame:cRect];
        [_collectBtn setImage:[UIImage imageNamed:@"collect_default"] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"collect_light"] forState:UIControlStateSelected];
        [_collectBtn addTarget:self action:@selector(TapCollect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}

#pragma mark - 单击先过一遍自己

/**单击Like*/
- (void)TapLike:(UIButton *)btn{
    NSLog(@"\n%@ - %s", [self class], __func__);

    btn.selected = ! btn.selected;
    if (btn.selected == YES) {
        self.popularNumLab.textColor = [UIColor orangeColor];
    }
    else{
        self.popularNumLab.textColor = [UIColor blackColor];
    }
    [self.delegate ExtraView_tapPopuliarItem_selected:btn.selected];
}

/*单击Collect*/
- (void)TapCollect:(UIButton *)btn{
    NSLog(@"\n%@ - %s", [self class], __func__);

    btn.selected = ! btn.selected;
    [self.delegate ExtraView_tapCollectItem_selected:btn.selected];
}

#pragma mark - 数字类扩展

/**评论数*/
- (UILabel *)commentNumLab{
    if (_commentNumLab == nil) {
        CGRect cRect = self.commentBtn.frame;
        cRect.size.height /= 2;
        cRect.origin.x += cRect.size.width;
        _commentNumLab = [[UILabel alloc] initWithFrame:cRect];
        _commentNumLab.text = @"0";
    }
    return _commentNumLab;
}

/**点赞数*/
- (UILabel *)popularNumLab{
    if (_popularNumLab == nil) {
        CGRect pRect = self.likeBtn.frame;
        pRect.size.height /= 2;
        pRect.origin.x += pRect.size.width;
        _popularNumLab = [[UILabel alloc] initWithFrame:pRect];
        _popularNumLab.text = @"0";
    }
    return _popularNumLab;
}

#pragma mark - 链式

/**comment数字*/
- (ExtraView *(^)(NSInteger)) CommentNum_Integer{
    return ^ExtraView *(NSInteger com){
        self.commentNumLab.text = [NSString stringWithFormat:@"%ld", com];
        return self;
    };
}

/**popular数字*/
- (ExtraView *(^)(NSInteger)) PopularNum_Integer{
    return ^ExtraView *(NSInteger pop){
        self.popularNumLab.text = [NSString stringWithFormat:@"%ld", pop];
        return self;
    };
}

@end
