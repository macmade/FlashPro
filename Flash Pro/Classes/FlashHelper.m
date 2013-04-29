/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   FlashHelper.m
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

#import "FlashHelper.h"

static FlashHelper * __sharedInstance = nil;

@implementation FlashHelper

@synthesize torch;

+ ( FlashHelper * )sharedInstance
{
    @synchronized( self )
    {
        if( __sharedInstance == nil )
        {
            [ [ self alloc ] init ];
        }
    }
    
    return __sharedInstance;
}

+ ( id )allocWithZone:( NSZone * )zone 
{
    @synchronized( self )
    {
        __sharedInstance = [ super allocWithZone: zone ];
        
        return __sharedInstance;
    }
}

- ( id )copyWithZone:( NSZone * )zone 
{
    ( void )zone;
    
    return self;
}

- ( id )retain
{
    return self;
}

- ( NSUInteger )retainCount
{
    return UINT_MAX;
}

- ( oneway void )release
{}

- ( id )autorelease
{
    return self;
}

- ( void )dealloc
{
    [ torch  release ];
    [ device release ];
    
    [ super dealloc ];
}

- ( id )init
{
    if( ( self = [ super init ] ) )
    {
        #ifndef TARGET_IPHONE_SIMULATOR
        
        {
            AVCaptureDeviceInput     * input;
            AVCaptureVideoDataOutput * output;
            AVCaptureSession         * session;
            
            device  = [ [ AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo ] retain ];
            input   = [ AVCaptureDeviceInput deviceInputWithDevice: device error: nil ];
            output  = [ AVCaptureVideoDataOutput new ];
            session = [ AVCaptureSession new ];
            
            [ session beginConfiguration ];
            [ device lockForConfiguration: nil ];
            [ session addInput: input ];
            [ session addOutput: output ];
            [ device unlockForConfiguration ];
            [ output release ];
            [ session commitConfiguration ];
            [ session startRunning ];
            [ self setTorch: session ];
            [ session release ];
        }
        
        #endif
    }
    
    return self;
}

- ( void )flashOn
{
    [ device lockForConfiguration: nil ];
    [ device setTorchMode: AVCaptureTorchModeOn ];
    [ device setFlashMode: AVCaptureFlashModeOn ];
    [ device unlockForConfiguration ];
}

- ( void )flashOff
{
    [ device lockForConfiguration: nil ];
    [ device setTorchMode: AVCaptureTorchModeOff ];
    [ device setFlashMode: AVCaptureFlashModeOff ];
    [ device unlockForConfiguration ];
}

@end
