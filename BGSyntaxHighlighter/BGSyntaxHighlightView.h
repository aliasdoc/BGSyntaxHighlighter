//
//  BGSyntaxHighlightView.h
//  BGSyntaxHighlighter
//
//  Created by KAZUMA Ukyo on 12/08/08.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGCodeObject.h"

@interface BGSyntaxHighlightView : UIView<UIScrollViewDelegate>
@property(nonatomic,strong) BGCodeObject* codeObject;
@end
