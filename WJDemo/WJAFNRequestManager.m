//
//  WJAFNRequestManager.m
//  WJAFNRequestManager
//
//  Created by jie wang on 16/5/17.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "WJAFNRequestManager.h"
#import "AppDelegate.h"
#import "WJProgressHUD.h"

@implementation WJAFNRequestManager

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id response))success failure:(void (^)(id error))failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = TIMEOUTINTERVAL;
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"uploadProgress =======%@======",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        // 请求成功
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        success(responseDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
      [self showResponseCode:task.response];
        failure(error);
        NSLog(@"===========Error=========\n%@\n==========",error);
        
    }];
}

+ (void)GET:(NSString *)url paramerters:(NSDictionary *)parameters success:(void (^)(id response))success
    failure:(void (^)(id error))failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = TIMEOUTINTERVAL;
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        success(responseDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showResponseCode:task.response];
        failure(error);
        NSLog(@"===========Error=========\n%@\n==========",error);
        
    }];
    
}

+ (void)UPLOADIMAGE:(NSString *)url
             parameters:(NSDictionary *)parameters
        uploadImage:(UIImage *)image
            success:(void (^)(id response))success
            failure:(void (^)(id error))failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = TIMEOUTINTERVAL;
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImagePNGRepresentation(image);
        
        [formData appendPartWithFileData:imageData name:@"file"fileName:@"file.jpg" mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        success(responseDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self showResponseCode:task.response];
        failure(error);
        NSLog(@"===========Error=========\n%@\n==========",error);
        
        
    }];
}

+ (void)showResponseCode:(NSURLResponse *)response {
    
    AppDelegate *appDdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [WJProgressHUD dismissAllHUDsForView:appDdelegate.window];
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    NSLog(@"responseStatusCode = %ld", responseStatusCode);
    
    if (responseStatusCode == 0) {
        NSLog(@"网络错误");
        [WJProgressHUD showHUDInView:appDdelegate.window dismissWithText:@"网络错误"];
    }else{
        //
        [WJProgressHUD showHUDInView:appDdelegate.window dismissWithText:@"服务器在开会，请稍候再试！"];
    }
}

@end
