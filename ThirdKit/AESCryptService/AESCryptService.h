//
//  AESCryptService.h
//  Lottery
//
//  Created by DTY on 2017/4/20.
//  Copyright © 2017年 caipiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESCryptService : NSObject
+ (NSData *)AES256Encrypt:(NSData*)data withKey:(NSData *)key;
+ (NSData *)AES256Decrypt:(NSData*)data withKey:(NSData *)key;
+ (NSString *)base16String:(NSData*)content;
+ (NSData *)base16Data: (NSString*)content;
+ (unichar)stringToASCIIChar:(NSString *)str;


@end
