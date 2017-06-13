//
//  GiftAnimationModel.h
//  LiveAnimation
//
//  Created by victor on 2017/6/10.
//  Copyright © 2017年 victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftAnimationModel : NSObject

@property (nonatomic, copy) NSString      *giftId; //相同的id giftNum会叠加
@property (nonatomic, copy) NSString      *image;
@property (nonatomic, copy) NSString      *titleUp;
@property (nonatomic, copy) NSString      *titleBottom;
@property (nonatomic, assign) NSInteger   giftNum;

@end
