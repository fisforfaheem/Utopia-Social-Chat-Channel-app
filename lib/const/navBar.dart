import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/screens/all_friends.dart';
import 'package:flutter_application_utopia/screens/home_screen.dart';
import 'package:flutter_application_utopia/screens/search_screen.dart';
import 'package:flutter_application_utopia/screens/settingscreen.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

getCustomenavBar(index) {
  return Container(
    color: ptaNI,
    child: GNav(
        rippleColor: Colors.grey[800]!, // tab button ripple color when pressed
        hoverColor: Colors.grey[700]!, // tab button hover color
        haptic: true, // haptic feedback
        tabBorderRadius: 15,
        tabActiveBorder:
            Border.all(color: Colors.black, width: 1), // tab button border
        tabBorder:
            Border.all(color: Colors.grey, width: 1), // tab button border
        tabShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
        ], // tab button shadow // tab animation curves
        duration: Duration(milliseconds: 100), // tab animation duration
        gap: 8, // the tab button gap between icon and text
        color: Colors.grey[800], // unselected icon color
        activeColor: newBlue, // selected icon and text color
        iconSize: 24, // tab button icon size
        tabBackgroundColor:
            Colors.purple.withOpacity(0.1), // selected tab background color
        padding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 10), // navigation bar padding
        selectedIndex: index,
        tabs: [
          GButton(
            onPressed: () {
              Get.offAll(HomeScreen());
            },
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            onPressed: () {
              Get.offAll(AllFriends());
            },
            icon: Icons.person,
            text: 'Friends',
          ),
          GButton(
            onPressed: () {
              Get.offAll(SearchScreen());
            },
            icon: Icons.search,
            text: 'Search',
          ),
          GButton(
            onPressed: () {
              Get.to(SettingPage());
            },
            icon: Icons.settings,
            text: 'Settings',
          ),
        ]),
  );
}
