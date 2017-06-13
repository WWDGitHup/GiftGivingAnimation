//
//  GiftAnimationShowView.m
//  LiveAnimation
//
//  Created by victor on 2017/6/10.
//  Copyright © 2017年 victor. All rights reserved.
//

#import "GiftAnimationShowView.h"
#import "GiftAnimationLabel.h"
#import "GiftAnimationModel.h"

@interface GiftAnimationShowView ()
@property (nonatomic, strong) CAGradientLayer       *backgroundLayer;
@property (nonatomic, strong) GiftAnimationLabel    *animationLabel;
@property (nonatomic, strong) UIImageView           *giftImageView;
@property (nonatomic, strong) UILabel               *titleUp;
@property (nonatomic, strong) UILabel               *titleBottom;
@property (nonatomic, copy)   ShowAnimationBlock     showAnimationCompletion;
@property (nonatomic, assign) NSInteger              animationCount;
@property (nonatomic, assign) CGRect                 originFrame;
@end

@implementation GiftAnimationShowView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.layer addSublayer:self.backgroundLayer];
        CGFloat cordious = frame.size.height / 2.0;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_backgroundLayer.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopLeft cornerRadii:CGSizeMake(cordious, cordious)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = maskPath.CGPath;
        _backgroundLayer.mask = maskLayer;
        [self addSubview:self.animationLabel];
        self.animationLabel.frame = CGRectMake(frame.size.width - 80, 0, 80, frame.size.height);
        _giftCount = 0;
        _animationCount = 1;
        _originFrame = frame;
        [self addSubview:self.titleBottom];
        [self addSubview:self.giftImageView];
        [self addSubview:self.titleUp];
        self.titleBottom.frame = CGRectMake(10, frame.size.height / 2, 150, frame.size.height / 2);
        self.giftImageView.frame = CGRectMake(frame.size.width - 120, frame.size.height / 2 - 20, 40, 40);
        self.titleUp.frame = CGRectMake(10, 0, 150, frame.size.height / 2);
    }
    return self;
}

//开始动画
- (void)shawAnimationCompletion:(ShowAnimationBlock)completion{
    self.showAnimationCompletion = completion;
    self.frame = CGRectMake(-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(_originFrame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        // 显示在界面完毕。开始做动画
        _animationLabel.text = [NSString stringWithFormat:@"X %ld",(long)_animationCount];
        [_animationLabel startAnimWithDuration:0.25];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(giftNumAnimation:) userInfo:nil repeats:YES];
    }];
}
- (void)giftNumAnimation:(NSTimer *)timer{
    
    if (_animationCount < _giftCount) {
        _animationCount ++;
    }else{
        _animationCount = 1;
        [timer invalidate];
        timer = nil;
        [self hideAnimationView];
        return ;
    }
    _animationLabel.text = [NSString stringWithFormat:@"X %ld",(long)_animationCount];
    [_animationLabel startAnimWithDuration:0.25];
}

//结束
- (void)hideAnimationView{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        self.frame = CGRectMake(_originFrame.origin.x, self.frame.origin.y - 50, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self reset];
        if (self.showAnimationCompletion) {
            self.showAnimationCompletion();
        }
    }];
}

- (void)reset{
    self.alpha = 1.0;
    self.frame = _originFrame;
    self.animationLabel.text = @"";
}

- (void)setModel:(GiftAnimationModel *)model{
    _model = model;
    self.titleUp.text = model.titleUp;
    self.titleBottom.text = model.titleBottom;
    self.giftImageView.image = [UIImage imageNamed:model.image];
    self.giftCount = model.giftNum;
}

#pragma mark -  attribute
- (CAGradientLayer *)backgroundLayer{
    if (_backgroundLayer == nil) {
        _backgroundLayer = [CAGradientLayer layer];
        _backgroundLayer.colors = @[(__bridge id)[UIColor colorWithRed:115/255.0 green:245/255.0 blue:75/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0 green:33/255.0 blue:235/255.0 alpha:0.4].CGColor];
        _backgroundLayer.startPoint = CGPointMake(0, 0);
        _backgroundLayer.endPoint = CGPointMake(1.0, 0);
    }
    return _backgroundLayer;
}

- (GiftAnimationLabel *)animationLabel{
    if (_animationLabel == nil) {
        _animationLabel = [[GiftAnimationLabel alloc] init];
        _animationLabel.borderColor = [UIColor yellowColor];
        _animationLabel.textColor = [UIColor yellowColor];
        _animationLabel.textAlignment = NSTextAlignmentCenter;
        _animationLabel.font = [UIFont italicSystemFontOfSize:25];
    }
    return _animationLabel;
}
- (UILabel *)titleUp{
    if (_titleUp == nil) {
        _titleUp = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleUp.textColor = [UIColor whiteColor];
        _titleUp.font = [UIFont systemFontOfSize:15];
    }
    return _titleUp;
}
- (UILabel *)titleBottom{
    if (_titleBottom == nil) {
        _titleBottom = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleBottom.textColor = [UIColor whiteColor];
        _titleBottom.font = [UIFont systemFontOfSize:15];
    }
    return _titleBottom;
}
- (UIImageView *)giftImageView{
    if (_giftImageView == nil) {
        _giftImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _giftImageView;
}

@end
