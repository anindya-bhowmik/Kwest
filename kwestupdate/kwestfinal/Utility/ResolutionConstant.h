//
//  ResolutionConstant.h
//  Fullmiere
//
//  Created by Mohon on 19/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef Fullmiere_ResolutionConstant_h
#define Fullmiere_ResolutionConstant_h

//#import "ResolutionDetectionController.h"

#define DeviceHeight [UIScreen mainScreen].bounds.size.height
#define DeviceWidth [UIScreen mainScreen].bounds.size.width


#define TOP_VIEW_WIDTH    DeviceWidth
#define TOP_VIEW_HEIGHT   DeviceHeight/1.2 

//Settings
#define SETTING_TABLE_SECTION_HEIGHT DeviceHeight/19.2 //25.0
#define SETTING_TABLE_ROW_HEIGHT  DeviceHeight/9.6 //50.0

#define BottomViewHeightt DeviceHeight/9.41 //51 for iphone 4
#define TopViewHeightt DeviceHeight - (BottomViewHeightt + (DeviceHeight/28)) // 20 pixel for  clock //Total 420
#define SwingButtonWidth DeviceWidth / 3

//measureview
#define ALL_HEADER_HEIGHT DeviceHeight/10.909090   // 44
#define BACKGROUND_LEFT_MARGIN DeviceWidth/64
#define BACKGROUND_TOP_MARGIN ALL_HEADER_HEIGHT+DeviceHeight/96 // 50 +
#define BACKGROUND_HEIGHT DeviceHeight-BottomViewHeightt-ALL_HEADER_HEIGHT-(DeviceHeight/96)*2 -20
#define BACKGROUND_WIDTH DeviceWidth-(BACKGROUND_LEFT_MARGIN*2)

// Save DataView

#define SaveTopBarViewHeight DeviceHeight/12
#define ProSwingDataViewHeight DeviceHeight/10.66667 //9.6
#define CUSTOM_TABLE_HEIGHT   DeviceHeight/9.6
#define CUSTOM_TABLE_SECTION_HEIGHT DeviceHeight/19.2 //17.78
#define CELL_HORIZENTAL_SEPARATOR 1

#define DIRECTION_IMAGE_WIDTH DeviceWidth/10.67



#define CLUB_TYPE_XCOR 0
#define CLUBTYPE_WIDTH DeviceWidth/8.21

#define CELL_SEPARATOR_ONE_XCOR CLUBTYPE_WIDTH


#define DISTANCE_LABEL_XCORD CLUBTYPE_WIDTH + 4
#define DISTANCE_LABEL_WIDTH DeviceWidth/6.667


#define DISTANCE_SCALE_LABEL_XCORD DISTANCE_LABEL_XCORD + DISTANCE_LABEL_WIDTH + 1
#define DISTANCE_SCALE_LABEL_WIDTH DeviceWidth/16


#define CELL_SEPARATOR_TWO_XCOR DISTANCE_SCALE_LABEL_XCORD + DISTANCE_SCALE_LABEL_WIDTH


#define ANGLE_LABEL_XCORD DISTANCE_SCALE_LABEL_XCORD + DISTANCE_SCALE_LABEL_WIDTH + CELL_HORIZENTAL_SEPARATOR
#define ANGLE_LABEL_WIDTH DeviceWidth/6.4


#define CELL_SEPARATOR_THREE_XCOR  ANGLE_LABEL_XCORD + ANGLE_LABEL_WIDTH


#define DIRECTION_IMAGEVIEW_XCORD ANGLE_LABEL_XCORD + ANGLE_LABEL_WIDTH + CELL_HORIZENTAL_SEPARATOR
#define DIRECTION_IMAGEVIEW_WIDTH DeviceWidth/2.67


#define DIRECTION_IMAGE_CORD_ONE DeviceWidth/32  // DeviceWidth/40  = 32
#define DIRECTION_IMAGE_CORD_TWO DeviceWidth/7.62
#define DIRECTION_IMAGE_CORD_THREE DeviceWidth/4.27

#define CELL_SEPARATOR_FOUR_XCOR  DIRECTION_IMAGEVIEW_XCORD + DIRECTION_IMAGEVIEW_WIDTH

#define FAV_MARKED_XCORD DIRECTION_IMAGEVIEW_XCORD + DIRECTION_IMAGEVIEW_WIDTH + CELL_HORIZENTAL_SEPARATOR + DeviceWidth/60
#define FAV_MARKED_WIDTH DeviceWidth/10.67


//Log in controller

#define loginTabButtonWidth DeviceWidth/2




#define APPLICATION_SCREEN_WIDTH DeviceWidth
#define APPLICATION_SCREEN_HEIGHT DeviceHeight/1.043478 //460
#define TABLE_HEADER_HEIGHT DeviceHeight/12//40
#define TABLE_FOOTER_HEIGHT DeviceHeight/10.6666667//45
#define HEADER_HEIGHT DeviceHeight/10.6666667//45
#define TOPBAR_BUTTON_CONTAINER_HEIGHT DeviceHeight/10.6666667//45
#define TOP_BAR_BUTTON_WIDTH DeviceHeight/3.2 //100
#define TOP_BAR_BUTTON_HEIGHT DeviceHeight/13.71428 //35
#define BOTTOM_BAR_BUTTON_HEIGHT DeviceHeight/9.6 //50
#define SAVE_TOPBAR_HEIGHT DeviceHeight/12 //40

#define RevMobBannerWidth DeviceWidth/2

#define DevicewidthRatio   DeviceWidth/320
#define DeviceheightRatio  DeviceHeight/480

#endif