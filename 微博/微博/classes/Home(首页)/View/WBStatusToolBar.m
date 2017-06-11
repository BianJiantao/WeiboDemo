//
//  WBStatusToolBar.m
//  微博
//
//  Created by BJT on 17/5/23.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBStatusToolBar.h"
#import "WBStatus.h"

@interface WBStatusToolBar ()

@property (nonatomic,strong) NSMutableArray *btnArray;
@property (nonatomic,strong) NSMutableArray *divideLineArray;


/** 转发按钮 repost  button */
@property (nonatomic,strong) UIButton *repostBtn;
/** 评论按钮 comments button */
@property (nonatomic,strong) UIButton *commentBtn;
/** 点赞按钮 like button */
@property (nonatomic,strong) UIButton *attitudeBtn;

@end

@implementation WBStatusToolBar

+(instancetype)toolBar
{
    return [[self alloc] init];
}

-(NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

-(NSMutableArray *)divideLineArray
{
    if (_divideLineArray == nil) {
        _divideLineArray = [NSMutableArray array];
    }
    return _divideLineArray;
}

-(instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        self.repostBtn = [self setupBtnWithImage:@"timeline_icon_retweet" title:@"转发"];
        self.commentBtn = [self setupBtnWithImage:@"timeline_icon_comment" title:@"评论"];
        self.attitudeBtn = [self setupBtnWithImage:@"timeline_icon_unlike" title:@"赞"];
        
        [self setupDivideLine];
        [self setupDivideLine];
        
    }
    return self;
}
/**
 *  add divide line between button
 */
-(void)setupDivideLine
{
    UIImageView *divideLine = [[UIImageView alloc] init];
    divideLine.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [divideLine sizeToFit];
    [self.divideLineArray addObject:divideLine];
    [self addSubview:divideLine];
}

/**
 *  add button
 */
-(UIButton *)setupBtnWithImage:(NSString *)icon title:(NSString *)title
{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.btnArray addObject:btn];
    [self addSubview:btn];
    
    return btn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // set button frame
    NSInteger btnCount = self.btnArray.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0 ; i < btnCount; i++) {
        UIButton *btn = self.btnArray[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
    
    // set divide Line frame
    
    NSInteger lineCount = self.divideLineArray.count;
    for (int i = 0; i < lineCount; i++) {
        
        UIImageView *divideLine = self.divideLineArray[i];
        divideLine.x = (i + 1) * btnW;
        
    }
}

-(void)setStatus:(WBStatus *)status
{
    _status = status;
    
//    status.reposts_count  = 123456; // 12.3万
//    status.comments_count = 230008; // 23万
//    status.attitudes_count = 8999; // 8999
    
    [self setBtn:self.repostBtn Count:status.reposts_count title:@"转发"];
    [self setBtn:self.commentBtn Count:status.comments_count title:@"评论"];
    [self setBtn:self.attitudeBtn Count:status.attitudes_count title:@"赞"];

    
}

/**
 *  set toolBar button title
 *
 */
- (void)setBtn:(UIButton *)btn Count:(int)count title:(NSString *)title
{
    /** title style
     
     status.reposts_count  = 123456; // 12.3万
     status.comments_count = 230008; // 23万
     status.attitudes_count = 8999; // 8999
     
     */
    
    // set title style
    if (count) {
        
        if (count < 10000) {
            
            title = [NSString stringWithFormat:@"%d",count];
        }else{
            
            double number = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",number];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
}



@end
