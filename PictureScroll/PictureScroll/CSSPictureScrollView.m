//
//  CSSPictureScrollView.m
//  PictureScroll
//
//  Created by cq on 16/1/13.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "CSSPictureScrollView.h"


@interface CSSPictureScrollView()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *mainScrollView;

@property (nonatomic,strong)UIPageControl *maiPageController;

@property (nonatomic,assign)CGFloat viewWithWidth;

@property (nonatomic,assign)CGFloat viewWithHeight;

@property (nonatomic,strong)NSArray *imageNamesArray;

@property (nonatomic,strong)NSMutableArray *imageViewsArray;

@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,assign)UIViewContentMode imageViewContentMode;

@property (nonatomic,assign)TapImageButtonBlock block;

@property (nonatomic,assign) BOOL isRight;

@property (nonatomic, assign) NSInteger currentPage;

@end


@implementation CSSPictureScrollView

+(instancetype)CSSPictureScrollViewWithFrame:(CGRect)frame WithImages:(NSArray *)images {
    CSSPictureScrollView *instance=[[CSSPictureScrollView alloc] initWithFrame:frame withImages:images];
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame withImages:(NSArray *)images {
    self=[super initWithFrame:frame];
    if (self) {
        _viewWithWidth=frame.size.width;
        _viewWithHeight=frame.size.height;
        
        _scrollInterval=3.0;
        _animationInterval=0.7;
        
        _isRight=YES;
        
        //显示当前页面
        _currentPage=0;
        _imageViewContentMode=UIViewContentModeScaleAspectFill;
        self.clipsToBounds=YES;
        _imageNamesArray=images;
        
        //初始化滚动视图
        //初始化imageView
        //初始化Timer
        
    }
    return self;
}



@end
