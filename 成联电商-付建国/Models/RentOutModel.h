//
//  RentOutModel.h
//  成联电商-付建国
//
//  Created by 付建国 on 16/4/12.
//  Copyright © 2016年 sher. All rights reserved.
//

#import "BaseModel.h"

@interface RentOutModel : BaseModel

@property (nonatomic, strong) NSString *NameCHN;

@property (nonatomic, strong) NSString *WHAddress;

@property (nonatomic, strong) NSString *Person;

@property (nonatomic, strong) NSString *PersonTel;

@property (nonatomic, strong) NSString *ReleaseTime;

@property (nonatomic, strong) NSNumber *WHType;

@property (nonatomic, strong) NSNumber *WHArea;

@property (nonatomic, strong) NSNumber *WHArealeast;

@property (nonatomic, strong) NSString *Description;

@property (nonatomic, strong) NSString *WarehouseType;

@property (nonatomic, strong) NSNumber *Identifier;

@end
