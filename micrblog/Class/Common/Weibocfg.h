/*
 存放微博应用相关的一些配置
 */

#define kAppKey @"2783540646"
#define kAppSecret @"ca07a4fda7bedb05407e04394c2d7aa2"
#define kRedirectURL @"http://"

#define kAccessToken @"access_token"
#define KUid @"uid"
#define kScreenName @"screen_name"

// 授权地址
#define kOauthURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&display=mobile&response_type=token", kAppKey, kRedirectURL]

// 公共请求地址
#define kBaseURL @"https://api.weibo.com/2/"