//
//  BGSyntaxHighlightLineNumberView.m
//  BGSyntaxHighlighter
//
//  Created by KAZUMA Ukyo on 12/08/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BGSyntaxHighlightLineNumberView.h"
#import "UIFont+BGSyntaxHighlighter.h"
#import "UIColor+BGSyntaxHighlighter.h"

@interface BGSyntaxHighlightLineNumberView()
@property(nonatomic,strong) UILabel *lineNumberLabel;
@end

@implementation BGSyntaxHighlightLineNumberView

@synthesize lineNumber = _lineNumber;
@synthesize lineNumberLabel = _lineNumberLabel;
@synthesize theme = _theme;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.lineNumberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.lineNumberLabel.textAlignment = UITextAlignmentRight;
        self.lineNumberLabel.font = [UIFont courierFontOfSize:14];
        self.lineNumberLabel.backgroundColor = [UIColor darkBackgroundColor];
        self.lineNumberLabel.textColor = [UIColor darkBaseTextColor];
        [self addSubview:self.lineNumberLabel];
        
    }
    return self;
}

#pragma mark - properties
- (void)setLineNumber:(NSUInteger)lineNumber {
    _lineNumber = lineNumber;
    self.lineNumberLabel.text = [NSString stringWithFormat:@"%4d.", lineNumber];
}
/*
- (void)setTheme:(BGSyntaxHighlighterTheme)theme {
    _theme = theme;
    //    if()
}
 */

#pragma mark - layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.lineNumberLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
