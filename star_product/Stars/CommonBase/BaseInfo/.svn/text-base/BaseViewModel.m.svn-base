
//

#import "BaseViewModel.h"


@interface BaseViewModel ()

@property (nonatomic, assign) NSInteger currentPage;//当前页数 - 

@end

@implementation BaseViewModel

- (void)dealloc{
    
    NSLog(@"%@ - delloc",NSStringFromClass([self class]));
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}

/**
 布局数据
 
 @param layoutData 成功||失败
 */
- (void)layoutRequestBackData:(LayoutData)layoutData;{
    
}

@end
