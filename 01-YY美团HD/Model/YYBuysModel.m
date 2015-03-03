//
//  YYBuysModel.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/11.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYBuysModel.h"
#import <MJExtension.h>

@implementation YYBuysModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"desc":@"description",
             @"is_refundable":@"restrictions.is_refundable",
             @"editing":@"nil"
             };
}
#pragma mark - 显示的时候，看当前团购是否被收藏
// 这个方法是点击新的一个cell的时候就会触发，重写这个方法干嘛呢？
// 不重写这个方法的话，收藏的功能再次重启程序后就会出现问题

- (BOOL)isEqual:(YYBuysModel *)other
{
    if ([self.deal_id isEqualToString:other.deal_id]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 归档的时候哪些属性需要归档，解档的时候哪些属性要归档
//// 因为要保存的属性很多，所以一个一个这样写不是很····如果把key都弄成宏，那不是需要很多宏？
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.title forKey:@"title"];
//    [aCoder encodeObject:self.deal_id forKey:@"deal_id"];
//}
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        self.title = [aDecoder decodeObjectForKey:@"title"];
//        self.deal_id = [aDecoder decodeObjectForKey:@"deal_id"];
//    }
//    return self;
//}

// 这一句话会指定归档解档的时候，包括头文件中的所有属性
MJCodingImplementation
@end
