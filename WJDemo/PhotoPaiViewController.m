//
//  PhotoPaiViewController.m
//  WJDemo
//
//  Created by jie wang on 16/2/2.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "PhotoPaiViewController.h"
#import "CollectedInfo.h"
#import "AppDelegate.h"
#import "ZoomViewController.h"

#import <UIImageView+WebCache.h>
#import <MBProgressHUD.h>


#define PPAPI_URL @"http://tips.photopai.com/ppapi/get_post/?id="
//#define PPAPI_URL @"http://tips.photopai.com/2401"

@interface PhotoPaiViewController ()<UIWebViewDelegate>{

    UIView *bgView;
    UIImageView *imgView;
    
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *htmlString;


@end

@implementation PhotoPaiViewController

@synthesize context;

- (void)htmlContentGetWithID:(NSInteger)ID{

    NSString *url = [NSString stringWithFormat:@"%@%ld",PPAPI_URL,(long)ID];
    
    [LORequestManger GET:url success:^(id response) {
        [HUD show:YES];
        
        NSDictionary *dic = (NSDictionary *)response;
        self.htmlString = dic[@"post"][@"content"];
        [self loadWebViewWithString:self.htmlString];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"网络连接失败";
        [HUD hide:YES afterDelay:2];
    }];
}

- (void)loadWebViewWithString:(NSString *)string{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.webView loadHTMLString:string baseURL:nil];
    });
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(collect)];
    self.navigationItem.rightBarButtonItem = collectItem;

    self.navigationItem.backBarButtonItem = [BackBarBtnItem shareBackItem];
    
    self.webView.scrollView.bounces = NO;
    
    [self htmlContentGetWithID:self.model.ID];
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 收藏
- (void)collect{
    
    BOOL isCollected = [self isCollectedWithID:self.model.ID];
    if (isCollected) {
       
        [self cancelCollectedWithID:self.model.ID];

        return;
    }

    NSError *error = nil;
    CollectedInfo *info = [NSEntityDescription insertNewObjectForEntityForName:@"CollectedInfo" inManagedObjectContext:context];
    
    info.likeID = [NSString stringWithFormat:@"%ld",(long)self.model.ID];
    info.imgurl = self.model.thumbnail;
    info.title = self.model.title;
    info.imgData = [self downloadWithUrl:self.model.thumbnail];

    if (![self.context save:&error]) {
        [HUD showAnimated:YES whileExecutingBlock:^{
            HUD.labelText = @"收藏失败";
            HUD.mode = MBProgressHUDModeCustomView;
            sleep(2);
        } completionBlock:^{
            HUD.labelText = @"";
        }];

        NSLog(@"收藏失败:%@",[error localizedDescription]);
    }else{

        [HUD showAnimated:YES whileExecutingBlock:^{
            HUD.labelText = @"收藏成功";
            HUD.mode = MBProgressHUDModeCustomView;
            sleep(2);
        } completionBlock:^{
            HUD.labelText = @"";
        }];
    }
    
}

//判断是否收藏过
- (BOOL )isCollectedWithID:(NSInteger)likeID{
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.context = delegate.managedObjectContext;
    
    NSError *error = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CollectedInfo" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchObj = [context executeFetchRequest:fetchRequest error:&error];
    for(NSManagedObject *info in fetchObj){
        NSInteger ID = [[info valueForKey:@"likeID"] integerValue];
       
        if (ID == likeID) {
            
            return YES;
//            break;
        }
    }

    return NO;
}

//取消收藏
- (void)cancelCollectedWithID:(NSInteger)likeID{
    
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CollectedInfo" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchObj = [self.context executeFetchRequest:fetchRequest error:&error];
    for(NSManagedObject *info in fetchObj){
        NSInteger ID = [[info valueForKey:@"likeID"] integerValue];
        
        if (ID == likeID) {
            
            [self.context deleteObject:info];
            
            [HUD showAnimated:YES whileExecutingBlock:^{
                HUD.labelText = @"已取消收藏";
                HUD.mode = MBProgressHUDModeCustomView;
                sleep(2);
            } completionBlock:^{
                HUD.labelText = @"";
            }];
            
//            [SVProgressHUD showSuccessWithStatus:@"已取消收藏"];
            break;
        }
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{

//    [SVProgressHUD dismiss];
    [HUD hide:YES];
    
//    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title='你的肌肤稳步前进浪费'"];
//    NSLog(@"title =%@",title);
//    [webView stringByEvaluatingJavaScriptFromString:title];
    
    /*
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];

    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
   //修改界面元素的值。
    NSString *js_result = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('q')[0].value='朱祁林';"];
     
     //调整字号
     NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '95%'";
     [webView stringByEvaluatingJavaScriptFromString:str];
    */
    
    //修改服务器页面的meta的值
    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", webView.frame.size.width];
    [webView stringByEvaluatingJavaScriptFromString:meta];
    
    /*
    //给网页增加utf-8编码
    [webView stringByEvaluatingJavaScriptFromString:
     @"var tagHead =document.documentElement.firstChild;"
     "var tagMeta = document.createElement(\"meta\");"
     "tagMeta.setAttribute(\"http-equiv\", \"Content-Type\");"
     "tagMeta.setAttribute(\"content\", \"text/html; charset=utf-8\");"
     "var tagHeadAdd = tagHead.appendChild(tagMeta);"];
     */
    
    /*
    //给网页增加css样式
    [webView stringByEvaluatingJavaScriptFromString:
     @"var tagHead =document.documentElement.firstChild;"
     "var tagStyle = document.createElement(\"style\");"
     "tagStyle.setAttribute(\"type\", \"text/css\");"
     "tagStyle.appendChild(document.createTextNode(\"BODY{padding: 20pt 15pt}\"));"
     "var tagHeadAdd = tagHead.appendChild(tagStyle);"];
    */
    
    //拦截网页图片  并修改图片大小
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=380;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.height * (maxwidth/oldwidth);"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    
    
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    for(var i=0;i<objs.length;i++){\
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+this.src;\
    };\
    };\
    return objs.length;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];
    //注入自定义的js方法后别忘了调用 否则不会生效（不调用也一样生效了，，，不明白）
    NSString *resurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    NSLog(@"---调用js方法--jsMehtods_result = %@",resurlt);
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    //将url转换为string
    NSString *requestString = [[request URL] absoluteString];
        NSLog(@"requestString is %@",requestString);
    
    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
    if ([requestString hasPrefix:@"myweb:imageClick:"]) {
        NSString *imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
                NSLog(@"image url------%@", imageUrl);
        
        [self showBigImage:imageUrl];//创建视图并显示图片
        
        return NO;
    }

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{

}

#pragma mark 显示大图片
-(void)showBigImage:(NSString *)imageUrl{
    
    ZoomViewController *viewCtl = [[ZoomViewController alloc] init];
    viewCtl.urlStr = imageUrl;
    [self.navigationController pushViewController:viewCtl animated:YES];

}

- (void)dealloc{
    [HUD removeFromSuperview];
    HUD = nil;
}


#pragma mark - 缓存图片
- (NSData *)downloadWithUrl:(NSString *)urlStr{
   
   __block NSData *imgData;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    NSURL *URL = [NSURL URLWithString:urlStr];
    [manager downloadImageWithURL:URL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        if (image){
            
            imgData = UIImageJPEGRepresentation(image, 1);
        }
    }];
    
    return imgData;
}



@end
