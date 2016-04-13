//
//  RentOutTableViewCell.m
//  成联电商-付建国
//
//  Created by 付建国 on 16/4/12.
//  Copyright © 2016年 sher. All rights reserved.
//

#import "RentOutTableViewCell.h"

@interface RentOutTableViewCell ()

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *kindL;
@property (nonatomic, strong) UILabel *addressL;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *phoneL;
@property (nonatomic, strong) UILabel *timeL;

@end

@implementation RentOutTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];

    }
    return self;
}
- (void)setModel:(RentOutModel *)model{
    _model = model;
    [self fuzhi];

}
- (void)createSubViews{
    
    self.titleL = [[UILabel alloc] init];
    [self.contentView addSubview:_titleL];
    
    self.kindL = [[UILabel alloc] init];
    [self.contentView addSubview:_kindL];
    
    self.addressL = [[UILabel alloc] init];
    [self.contentView addSubview:_addressL];
    
    self.nameL = [[UILabel alloc] init];
    [self.contentView addSubview:_nameL];
    
    self.phoneL = [[UILabel alloc] init];
    [self.contentView addSubview:_phoneL];
    
    self.timeL = [[UILabel alloc] init];
    [self.contentView addSubview:_timeL];
                     
    
}
- (void)fuzhi{
    
    NSString *str = [NSString stringWithFormat:@"%@仓库出租", _model.NameCHN];
    self.titleL.text = str;
    
    self.nameL.text = _model.Person;
    
    self.timeL.text = _model.ReleaseTime;
    
    self.phoneL.text = _model.PersonTel;
    
    self.addressL.text = _model.WHAddress;
    
    if ([_model.WHType isEqualToNumber:@1]) {
        
        self.kindL.text = @"普通仓库";
    }else{
        self.kindL.text = @"钢筋混凝土仓库";
    }
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleL.frame = CGRectMake(5, 5, self.contentView.frame.size.width - 10, 20);

    
    self.kindL.frame = CGRectMake(5, 35, 150, 20);

    
    self.addressL.frame = CGRectMake(self.contentView.frame.size.width - 170, 25, 150, 50);
    self.addressL.textColor = [UIColor orangeColor];
    self.addressL.numberOfLines = 2;

    
    self.nameL.frame = CGRectMake(5, 80, 60, 20);

    
    self.phoneL.frame = CGRectMake(self.contentView.frame.size.width - 170, 80, 150, 20);

    
    self.timeL.frame = CGRectMake(5, self.contentView.frame.size.height - 20, 250, 15);
    self.timeL.textColor = [UIColor grayColor];

    
    
}


- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
