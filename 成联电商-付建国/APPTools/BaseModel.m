//
//  BaseModel.m
//  SeaWaveTravel
//
//  Created by dllo on 16/1/23.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }return self;
}

+ (instancetype)BaseModelWithDic:(NSDictionary *)dic {
    return [[[self class] alloc] initWithDic:dic];
}

+ (NSMutableArray *)modelHandleWithArray:(NSArray *)array {
    NSMutableArray *arrModel = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        id model = [[self class] BaseModelWithDic:dic];
        [arrModel addObject:model];
    }
    return arrModel;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
