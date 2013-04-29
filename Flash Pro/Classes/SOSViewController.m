/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   SOSViewController.m
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

#import "SOSViewController.h"
#import "MorseHelper.h"

@implementation SOSViewController

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
     [ [ MorseHelper sharedInstance ] displayMessage: @"sos" repeat: YES ];
    
    flashOn = YES;
}

- ( IBAction )flashOff: ( id )sender
{
    ( void )sender;
    
    [ backgroundImage setImage: [ UIImage imageNamed: @"Off.png" ] ];
    [ [ MorseHelper sharedInstance ] stop ];
    
    flashOn = NO;
}

@end
