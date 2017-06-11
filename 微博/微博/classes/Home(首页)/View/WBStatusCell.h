//
//  WBStatusCell.h
//  微博
//
//  Created by BJT on 17/5/22.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBStatusFrame;
@interface WBStatusCell : UITableViewCell

@property (nonatomic,strong) WBStatusFrame *statusFrame;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
