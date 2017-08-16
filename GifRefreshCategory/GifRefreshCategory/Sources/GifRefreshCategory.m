//
//  GifRefreshCategory.m
//  GifRefreshCategory
//
//  Created by ccSunday on 2017/8/16.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "GifRefreshCategory.h"

#define K_ScreenWidth  [[UIScreen mainScreen]bounds].size.width

@implementation MJRefreshGifHeader (Category)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL swizzleSelectors[2] = {
            @selector(prepare),
            @selector(placeSubviews)
        };
        for (int i = 0; i < 1;  i++) {
            SEL selector = swizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"header_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)header_prepare{
    [self header_prepare];//先调用原来的方法
    NSMutableArray *idleImages = [NSMutableArray array];//定义数组存储图片
    for (int i = 0; i<6; i++) {
        NSString *imgName = [NSString stringWithFormat:@"loading0%d",i+1];
        UIImage *img = [UIImage imageNamed:imgName];
        [idleImages addObject:img];
    }
//    [[UIScreen mainScreen]bounds].size.width

    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    CGPoint center = self.gifView.center;
    center.x = K_ScreenWidth/2;
    self.gifView.center = center;
    // 设置普通状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self setImages:idleImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateRefreshing];
}

- (void)header_placeSubviews{
    [self header_placeSubviews];
}

@end


@implementation MJRefreshAutoGifFooter (Category)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL swizzleSelectors[2] = {
            @selector(prepare),
            @selector(placeSubviews)
        };
        for (int i = 0; i < 1;  i++) {
            SEL selector = swizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"footer_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)footer_prepare{
    [self footer_prepare];//先调用原来的方法
    NSMutableArray *idleImages = [NSMutableArray array];//定义数组存储图片
    for (int i = 0; i<6; i++) {
        NSString *imgName = [NSString stringWithFormat:@"loading0%d",i+1];
        UIImage *img = [UIImage imageNamed:imgName];
        [idleImages addObject:img];
    }
    self.stateLabel.hidden = YES;
    self.refreshingTitleHidden = YES;
    CGPoint center = self.gifView.center;
    center.x = K_ScreenWidth/2;
    self.gifView.center = center;
    // 设置普通状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self setImages:idleImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateRefreshing];
}

- (void)footer_placeSubviews{
    [self footer_placeSubviews];
}

@end
