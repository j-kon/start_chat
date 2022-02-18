import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:start_chat/pages/calls_page.dart';
import 'package:start_chat/pages/contact_page.dart';
import 'package:start_chat/pages/messages_page.dart';
import 'package:start_chat/pages/notifications_page.dart';
import 'package:start_chat/theme.dart';
import 'package:start_chat/widgets/widgets.dart';

import '../helper.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage(),
  ];

  final pageTitle = const [
    'Messages',
    'Notifications',
    'Calls',
    'Contacts',
  ];

  void _onNavigationItemSelcted(index) {
    title.value = pageTitle[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) {
            return Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Avatar.small(url: Helpers.randomPictureUrl()),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottonNavigationBar(
        onItemSelected: _onNavigationItemSelcted,
      ),
    );
  }
}

class _BottonNavigationBar extends StatefulWidget {
  const _BottonNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottonNavigationBar> createState() => _BottonNavigationBarState();
}

class _BottonNavigationBarState extends State<_BottonNavigationBar> {
  var selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavigationBarItem(
            index: 0,
            label: 'Messages',
            icon: CupertinoIcons.bubble_left_bubble_right_fill,
            isSelected: (selectedIndex == 0),
            onTap: handleItemSelected,
          ),
          _NavigationBarItem(
            index: 1,
            label: 'Notifications',
            icon: CupertinoIcons.bell_solid,
            isSelected: (selectedIndex == 1),
            onTap: handleItemSelected,
          ),
          _NavigationBarItem(
            index: 2,
            label: 'Calls',
            icon: CupertinoIcons.phone_fill,
            isSelected: (selectedIndex == 2),
            onTap: handleItemSelected,
          ),
          _NavigationBarItem(
            index: 3,
            label: 'Contacts',
            icon: CupertinoIcons.person_2_fill,
            isSelected: (selectedIndex == 3),
            onTap: handleItemSelected,
          ),
        ],
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {Key? key,
      required this.index,
      required this.label,
      required this.icon,
      required this.onTap,
      this.isSelected = false})
      : super(key: key);
  final ValueChanged<int> onTap;
  final int index;
  final String label;
  final bool isSelected;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (() {
        onTap(index);
      }),
      child: SizedBox(
        height: 50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary)
                  : const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
