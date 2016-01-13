//
//  CSSPictureScrollView.h
//  PictureScroll
//
//  Created by cq on 16/1/13.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import <UIKit/UIKit.h>

//点击图片产生点击响应
typedef void(^TapImageButtonBlock)(NSInteger imageIndex);

@interface CSSPictureScrollView : UIView

//图片自动切换时间
@property (nonatomic,assign)CGFloat scrollInterval;
//切换耗费的时间
@property (nonatomic,assign)CGFloat animationInterval;
/**
 *  便利构造器
 */
+ (instancetype) CSSPictureScrollViewWithFrame:(CGRect)frame WithImages:(NSArray *)images;

/**
 *  初始化函数
 */
- (instancetype) initWithFrame:(CGRect)frame withImages:(NSArray *)images;
/**
 *  图片添加点击事件
 */

- (void)addTapEventForImageWithBlock:(TapImageButtonBlock) block;

@end
