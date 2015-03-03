//
//  YYCityModel.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYCityModel.h"
#import <MJExtension.h>
#import "YYSmallCityModel.h"

@implementation YYCityModel

+ (NSDictionary *)objectClassInArray
{
    return @{@"districts":[YYSmallCityModel class]};
}

@end
