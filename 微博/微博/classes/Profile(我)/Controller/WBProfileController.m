//
//  WBProfileController.m
//  微博
//
//  Created by BJT on 17/5/14.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "SDWebImageManager.h"

#import "WBProfileController.h"

@interface WBProfileController ()

@end

@implementation WBProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:0 target:nil action:nil];
    
//    self.navigationItem.rightBarButtonItem.enabled = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    NSInteger byteSzie = [SDImageCache sharedImageCache].getSize;
    CGFloat size = byteSzie / 1000.0 / 1000.0; // Byte -> Mb
    cell.textLabel.text = [NSString stringWithFormat:@"清理图片缓存 (%.1fM)",size];
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 清楚图片缓存
    [[SDImageCache sharedImageCache] clearDisk];
    [tableView reloadData];
}

@end
