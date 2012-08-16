//
//  BGSyntaxHighlightView.m
//  BGSyntaxHighlighter
//
//  Created by KAZUMA Ukyo on 12/08/08.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BGSyntaxHighlightView.h"
#import "BGSyntaxHighlightLineNumberView.h"
#import "BGSyntaxHighlightLineView.h"
#import "UIColor+BGSyntaxHighlighter.h"

#define kLineNumberWidth        (50)
#define kLineHeight             (20)
#define kMarginHeightPower      (1.5)

@interface BGSyntaxHighlightView()
@property(nonatomic, strong) UIScrollView *lineNumberScrollView;
@property(nonatomic, strong) UIScrollView *codeScrollView;
@property(nonatomic, strong) NSMutableArray *lineNumberViews;
@property(nonatomic, strong) NSMutableArray *lineViews;
@property(nonatomic, strong) NSMutableSet *recycleLineNumberViews;
@property(nonatomic, strong) NSMutableSet *recycleLineViews;
@property(nonatomic) NSRange viewingLinesRange;
@property(nonatomic) CGFloat beforeContentOffsetY;
@end

@implementation BGSyntaxHighlightView
@synthesize codeObject = _codeObject;
@synthesize lineNumberScrollView = _lineNumberScrollView;
@synthesize codeScrollView = _codeScrollView;
@synthesize lineNumberViews = _lineNumberViews;
@synthesize lineViews = _lineViews;
@synthesize recycleLineNumberViews = _recycleLineNumberViews;
@synthesize recycleLineViews = _recycleLineViews;
@synthesize viewingLinesRange = _viewingLinesRange;
@synthesize beforeContentOffsetY = _beforeContentOffsetY;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.lineNumberScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.lineNumberScrollView.backgroundColor = [UIColor darkBackgroundColor];
        self.lineNumberScrollView.delegate = self;
        [self addSubview:self.lineNumberScrollView];
        
        self.codeScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.codeScrollView.backgroundColor = [UIColor darkBackgroundColor];
        self.codeScrollView.delegate = self;
        [self addSubview:self.codeScrollView];
    
        self.lineNumberViews = [NSMutableArray array];
        self.lineViews = [NSMutableArray array];
        self.recycleLineNumberViews = [NSMutableSet set];
        self.recycleLineViews = [NSMutableSet set];
        
        self.beforeContentOffsetY = 0;
    }
    return self;
}

- (void)layoutSubviews {
    
    CGRect frame = self.frame;
    self.lineNumberScrollView.frame = CGRectMake(0, 0, kLineNumberWidth, frame.size.height);
    self.codeScrollView.frame = CGRectMake(kLineNumberWidth, 0, frame.size.width - kLineNumberWidth, frame.size.height);
    
    for(NSInteger i = 0; i < [self.codeObject numberOfCodeLines]; i++) {
        BGSyntaxHighlightLineNumberView *lineNumberView = [[BGSyntaxHighlightLineNumberView alloc] initWithFrame:CGRectMake(0, 20*i, kLineNumberWidth, 20)];
        lineNumberView.lineNumber = i + 1;
        [self.lineNumberScrollView addSubview:lineNumberView];
        [self.lineNumberViews addObject:lineNumberView];
        
        BGSyntaxHighlightLineView *lineView = [[BGSyntaxHighlightLineView alloc] initWithFrame:CGRectMake(0, 20*i, 800, 20)];
        lineView.codeString = [self.codeObject codeStringForLineAtIndex:i];
        [self.codeScrollView addSubview:lineView];
        [self.lineViews addObject:lineView];
        
        if((i+1) * kLineHeight >= self.frame.size.height) {
            self.viewingLinesRange = NSMakeRange(0U, i);
            break;
        }
    }
    self.lineNumberScrollView.contentSize = CGSizeMake(kLineNumberWidth, kLineHeight * [self.codeObject numberOfCodeLines]);
    self.codeScrollView.contentSize = CGSizeMake(800, kLineHeight * [self.codeObject numberOfCodeLines]);
    
}

#pragma mark - View Recycle
- (BGSyntaxHighlightLineNumberView*)dequeueReusableLineNumberView {
    if(self.recycleLineNumberViews && [self.recycleLineNumberViews count] > 0) {
        BGSyntaxHighlightLineNumberView *view = [self.recycleLineNumberViews anyObject];
        [self.recycleLineNumberViews removeObject:view];
        NSLog(@"dequeued maxviews %d", [self.lineNumberViews count]);
        return view;
    }
    return nil;
}

- (BGSyntaxHighlightLineView*)dequeueReusableLineView {
    if(self.recycleLineViews && [self.recycleLineViews count] > 0) {
        BGSyntaxHighlightLineView *view = [self.recycleLineViews anyObject];
        [self.recycleLineViews removeObject:view];
        return view;
    }
    return nil;
}

#pragma mark - View Create
- (BGSyntaxHighlightLineNumberView*)lineNumberViewAtRow:(NSInteger)row {
    BGSyntaxHighlightLineNumberView *view = [self dequeueReusableLineNumberView];
    if(!view) {
        view = [[BGSyntaxHighlightLineNumberView alloc] initWithFrame:CGRectZero];
    }
    view.lineNumber = row;
    return view;
}

-(BGSyntaxHighlightLineView*)lineViewAtRow:(NSInteger)row {
    BGSyntaxHighlightLineView *view = [self dequeueReusableLineView];
    if(!view) {
        view = [[BGSyntaxHighlightLineView alloc] initWithFrame:CGRectZero];
    }
    view.codeString = [self.codeObject codeStringForLineAtIndex:row];
    return view;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(self.lineNumberScrollView == scrollView) {
        self.codeScrollView.contentOffset = CGPointMake(self.codeScrollView.contentOffset.x, scrollView.contentOffset.y);
    }
    else {
        self.lineNumberScrollView.contentOffset = CGPointMake(self.lineNumberScrollView.contentOffset.x, scrollView.contentOffset.y);
    }
    
    CGFloat y = scrollView.contentOffset.y;
    if(y > self.beforeContentOffsetY) {
        // 下
        NSInteger bottomLineNumber = self.viewingLinesRange.location + self.viewingLinesRange.length;
        NSInteger needsBottomLineNumber = (y + scrollView.frame.size.height) / kLineHeight;
        if(bottomLineNumber > needsBottomLineNumber) {
            return;
        }
        for (NSInteger i = bottomLineNumber+1; i <= needsBottomLineNumber; i++) {
            BGSyntaxHighlightLineNumberView *lineNumberView = [self lineNumberViewAtRow:i];
            [self.lineNumberViews addObject:lineNumberView];
            [self.lineNumberScrollView addSubview:lineNumberView];
            lineNumberView.frame = CGRectMake(0, kLineHeight *  (i-1), kLineNumberWidth, kLineHeight);
        }
        
        NSMutableArray *array = [NSMutableArray array];
        for (BGSyntaxHighlightLineNumberView *lineNumberView in self.lineNumberViews) {
            if(lineNumberView.frame.origin.y + kLineHeight < scrollView.contentOffset.y) {
                [lineNumberView removeFromSuperview];
                [array addObject:lineNumberView];
            }
        }
        [self.recycleLineNumberViews addObjectsFromArray:array];
        [self.lineNumberViews removeObjectsInArray:array];
        
        
        self.viewingLinesRange = NSMakeRange(needsBottomLineNumber - self.viewingLinesRange.length, self.viewingLinesRange.length);
    }
    else {
        // 上
    }
    
    self.beforeContentOffsetY = y;
    
}

@end
