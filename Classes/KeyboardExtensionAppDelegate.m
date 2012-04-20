//
//
//  initiated by Jason Lam (cofounder @WaveSpread) on 8/28/11.
//  Copyright 2012 keyboards.hk
//
//  Initiators/root branches
//      iOS code: https://github.com/jasonlamkk/iOSNumPadDoneButton/
//      Concept and Graphic Reference : 2008/2009 Neoos GmbH
//      http://www.neoos.ch/blog/37-uikeyboardtypenumberpad-and-the-missing-return-key
//      Major Update :
//        - support multiple textfields in same page, each of different type
//        - support dynamic done button text by using empty button background image and textlable 
//  Contributors:
//      https://github.com/jasonlamkk/iOSNumPadDoneButton/contributors
//
#import "KeyboardExtensionAppDelegate.h"
#import "DemoViewController.h"

@implementation KeyboardExtensionAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    viewController = [[DemoViewController alloc] init];
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
