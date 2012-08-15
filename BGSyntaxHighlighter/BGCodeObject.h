//
//  BGCodeObject.h
//  BGSyntaxHighlighter
//
//  Created by KAZUMA Ukyo on 12/08/08.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGCodeObject : NSObject
- (id)initWithCodeString:(NSString*)codeString;
- (NSInteger)numberOfCodeLines;
- (NSString*)codeStringForLineAtIndex:(NSInteger)index;
- (NSString*)maximumLengthStringForCodeLines;
@end
