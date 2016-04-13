//
//  DetailVC.m
//  成联电商-付建国
//
//  Created by 付建国 on 16/4/12.
//  Copyright © 2016年 sher. All rights reserved.
//

#import "DetailVC.h"
#import "DetailTableViewCell.h"

@interface DetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *backTabelV;/**< 求租仓库TableView */

@property (nonatomic, strong) NSMutableArray *arr;/**< 数据数组 */

@property (nonatomic, assign) CGRect rect;/**< label自定义长度 */

@property (nonatomic, assign) CGRect rect2;/**< label自适应高度 */


@end

@implementation DetailVC

- (void)dealloc{
    self.backTabelV.delegate = nil;
    self.backTabelV.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 搜索按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"地图" style:UIBarButtonItemStylePlain target:self action:@selector(action)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.arr = [NSMutableArray array];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.model.NameCHN, @"公司/个人", nil];
    [self.arr addObject:dic];
    
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:self.model.WHAddress, @"仓库名称", nil];
    [self.arr addObject:dic2];
    
    NSString *str = [NSString stringWithFormat:@"%@", self.model.WHArea];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:str, @"仓库总面积（单位：m2)", nil];
    [self.arr addObject:dic3];
    
    NSString *str2 = [NSString stringWithFormat:@"%@", self.model.WHArealeast];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:str2, @"可租用面积（单位：m2)", nil];
    [self.arr addObject:dic4];
    
    NSString *str3 = [NSString stringWithFormat:@"%@", self.model.WHType];
    NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:str3, @"仓库类型", nil];
    [self.arr addObject:dic5];
    
    NSDictionary *dic6 = [NSDictionary dictionaryWithObjectsAndKeys:@"面议", @"仓库价格", nil];
    [self.arr addObject:dic6];
    
    NSDictionary *dic7 = [NSDictionary dictionaryWithObjectsAndKeys:self.model.WHAddress, @"所属区域", nil];
    [self.arr addObject:dic7];
    
    NSDictionary *dic8 = [NSDictionary dictionaryWithObjectsAndKeys:@"暂无", @"有效期", nil];
    [self.arr addObject:dic8];

    NSDictionary *dic9 = [NSDictionary dictionaryWithObjectsAndKeys:self.model.Description, @"备注", nil];
    [self.arr addObject:dic9];
    
    
    [self createView];
    
}
- (void)createView{
    
    self.backTabelV = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_backTabelV];
    
    self.backTabelV.delegate = self;
    self.backTabelV.dataSource = self;
    
    //注册 cell
    [self.backTabelV registerClass:[DetailTableViewCell class] forCellReuseIdentifier:@"DetailTableViewCell"];
    
}
/**< tableview协议方法 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell"];
    
    cell.dic = self.arr[indexPath.row];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 自定义高度
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil];
    
    // 通过文字大小 获取文本的高度
    NSDictionary *dic2 = self.arr[indexPath.row];
    
    self.rect = [[dic2 allKeys][0] boundingRectWithSize:CGSizeMake(0, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    self.rect2 = [[dic2 objectForKey:[dic2 allKeys][0]] boundingRectWithSize:CGSizeMake(self.view.frame.size.width - self.rect.size.width - 20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return self.rect2.size.height + 40;
    return 40;
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
