import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/screens/navigations_Folder/navigationscreen.dart';
import 'package:kaamwalijobs_new/screens/onboardingScreen/onboarding_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingView> {
  bool isLastPage=false;
  
  final controller =OnboardingItems();
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    double screenHeight =MediaQuery.of(context).size.height;
      double screenwidth =MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: whiteColor,
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      color: whiteColor,
      child:isLastPage?getStarted(): Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        TextButton(onPressed: ()=>pageController.jumpToPage(controller.items.length-1), child: const Text("Skip",style: TextStyle(color: textGreyColor),)),
        SmoothPageIndicator(
          
          controller: pageController,
          onDotClicked: (index) => pageController.animateToPage(index,duration: const Duration(milliseconds: 300),curve: Curves.easeIn),
           count: controller.items.length,
           effect: const WormEffect(activeDotColor: Color(0xff2C557D),dotHeight: 12,dotWidth: 12),
           ),
      InkWell
      (onTap: () {
        pageController.nextPage(duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
      },
        child: Container
        (
          height: screenHeight*0.05,
        width: screenwidth*0.30,
          decoration: const BoxDecoration(color: Color(0xff2C557D)),
           child: const Center(child: Text("Next",style: TextStyle(color: whiteColor),)))),
      ],),
    ),
      
      body: Stack(
        children:[ 

          // Container(
          //   height: MediaQuery.of(context).size.height*0.15,
          // width: MediaQuery.of(context).size.width,
          //   decoration:   const BoxDecoration(color:Color(0xffE6E6E6),
          //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(1000),bottomRight: Radius.circular(1000),)
          //   ),),
          
          Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
        child: PageView.builder(
         onPageChanged: (index) => setState(() {
          isLastPage=controller.items.length-1==index;
           
         }),
          itemCount: controller.items.length,
          controller: pageController,
          
          
          itemBuilder: (context, index) {
            
            return  Column(children: 
            [
    
              SizedBox(height: screenHeight*0.25,),
              Image.asset(controller.items[index].images,height: 300,),
              Text(controller.items[index].title,style: const TextStyle(
                fontSize: 28,fontWeight: FontWeight.bold,color: Color(0xff0D0D26),),),
              Padding(
                padding: const EdgeInsets.only(top:4.0),
                child: Text(textAlign: TextAlign.center,
                  controller.items[index].descriptions,style: const TextStyle(color: textGreyColor ,fontFamily: "PoltawskiNowy"),),
              )
              ],);
          
            
          },
        ),
          ),]
      ),
    );
  }

  Widget getStarted(){
    

    return Container(width:MediaQuery.of(context).size.width*.9,
    height: MediaQuery.of(context).size.height*0.07,
    decoration: const BoxDecoration(color: Color(0xff2C557D)),
      child: TextButton(onPressed: (){
            // final pres = await SharedPreferences.getInstance();
            // pres.setBool("onboarding", true);
            // if(!mounted)return;
        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Navigationscreen()));}, child: const Text("Get Started",style: TextStyle(color: Colors.white),)));
  }
}