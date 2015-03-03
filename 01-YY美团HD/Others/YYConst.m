


#import <UIKit/UIKit.h>

/**
 *  分类变化的时候发出的通知
 */
NSString * const YYCateGoryDidChangeNotification = @"YYCateGoryDidChangeNotification";
NSString * const YYCateGoryDidChangeKey = @"YYCateGoryDidChangeKey";
NSString * const YYSubcategoriesKey = @"YYSubcategoriesKey";

/**
 *  排序方法改变的时候发出的通知
 */
NSString * const YYSortDidChangeNotification = @"YYSortDidChangeNotification";
NSString * const YYSortDidChangeKey = @"YYSortDidChangeKey";

/**
 *  城市地区改变的时候发出的通知
 */
NSString * const YYCityDidChangeNotification = @"YYCityDidChangeNotification";
NSString * const YYCityDidChangeKey = @"YYCityDidChangeKey";

/**
 *  城市某区某县改变的时候发出的通知
 */
NSString * const YYSmallCityDidChangeNotification = @"YYSmallCityDidChangeNotification";
NSString * const YYSmallCityNameDidChangeKey = @"YYSmallCityNameDidChangeKey";
NSString * const YYSmallCitySmallNameDidChangeKey = @"YYSmallCitySmallNameDidChangeKey";

/**
 *  屏幕的尺寸
 */
CGFloat const YYMaxScreen = 1024;
CGFloat const YYMinScreen = 768;

/**
 *  当这个cell被点击的时候发出的通知
 */
NSString *const YYCellDidCheckedNotification = @"YYCellDidCheckedNotification";
