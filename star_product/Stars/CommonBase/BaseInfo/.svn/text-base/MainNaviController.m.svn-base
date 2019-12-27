
//

#import "MainNaviController.h"
#import "MainTabBarViewController.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

@interface MainNaviController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic,assign) BOOL currentAnimating;

@end

@implementation MainNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate=self;
    
}
#pragma clang diagnostic pop

#pragma mark - Can't add self as subview 处理

- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 修正push控制器tabbar上移问题
    if (@available(iOS 11.0, *)){
        // 修改tabBra的frame
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.tabBarController.tabBar.frame = frame;
    }
    if(_currentAnimating) {
        return;
    } else if(animated) {
        _currentAnimating = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *) popViewControllerAnimated:(BOOL)animated {
    if(_currentAnimating) {
        return nil;
    } else if(animated) {
        _currentAnimating = YES;
    }
    
    return [super popViewControllerAnimated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    _currentAnimating = NO;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
   
    [[self transitionCoordinator]
        notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context){
        
        if([context isCancelled]) {
            UIViewController *fromViewController = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
            [self navigationController:navigationController willShowViewController:fromViewController animated:animated];
            
            if([self respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
                NSTimeInterval animationCompletion = [context transitionDuration] * [context percentComplete];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (uint64_t)animationCompletion * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [self navigationController:navigationController didShowViewController:fromViewController animated:animated];
                });
            }
        }
    }];
}

@end
