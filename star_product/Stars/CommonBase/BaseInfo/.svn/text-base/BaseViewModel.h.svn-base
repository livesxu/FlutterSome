
//viewModel基类，作为VC的属性，数据请求、处理

#import <Foundation/Foundation.h>

typedef void(^LayoutData)(BOOL isSuccess);

@interface BaseViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;

/**
 布局数据

 @param layoutData 成功||失败
 */
- (void)layoutRequestBackData:(LayoutData)layoutData;

@end
