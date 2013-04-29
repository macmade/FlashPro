/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   FlashHelper.h
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

@interface FlashHelper: NSObject
{
@protected
    
    AVCaptureSession * torch;
    AVCaptureDevice  * device;
    
@private

    id r1;
    id r2;
}

@property( nonatomic, retain ) AVCaptureSession * torch;

+ ( FlashHelper * )sharedInstance;

- ( void )flashOn;
- ( void )flashOff;

@end
