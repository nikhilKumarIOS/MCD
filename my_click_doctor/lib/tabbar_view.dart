import 'package:flutter/material.dart';
import 'package:my_click_doctor/ui/book_appointment_screen.dart';
import 'package:my_click_doctor/ui/call_screen.dart';
import 'package:my_click_doctor/ui/chat_screen.dart';
import 'package:my_click_doctor/ui/colleagues_screen.dart';
import 'package:my_click_doctor/ui/home/home_screen.dart';

// void main() => runApp(const MyTabBar());

// class MyTabBar extends StatelessWidget {
//   const MyTabBar({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyStatefulWidget(),
//     );
//   }
// }

class MyTabBar extends StatefulWidget {
  const MyTabBar({Key key}) : super(key: key);
  @override
  State<MyTabBar> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyTabBar>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _bodyView = <Widget>[
    HomeScreen(),
    ChatScreen(),
    CallScreen(),
    BookAppointmentScreen(),
    ColleaguesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  Widget _tabItem(Widget child, {bool isSelected = false}) {
    return AnimatedContainer(
        margin: const EdgeInsets.all(8),
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 500),
        decoration: !isSelected
            ? null
            : BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            child,
            // Text(label, style: TextStyle(fontSize: 8)),
          ],
        ));
  }

  // final List<String> _labels = ['Home', 'Chats', 'Group', 'Schedule', 'Call'];

  @override
  Widget build(BuildContext context) {
    var _icons = const [
      Icons.home_outlined,
      Icons.message,
      Icons.wifi_calling,
      Icons.calendar_month_outlined,
      Icons.group_sharp,
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(239, 239, 247, 248),
        // appBar: AppBar(
        //  // title: const Text('BottomNavigationBar Sample'),
        // ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Text("ola"),
            _bodyView.elementAt(_selectedIndex),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _icons
                      .asMap()
                      .entries
                      .map((e) => tabIcon(e.value, e.key))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        // bottomNavigationBar: Container(
        //   color: const Color.fromARGB(239, 239, 247, 248),
        //   height: MediaQuery.of(context).size.height / 10,
        //   padding: const EdgeInsets.all(12),
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(80.0),
        //     child: Container(
        //       color: Colors.white,
        //       child: TabBar(
        //           onTap: (x) {
        //             setState(() {
        //               _selectedIndex = x;
        //             });
        //           },
        //           labelColor: Colors.white,
        //           unselectedLabelColor: Colors.grey,
        //           indicator: const UnderlineTabIndicator(
        //             borderSide: BorderSide.none,
        //           ),
        //           tabs: [
        //             for (int i = 0; i < _icons.length; i++)
        //               _tabItem(
        //                 _icons[i],
        //                 //  _labels[i],
        //                 isSelected: i == _selectedIndex,
        //               ),
        //           ],
        //           controller: _tabController),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget tabIcon(icon_, ind) {
    return GestureDetector(
      onTap: () => {
        setState(() => {_selectedIndex = ind}),
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: (_selectedIndex == ind) ? Colors.black : Colors.transparent,
          border: Border.all(
              color: (_selectedIndex == ind)
                  ? Colors.black
                  : const Color.fromARGB(255, 194, 185, 185),
              width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon_,
          color: (_selectedIndex == ind)
              ? const Color.fromARGB(255, 255, 251, 251)
              : const Color.fromARGB(255, 54, 41, 41),
        ),
      ),
    );
  }
}
