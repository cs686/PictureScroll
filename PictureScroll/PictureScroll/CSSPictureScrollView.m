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

@property (nonatomic, strong) UIPageControl *imageViewPageControl;

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
        [self initScrollView];
        //初始化imageView
        [self addImageViewsForMainScroll];
        //初始化Timer
        [self addTimerLoop];
        //初始化PageControll
        [self addPageControll];
        
    }
    return self;
}

- (void)addPageControll{
    _imageViewPageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, _viewWithHeight-20, _viewWithWidth, 20)];
    _imageViewPageControl.numberOfPages=_imageNamesArray.count;
    _imageViewPageControl.currentPage=_currentPage-1;
    _imageViewPageControl.currentPageIndicatorTintColor=[UIColor blackColor];
    _imageViewPageControl.pageIndicatorTintColor=[UIColor whiteColor];
    [self addSubview:_imageViewPageControl];
}

- (void)addTapEventForImageWithBlock:(TapImageButtonBlock) block; {
    if (_block == nil) {
        if (block!=nil) {
            _block=block;
            [self initImageViewButton];
        }
    }
}

- (void) initImageViewButton {
    for (int i=0; i<_imageViewsArray.count+1; i++) {
        CGRect currentFrame=CGRectMake(_viewWithWidth*i, 0, _viewWithWidth, _viewWithHeight);
        
        UIButton *tempButton=[[UIButton alloc] initWithFrame:currentFrame];
        
        [tempButton addTarget:self action:@selector(tapImageButton:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            tempButton.tag=_imageViewsArray.count;
        } else {
            tempButton.tag=i;
        }
        [_mainScrollView addSubview:tempButton];
    }
}

- (void) tapImageButton:(UIButton*)sender {
    if (_block) {
        _block(_currentPage+1);
        //NSLog(@"ddddd");
        //NSLog(@"%@",sender);
    }
    
}

- (void)initScrollView {
    _mainScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _viewWithWidth, _viewWithHeight)];
    _mainScrollView.contentSize=CGSizeMake(_viewWithWidth, _viewWithHeight);
    _mainScrollView.pagingEnabled=YES;
    _mainScrollView.showsVerticalScrollIndicator=NO;
    _mainScrollView.showsHorizontalScrollIndicator=NO;
    _mainScrollView.delegate=self;
    [self addSubview:_mainScrollView];
}

#pragma mark 添加imageView
- (void)addImageViewsForMainScroll {
    _mainScrollView.contentSize=CGSizeMake(_viewWithWidth*2, _viewWithHeight);
    _imageViewsArray=[[NSMutableArray alloc] initWithCapacity:2];
    for (int i=0; i<2; i++) {
        CGRect currentFrame=CGRectMake(_viewWithWidth*i, 0, _viewWithWidth, _viewWithHeight);
        UIImageView *tempImageView=[[UIImageView alloc] initWithFrame:currentFrame];
        tempImageView.contentMode=_imageViewContentMode;
        tempImageView.clipsToBounds=YES;
        [_mainScrollView addSubview:tempImageView];
        [_imageViewsArray addObject:tempImageView];
    }
    UIImageView *tempImageView =_imageViewsArray[0];
    [tempImageView setImage:[UIImage imageNamed:_imageNamesArray[0]]];
    
}

- (void)addTimerLoop{
    self.translatesAutoresizingMaskIntoConstraints=NO;
    if (_timer==nil) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:_scrollInterval target:self selector:@selector(changeOffset) userInfo:nil repeats:YES];
        
    }
}

- (void)changeOffset {
    _currentPage++;
    if (_currentPage >= _imageNamesArray.count) {
        _currentPage=0;
    }
    if (_currentPage<_imageNamesArray.count) {
        UIImageView *tempImageView=_imageViewsArray[1];
        [tempImageView setImage:[UIImage imageNamed:_imageNamesArray[_currentPage]]];
    }
    [UIView animateWithDuration:_animationInterval animations:^{
        if (_isRight) {
            _mainScrollView.contentOffset=CGPointMake(_viewWithWidth, 0);
        } else {
            _mainScrollView.contentOffset=CGPointMake(-_viewWithWidth, 0);
        }
    } completion:^(BOOL finished) {
        if (_currentPage < _imageNamesArray.count) {
            
            _mainScrollView.contentOffset = CGPointMake(0, 0);
            UIImageView *tempImageView = _imageViewsArray[0] ;
            [tempImageView setImage:[UIImage imageNamed:_imageNamesArray[_currentPage]]];
            
        }
    }];
    _imageViewPageControl.currentPage=_currentPage;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _currentPage ++;
    
    //如果是最后一个图片，让其成为第一个
    if (_currentPage >= _imageNamesArray.count) {
        _currentPage = 0;
    }
    
    //将要显示的视图
    if(_currentPage < _imageNamesArray.count){
        UIImageView *tempImageView = _imageViewsArray[1] ;
        [tempImageView setImage:[UIImage imageNamed:_imageNamesArray[_currentPage]]];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //说明是用的第二个ImageView
    if (_currentPage < _imageNamesArray.count) {
        
        _mainScrollView.contentOffset = CGPointMake(0, 0);
        UIImageView *tempImageView = _imageViewsArray[0] ;
        [tempImageView setImage:[UIImage imageNamed:_imageNamesArray[_currentPage]]];
        
    }
    
    
    _imageViewPageControl.currentPage = _currentPage;
    
    [self resumeTimer];
    
    
}

#pragma 暂停定时器
-(void)resumeTimer{
    
    if (![_timer isValid]) {
        return ;
    }
    
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_scrollInterval-_animationInterval]];
    
}

#pragma 改变方向
- (void) LoopRightWithBool: (BOOL) isRight{
    _isRight =isRight;
    UIImageView *secondImageView = _imageViewsArray[1];
    
    if (isRight) {
        secondImageView.frame = CGRectMake(_viewWithWidth, 0, _viewWithWidth, _viewWithHeight);
    } else {
        secondImageView.frame = CGRectMake(-_viewWithWidth, 0, _viewWithWidth, _viewWithHeight);
    }
}


@end
