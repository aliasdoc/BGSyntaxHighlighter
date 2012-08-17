//
//  BGSyntaxHighlighter - BGSyntaxHighlightViewTests.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import <GHUnitIOS/GHUnit.h>
#import "BGSyntaxHighlightView.h"
#import "BGCodeObject.h"
#import "NSBundle+SyntaxHighlighter.h"
#import "NLTQuickCheck.h"
#import "NSNumber+BGArbitrary.h"

@interface BGSyntaxHighlightView()
@property(nonatomic, strong) UIScrollView *lineNumberScrollView;
@property(nonatomic, strong) UIScrollView *codeScrollView;
@property(nonatomic, strong) NSMutableArray *lineNumberViews;
@property(nonatomic, strong) NSMutableArray *lineViews;
@end

@interface BGSyntaxHighlightViewTests : GHViewTestCase
{
    BGSyntaxHighlightView *view;
    BGCodeObject *codeObject;
}
@end

@implementation BGSyntaxHighlightViewTests

- (BOOL)shouldRunOnMainThread {
    // By default NO, but if you have a UI test or test dependent on running on the main thread return YES
    return YES;
}

- (void)setUpClass {
    // Run at start of all tests in the class
}

- (void)tearDownClass {
    // Run at end of all tests in the class
}

- (void)setUp {
    // Run before each test method
    view = [[BGSyntaxHighlightView alloc] initWithFrame:CGRectZero];
    codeObject = [[BGCodeObject alloc] initWithCodeString:[NSBundle codeStringForResouce:@"mockLongObjective-C" ofType:@"txt"]];
    view.codeObject = codeObject;
}

- (void)tearDown {
    // Run after each test method
}

- (void)testNormalView
{
    view.frame = CGRectMake(0, 0, 320, 460);
    GHVerifyView(view);
}

- (void)testBufferingView
{
    view.frame = CGRectMake(0, 0, 320, 100);
    GHVerifyView(view);
    GHAssertEquals(5U, [view.lineNumberViews count], @"100/20=5で初期段階で5個ある");
    GHAssertEquals(5U, [view.lineViews count], @"100/20=5で初期段階で5個ある");
    
    [view.lineNumberScrollView scrollRectToVisible:CGRectMake(0, 180, 320, 100) animated:NO];
    GHAssertEquals(5U, [view.lineNumberViews count], @"ぴったりで移動するのでやっぱり5個ある");
    GHAssertEquals(5U, [view.lineViews count], @"ぴったりで移動するのでやっぱり5個ある");
    
    [view.lineNumberScrollView scrollRectToVisible:CGRectMake(0, 185, 320, 100) animated:NO];
    GHAssertEquals(5U, [view.lineNumberViews count], @"すこしずれて移動するので下に1個余分に追加されて6個になる");
    GHAssertEquals(5U, [view.lineViews count], @"すこしずれて移動するので下に1個余分に追加されて6個になる");
}

- (BOOL)propRecycleLogic:(NSNumber*)y {
    view = [[BGSyntaxHighlightView alloc] initWithFrame:CGRectZero];
    codeObject = [[BGCodeObject alloc] initWithCodeString:[NSBundle codeStringForResouce:@"mockLongObjective-C" ofType:@"txt"]];
    view.codeObject = codeObject;
    view.frame = CGRectMake(0, 500, 320, 100);
    [view layoutSubviews];
    [view.lineNumberScrollView scrollRectToVisible:CGRectMake(0, [y floatValue], 320, 100) animated:NO];
    GHTestLog(@"%d", [view.lineNumberViews count]);
    return [view.lineNumberViews count] < 8; // 3つくらいは許容できる
}

- (void)testRecycle {
    NLTQTestable *testable = [NLTQTestable testableWithPropertySelector:@selector(propRecycleLogic:) 
                                                                 target:self
                                                            arbitraries:[NSNumber scrollYArbitrary], nil];
    [testable verboseCheck];
    GHAssertTrue([testable success], @"%@", [testable prettyReport]);
}

@end
