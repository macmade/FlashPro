/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   ApplicationDelegate.h
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

@interface ApplicationDelegate: NSObject < UIApplicationDelegate, UITabBarControllerDelegate >
{
@protected
    
    BOOL     hasTorch;
    UIView * errorView;
    
@private
    
    id r1;
    id r2;
}

@property( nonatomic, retain ) IBOutlet UIWindow           * window;
@property( nonatomic, retain ) IBOutlet UITabBarController * tabBarController;
@property( nonatomic, retain ) IBOutlet UIView             * errorView;

@end
