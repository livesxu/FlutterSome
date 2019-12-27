//

#import <UIKit/UIKit.h>
#import "PickViewCustom.h"

typedef void(^PickData)(NSArray<PickerCustomModel *> *dataArray);

@interface UIView (Picker)

@property(strong,nonatomic,readwrite) PickViewCustom *inputView;

-(void)pickCategroyDataSource:(NSArray<NSArray<PickerCustomModel *> *> *)dataSource SourceType:(CustomPickerSourceType)sourceType Component:(NSInteger)groupNum PickData:(PickData)pickData;

-(void)changeCategroyPickDataSource:(NSArray<NSArray<PickerCustomModel *> *> *)datasource;

-(void)pickerShow;

@end
