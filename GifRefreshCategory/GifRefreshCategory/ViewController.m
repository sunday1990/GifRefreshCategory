//
//  ViewController.m
//  GifRefreshCategory
//
//  Created by ccSunday on 2017/8/16.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh/MJRefresh.h>
#define ScreenWidth  [[UIScreen mainScreen]bounds].size.width
#define ScreenHeight  [[UIScreen mainScreen]bounds].size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
    MJRefreshGifHeader *_refreshHeader;
    
    MJRefreshAutoGifFooter *_refreshFooter;
    
    NSInteger _rowNum;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _rowNum = 20;
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [UIView new];
    
    _refreshHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self requestData:1];
    }];
    _tableView.mj_header = _refreshHeader;
    
    
    _refreshFooter = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [self requestData:0];
    }];
    _tableView.mj_footer = _refreshFooter;


}

- (void)requestData:(int)pull{
    dispatch_time_t time =  dispatch_time(DISPATCH_TIME_NOW, (uint64_t)(NSEC_PER_SEC * 1.5));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        if (pull == 1) {
            _rowNum = 20;
        }else{
            _rowNum += 20;
        }
        [_tableView reloadData];
        [_refreshFooter endRefreshing];
        [_refreshHeader endRefreshing];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rowNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellID = @"CELL_ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
