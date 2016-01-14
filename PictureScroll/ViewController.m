//
//  ViewController.m
//  PictureScroll
//
//  Created by cq on 16/1/13.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "ViewController.h"
#import "CSSPictureScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor redColor];
    
    [self addImageScroll];
    
    for (int i=0; i<100; i++) {
        UIImageView *imageView=[[UIImageView alloc] init];
        [self.view addSubview:imageView];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)addImageScroll {
    CGRect screenFrame=[[UIScreen mainScreen] bounds];
    CGRect frame=CGRectMake(10, 60, screenFrame.size.width-20, 200);
    
    NSArray *imageArray=@[@"001.png", @"002.png", @"003.png", @"004.png", @"005.png"];
    CSSPictureScrollView *imageViewDisplay=[CSSPictureScrollView CSSPictureScrollViewWithFrame:frame WithImages:imageArray];
    imageViewDisplay.scrollInterval=3;
    
    
    
    imageViewDisplay.animationInterval=0.6;
    [self.view addSubview:imageViewDisplay];
    [imageViewDisplay addTapEventForImageWithBlock:^(NSInteger imageIndex) {
        NSLog(@"%ld",imageIndex);
        if (imageIndex==2) {
            NSLog(@"我要弹出来");
            
        }
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
