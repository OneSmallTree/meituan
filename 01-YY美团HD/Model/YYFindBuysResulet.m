//
//  YYFindBuysResulet.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/11.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYFindBuysResulet.h"
#import <MJExtension.h>
#import "YYBuysModel.h"

@implementation YYFindBuysResulet
+ (NSDictionary *)objectClassInArray
{
    return @{@"deals":[YYBuysModel class]};
}
@end
