//
//  NSBundle+SyntaxHighlighter.h
//  BGSyntaxHighlighter
//
//  Created by KAZUMA Ukyo on 12/08/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (SyntaxHighlighter)
+ (NSString *)codeStringForResouce:(NSString *)resouce ofType:(NSString*)type;
@end
