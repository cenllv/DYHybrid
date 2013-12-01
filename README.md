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
Call resetViewLayoutAfterRotateOrientation for view controller rotate
