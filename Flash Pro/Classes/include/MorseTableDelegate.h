/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   MorseTableDelegate.h
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

@interface MorseTableDelegate: NSObject < UITableViewDelegate >
{
@protected
    
    UITableViewCell * currentCell;
    
@private
    
    id r1;
    id r2;
}

- ( void )morseCodeEnd: ( id )nothing;

@end
