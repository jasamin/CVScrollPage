//
//  CVScorllViewPage.m
//  PageScroll
//
//  Created by Hanrun on 2019/2/26.
//  Copyright © 2019年 Carvin. All rights reserved.
//

#import "CVScorllViewPage.h"
#import <UIImageView+WebCache.h>

@interface CVScorllViewPage ()<UIScrollViewDelegate>
@property(strong,nonatomic) UIScrollView *scrview;
@property(strong,nonatomic) UIPageControl *pageView;
@property(strong,nonatomic) UILabel *titleLab;
@property(assign,nonatomic) NSInteger currenPage;
@property(weak,nonatomic) NSTimer *autoScroll;
@end



@implementation CVScorllViewPage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame direction:(CVDirection)direction {
    self = [super initWithFrame:frame];
    if (self) {
        _currenPage = 0;
        self.direction = direction?direction:CVHorizontal;
        [self addSubview:self.scrview];
        for (NSInteger i=0; i<3; i++) {
            UIImageView *image = [[UIImageView alloc]init];
            [_scrview addSubview:image];
        }
        [self addSubview:self.titleLab];
        [self addSubview:self.pageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    
    self.scrview.contentSize = self.direction==CVHorizontal ? CGSizeMake(width*3,height) : CGSizeMake(width, height*3);

    for(NSInteger i=0;i<3;i++){
        UIImageView *img = self.scrview.subviews[i];
        img.frame = self.direction==CVHorizontal ? CGRectMake(width*i, 0, width, height) : CGRectMake(0, height*i, width, height);
    }
    
    //把scrview滑动到中间
    self.scrview.contentOffset = self.direction==CVHorizontal ? CGPointMake(width, 0) : CGPointMake(0, height);
    CGFloat pageW = 100;
    CGFloat pageH = 20;
    CGFloat pageX = width - pageW;
    CGFloat pageY = height - pageH;
    self.pageView.frame = CGRectMake(pageX, pageY, pageW, pageH);
}

#pragma mark - delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.direction==CVHorizontal) {
        if (scrollView.contentOffset.x < self.bounds.size.width) {
            self.currenPage = _currenPage==0 ? self.imagesUrls.count-1 : _currenPage-1;
        }else {
            self.currenPage = _currenPage>=self.imagesUrls.count-1 ? 0 : _currenPage+1;
        }
    }else{
        if (scrollView.contentOffset.y < self.bounds.size.height) {
            self.currenPage = _currenPage==0 ? self.imagesUrls.count-1 : _currenPage-1;
        }else {
            self.currenPage = _currenPage>=self.imagesUrls.count-1 ? 0 : _currenPage+1;
        }
    }
    [self showImage];
    NSLog(@"image url %@",[NSString stringWithFormat:@"%@",self.imagesUrls[_currenPage]]);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}


#pragma mark - setdata
- (void)setImagesUrls:(NSArray *)imagesUrls {
    _imagesUrls = [imagesUrls copy];
    self.pageView.numberOfPages = imagesUrls.count;
    self.pageView.hidesForSinglePage = YES;
    [self showImage];
}

- (void)showImage {
    NSString *url;
    for (NSInteger i=0; i<3; i++) {
        UIImageView *img = self.scrview.subviews[i];
        if (i==0) {//中间显示的是第一个
            if (self.currenPage==0) {
                url = self.imagesUrls[self.imagesUrls.count-1];
            }else {
                url = self.imagesUrls[self.currenPage-1];
            }
        }else if (i==1){//中间显示的是最后一个
            url = self.imagesUrls[self.currenPage];
        }else {
            if (self.currenPage==self.imagesUrls.count-1) {
                url = self.imagesUrls[0];
            }else {
                url = self.imagesUrls[self.currenPage+1];
            }
        }
        
        if (_isLocalImage) {
            img.image = [UIImage imageNamed:url];
        }else {
            [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"temp.png"]];
        }
        
        
    }
    self.pageView.currentPage = _currenPage;
    self.scrview.contentOffset = self.direction==CVHorizontal ? CGPointMake(self.bounds.size.width, 0) : CGPointMake(0, self.bounds.size.height);
    //刷新标题
    if (_currenPage >= _titleArr.count) {
        self.titleLab.text = @"";
    }else {
        self.titleLab.text = _titleArr[_currenPage];
    }
}

- (void)setTitleArr:(NSArray *)titleArr {
    _titleArr = [titleArr copy];
    _titleLab.hidden = NO;
}


#pragma mark - timer
- (void)setScrollTime:(float)scrollTime {
    _autoScroll = [NSTimer scheduledTimerWithTimeInterval:scrollTime target:self selector:@selector(autoScrollImage:) userInfo:nil repeats:YES];
}

- (void)autoScrollImage:(id)sender {
    if (self.currenPage==self.imagesUrls.count-1) {
        self.currenPage = 0;
    }else {
        self.currenPage += 1;
    }

    [self showImage];
    
    [UIView animateWithDuration:1 animations:^{
        self.scrview.subviews[1].alpha = 0.5;
        [UIView animateWithDuration:1 animations:^{
            self.scrview.subviews[1].alpha = 1;
        }];
    }];
    
}

#pragma mark - property
- (void)setHidePageController:(BOOL)hidePageController {
    self.pageView.hidden = hidePageController;
}

- (void)setPageviewFrame:(CGRect)pageviewFrame {
    self.pageView.frame = pageviewFrame;
}

#pragma mark - lazyLoad
- (UIScrollView *)scrview {
    if (!_scrview) {
        _scrview = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrview.delegate = self;
        _scrview.pagingEnabled = YES;
        _scrview.showsVerticalScrollIndicator = NO;
        _scrview.showsHorizontalScrollIndicator = NO;
    }
    return _scrview;
}
- (UIPageControl *)pageView {
    if (!_pageView) {
        _pageView = [[UIPageControl alloc]init];
    }
    return _pageView;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-30, self.bounds.size.width, 30)];
        _titleLab.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.text = @"标题";
        _titleLab.hidden = YES;
    }
    return _titleLab;
}
@end
