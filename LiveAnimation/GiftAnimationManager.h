//
//  GiftAnimationManager.h
//  LiveAnimation
//
//  Created by victor on 2017/6/10.
//  Copyright © 2017年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class GiftAnimationModel;
@interface GiftAnimationManager : NSObject

+ (instancetype)defaultGiftManager;

@property (nonatomic, strong) UIView     *showView;
//管理动画显示
- (void)addANewAnimationToQueue:(GiftAnimationModel *)animationModel;



@end
