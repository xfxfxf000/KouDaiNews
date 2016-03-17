

#import <Foundation/Foundation.h>
#import "NSString+Hashing.h"


@interface CacheOperate : NSObject
//写缓存
+(void)writeCacheWithURLStr:(NSString *)str andWithData:(NSData *)data;
//读取缓存
+(NSData *)readDataWithURLStr:(NSString *)str;

@end
