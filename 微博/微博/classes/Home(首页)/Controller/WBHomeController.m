//
//  WBHomeController.m
//  微博
//
//  Created by BJT on 17/5/14.
//  Copyright © 2017年 BJT. All rights reserved.
//



#import "NSDictionary+Extension.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#import "WBHomeController.h"
#import "WBDropDownMenu.h"
#import "WBDropDownMenuController.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "WBTitleButton.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "WBLoadMoreFooter.h"
#import "WBStatusCell.h"
#import "WBStatusFrame.h"
#import "WBHttpTool.h"
#import "WBStatusCacheTool.h"

@interface WBHomeController ()<WBDropDownMenuDelegate>
/**
 *  weibo statusFrame model array
 */
@property (nonatomic,strong) NSMutableArray *statusFrames;

@end

@implementation WBHomeController

-(NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = kRGBColor(220, 220, 220);
    
    // set NavigationBar content
    [self setupNavigationBar];
    // set user name
    [self setupUserInfo];
    
    // add down pull RefreshControl
    [self setupDownRefresh];
    
    // add up pull RefreshControl
    [self setupUpRefresh];
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(setUnReadCount) userInfo:nil repeats:YES];
//    // monitor scroll event mode
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}




#pragma mark - set statuses unread count
/**
 *  set statuses unread count
 */
- (void)setUnReadCount
{
//    WBLog(@"setUnReadCount");
    
    WBAccount *account = [WBAccountTool account];
    NSString *urlStr = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"access_token"] = account.access_token;
    paras[@"uid"] = account.uid;
    //        paras[@"count"] = @10;
    
    [WBHttpTool GET:urlStr parameters:paras success:^(id responseObject) {
        
        //        WBLog(@"setUnReadCount--%@",responseObject);
        
        //status	int	新微博未读数
        NSString *statusUnReadCount = [responseObject[@"status"] description];
        
        if ([statusUnReadCount isEqualToString:@"0"]) { // unread count is 0
            
            // clear tabBar badgeValue
            self.tabBarItem.badgeValue = nil;
            // set appliciation badgeValue 0 to hide
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            
        }else{
            // set tabBar badgeValue
            self.tabBarItem.badgeValue = statusUnReadCount;
            // set appliciation badgeValue
            [UIApplication sharedApplication].applicationIconBadgeNumber = statusUnReadCount.integerValue;
        }
        
    } failure:^(NSError *error) {
        
        WBLog(@"failure,%@",error);
        
    }];
}



// change tableFooterView height
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.tableFooterView.height = 30;
}

