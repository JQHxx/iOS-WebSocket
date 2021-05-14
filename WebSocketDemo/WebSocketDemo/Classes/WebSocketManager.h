//
//  WebSocketManager.h
//  WebSocketDemo
//
//  Created by OFweek01 on 2021/4/19.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, WebSocketStatus){
    WebSocketStatusDefault = 0, //初始状态，未连接
    WebSocketStatusConnect,     //已连接
    WebSocketStatusDisConnect,  //断开连接
};

@protocol WebSocketManagerDelegate<NSObject>

-(void)webSocketDidReceiveMessage:(NSString *)string;

@end


@interface WebSocketManager : NSObject

@property(nonatomic, strong, nullable) SRWebSocket *webScoket;
@property(nonatomic, weak) id<WebSocketManagerDelegate> delegate;
@property(nonatomic, assign) BOOL isConnect; //是否连接
@property(nonatomic, assign) WebSocketStatus socketStatus;

@property(nonatomic, copy, nullable) NSString *linkURL;

+(instancetype)shared;
-(void)connectServer;//建立长连接
-(void)reConnectServer;//重新连接
-(void)webSocketClose;//关闭连接
-(void)sendDataToServer:(NSString *)data; //向服务器发送数据

@end

NS_ASSUME_NONNULL_END
