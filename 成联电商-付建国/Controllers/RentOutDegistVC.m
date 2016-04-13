//
//  RentOutDegistVC.m
//  成联电商-付建国
//
//  Created by 付建国 on 16/4/12.
//  Copyright © 2016年 sher. All rights reserved.
//

#import "RentOutDegistVC.h"
#import "APPTools.h"
#import "RentOutModel.h"
#import "RentOutVC.h"

@interface RentOutDegistVC ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *backView;/**< 底层tableview */
@property (nonatomic, strong) UIPickerView *pickView;/**< 选择器 */
@property (nonatomic, retain) NSMutableArray *pArr;/**< 省市区数组及判断类型 */
@property (nonatomic, retain) NSMutableArray *pNameArr;
@property (nonatomic, retain) NSMutableArray *cityArr;
@property (nonatomic, retain) NSMutableArray *areaArr;
@property (nonatomic, strong) NSMutableArray *kindArr;
@property (nonatomic, assign) NSInteger kindOfData;
@property (nonatomic, strong) UIButton *addressBtn;/**< 地区按钮 */
@property (nonatomic, strong) UIButton *kindSizeBtn;/**< 仓库类型按钮 */
@property (nonatomic, strong) UITextField *firstTF;
@property (nonatomic, copy) NSNumber *numb;

@property (nonatomic, assign)BOOL isFirst;


@end

@implementation RentOutDegistVC

- (void)dealloc{
    self.pickView.delegate = nil;
    self.pickView.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _isFirst = YES;

    self.firstTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, 30)];
    _firstTF.placeholder = @"请输入关键字";
    [self.view addSubview:_firstTF];
    _firstTF.layer.borderWidth = 1;
    _firstTF.layer.cornerRadius = 5;
    
    UITextField *sizeTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 70, (self.view.frame.size.width - 40) / 2, 30)];
    sizeTF.placeholder = @"仓库面积M2";
    [self.view addSubview:sizeTF];
    sizeTF.layer.borderWidth = 1;
    sizeTF.layer.cornerRadius = 5;

    
    UITextField *otherSizeTF = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 40) / 2 + 30, 70, (self.view.frame.size.width - 40) / 2, 30)];
    otherSizeTF.placeholder = @"剩余面积M2";
    [self.view addSubview:otherSizeTF];
    otherSizeTF.layer.borderWidth = 1;
    otherSizeTF.layer.cornerRadius = 5;

    self.addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addressBtn.frame = CGRectMake(10, 120, (self.view.frame.size.width - 40) / 2, 30);
    [_addressBtn setTitle:@"未选择>" forState:UIControlStateNormal];
    [_addressBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_addressBtn addTarget:self action:@selector(addressBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addressBtn];
    _addressBtn.layer.borderWidth = 1;
    _addressBtn.layer.cornerRadius = 5;

    self.kindSizeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _kindSizeBtn.frame = CGRectMake((self.view.frame.size.width - 40) / 2 + 30, 120, (self.view.frame.size.width - 40) / 2, 30);
    [_kindSizeBtn setTitle:@"仓库类型>" forState:UIControlStateNormal];
    [_kindSizeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_kindSizeBtn addTarget:self action:@selector(kindSizeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_kindSizeBtn];
    _kindSizeBtn.layer.borderWidth = 1;
    _kindSizeBtn.layer.cornerRadius = 5;

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 170, self.view.frame.size.width - 20, 30);
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:button];
    
    UILabel *phoneL = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, (self.view.frame.size.width - 40) / 2, 30)];
    phoneL.text = @"服务热线：";
    [self.view addSubview:phoneL];
    
    UILabel *otherPhoneL = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 40) / 2 - 10, 220, (self.view.frame.size.width - 40) / 2, 30)];
    otherPhoneL.text = @"400-662-9256";
    otherPhoneL.textColor = [UIColor redColor];
    [self.view addSubview:otherPhoneL];
    
    // 省市字典解析
    [self Handle];
    self.pNameArr = [NSMutableArray array];
    for (NSDictionary *dic in _pArr) {
        [_pNameArr addObject:dic[@"pName"]];

    }
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 260, self.view.frame.size.width, self.view.frame.size.height - 400)];
    [self.view addSubview:_backView];
    
    // 选择器
    self.pickView = [[UIPickerView alloc] init];
    _pickView.frame = CGRectMake(0, 50, self.view.frame.size.width, 200);
    [self.backView addSubview:self.pickView];

    _pickView.dataSource = self;
    _pickView.delegate = self;
    [_pickView selectRow:5 inComponent:0 animated:YES];

    // 仓库类型
    self.kindArr = [NSMutableArray array];
    
    
}
/**< pickerview的协议方法 */
// 选择器的列数（轮子的个数）
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.kindOfData == 1) {
        return 3;
    }else{
        return 1;
    }
}
//每个轮子所显示的个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.kindOfData == 1) {
        
        if (component == 0) {
            return _pNameArr.count;
        }else if(component == 1){
            if (_isFirst) {
                // 取出省字典
                NSMutableDictionary *dic = _pArr[0];
                // 取出市数组
                _cityArr = [dic objectForKey:@"city"];
            }
            return _cityArr.count;
        }else{
            if (_isFirst) {
                NSMutableDictionary *dic = _cityArr[0];
                _areaArr = [dic objectForKey:@"area"];

            }
            return _areaArr.count;
        }
    }else{
        return self.kindArr.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.kindOfData == 1) {
        
        if (component == 0) {
            return _pNameArr[row];
        }else if(component == 1){
            return _cityArr[row][@"cName"];
        }else{
            return _areaArr[row];
        }
    }else{
        RentOutModel *model = [[RentOutModel alloc] init];
        model = _kindArr[row];

        return model.WarehouseType;
    }
    
}
// 点击方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.kindOfData == 1) {
        _isFirst = NO;
        if (component == 0) {
            // 取出省字典
            NSMutableDictionary *dic = _pArr[row];
            // 取出市数组
            _cityArr = [dic objectForKey:@"city"];
            // 取出区数组
            NSMutableDictionary *dic2 = _cityArr[0];
            _areaArr = [dic2 objectForKey:@"area"];

            [_pickView reloadAllComponents];
            [_pickView selectRow:0 inComponent:1 animated:NO];
            [_pickView selectRow:0 inComponent:2 animated:NO];
            [self.addressBtn setTitle:_areaArr[0] forState:UIControlStateNormal];

        }
        if (component == 1) {
            NSMutableDictionary *dic = _cityArr[row];
            _areaArr = [dic objectForKey:@"area"];
            
            [_pickView reloadAllComponents];
            [_pickView selectRow:0 inComponent:2 animated:NO];
            [self.addressBtn setTitle:_areaArr[0] forState:UIControlStateNormal];

        }
        if (component == 2) {
            [self.addressBtn setTitle:_areaArr[row] forState:UIControlStateNormal];
        }
    }else{
        RentOutModel *model = [[RentOutModel alloc] init];
        model = _kindArr[row];
        [self.kindSizeBtn setTitle:model.WarehouseType forState:UIControlStateNormal];
        self.numb = model.Identifier;
    }
}

