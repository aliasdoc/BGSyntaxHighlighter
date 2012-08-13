//
//  BGSyntaxHighlightLineView.m
//  BGSyntaxHighlighter
//
//  Created by KAZUMA Ukyo on 12/08/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BGSyntaxHighlightLineView.h"
#import "UIFont+BGSyntaxHighlighter.h"
#import "UIColor+BGSyntaxHighlighter.h"

@interface BGSyntaxHighlightLineView()
@property(nonatomic, strong) TTTAttributedLabel *lineLabel;
@end

@implementation BGSyntaxHighlightLineView
@synthesize codeString = _codeString;
@synthesize lineLabel = _lineLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.lineLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        self.lineLabel.textAlignment = UITextAlignmentLeft;
        self.lineLabel.font = [UIFont courierFontOfSize:14];
        self.lineLabel.backgroundColor = [UIColor darkBackgroundColor];
        self.lineLabel.textColor = [UIColor darkBaseTextColor];
        [self addSubview:self.lineLabel];
        
    }
    return self;
}

#pragma mark - properties
- (void)setCodeString:(NSString *)codeString {
    _codeString = codeString;
    self.lineLabel.text = codeString;
}


#pragma mark - layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.lineLabel.frame = self.frame;
}
@end
