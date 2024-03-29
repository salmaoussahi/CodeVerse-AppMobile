import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/widgets/menu_item.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/scheduler_page.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/Absencepage.dart';


class SideBar extends StatefulWidget {
  const SideBar({ Key key }) : super(key: key);
  
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin <SideBar>  {
 AnimationController _animationController;
 StreamController<bool> isSidebarOpenedStreamController;
 Stream<bool> isSidebarOpenedStream;
 StreamSink<bool> isSidebarOpenedSink;
// final bool isSidebarOpened = true;
final _animationDuration = const Duration(milliseconds: 500);

 @override
  void initState() {
      _animationController = AnimationController(vsync: this, duration: _animationDuration); 
      isSidebarOpenedStreamController = PublishSubject<bool>();
      isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
      isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
    super.initState();
  }

   @override
  void dispose() {
    _animationController.dispose();
     isSidebarOpenedStreamController.close();
     isSidebarOpenedSink.close();
    super.dispose();
  }
   void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
      return AnimatedPositioned (
      duration: _animationDuration,
      top:0,
      bottom:0,
      left:isSideBarOpenedAsync.data ? 0 : -screenWidth, 
      right:isSideBarOpenedAsync.data ? 0 : screenWidth-45 ,
       child: Row(
        children: <Widget>[
            Expanded(
                child:Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                   color: Colors.blueAccent[700],
                child:Column(
                  children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      ListTile(
                        title: Text(
                          "IRISI",
                          style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                         subtitle: Text(
                          "www.irisi2.com",
                          style: TextStyle(
                            color: Color(0xFF1BB5FD),
                            fontSize: 18,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      ),
                    Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                       MenuItem(
                        icon: Icons.home,
                        title: "Mon Emploi",
                        onTap: () {
                          Navigator.push(
                             context,
                           MaterialPageRoute(builder: (context) => const SchedulerPage()),
                            );
                        },
                      ),
                      //  MenuItem(
                      //   icon: Icons.person,
                      //   title: "My Account",
                      //   onTap: () {
                      //     onIconPressed();
                      //     // BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyAccountClickedEvent);
                      //   },
                      // ),
                      //  MenuItem(
                      //   icon: Icons.shopping_basket,
                      //   title: "My Orders",
                      //   onTap: () {
                      //     onIconPressed();
                      //     // BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyOrdersClickedEvent);
                      //   },
                      // ),
                      //  MenuItem(
                      //   icon: Icons.card_giftcard,
                      //   title: "Wishlist",
                      // ),
                        Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                     MenuItem(
                       icon: Icons.settings,
                         title: "Mes absences",
                         onTap: () {
                          Navigator.push(
                             context,
                           MaterialPageRoute(builder: (context) => const AbsencePage()),
                            );
                        },
                       ),
                       Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                       MenuItem(
                        icon: Icons.exit_to_app,
                        title: "Logout",
                      ),
                  ],
                ),
                ),
            ),
            Align(
             alignment: Alignment(0,-0.9),
             child: GestureDetector(
                onTap: () {
                    onIconPressed();
                  },
            
               child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Colors.blueAccent[700],
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
        ],  
       ), 
       );
       },
    );
  }
}
class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}