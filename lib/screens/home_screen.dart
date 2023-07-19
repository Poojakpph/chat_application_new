import 'package:chat_app/pages/calls_page.dart';
import 'package:chat_app/pages/contacts_pages.dart';
import 'package:chat_app/pages/messages_page.dart';
import 'package:chat_app/pages/notifications_page.dart';
import 'package:chat_app/screens/theme.dart';
import 'package:chat_app/widgets/glowing_action_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers.dart';
import '../widgets/avatar.dart';
import '../widgets/icon_buttons.dart';

class HomeScreen extends StatelessWidget {
    HomeScreen({super.key});

final ValueNotifier<int> pageIndex=ValueNotifier(0);
final ValueNotifier<String> title=ValueNotifier('Messages');


final pages=const [
   MessagesPage(),
   NotificationPage(),
   CallPage(),
   ContactPage(),
];

final pageTitles= const[
  'Messages', 'Notifications', 'Calls', 'Contacts',
];

 void _onNavigationItemSelector(index){
       title.value= pageTitles[index];
       pageIndex.value=index;
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: ValueListenableBuilder(
            valueListenable: title,
            builder: (BuildContext context, String value, _) {
              return Text( 
              title.value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                 ),
               );
              },
            ),
         ),

leadingWidth: 58,
leading: Align(
  alignment: Alignment.centerRight,
  child: IconBackground(
     icon: Icons.search, 
     onTap: (){
       print('TODO SEARCH');
       },
     ),
  ),

 actions: [
  Padding(
    padding: const EdgeInsets.only(right: 24),
    child: Avatar.small(url: Helpers.randomPictureUrl()),
  )
  ],
        ),
      
      body: ValueListenableBuilder(
        valueListenable: pageIndex, 
        builder: (BuildContext context, int value, _){
          return pages[value];
        },
      ),

      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelector,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex=0;

  void handleItemSelected(int index){
    setState(() {
      selectedIndex=index;
    });

    widget.onItemSelected(index);
  }
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavigationBarItem(
                  isSelected: (selectedIndex==0),
                  index: 0,
                  lable: 'Messages',
                  icon: CupertinoIcons.bubble_left_bubble_right_fill, 
                  onTap: handleItemSelected,
                ),
              
              _NavigationBarItem(
                 isSelected: (selectedIndex==1),
                 index: 1,
                  lable: 'Notifications',
                  icon: CupertinoIcons.bell_solid,
                  onTap: handleItemSelected,
                ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GlowingActionButton(color: AppColors.secondary, icon: CupertinoIcons.add, onPressed: (){}),
          ),

                _NavigationBarItem(
                   isSelected: (selectedIndex==2),
                   index: 2,
                  lable: 'Calls',
                  icon: CupertinoIcons.phone_fill,
                  onTap: handleItemSelected,
                ),
          
                _NavigationBarItem(
                   isSelected: (selectedIndex==3),
                   index: 3,
                  lable: 'Contacts',
                  icon: CupertinoIcons.person_2_fill,
                  onTap: handleItemSelected,
                ),
              ],
            ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.index, 
    required this.lable,
    required this.onTap,
    required this.icon,
    this.isSelected=false,
    }): super(key:key);

  final int index;
  final String lable;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
         onTap(index);
      },
   child: SizedBox(
      width: 70,
       child: Column(
         mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),

          const SizedBox(height: 8),
            Text(
             lable,
             style: isSelected ? const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.secondary) :
             const TextStyle(fontSize: 11),
            ),
       
      ],
    ),
   ),
    );
  }
}
