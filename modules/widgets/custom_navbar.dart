import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/view/friends/friends_page.dart';
import 'package:tophotels/modules/view/homepage.dart';
import 'package:tophotels/modules/view/payments/payment.dart';
import 'package:tophotels/modules/view/profile/profile.dart';
import 'package:tophotels/modules/widgets/custom_list.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _PosNavBarState();
}

class _PosNavBarState extends State<CustomNavBar> {
  int currentIndex = 0;

  // Variable to track whether the custom list screen is shown or not
  bool showCustomListScreen = false;

  List<Widget> pages = [
    const HomePage(), // Regular Home screen
    FriendsPage(),
    PaymentPage(),
    ProfilePage(),
    const SizedBox.shrink(), // Empty space for 'Gfit a drink'
    // PaymentPage(),
    // ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // Keep the blue button centered
      floatingActionButton: Stack(
        children: [
          // Blue FAB that stays in the center
          Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width / 2 -
                25, // Center the blue FAB
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  currentIndex =
                      2; // This doesn't affect the HomePage or List view toggle
                });
              },
              shape: const CircleBorder(),
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: SizedBox(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset('assets/svg/gift_icon.svg'),
                )),
              ),
            ),
          ),

          // Red FAB for Home (index 0), positioned on the right
          if (currentIndex == 0) // Only show on Home screen
            Positioned(
              bottom: 100, // Adjust as necessary
              right: 20, // Positioned to the right side
              child: FloatingActionButton.small(
                  shape: const CircleBorder(),
                  onPressed: () {
                    // Toggle the screen between Home and Custom List
                    setState(() {
                      showCustomListScreen = !showCustomListScreen;
                      currentIndex =
                          0; // Keep the index at 0 to keep it on the home screen tab
                    });
                  },
                  backgroundColor: Colors.white,
                  child: showCustomListScreen
                      ? SvgPicture.asset('assets/svg/back_icon.svg')
                      : const Icon(
                          Icons.format_list_bulleted,
                          color: Colors.black,
                          size: 25,
                        )),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        backgroundColor: AppColors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/home_icon.svg',
              width: 25,
              height: 25,
            ),
            label: 'Home',
            activeIcon: SvgPicture.asset(
              'assets/svg/home_active.svg',
              width: 25,
              height: 25,
            ),
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/frined.svg',
                width: 25,
                height: 25,
              ),
              label: 'Friends',
              activeIcon: SvgPicture.asset(
                'assets/svg/f_active_icon.svg',
                width: 30,
                height: 30,
              )),
          BottomNavigationBarItem(
            icon: Container(
              height: 26,
            ), // Empty space for FAB
            label: 'Gift a drink',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/history_icon.svg',
                width: 25,
                height: 25,
              ),
              label: 'History',
              activeIcon: SvgPicture.asset(
                'assets/svg/history_active.svg',
                width: 30,
                height: 30,
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/profile_icon.svg',
                width: 25,
                height: 25,
              ),
              label: 'Account',
              activeIcon: SvgPicture.asset(
                'assets/svg/p_active.svg',
                width: 30,
                height: 30,
              )),
        ],
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.grey,
        onTap: (index) {
          if (index != 2) {
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          // Conditionally show either HomePage or Custom List Screen
          showCustomListScreen ? CustomListViewWidget() : HomePage(),
          ...pages.sublist(1), // Keep the other pages as is
        ],
      ),
    );
  }
}
