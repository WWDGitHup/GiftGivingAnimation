//
//  GiftAnimationShowView.h
//  LiveAnimation
//
//  Created by victor on 2017/6/10.
//  Copyright © 2017年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GiftAnimationModel;
typedef void(^ShowAnimationBlock)();

@interface GiftAnimationShowView : UIView
//礼物个数
@property (nonatomic, assign) NSInteger              giftCount;
@property (nonatomic, strong) GiftAnimationModel    *model;
//动画结束
- (void)shawAnimationCompletion:(ShowAnimationBlock)completion;



@end
