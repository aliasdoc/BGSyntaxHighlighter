//
//  BGSyntaxHighlightLineNumberView.h
//  BGSyntaxHighlighter
//
//  Created by KAZUMA Ukyo on 12/08/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGSConstants.h"

@interface BGSyntaxHighlightLineNumberView : UIView
@property(nonatomic) NSUInteger lineNumber;
@property(nonatomic) BGSyntaxHighlighterTheme theme;
@end
