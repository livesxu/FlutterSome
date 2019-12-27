# CustomPickView
PickView

Demo
- (void)configAlone {

NSMutableArray *alone = [NSMutableArray array];
PickerCustomModel *model = [[PickerCustomModel alloc]init];
model.pickKey = @"1";
model.pickName = @"one";
[alone addObject:model];

PickerCustomModel *model1 = [[PickerCustomModel alloc]init];
model1.pickKey = @"2";
model1.pickName = @"two";
[alone addObject:model1];

PickerCustomModel *model2 = [[PickerCustomModel alloc]init];
model2.pickKey = @"3";
model2.pickName = @"three";
[alone addObject:model2];

PickerCustomModel *model3 = [[PickerCustomModel alloc]init];
model3.pickKey = @"4";
model3.pickName = @"four";
[alone addObject:model3];

PickerCustomModel *model4 = [[PickerCustomModel alloc]init];
model4.pickKey = @"5";
model4.pickName = @"five";
[alone addObject:model4];

[self.view pickCategroyDataSource:@[alone] SourceType:0 Component:1 PickData:^(NSArray<PickerCustomModel *> *dataArray) {

NSLog(@"%@",dataArray);
}];
}

- (void)configChain {

NSString *info = [[NSBundle mainBundle] pathForResource:@"Citys" ofType:@"plist"];
NSArray *infoArray = [[NSArray alloc]initWithContentsOfFile:info];

NSMutableArray *chain = [NSMutableArray array];
for (NSDictionary *dicP in infoArray) {
PickerCustomModel *modelP = [[PickerCustomModel alloc]init];
modelP.pickKey = dicP[@"cityCode"];
modelP.pickName = dicP[@"cityName"];
modelP.subSource = [NSMutableArray array];
if (dicP[@"subCitys"] && [dicP[@"subCitys"] isKindOfClass:[NSArray class]]) {
NSArray *cityArray = dicP[@"subCitys"];
for (NSDictionary *dicC in cityArray) {
PickerCustomModel *modelC = [[PickerCustomModel alloc]init];
modelC.pickKey = dicC[@"cityCode"];
modelC.pickName = dicC[@"cityName"];
modelC.subSource = [NSMutableArray array];
if (dicC[@"subCitys"] && [dicC[@"subCitys"] isKindOfClass:[NSArray class]]) {
NSArray *areaArray = dicC[@"subCitys"];
for (NSDictionary *dicA in areaArray) {
PickerCustomModel *modelA = [[PickerCustomModel alloc]init];
modelA.pickKey = dicA[@"cityCode"];
modelA.pickName = dicA[@"cityName"];

[modelC.subSource addObject:modelA];
}
}
[modelP.subSource addObject:modelC];
}
}
[chain addObject:modelP];
}

[self.view pickCategroyDataSource:chain SourceType:1 Component:3 PickData:^(NSArray<PickerCustomModel *> *dataArray) {

NSLog(@"%@",dataArray);
}];

}

