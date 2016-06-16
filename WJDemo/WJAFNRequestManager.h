//
//  WJAFNRequestManager.h
//  WJAFNRequestManager
//
//  Created by jie wang on 16/5/17.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <UIKit/UIKit.h>

#define TIMEOUTINTERVAL 20


@interface WJAFNRequestManager : NSObject

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id response))success failure:(void (^)(id error))failure;

+ (void)GET:(NSString *)url paramerters:(NSDictionary *)parameters success:(void (^)(id response))success
    failure:(void (^)(id error))failure;

+ (void)UPLOADIMAGE:(NSString *)url
         parameters:(NSDictionary *)parameters
        uploadImage:(UIImage *)image
            success:(void (^)(id response))success
            failure:(void (^)(id error))failure;

@end


