//
//  AESEncrypt.h
//  WebSocketDemo
//
//  Created by OFweek01 on 2021/5/14.
//

#import <Foundation/Foundation.h>

//AESEncrypt.h
@interface AESEncrypt : NSObject
 
+ (NSString*) AES128Encrypt:(NSString *)plainText;
 
+ (NSString*) AES128Decrypt:(NSString *)encryptText;
 
+ (BOOL)validKey:(NSString*)key;
 
@end
