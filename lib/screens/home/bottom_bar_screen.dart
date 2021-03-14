import 'package:lichtline/constants/assets/assets_constants.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/screens/auth/login_screen.dart';
import 'package:lichtline/screens/profile/profile_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    LoginScreen(),
    ProfileMenuScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      changeTab(index, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _willPopCallback() async {
      //Todo: check stack count

      if (_selectedIndex != 0) {
        setState(() {
          changeTab(0, context);
        });
        return false;
      } else {
        return true;
      }
    }

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: ColorConstant.greyishBrownThree.withOpacity(0.3),
                  offset: Offset(0.0, 0.5),
                  spreadRadius: 0.0,
                  blurRadius: 10),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AssetConstant.rides_inactive),
                  activeIcon: SvgPicture.asset(AssetConstant.rides_active),
                  label: StringConstant.rides,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AssetConstant.bids_inactive),
                  activeIcon: SvgPicture.asset(AssetConstant.bids_active),
                  label: StringConstant.myBids,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AssetConstant.post_ride_inactive),
                  activeIcon: SvgPicture.asset(AssetConstant.post_ride_active),
                  label: StringConstant.postAride,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AssetConstant.messages_inactive),
                  activeIcon: SvgPicture.asset(AssetConstant.messages_active),
                  label: StringConstant.messages,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AssetConstant.setttings_inactive),
                  activeIcon: SvgPicture.asset(AssetConstant.setttings_active),
                  label: StringConstant.settings,
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: ColorConstant.black,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

  changeTab(int index, context) {
    _selectedIndex = index;
    // var provider = Provider.of<SearchProvider>(context, listen: false);
    // var authProvider = Provider.of<AuthProvider>(context, listen: false);
    // provider.searchInputFocus.unfocus();
    // provider.setSearchScreen(false);
    // if (provider.overlayEntry != null) {
    //   provider.overlayEntry.remove();
    //   provider.overlayEntry = null;
    //   provider.searchController.text = "";
    // }
    // if (!authProvider.userModel.loggedIn) {
    //   if (index == 4) {
    //     authProvider.navigateToScreen = RouteConstants.profileMenu;
    //     Navigator.pushNamed(context, RouteConstants.pleaseSignInSignup);
    //   } else {
    //     _selectedIndex = index;
    //   }
    // } else {
    //   _selectedIndex = index;
    // }
  }
}
