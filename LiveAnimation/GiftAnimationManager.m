//
//  GiftAnimationManager.m
//  LiveAnimation
//
//  Created by victor on 2017/6/10.
//  Copyright © 2017年 victor. All rights reserved.
//

#import "GiftAnimationManager.h"
#import "GiftAnimationModel.h"
#import "GiftAnimationShowView.h"

@interface GiftAnimationManager ()
@property (nonatomic, strong) NSMutableArray      *animationModelArray;
@property (nonatomic, assign) NSInteger            currentShowViewCount;
@property (nonatomic, assign) BOOL                 isShowInTop;

@property (nonatomic, assign) NSInteger            showViewTag;//0 上 1 下 2超 

@end


@implementation GiftAnimationManager

- (instancetype)init{
    self = [super init];
    if (self) {
        _animationModelArray = @[].mutableCopy;
        _currentShowViewCount = 0;
        _isShowInTop = YES;
    }
    return self;
}
+ (instancetype)defaultGiftManager{
    static GiftAnimationManager * __manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[GiftAnimationManager alloc] init];
        
    });
    return __manager;
}

- (void)addANewAnimationToQueue:(GiftAnimationModel *)animationModel{
    __block BOOL isExited;
    [_animationModelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GiftAnimationModel *model = obj;
        if ([model.giftId isEqualToString:animationModel.giftId]) {
            model.giftNum += animationModel.giftNum;
            isExited = YES;
        }
    }];
    if (!isExited) {
          //确定显示位置
        [_animationModelArray addObject:animationModel];
    }
    [self startAnimation];
}

- (void)startAnimation{
    if (_animationModelArray.count == 0) {
        return ;
    }
    //判断显示在上面还是下面
    if (_currentShowViewCount > 1) {
        return ;
    }
    _currentShowViewCount ++;
    //获取设备
    if (_isShowInTop == YES) {
        _isShowInTop = NO;
        [self showTopAnimationView];
    }else{
        [self showBottomAnimationView];
        _isShowInTop = YES;
    }
}
- (void)showTopAnimationView{
    //上面
    if (_animationModelArray.count == 0) {
        return;
    }
    GiftAnimationModel * model = _animationModelArray[0];
    [_animationModelArray removeObject:model];
    GiftAnimationShowView * animationView = [[GiftAnimationShowView alloc] initWithFrame:CGRectMake(20, 100, 200, 60)];
    animationView.giftCount = model.giftNum;
    animationView.model = model;
    __weak typeof(self)weakSelf = self;
    [animationView shawAnimationCompletion:^{
        weakSelf.currentShowViewCount --;
        weakSelf.isShowInTop = YES;
        [weakSelf startAnimation];
    }];
    [_showView addSubview:animationView];
}

- (void)showBottomAnimationView{
    //下面
    if (_animationModelArray.count == 0) {
        return;
    }
    GiftAnimationModel * model = _animationModelArray[0];
    [_animationModelArray removeObject:model];
    GiftAnimationShowView * animationView = [[GiftAnimationShowView alloc] initWithFrame:CGRectMake(20, 180, 200, 60)];
    animationView.giftCount = model.giftNum;
    animationView.model = model;
     __weak typeof(self)weakSelf = self;
    [animationView shawAnimationCompletion:^{
        weakSelf.currentShowViewCount --;
        weakSelf.isShowInTop = NO;
        [weakSelf startAnimation];
    }];
    [_showView addSubview:animationView];
}



@end
