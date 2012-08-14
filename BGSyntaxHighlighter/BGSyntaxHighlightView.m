//
//  BGSyntaxHighlightView.m
//  BGSyntaxHighlighter
//
//  Created by KAZUMA Ukyo on 12/08/08.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BGSyntaxHighlightView.h"
#import "BGSyntaxHighlightLineNumberView.h"

#define kLineNumberWidth    (50)

@interface BGSyntaxHighlightView()
@property(nonatomic, strong) UIScrollView *lineNumberScrollView;
@property(nonatomic, strong) UIScrollView *codeScrollView;
@end

@implementation BGSyntaxHighlightView
@synthesize codeObject = _codeObject;
@synthesize lineNumberScrollView = _lineNumberScrollView;
@synthesize codeScrollView = _codeScrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.lineNumberScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.lineNumberScrollView.backgroundColor = [UIColor redColor];
        self.lineNumberScrollView.delegate = self;
        [self addSubview:self.lineNumberScrollView];
        self.codeScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.codeScrollView.backgroundColor = [UIColor greenColor];
        self.codeScrollView.delegate = self;
        [self addSubview:self.codeScrollView];
    }
    return self;
}

- (void)layoutSubviews {
    
    CGRect frame = self.frame;
    self.lineNumberScrollView.frame = CGRectMake(0, 0, kLineNumberWidth, frame.size.height);
    self.codeScrollView.frame = CGRectMake(kLineNumberWidth, 0, frame.size.width - kLineNumberWidth, frame.size.height);
    
#warning テスト用 :(
    for(NSInteger i = 0; i < 100; i++) {
        BGSyntaxHighlightLineNumberView *view = [[BGSyntaxHighlightLineNumberView alloc] initWithFrame:CGRectMake(0, 20*i, kLineNumberWidth, 20)];
        BGSyntaxHighlightLineNumberView *view2 = [[BGSyntaxHighlightLineNumberView alloc] initWithFrame:CGRectMake(0, 20*i, kLineNumberWidth, 20)];
        view.lineNumber = i;
        view2.lineNumber = i;
        [self.lineNumberScrollView addSubview:view];
        [self.codeScrollView addSubview:view2];
    }
    self.lineNumberScrollView.contentSize = CGSizeMake(kLineNumberWidth, 2000);
    self.codeScrollView.contentSize = CGSizeMake(frame.size.width - kLineNumberWidth, 2000);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(self.lineNumberScrollView == scrollView) {
        self.codeScrollView.contentOffset = CGPointMake(self.codeScrollView.contentOffset.x, scrollView.contentOffset.y);
    }
    else {
        self.lineNumberScrollView.contentOffset = CGPointMake(self.lineNumberScrollView.contentOffset.x, scrollView.contentOffset.y);
    }
}

@end
