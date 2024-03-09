import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:kitajom/utils/global_variables.dart';
import 'package:provider/provider.dart';

import '../provider/page_provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    create();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void create() async{
    Provider.of<PageProvider>(context, listen: false).createPageController(_pageController);
  }




  void navigationTapped(int page, PageProvider value) {
    //Animating Page

    value.pageController.jumpToPage(page);
    value.setPage(page);
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<PageProvider>(
      builder: (context, value, child) => Scaffold(
        body: PageView(
          controller: value.pageController,
          onPageChanged: (int page) {
            {
              value.setPage(page);
            }
          },
          children: homeScreenItems,
        ),
        bottomNavigationBar: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GNav(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    color: buttonGreen,
                    activeColor: buttonGreen,
                    tabBackgroundColor: lightGreen.withOpacity(0.6),
                    tabBorderRadius: 30,
                    gap: 8,
                    onTabChange: (index) {
                      navigationTapped(index, value);
                    },
                    selectedIndex: value.page,
                    tabs: const [
                      GButton(
                        icon: Icons.home,
                        text: "Home",
                      ),
                      GButton(
                        icon: Icons.widgets_rounded,
                        text: "Menu",
                      ),
                      GButton(
                        icon: Icons.view_list_rounded,
                        text: "Booking",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