- (void)setupUpRefresh
{
    /* 法1 : 自己写上拉刷新 */
    WBLoadMoreFooter *footer = [WBLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
    
    /* 法2 : 第三方框架 */
//    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
}

- (void)setupDownRefresh
{
    /* 法1 : 自己写下拉刷新 */
    UIRefreshControl *freshControl = [[UIRefreshControl alloc] init];
    [freshControl addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:freshControl];
    
    // auto refresh
    [freshControl beginRefreshing];
    [self loadNewStatus:freshControl];
    
}

/**
 *  change status array to statusFrame array
 *
 */
-(NSArray *)statusFramesWithStatus:(NSArray *)statusArray
{
    NSMutableArray *statusFrameArray = [NSMutableArray array];
    for (WBStatus *status in statusArray) {
        WBStatusFrame *statusFrame = [[WBStatusFrame alloc] init];
        statusFrame.status = status;
        [statusFrameArray addObject:statusFrame];
    }
    return statusFrameArray;
}


#pragma mark - load more statuses
/**
 *  load more weibo statuses
 */
- (void)loadMoreStatus
{
    WBAccount *account = [WBAccountTool account];
    NSString *urlStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"access_token"] = account.access_token;
//        paras[@"count"] = @10;
    
    // max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    WBStatusFrame *statusF = [self.statusFrames lastObject];
    if (statusF) {
        
        paras[@"max_id"] = [NSString stringWithFormat:@"%lld",statusF.status.idstr.longLongValue - 1];
    }
    
    NSArray *statuses = [WBStatusCacheTool statusesFromCacheWithParameters:paras];
    if (statuses.count) {
        
        // MJExtension: change Dictionary array to model array
        NSArray  *newStatuses = [WBStatus objectArrayWithKeyValuesArray:statuses];
        
        NSArray *statusF = [self statusFramesWithStatus:newStatuses];
        
        [self.statusFrames addObjectsFromArray:statusF];
        
        [self.tableView reloadData];
        // end refresh , hide footer
        self.tableView.tableFooterView.hidden = YES;
        
    }else{
        
        [WBHttpTool GET:urlStr parameters:paras success:^(id responseObject) {
            
            [WBStatusCacheTool saveStatusToCache:responseObject[@"statuses"]];
            
            // MJExtension: change Dictionary array to model array
            NSArray  *newStatuses = [WBStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
            
            NSArray *statusF = [self statusFramesWithStatus:newStatuses];
            
            [self.statusFrames addObjectsFromArray:statusF];
            
            [self.tableView reloadData];
            // end refresh , hide footer
            self.tableView.tableFooterView.hidden = YES;
            
        } failure:^(NSError *error) {
            
            WBLog(@"failure,%@",error);
            
            self.tableView.tableFooterView.hidden = YES;
        }];
    }
    
    

}

#pragma mark - load new statuses
/**
 *  load new weibo statuses
 */
- (void)loadNewStatus:(UIRefreshControl *)freshControl
{
    
    WBAccount *account = [WBAccountTool account];
    NSString *urlStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"access_token"] = account.access_token;
//        paras[@"count"] = @10;
    
    // since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    WBStatusFrame *statusFrame = [self.statusFrames firstObject];
    if (statusFrame) {
        
        paras[@"since_id"] = statusFrame.status.idstr;
    }
    
    NSArray *statuses = [WBStatusCacheTool statusesFromCacheWithParameters:paras];
    if (statuses.count) { // 有缓存
        
        NSArray  *newStatuses = [WBStatus objectArrayWithKeyValuesArray:statuses];
        
        NSArray *statusF = [self statusFramesWithStatus:newStatuses];
        
        // show new status count
        [self showStatusCount:statusF.count];
        
        NSRange range = NSMakeRange(0, statusF.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:statusF atIndexes:indexSet];
        
        [self.tableView reloadData];
        
        // end refresh
        [freshControl endRefreshing];
        
    }else{
        [WBHttpTool GET:urlStr parameters:paras success:^(id responseObject) {
            
            //        WBLog(@"%@",responseObject);
            //     //replace value which is null by "";
            //        NSDictionary *dict = [responseObject dictionaryByRemoveNULL];
            //        NSString *path = @"/Users/bjt/Desktop/status.plist";
            //        WBLog(@"%d",[dict writeToFile:path atomically:YES]);
            
            //        NSArray *dictArray = responseObject[@"statuses"];
            //        for (NSDictionary *dict in dictArray) {
            //
            ////            WBStatus *status = [WBStatus statusWithDict:dict];
            //            WBStatus *status = [WBStatus objectWithKeyValues:dict];
            //            [self.statuses addObject:status];
            //        }
            
            // 缓存到数据库
            [WBStatusCacheTool saveStatusToCache:responseObject[@"statuses"]];
            
            // MJExtension: change Dictionary array to model array
            NSArray  *newStatuses = [WBStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
            
            NSArray *statusF = [self statusFramesWithStatus:newStatuses];
            
            // show new status count
            [self showStatusCount:statusF.count];
            
            NSRange range = NSMakeRange(0, statusF.count);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [self.statusFrames insertObjects:statusF atIndexes:indexSet];
            
            [self.tableView reloadData];
            
            // end refresh
            [freshControl endRefreshing];
            
            
        } failure:^(NSError *error) {
            
            WBLog(@"failure,%@",error);
            
            // end refresh
            [freshControl endRefreshing];
            
        }];
        

    }
    
}

#pragma mark - show new status count
- (void)showStatusCount:(NSInteger) statusCount
{
    /* reset badgeValue when refresh new statuses */
    // clear tabBar badgeValue
    self.tabBarItem.badgeValue = nil;
    // set appliciation badgeValue 0 to hide
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    UILabel *label = [[UILabel alloc] init];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 44;
    label.y = 64 - label.height;
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    
    if (statusCount == 0) {
        label.text = [NSString stringWithFormat:@"没有新微博数据,请稍后再试"];
    }else{
        label.text = [NSString stringWithFormat:@"刷新到%ld条微博数据",statusCount];
    }
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        
    } completion:^(BOOL finished) {
        
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            
            label.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }];
}





/**
 *  setup User Info
 */
- (void)setupUserInfo
{
    /*
     access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
     uid	false	int64	需要查询的用户ID。
     */
    WBAccount *account = [WBAccountTool account];
    NSString *urlStr = @"https://api.weibo.com/2/users/show.json";
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"access_token"] = account.access_token;
    paras[@"uid"] = account.uid;
    
    [WBHttpTool GET:urlStr parameters:paras success:^(id responseObject) {
        
        //        WBLog(@"success,%@",responseObject);
        //        NSString *name = responseObject[@"name"];
        
        //        WBUser *user = [WBUser userWithDict:responseObject];
        
        // MJExtension: change Dictionary  to model
        WBUser *user = [WBUser objectWithKeyValues:responseObject];
        // save user name to sandBox
        account.name = user.name;
        [WBAccountTool saveAccount:account];
        
        WBTitleButton *titleBtn = (WBTitleButton *)self.navigationItem.titleView;
        [titleBtn setTitle:user.name forState:UIControlStateNormal];
        

    } failure:^(NSError *error) {
        
        WBLog(@"failure,%@",error);
        

    }];
   

}

