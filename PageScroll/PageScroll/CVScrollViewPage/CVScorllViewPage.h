//
//  CVScorllViewPage.h
//  PageScroll
//
//  Created by Hanrun on 2019/2/26.
//  Copyright © 2019年 Carvin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CVDirection) {
    CVVerticalScroll = 0,/**< 垂直方向 */
    CVHorizontal, /**< 水平方向*/
};


NS_ASSUME_NONNULL_BEGIN

@interface CVScorllViewPage : UIView
///图片是否为本地资源 该属性需在图片链接数组赋值前设置
@property (assign,nonatomic) BOOL isLocalImage;
///标题 该属性需在图片链接数组赋值前设置
@property (copy,nonatomic) NSArray *titleArr;
///图片链接
@property (copy,nonatomic) NSArray *imagesUrls;
///滑动方向
@property (assign,nonatomic) CVDirection direction;
///设置自动滑动时间
@property (assign,nonatomic) float scrollTime;
///隐藏pageview
@property (assign,nonatomic) BOOL hidePageController;
///pageview frame
@property (assign,nonatomic) CGRect pageviewFrame;
- (instancetype)initWithFrame:(CGRect)frame direction:(CVDirection)direction;
@end

NS_ASSUME_NONNULL_END
