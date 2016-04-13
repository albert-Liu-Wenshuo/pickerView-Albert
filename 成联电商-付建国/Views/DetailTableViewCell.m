//
//  DetailTableViewCell.m
//  成联电商-付建国
//
//  Created by 付建国 on 16/4/12.
//  Copyright © 2016年 sher. All rights reserved.
//

#import "DetailTableViewCell.h"

@interface DetailTableViewCell ()

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *degistL;
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) CGRect rect2;




@end

@implementation DetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
        
    }
    return self;
}
- (void)createSubViews{
    self.titleL = [[UILabel alloc] init];
    [self.contentView addSubview:_titleL];
    
    self.degistL = [[UILabel alloc] init];
    [self.contentView addSubview:_degistL];

}
- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    [self fuzhi];
}
- (void)fuzhi{
    
    self.titleL.text = [_dic allKeys][0];
    
    self.degistL.text = [_dic objectForKey:[_dic allKeys][0]];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    // 自定义高度
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil];
    // 通过文字大小 获取文本的高度
    self.rect = [[_dic allKeys][0] boundingRectWithSize:CGSizeMake(0, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.titleL.frame = CGRectMake(10, 10, self.rect.size.width, 40);
    self.titleL.font = [UIFont systemFontOfSize:15];
    self.titleL.textColor = [UIColor grayColor];
    
    // 通过文字大小 获取文本的高度
    self.rect2 = [[_dic objectForKey:[_dic allKeys][0]] boundingRectWithSize:CGSizeMake(self.contentView.frame.size.width - self.rect.size.width - 20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    self.degistL.frame = CGRectMake(self.rect.size.width + 10, 20, self.contentView.frame.size.width - self.rect.size.width - 20, self.rect2.size.height);
    self.degistL.font = [UIFont systemFontOfSize:15];
    self.degistL.textAlignment = NSTextAlignmentRight;
    self.degistL.numberOfLines = 30;
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
