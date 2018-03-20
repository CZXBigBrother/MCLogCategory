//
//  NSObject+MCLog.m
//  testTimeeeee
//
//  Created by marco chen on 2018/3/20.
//  Copyright © 2018年 marco chen. All rights reserved.
//

#import "NSObject+MCLog.h"
#import <objc/runtime.h>

//NSObject
@implementation NSObject (MCLog)

- (void)mc_log {
    NSLog(@"printPropertList:%@",[self printPropertList]);
    NSLog(@"printMethodList:%@",[self printMethodList]);
}
- (void)mc_log_pro {
    NSLog(@"MC_LOG_PRO:%@",[self printPropertList]);
}
- (void)mc_log_method {
    NSLog(@"MC_LOG_METHOD:%@",[self printMethodList]);
}

- (NSDictionary *)printPropertList {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        //        propertyName.i
        if ([propertyName isEqual: @"description"]) continue;
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (!propertyValue) propertyValue = [NSNull null];
        [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}
- (NSArray *)printMethodList {
    NSMutableArray * list = [NSMutableArray array];
    unsigned int mothCout_f =0;
    Method* mothList_f = class_copyMethodList([self class],&mothCout_f);
    for(int i=0;i<mothCout_f;i++) {
        Method temp_f = mothList_f[i];
        //        IMP imp_f = method_getImplementation(temp_f);
        //        SEL name_f = method_getName(temp_f);
        const char* name_s =sel_getName(method_getName(temp_f));
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding = method_getTypeEncoding(temp_f);
        NSString * str = [NSString stringWithFormat:@"func_name:%@,argu_num:%d,code:%@",[NSString stringWithUTF8String:name_s],arguments,[NSString stringWithUTF8String:encoding]];
        [list addObject:str];
    }
    free(mothList_f);
    return [list copy];
}
@end
//NSArray
@implementation NSArray (MCLog)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    
    return strM;
}

@end
//NSDictionary
@implementation NSDictionary (MCLog)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}

@end
