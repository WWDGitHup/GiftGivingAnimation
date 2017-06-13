//
//  GiftAnimationLabel.h
//  LiveAnimation
//
//  Created by victor on 2017/6/10.
//  Copyright © 2017年 victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftAnimationLabel : UILabel
// 动画时间
@property (nonatomic,assign) NSTimeInterval duration;
// 描边颜色
@property (nonatomic,strong) UIColor *borderColor;

- (void)startAnimWithDuration:(NSTimeInterval)duration;

@end
