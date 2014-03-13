DYHybrid
========

a collection utility view controller, util, or common object for iOS

How To Build
------------

- 1. Build the DYHybrid target with iOS Device
- 2. Build the DYHybrid traget with iOS simulator
- 3. Build the Aggregate traget with iOS Device
- 4. You can find the compiled DYHybrid.framework in the product direcotry(right click the DYHybrid.framework in the xcode, select show in Finder)

for more detail information how to create custom iOS framework, you can refer to : http://jaym2503.blogspot.com/2012/09/how-to-create-custom-ios-framework.html


Structure:
===========
  Util (Such StringUtil, DateUtil, DBUtil something else) <br/>
  View (Common view components, CalendarView etc.) <br/>
  ViewController (PhotoViewController, Push & Pull View Controller,etc)<br/>

DYPhotoScrollView
----------------
A photo viewer for zooming out and zooming in. The max zoom scale is immutable, set to 1. The min zoom scale is min(imageWidth/width, imageHeight/height), and of couse should not bigger than 1.0.
<br/>
Call resetViewLayoutAfterRotateOrientation for view controller rotate</br>
How to use:
- 1. Init the DYPhotoScrollView and call - (void) displayImage:(UIImage *)image. You can call dispayImage multiple times with different images.

DYCalendarView
================
A simple implementation of Calendar.

DYPhotoAlbumViewController
==========================
A photo view controller to display several images, scroll and paging.<br/>
How to use:
- 1. init the IBOutlet albumScrollView
- 2. init show data `-(void)displayImages:(NSArray *)images currentPage:(NSInteger)currentPage`

DYPanNavigationViewController
=============================
A custom navigation controller which support pan gesture backing to the previsou controller.
How to use:
- 1. The only thing you need to do is init your navigation controller as DYPanNavigationController




