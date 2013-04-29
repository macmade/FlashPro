/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   FlashViewController.m
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

#import "FlashViewController.h"
#import "FlashHelper.h"

@implementation FlashViewController

@synthesize backgroundImage;

- ( void )viewDidLoad
{
    [ super viewDidLoad ];
}

- ( BOOL )shouldAutorotateToInterfaceOrientation: ( UIInterfaceOrientation )interfaceOrientation
{
    return ( interfaceOrientation == UIInterfaceOrientationPortrait );
}

- ( void )didReceiveMemoryWarning
{
    [ super didReceiveMemoryWarning ];
}

- (void)viewDidUnload
{
    [ super viewDidUnload ];
}

- ( void )dealloc
{
    [ backgroundImage release ];
    
    [ super dealloc ];
}

- ( void )viewWillDisappear: ( BOOL )animated
{
    ( void )animated;
    
    if( flashOn == YES )
    {
        [ self toggleFlash: nil ];
    }
}

- ( IBAction )toggleFlash: ( id )sender
{
    if( flashOn == YES )
    {
        [ self flashOff: sender ];
    }
    else
    {
        [ self flashOn: sender ];
    }
}

- ( IBAction )flashOn: ( id )sender
{
    ( void )sender;
    
    [ backgroundImage setImage: [ UIImage imageNamed: @"On.png" ] ];
    [ [ FlashHelper sharedInstance ] flashOn ];
    
    flashOn = YES;
}

- ( IBAction )flashOff: ( id )sender
{
    ( void )sender;
    
    [ backgroundImage setImage: [ UIImage imageNamed: @"Off.png" ] ];
    [ [ FlashHelper sharedInstance ] flashOff ];
    
    flashOn = NO;
}

@end
