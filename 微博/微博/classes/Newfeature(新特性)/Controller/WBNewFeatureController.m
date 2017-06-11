//
//  WBNewFeatureController.m
//  微博
//
//  Created by BJT on 17/5/17.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBNewFeatureController.h"
#import "WBTabbarController.h"

// newFeature image count
#define kNewFeatureCount 4

@interface WBNewFeatureController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation WBNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // create scrollview
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    scrollView.contentSize = CGSizeMake(kNewFeatureCount * scrollW, 0);
    
    for (int i = 0 ; i < kNewFeatureCount; i++) { // set New Feature image content
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.x = i * scrollW;
        imageView.y = 0;
        
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        
        [scrollView addSubview:imageView];
        if (i == kNewFeatureCount - 1 ) { // last new feature imageview
            [self setupLastImageView:imageView];
        }
        
    }
    
    [self.view addSubview:scrollView];
    
    // create pagecontrol
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = kNewFeatureCount;
//    pageControl.backgroundColor = [UIColor greenColor];
//    pageControl.width = 100;
//    pageControl.height = 50;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = kRGBColor(189, 189, 189);
  
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height - 50;
    
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
   
}

#pragma mark - setupLastImageView
-(void)setupLastImageView:(UIImageView *)imageView
{
    // enable the user Interaction
    imageView.userInteractionEnabled = YES;
    // 1. share button
    UIButton *shareBtn = [[UIButton alloc] init];
//    shareBtn.backgroundColor = [UIColor redColor];
    shareBtn.width = 150;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.6;
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // set margin between imageView and titleLabel
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [shareBtn addTarget:self action:@selector(shareBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    
    // 2.start button
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage: [UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.7;
    [startBtn addTarget:self action:@selector(startBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
    
    
}
-(void)dealloc
{
    WBLog(@"WBNewFeatureController---dealloc");
}

#pragma mark - click start button
- (void)startBtnDidClick
{
    // start weibo , switch to WBTabbarController
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[WBTabbarController alloc] init];

}

#pragma mark -click share button
- (void)shareBtnDidClick:(UIButton *)shareBtn
{
    // update image by changing the selected state
    shareBtn.selected = !shareBtn.isSelected;
}

#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    WBLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    double page = scrollView.contentOffset.x / scrollView.width;
    // update pagecontrol cunrrentPage , round to integer
    self.pageControl.currentPage = (int)(page + 0.5);
    
    
}



@end
