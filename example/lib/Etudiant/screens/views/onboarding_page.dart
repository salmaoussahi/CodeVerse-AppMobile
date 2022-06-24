import 'package:flutter/material.dart';
import '../../../main.dart';
import '../size_configs.dart';
import './pages.dart';
import './home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnboardingPage extends StatefulWidget {
  const OnboardingPage({ Key key }) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  AnimatedContainer dotIndicator(index){
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.blue : Colors.purple,
        shape: BoxShape.circle,
      ),
    );
  }
  Future setSeenonboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seenOnboard= await prefs.setBool('seenOnboard', true);
    // this will set seenOnboard to true when running onboard page for first time.
  }
    @override
  void initState() {
    super.initState();
    setSeenonboard();
  }
  @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
     double sizeV = SizeConfig.blockSizeV;
     double sizeH = SizeConfig.blockSizeH;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
           
        )),
    ); 
  }
}
class MyTextButton extends StatelessWidget{
  const MyTextButton({
        Key key,
         this.buttonName,
         this.onPressed,
         this.bgColor,
  }): super(key: key);
  final String buttonName;
  final VoidCallback onPressed;
  final Color bgColor;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,),
                  child: SizedBox(
                  width: SizeConfig.blockSizeH*100,
                  height: SizeConfig.blockSizeH*15.5,
                  child:TextButton(
                  onPressed: onPressed,
                  child:Text(
                  buttonName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style:TextButton.styleFrom(
                    backgroundColor: bgColor,
                  ),
                  ),
                  )
    );
  }
}


class OnboardNavBtn extends StatelessWidget {
      const OnboardNavBtn ({
           Key key,
           this.name,
           this.onPressed,
      }) : super(key: key);
      final String name;
      final VoidCallback onPressed;
      @override
      Widget build(BuildContext context){
        return InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(6),
          splashColor: Colors.black,
          child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            name,
            style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),  
        );
      }
}