//
//  BaseModel.h
//  SeaWaveTravel
//
//  Created by dllo on 16/1/23.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)BaseModelWithDic:(NSDictionary *)dic;

+ (NSMutableArray *)modelHandleWithArray:(NSArray *)array;


@end
