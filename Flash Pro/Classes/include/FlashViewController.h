/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   FlashViewController.h
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

@interface FlashViewController: UIViewController
{
@protected
    
    UIImageView * backgroundImage;
    BOOL          flashOn;
    
@private
    
    id r1;
    id r2;
}

@property( nonatomic, retain ) IBOutlet UIImageView * backgroundImage;

- ( IBAction )toggleFlash: ( id )sender;
- ( IBAction )flashOn: ( id )sender;
- ( IBAction )flashOff: ( id )sender;

@end
