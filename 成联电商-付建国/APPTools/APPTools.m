//
//  APPTools.m
//  TableView&CollectionView
//
//  Created by 何欣 on 15/12/18.
//  Copyright © 2015年 何欣. All rights reserved.
//

#import "APPTools.h"
#import "AFNetworking.h"


@implementation APPTools

+ (void)GETWithURL:(NSString *)urlStr
               par:(NSDictionary *)dic
           success:(void (^)(id))responseObj filed:(void (^)(NSError *))err
{

    AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
    // 有的返回的数据格式，AFN不支持解析，所以我们要设置一下。让AFN支持。
    [man.requestSerializer setValue:@"domain=.ximalaya.com; path=/; channel=ios-b1; 1&_device=iPhone&4331AEED-1B57-45FB-87C9-D9421ECD697F&4.3.2; impl=com.gemd.iting; XUM=4331AEED-1B57-45FB-87C9-D9421ECD697F; c-oper=%E6%9C%AA%E7%9F%A5; net-mode=WIFI; res=640%2C1136" forHTTPHeaderField:@"Cookie"];
    [man.requestSerializer setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [man.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [man.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Proxy-Connection"];
    [man.requestSerializer setValue:@"ting_v4.3.2_c5(CFNetwork, iPhone OS 8.4.1, iPhone5,3) Paros/3.2.13" forHTTPHeaderField:@"User-Agent"];
    [man.requestSerializer setValue:@"XMFindLogoutViewController_UIView" forHTTPHeaderField:@"x-viewId"];
    [man.requestSerializer setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [man.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",nil]];
    
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *Mariana = [documentPath stringByAppendingPathComponent:@"Mariana"];
    
    BOOL result = [fileManager createDirectoryAtPath:Mariana withIntermediateDirectories:YES attributes:nil error:nil];
    if (result == YES) {
        NSLog(@"创建缓存文件夹成功");
        NSLog(@"%@", documentPath);
    }else {
        NSLog(@"创建缓存文件夹失败");
    }
    
    NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[urlStr hash]];
    
    NSString *TextFilePath = [Mariana stringByAppendingPathComponent:path];
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [man GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        responseObj(responseObject);
        
        // 序列化（等同于将文件写入本地）
        BOOL result1 = [NSKeyedArchiver archiveRootObject:responseObject toFile:TextFilePath];
        if (result1) {
            NSLog(@"写入成功");
        }else {
            NSLog(@"写入失败");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        err(error);
        NSDictionary *dic1 = [NSKeyedUnarchiver unarchiveObjectWithFile:TextFilePath];
        responseObj(dic1);

    }];
}

+ (void)POSTWithURL:(NSString *)urlStr
                par:(NSDictionary *)dic
            success:(void (^)(id))response filed:(void (^)(NSError *))err
{
    

    AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
    
    [man.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",nil]];
    
     urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [man POST:urlStr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        response(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        err(error);

    }];
    
 
}

#pragma mark - 16进制颜色
+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 charactersif ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearsif ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



@end
