// Copyright @ MyScript. All rights reserved.

#import <UIKit/UIKit.h>
#import <iink/IINKEditor.h>

@class IInkUIRefImplUtils;
@class SmartGuideViewController;

@protocol SmartGuideViewControllerDelegate <NSObject>

- (void)smartGuideViewController:(SmartGuideViewController *)smartGuideViewController didTapOnMoreButton:(UIButton *)moreButton forBlock:(IINKContentBlock *)block;

@end


@interface SmartGuideViewController : UIViewController

@property (strong, nonatomic) IINKEditor *editor;
@property (weak, nonatomic) id<SmartGuideViewControllerDelegate> delegate;

@end
