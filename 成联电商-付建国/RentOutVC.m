//
//  RentOutVC.m
//  成联电商-付建国
//
//  Created by 付建国 on 16/4/12.
//  Copyright © 2016年 sher. All rights reserved.
//

#import "RentOutVC.h"
#import "APPTools.h"
#import "RentOutModel.h"
#import "RentOutTableViewCell.h"
#import "RentOutDegistVC.h"
#import "DetailVC.h"

@interface RentOutVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *backTabelV;/**< 求租仓库TableView */
@property (nonatomic, strong) NSMutableArray *modelArr;/**< model数组 */

@end

@implementation RentOutVC

- (void)dealloc{
    self.backTabelV.delegate = nil;
    self.backTabelV.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"求租仓库";
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationController.navigationBar.translucent = NO;
    // 改变navigationBar字体的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 搜索按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(action)];
    self.navigationItem.rightBarButtonItem = rightButton;

    
    
    [self createView];
    [self dataHander];
    
}
// 搜索点击
- (void)action{
    RentOutDegistVC *degistVC = [[RentOutDegistVC alloc] init];
    
    [self.navigationController pushViewController:degistVC animated:YES];

}

- (void)createView{
    
    self.backTabelV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    [self.view addSubview:_backTabelV];
    
    self.backTabelV.delegate = self;
    self.backTabelV.dataSource = self;
    
    self.backTabelV.rowHeight = 130;
    
    //注册 cell
    [self.backTabelV registerClass:[RentOutTableViewCell class] forCellReuseIdentifier:@"RentOutTableViewCell"];
    
    // 改变返回按钮颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}
/**< tableview协议方法 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RentOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentOutTableViewCell"];
    
    RentOutModel *model = self.modelArr[indexPath.row];
    
    cell.model = model;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailVC *detaiVC = [[DetailVC alloc] init];
    
    RentOutModel *model = self.modelArr[indexPath.row];

    detaiVC.model = model;
    
    [self.navigationController pushViewController:detaiVC animated:YES];
    
}

// 数据解析
- (void)dataHander{
    
    self.modelArr = [NSMutableArray array];
    if (self.vtypes != nil) {
    
        NSString *url = [NSString stringWithFormat:@"http://www.560315.com/MobileAPI/WarehouseList?keys=%@&vtypes=%@", self.type, self.vtypes];
        //(汉字)转码
        NSString *URL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:url]];
        NSLog(@"%@", URL);
        [APPTools GETWithURL:URL par:nil success:^(id responseObject) {
            
            NSArray *arr = [NSArray arrayWithArray:responseObject];
            
            self.modelArr = [RentOutModel modelHandleWithArray:arr];
            
            NSLog(@"%ld", self.modelArr.count);
            
            [self.backTabelV reloadData];
            
        } filed:^(NSError *error) {
            
            
            NSLog(@"数据解析失败");
            
        }];
    }else{
        
        NSString *url = @"http://www.560315.com/MobileAPI/WarehouseList?keys=&vtypes=";
        [APPTools GETWithURL:url par:nil success:^(id responseObject) {
            
            NSArray *arr = [NSArray arrayWithArray:responseObject];
            
            self.modelArr = [RentOutModel modelHandleWithArray:arr];
            
            NSLog(@"%ld", self.modelArr.count);
            
            [self.backTabelV reloadData];
            
        } filed:^(NSError *error) {
            
            
            NSLog(@"数据解析失败");
            
        }];

    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
