//
//  YYGetSingleDealResult.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/15.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYGetSingleDealResult.h"
#import <MJExtension.h>
#import "YYBuysModel.h"

@implementation YYGetSingleDealResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"deals":[YYBuysModel class]};
}
@end