/**
 *  setup NavigationBar
 */
- (void)setupNavigationBar
{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"];
    
    WBTitleButton *titleBtn = [[WBTitleButton alloc] init];
    // get user name from sandBox
    NSString *name = [WBAccountTool account].name;
    [titleBtn setTitle:name?name:@"首页" forState: UIControlStateNormal];
    
    [titleBtn addTarget:self action:@selector(titBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    
//    WBLog(@"%@",NSStringFromCGRect(titleBtn.frame));
//     WBLog(@"%@",NSStringFromCGRect(titleBtn.titleLabel.frame));
//     WBLog(@"%@",NSStringFromCGRect(titleBtn.imageView.frame));

}


/**
 *  click title
 */
- (void)titBtnClick:(UIButton *)titleBtn
{
    
    // 1. create dropdownMenu
    WBDropDownMenu *dropdownMenu = [WBDropDownMenu menu];
    dropdownMenu.delegate = self;
    
    // 2. set dropdownMenu's content
    WBDropDownMenuController *menuVc = [[WBDropDownMenuController alloc] init];
    menuVc.view.height = 150;
    menuVc.view.width = 150;
    dropdownMenu.contentVc = menuVc;
    
    // 3. show dropdownMenu
    [dropdownMenu showFrom:titleBtn];
    
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    

}

#pragma mark - WBDropDownMenuDelegate

-(void)dropDownMenuDidDismiss:(WBDropDownMenu *)dropDownMenu
{
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
    
    // change titleButton image
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    titleBtn.selected = NO;
}
-(void)dropDownMenuDidShow:(WBDropDownMenu *)dropDownMenu
{
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
    
    // change titleButton image
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleBtn.selected = YES;
}



- (void)friendSearch
{
    NSLog(@"%s",__func__);
}

- (void)pop
{
    NSLog(@"%s",__func__);
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView];
    
    /* viewFrame */
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    
/* 2 model
    // get status model
    WBStatus *status = self.statuses[indexPath.row];
    // get user model
    WBUser *user = status.user;
    
    // set user name
    cell.textLabel.text = user.name;
    UIImage *placeholderImage = [UIImage imageNamed:@"avatar_default_small"];
    // set user icon
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placeholderImage];
    
    // set status text
    cell.detailTextLabel.text = status.text;
  */
    
/* 1 NSDictionary
     
     NSDictionary *status = self.statuses[indexPath.row];
     NSDictionary *user = status[@"user"];
     
     // set user name
     cell.textLabel.text = user[@"name"];
     
     // set user icon
     NSString *imageUrl = user[@"profile_image_url"];
     UIImage *placeholderImage = [UIImage imageNamed:@"avatar_default_small"];
     [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholderImage];
     
     // set status text
     cell.detailTextLabel.text = status[@"text"];
     
     
*/
    
    
//    NSIndexPath *index = [NSIndexPath indexPathForRow:self.statuses.count-1 inSection:0];
//    CGRect rect = [tableView rectForRowAtIndexPath:index];
//    WBLog(@"%@",NSStringFromCGRect(rect));
    
    return  cell;
}

/**
 *  show the FooterView when last cell is entirely visiable , then load more statuses
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat offsetY = scrollView.contentOffset.y;
//    CGFloat judgeOffSetY = scrollView.contentSize.height ;
    
//    WBLog(@"tableFooterView%@",NSStringFromCGRect(self.tableView.tableFooterView.frame));
//    WBLog(@"tableView%f", self.tableView.contentOffset.y + self.tableView.height);
    
    // return when controller has no status or  is loading more status
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.hidden == NO)  return;
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.statusFrames.count-1 inSection:0];
    // get the last cell frame
    CGRect lastCellFrme = [self.tableView rectForRowAtIndexPath:index];
//        WBLog(@"%@",NSStringFromCGRect(rect));

    CGFloat lastCellMaxY = CGRectGetMaxY(lastCellFrme);
    CGFloat tableViewMaxY = self.tableView.contentOffset.y + self.tableView.height;
    if (tableViewMaxY >= lastCellMaxY) { // show the FooterView when last cell is entirely visiable
        
        self.tableView.tableFooterView.hidden = NO;
        
        [self loadMoreStatus];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatusFrame *statusF = self.statusFrames[indexPath.row];
    return statusF.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBLog(@"didSelectRowAtIndexPath--%ld",indexPath.row);
}


@end
