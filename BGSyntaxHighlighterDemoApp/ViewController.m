//
//  ViewController.m
//  BGSyntaxHighlighterDemoApp
//
//  Created by KAZUMA Ukyo on 12/08/07.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "BGSyntaxHighlighter.h"
#import "NSBundle+SyntaxHighlighter.h"

@interface ViewController ()
@property(nonatomic,strong) BGCodeObject *codeObject;
@property(nonatomic,strong) BGSyntaxHighlightView *syntaxHightlightView;
@end

@implementation ViewController
@synthesize codeObject = _codeObject;
@synthesize syntaxHightlightView = _syntaxHightlightView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.codeObject = [[BGCodeObject alloc] initWithCodeString:[NSBundle codeStringForResouce:@"mockLongObjective-C" ofType:@"txt"]];
    self.syntaxHightlightView = [[BGSyntaxHighlightView alloc] initWithFrame:self.view.frame];
    self.syntaxHightlightView.codeObject = self.codeObject;
    [self.view addSubview:self.syntaxHightlightView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //self.syntaxHightlightView.frame = self.view.frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
