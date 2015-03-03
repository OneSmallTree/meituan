
#import <UIKit/UIKit.h>

// 分类改变
UIKIT_EXTERN NSString * const YYCateGoryDidChangeNotification;
UIKIT_EXTERN NSString * const YYCateGoryDidChangeKey;
UIKIT_EXTERN NSString * const YYSubcategoriesKey;

// 排序方法改变
UIKIT_EXTERN NSString * const YYSortDidChangeNotification;
UIKIT_EXTERN NSString * const YYSortDidChangeKey;

// 城市地区改变
UIKIT_EXTERN NSString * const YYCityDidChangeNotification;
UIKIT_EXTERN NSString * const YYCityDidChangeKey;


// 城市中区县的改变
UIKIT_EXTERN NSString * const YYSmallCityDidChangeNotification;
UIKIT_EXTERN NSString * const YYSmallCityNameDidChangeKey;
UIKIT_EXTERN NSString * const YYSmallCitySmallNameDidChangeKey;

// 屏幕尺寸
CGFloat const YYMaxScreen;
CGFloat const YYMinScreen;

// cell 被点击的时候发出的通知
UIKIT_EXTERN NSString *const YYCellDidCheckedNotification;