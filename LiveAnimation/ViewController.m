//
//  ViewController.m
//  LiveAnimation
//
//  Created by victor on 2017/6/10.
//  Copyright © 2017年 victor. All rights reserved.
//

#import "ViewController.h"
#import "GiftAnimationShowView.h"
#import "GiftAnimationManager.h"
#import "GiftAnimationModel.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    [GiftAnimationManager defaultGiftManager].showView = self.view;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    GiftAnimationModel *mdeo = [[GiftAnimationModel alloc] init];
    //用来区分不同的来源
    mdeo.giftId = [NSString stringWithFormat:@"%d",arc4random() % 100000];
    mdeo.image = @"flower.png";
    mdeo.titleBottom = @"樱桃小丸子";
    mdeo.titleUp = @"送你一个大飞机";
    mdeo.giftNum = arc4random() % 20;
    [[GiftAnimationManager defaultGiftManager] addANewAnimationToQueue:mdeo];
    
}


@end
