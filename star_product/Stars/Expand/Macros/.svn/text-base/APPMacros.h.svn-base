
//  和app有关的宏定义

#ifndef APPMacros_h
#define APPMacros_h

/* 主色调 */
#define mainColor [UIColor colorWithHexString:@"#887fff"]
/* 页面背景色 */
#define pageColor [UIColor colorWithHexString:@"#f8f8f8"]
/* deep加深页面背景色 */
#define pageDeepColor [UIColor colorWithHexString:@"#f0f0f0"]
/* navi背景色 */
#define naviColor [UIColor colorWithHexString:@"#ffffff"]
/* tabar背景色 */
#define tabColor [UIColor colorWithHexString:@"#ffffff"]

/* 常用色调 */
#define Color333 [UIColor colorWithHexString:@"333333"]
#define Color484848 [UIColor colorWithHexString:@"484848"]
#define Color555 [UIColor colorWithHexString:@"555555"]
#define Color666 [UIColor colorWithHexString:@"666666"]
#define Color777 [UIColor colorWithHexString:@"777777"]
#define Color999 [UIColor colorWithHexString:@"999999"]
#define Colorccc [UIColor colorWithHexString:@"cccccc"]
#define ColorInputHold [UIColor colorWithHexString:@"e8ecf0"]   //输入框背景
#define ColorLineW [UIColor colorWithHexString:@"e3e3e3"]       //宽分割线 - 深
#define ColorLineN [UIColor colorWithHexString:@"e9e9e9"]       //细分割线 - 浅
#define ColorOrange [UIColor colorWithHexString:@"f49326"]
#define ColorRed [UIColor colorWithHexString:@"FF5947"]
#define Colorfff [UIColor colorWithHexString:@"ffffff"]
#define ColorClear [UIColor clearColor]

/*适配*/
#define Layout(xxx) (xxx)/375.0 *kScreenWidth
#define LayoutHy(xxx) (xxx)/667.0 *kScreenHeight // 适配x
#define StateHeight  StatebarHeight()
//适配x 屏幕比适配
#define JIphoneX(xxx,yyy) StateHeight > 20 ? (xxx) : (yyy)

/*适配图片*/
#define Image(xxx) [UIImage imageNamed:(xxx)]


#define Font(xxx)  [UIFont systemFontOfSize:Layout(xxx)]
#define BoldFont(xxx)  [UIFont boldSystemFontOfSize:Layout(xxx)]

/********************************接口**********************************************/
#define kBaseHost @"https://baidu.com"
#define COMMON_API(xxx) [NSString stringWithFormat:@"%@%@", kBaseHost, xxx]

#endif /* APPMacros_h */
