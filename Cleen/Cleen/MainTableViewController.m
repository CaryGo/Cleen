//
//  MainTableViewController.m
//  Cleen
//
//  Created by Cary on 2017/1/13.
//  Copyright © 2017年 caryclould. All rights reserved.
//

#import "MainTableViewController.h"

#import "Data.h"
#import "MainCell.h"
#import "HttpClient.h"
#import <MJRefresh.h>

#define request_url @"http://thoughtworks-ios.herokuapp.com/facts.json"

@interface MainTableViewController ()

@property (nonatomic, strong)NSMutableArray * dataSource;
//数据模型
@property(nonatomic, strong)Data * dataModel;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)loadView{
    [super loadView];
    
    [self loadData];
    [self tableViewRefresh];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(requestData)];
}

- (void)tableViewRefresh{
    __unsafe_unretained UITableView *tableView = self.tableView;
    // 下拉刷新
    MJRefreshNormalHeader *header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
        [UIApplication sharedApplication].statusBarHidden = NO;
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 设置刷新控件
    tableView.mj_header = header;
}

- (void)requestData{
    __weak __typeof (self)weakSelf = self;
    [HttpClient getWithURL:request_url params:nil success:^(id json) {
        [weakSelf.tableView.mj_header endRefreshing];
        //json解析model
        Data * dataModel = [Data yy_modelWithJSON:json];
        weakSelf.title = dataModel.title;
        weakSelf.dataModel = dataModel;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        //
    }];
}

/**
 获取数据
 */
- (void) loadData{
    //获取json数据
    NSString * dataPosition = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    if (dataPosition) {
        NSData * data = [[NSData alloc] initWithContentsOfFile:dataPosition];
        //json解析model
        Data * dataModel = [Data yy_modelWithJSON:data];
        self.title = dataModel.title;
        self.dataModel = dataModel;
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataModel) {
        return self.dataModel.rows.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"reuseIdentifier";
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    NSDictionary * dict = self.dataModel.rows[indexPath.row];
    RowType * rowInfo = [RowType yy_modelWithDictionary:dict];
    cell.row = rowInfo;
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dict = self.dataModel.rows[indexPath.row];
    RowType * rowInfo = [RowType yy_modelWithDictionary:dict];
    if (rowInfo) {
        //计算cell的高度 没做缓存
        return [MainCell cellHeightWithModel:rowInfo];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
