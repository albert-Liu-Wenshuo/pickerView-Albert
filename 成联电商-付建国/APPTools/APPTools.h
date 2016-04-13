//
//  APPTools.h
//  TableView&CollectionView
//
//  Created by 何欣 on 15/12/18.
//  Copyright © 2015年 何欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APPTools : NSObject

+ (void)GETWithURL:(NSString *)urlStr
               par:(NSDictionary *)dic
           success:(void(^)(id responseObject))responseObj
             filed:(void(^)(NSError *error))error;

+ (void)POSTWithURL:(NSString *)urlStr
                par:(NSDictionary *)dic
            success:(void(^)(id responseObject))response
              filed:(void(^)(NSError *error))err;

/** 16进制颜色 */
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;

@end
