//
//  ViewController.m
//  WebSocketDemo
//
//  Created by OFweek01 on 2021/4/19.
//

#import "ViewController.h"
#import "WebSocketManager.h"
#import "CSTextField.h"
#import <AFNetworking.h>
#import <MJExtension.h>
//#import "AESEncrypt.h"
#import "ADSuyiKitCryptoAES.h"
//#import "NSData+ADSuyiKit.h"


@interface ViewController ()

@property (nonatomic, strong) UIButton *connectButton;
@property (nonatomic, strong) UIButton *sendDataButton;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) CSTextField *inputTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - Private methods
- (void)setupUI {
    [self.view addSubview:self.inputTextField];
    [self.view addSubview:self.connectButton];
    [self.view addSubview:self.sendDataButton];
    [self.view addSubview:self.closeButton];
    
    self.inputTextField.frame = CGRectMake(20, 100, UIScreen.mainScreen.bounds.size.width - 40, 40);
    self.connectButton.frame = CGRectMake(20, self.inputTextField.frame.origin.y + self.inputTextField.frame.size.height + 10, UIScreen.mainScreen.bounds.size.width - 40, 40);
    self.sendDataButton.frame = CGRectMake(20, self.connectButton.frame.origin.y + self.connectButton.frame.size.height + 10, UIScreen.mainScreen.bounds.size.width - 40, 40);
    self.closeButton.frame = CGRectMake(20, self.sendDataButton.frame.origin.y + self.sendDataButton.frame.size.height + 10, UIScreen.mainScreen.bounds.size.width - 40, 40);
    
}

#pragma mark - Event response
- (void)connectButtonAction {
    //[[WebSocketManager shared] connectServer];
    [self login];
}

- (void)sendDataButtonAction {
    [[WebSocketManager shared] sendDataToServer:self.inputTextField.text];
}

- (void)closeButtonAction {
    [[WebSocketManager shared] webSocketClose];
}

#pragma mark - Setter & Getter
- (UIButton *)connectButton {
    if (!_connectButton) {
        _connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _connectButton.backgroundColor = [UIColor orangeColor];
        [_connectButton setTitle:@"连接" forState:UIControlStateNormal];
        _connectButton.layer.cornerRadius = 5;
        [_connectButton addTarget:self action:@selector(connectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectButton;
}

- (CSTextField *)inputTextField {
    if (!_inputTextField) {
        _inputTextField = [[CSTextField alloc]init];
        _inputTextField.layer.borderColor = [UIColor redColor].CGColor;
        _inputTextField.layer.borderWidth = 0.5;
        _inputTextField.placeholder = @"输入框";
        _inputTextField.layer.cornerRadius = 5;
        [_inputTextField setPadding:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    }
    return _inputTextField;
}

- (UIButton *)sendDataButton {
    if (!_sendDataButton) {
        _sendDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendDataButton.backgroundColor = [UIColor orangeColor];
        [_sendDataButton setTitle:@"发送" forState:UIControlStateNormal];
        _sendDataButton.layer.cornerRadius = 5;
        [_sendDataButton addTarget:self action:@selector(sendDataButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendDataButton;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.backgroundColor = [UIColor orangeColor];
        [_closeButton setTitle:@"断开" forState:UIControlStateNormal];
        _closeButton.layer.cornerRadius = 5;
        [_closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}


- (void)login{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置自动管理Cookies
    //manager.requestSerializer.HTTPShouldHandleCookies = YES;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"account"] = @"18775134221";
    params[@"password"] = @"123456";
    [manager GET:[NSString stringWithFormat:@"%@%@", @"http://newlive.ofweek.com", @"/api/web/login/memberlogin"] parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        //NSLog(@"%@", responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0) {
            NSString *userToken = responseObject[@"data"][@"userToken"];
            // NSLog(@"%@", userToken);
            NSString *roomid = @"90";
            NSString *memberid = @"66";
            // 会员模式
            NSString *type = @"2";
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"groupid"] = roomid;
            dict[@"memberid"] = memberid;
            dict[@"type"] = type;
            dict[@"token"] = userToken;
            
            NSString *paramStr = KADSYAESCBCEncryptData(dict.mj_JSONString, @"kijhytgvmt578943", @"erasrehyt5rtyj75");
            //paramStr = [self urlEncode:paramStr];
            paramStr = [paramStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "].invertedSet];
            /*
            NSString *decodeStr = @"byRcb7NFWsDeJSUXqvHhxuTLmEh6bKvk0YxLL7aQdd7IaWm7iTdOfF9Sdw2EJ6oZaeyS7e9FSn0uHjqhTl1tJ6F3GGUN4/n48o1aQZxBBwSTHC/dc3i5WuP394Ab9eessD4dlWIAv7NGc/Vrr/sUp/RERDgXEzl+bnzPqhFlz1H3vjdPLnyzMIfCbNWvL/uGR8aAWnJpX5jOJEe1x5heyQ==";
            decodeStr = KADSYAESCBCDecryptData(decodeStr, @"kijhytgvmt578943", @"erasrehyt5rtyj75");
             */
            
            NSString *url = [NSString stringWithFormat:@"ws://newlive.ofweek.com/api/web/ws/webSocket?param=%@&needDecode=1", paramStr];
            [WebSocketManager shared].linkURL = url;
            [[WebSocketManager shared] connectServer];
            
        }
        
  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (NSString *)urlEncode:(NSString *)pstr {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations" // 这部分是用到的过期api
    NSString *result = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,
                                                                                            
                                                                                            (CFStringRef)pstr, nil,
                                                                                            
                                                                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
#pragma clang diagnostic pop
    return [NSString stringWithFormat:@"%@", result];
}

@end
