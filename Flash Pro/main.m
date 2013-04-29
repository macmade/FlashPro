/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   main.m
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

int main( int argc, char * argv[] )
{
    NSAutoreleasePool * ap;
    int                 exitStatus;
    
    ap         = [ NSAutoreleasePool new ];
    exitStatus = UIApplicationMain( argc, argv, nil, nil );
    
    [ ap release ];
    
    return exitStatus;
}
