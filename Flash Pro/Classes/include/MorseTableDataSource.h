/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   MorseTableDataSource.h
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

@interface MorseTableDataSource: NSObject < UITableViewDataSource >
{
@protected
    
    NSUserDefaults * defaults;
    
@private
    
    id r1;
    id r2;
}

@end