- (void)Handle{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"txt"];

    NSString *bigStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    // 创建大数组
    NSArray *arr = [bigStr componentsSeparatedByString:@"\n"];
    
    // 创建省数组
    self.pArr = [NSMutableArray array];
    
    // 遍历数组
    for (NSString *str in arr) {
        // 省
        if (![str hasPrefix:@"  "]) {
            // 创建省字典
            NSMutableDictionary *pDic = [NSMutableDictionary dictionary];
            // 保存省名(第一对键值)
            [pDic setObject:str forKey:@"pName"];
            // 创建市数组
            NSMutableArray *cArr = [NSMutableArray array];
            // 保存市数组(第二对键值)
            [pDic setObject:cArr forKey:@"city"];
            // 添加到省数组
            [_pArr addObject:pDic];
            // 市
        } else if ([str hasPrefix:@"  "] && ![str hasPrefix:@"    "]) {
            // 从省数组中取出 当前省字典
            NSMutableDictionary *pDic = [_pArr lastObject];
            // 取出市数组
            NSMutableArray *cArr = [pDic objectForKey:@"city"];
            // 创建市字典
            NSMutableDictionary *cDic = [NSMutableDictionary dictionary];
            // 保存市名(第一对键值)
            [cDic setObject:str forKey:@"cName"];
            // 创建区数组
            NSMutableArray *areaArr = [NSMutableArray array];
            // 保存区数组(第二对键值)
            [cDic setObject:areaArr forKey:@"area"];
            // 把市字典放到市数组中
            [cArr addObject:cDic];
            // 区
        } else {
            // 取出当前省字典
            NSMutableDictionary *pDic = [_pArr lastObject];
            // 取出当前省的市数组
            NSMutableArray *cArr = [pDic objectForKey:@"city"];
            // 取出当前市的市字典
            NSMutableDictionary *cDic = [cArr lastObject];
            // 取出区数组
            NSMutableArray *areaArr = [cDic objectForKey:@"area"];
            // 插入区名!
            [areaArr addObject:str];
        }
    }
}
- (void)dataHandle{
    NSString *path = @"http://www.560315.com/MobileAPI/DictWarehouseTypeClass";
    [APPTools GETWithURL:path par:nil success:^(id responseObject) {
        
        self.kindArr = [RentOutModel modelHandleWithArray:responseObject];
        
        [self.pickView reloadAllComponents];
        
    } filed:^(NSError *error) {
       
        NSLog(@"数据解析失败");
        
    }];
}

- (void)addressBtnAction:(UIButton *)btn{
    
    [self.pickView removeFromSuperview];
    // 判断是哪个数据 1 省市 2 仓库类型
    self.kindOfData = 1;
    
    [self.backView addSubview:self.pickView];
    
    [self.addressBtn setTitle:@"西城区 1" forState:UIControlStateNormal];

    [self.pickView reloadAllComponents];

}
- (void)kindSizeBtnAction:(UIButton *)btn{
    
    [self.pickView removeFromSuperview];
    
    self.kindOfData = 2;
    // 仓库数据解析
    [self dataHandle];

    [self.backView addSubview:self.pickView];
    [self.kindSizeBtn setTitle:@"普通仓库" forState:UIControlStateNormal];

    
}
/**< 搜索方法 */
- (void)searchAction:(UIButton *)btn{
    RentOutVC *rentOutVC = [[RentOutVC alloc] init];
    rentOutVC.type = self.firstTF.text;
    rentOutVC.vtypes = self.numb;
    
    [self.navigationController pushViewController:rentOutVC animated:YES];
    
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
