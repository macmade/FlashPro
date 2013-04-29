/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   ApplicationDelegate.m
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

#import "ApplicationDelegate.h"
#import "FlashHelper.h"
#import "FlashViewController.h"
#import "SOSViewController.h"
#import "MorseHelper.h"

@implementation ApplicationDelegate

@synthesize window           = _window;
@synthesize tabBarController = _tabBarController;
@synthesize errorView;

- ( id )init
{
    
    if( ( self = [ super init ] ) )
    {
        hasTorch = NO;
        
        #ifndef TARGET_IPHONE_SIMULATOR
        
        {
            Class             captureDeviceClass;
            AVCaptureDevice * device;
            
            captureDeviceClass = NSClassFromString( @"AVCaptureDevice" );
            
            if( captureDeviceClass != nil )
            {
                device = [ AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo ];
                
                if( [ device hasTorch ] && [ device hasFlash ] )
                {
                    if( device.torchMode == AVCaptureTorchModeOff )
                    {
                        [ FlashHelper sharedInstance ];
                        
                        hasTorch = YES;
                    }
                }
            }
        }
        
        #endif
    }
    
    return self;
}

- ( BOOL )application: ( UIApplication * )application didFinishLaunchingWithOptions: ( NSDictionary * )launchOptions
{
    ( void )application;
    ( void )launchOptions;
    
    [ [ NSUserDefaults standardUserDefaults ] registerDefaults: [ NSDictionary dictionaryWithContentsOfFile: [ [ NSBundle mainBundle ] pathForResource: @"Defaults" ofType: @"plist" ] ] ];
    
    if( hasTorch )
    {
        self.window.rootViewController = self.tabBarController;
        
        [ self.window makeKeyAndVisible ];
    }
    else
    {
        [ self.window addSubview: errorView ];
    }
    
    return YES;
}

- ( void )applicationWillResignActive: ( UIApplication * )application
{
    ( void )application;
}

- ( void )applicationDidEnterBackground: ( UIApplication * )application
{
    ( void )application;
}

- ( void )applicationWillEnterForeground: ( UIApplication * )application
{
    FlashViewController * flash;
    SOSViewController   * sos;
    
    ( void )application;
    
    if( [ [ self tabBarController ] selectedIndex ] == 0 )
    {
        flash = ( FlashViewController * )[ [ self tabBarController ] selectedViewController ];
        
        [ flash flashOff: nil ];
    }
    else if( [ [ self tabBarController ] selectedIndex ] == 1 )
    {
        sos = ( SOSViewController * )[ [ self tabBarController ] selectedViewController ];
        
        [ sos flashOff: nil ];
    }
    else
    {
        [ [ MorseHelper sharedInstance ] stop ];
    }
}

- ( void )applicationDidBecomeActive: ( UIApplication * )application
{
    ( void )application;
}

- ( void )applicationWillTerminate: ( UIApplication * )application
{
    ( void )application;
}

- ( void )dealloc
{
    [ _window           release ];
    [ _tabBarController release ];
    
    [ super dealloc ];
}

- ( void )tabBarController: ( UITabBarController * )tabBarController didSelectViewController: ( UIViewController * )viewController
{
    ( void )tabBarController;
    ( void )viewController;
}

- ( void )tabBarController: ( UITabBarController * )tabBarController didEndCustomizingViewControllers: ( NSArray * )viewControllers changed: ( BOOL )changed
{
    ( void )tabBarController;
    ( void )viewControllers;
    ( void )changed;
}

@end
