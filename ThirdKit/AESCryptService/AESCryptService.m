//
//  AESCryptService.m
//  Lottery
//
//  Created by DTY on 2017/4/20.
//  Copyright © 2017年 caipiao. All rights reserved.
//

#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "AESCryptService.h"

@implementation AESCryptService

+ (NSData *)AES256Encrypt:(NSData*)data withKey:(NSData *)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    unsigned char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    [key getBytes:keyPtr length:kCCKeySizeAES256];
    
    NSUInteger dataLength = [data length];
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionECBMode + kCCOptionPKCS7Padding,keyPtr, kCCKeySizeAES128,
                                          NULL /* initialization vector (optional) */,
                                          [data bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    
    
    NSData *resultData = nil;
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        buffer = NULL;
    }
    if (buffer) {
        free(buffer); //free the buffer;
    }
    return resultData;
}

+ (NSData *)AES256Decrypt:(NSData*)data withKey:(NSData *)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    unsigned char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    [key getBytes:keyPtr length:[key length]];
    
    NSUInteger dataLength = [data length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionECBMode + kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES128,
                                          NULL /* initialization vector (optional) */,
                                          [data bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    NSData *resultData = nil;
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        buffer = NULL;
    }
    if (buffer) {
        free(buffer); //free the buffer;
    }
    return resultData;
}

+ (NSString*)base16String: (NSData*)content {
    NSMutableString *str = [NSMutableString string];
    const unsigned char  *chrs = (const unsigned char *)[content bytes];
    for (int i=0; i<[content length]; i++) {
        [str appendFormat:@"%02X",chrs[i]];
    }
    return str;
}

+ (NSData *)base16Data: (NSString*)content {
    if ([content length]%2 != 0) {
        return nil;
    }
    unsigned char key[[content length]/2+1];
    bzero(key, [content length]/2+1);
    for (int i=0; i<[content length]/2; i++) {
        NSString *str = [content substringWithRange:NSMakeRange(2*i, 2)];
        key[i] = [self stringToASCIIChar:str];
    }
    return [NSData dataWithBytes:key length:[content length]/2];
}

+ (unichar)stringToASCIIChar:(NSString *)str {
    if ([str length] < 2) {
        return 0;
    }
    unichar one = [str characterAtIndex:0];
    unichar two = [str characterAtIndex:1];
    if(('0'<=one) && (one<='9')) {
        one=one-'0';
    }
    if(('a'<=one) && (one<='z')) {
        one=one-'a'+10;
    }
    if(('A'<=one) && (one<='Z')) {
        one=one-'A'+10;
    }
    if(('0'<=two) && (two<='9')) {
        two=two-'0';
    }
    if(('a'<=two) && (two<='z')) {
        two=two-'a'+10;
    }
    if(('A'<=two) && (two<='Z')) {
        two=two-'A'+10;
    }
    return one*16+two;
}



@end
