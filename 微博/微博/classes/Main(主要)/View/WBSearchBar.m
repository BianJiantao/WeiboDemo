//
//  WBSearchBar.m
//  微博
//
//  Created by BJT on 17/5/15.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBSearchBar.h"

@implementation WBSearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        // create searchIcon in left
        UIImageView *searchIcon = [[UIImageView alloc]init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

+(instancetype)searchBar
{
    return [[self alloc] init];
}

@end
