//
//  ViewController.m
//  PageScroll
//
//  Created by Hanrun on 2019/2/26.
//  Copyright © 2019年 Carvin. All rights reserved.
//

#import "ViewController.h"
#import "CVScorllViewPage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CVScorllViewPage *page = [[CVScorllViewPage alloc]initWithFrame:CGRectMake(10, 100, 340, 280) direction:CVHorizontal];
    page.titleArr = @[@"猫 1",@"狗 2",@"猫 3",@"狗 4"];//先赋值标题 再设置图片资源
    //page.isLocalImage = YES;//如果是本地图片，先设置这个属性为真
    //page.imagesUrls = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    
    page.imagesUrls = @[
                        @"http://img5.imgtn.bdimg.com/it/u=2276391059,2676039382&fm=26&gp=0.jpg",
                        @"http://img2.imgtn.bdimg.com/it/u=1499844476,2082399552&fm=26&gp=0.jpg",
                        @"http://img4.imgtn.bdimg.com/it/u=3930436285,1263327733&fm=26&gp=0.jpg",
                        @"http://img3.imgtn.bdimg.com/it/u=3636018372,2939030053&fm=26&gp=0.jpg",
                        @"http://img0.imgtn.bdimg.com/it/u=3389517482,693147730&fm=26&gp=0.jpg"
                        ];
    page.scrollTime = 5;
    //page.hidePageController = YES;
    
    [self.view addSubview:page];
}


@end
