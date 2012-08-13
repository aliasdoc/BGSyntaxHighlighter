//
//  BGSyntaxHighlightView.m
//  BGSyntaxHighlighter
//
//  Created by KAZUMA Ukyo on 12/08/08.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BGSyntaxHighlightView.h"

@interface BGSyntaxHighlightView()
@property(nonatomic,strong) UIScrollView *baseScrollView;
@end

@implementation BGSyntaxHighlightView
@synthesize codeObject = _codeObject;
@synthesize baseScrollView = _baseScrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.baseScrollView];

    }
    return self;
}

- (void)layoutSubviews {
    
    self.baseScrollView.frame = self.frame;
    self.baseScrollView.contentSize = CGSizeMake(self.frame.size.width * 2, self.frame.size.height);
}

@end
