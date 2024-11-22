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
        TextButton(onPressed: ()=>pageController.jumpToPage(controller.items.length-1), child: const Text("Skip")),
        SmoothPageIndicator(
          
          controller: pageController,
          onDotClicked: (index) => pageController.animateToPage(index,duration: const Duration(milliseconds: 300),curve: Curves.easeIn),
           count: controller.items.length,
           effect: const WormEffect(activeDotColor: Colors.purple,dotHeight: 12,dotWidth: 12),
           ),
      TextButton(onPressed: ()=>pageController.nextPage(duration: const Duration(milliseconds: 600), curve: Curves.easeIn), child: const Text("Next"))
      ],),
    ),
      
      body: Stack(
        children:[ 

          Container(
            height: MediaQuery.of(context).size.height*0.15,
          width: MediaQuery.of(context).size.width,
            decoration:  const BoxDecoration(color:Color.fromARGB(255, 223, 241, 243),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(1000),bottomRight: Radius.circular(1000),)
            ),),
          
          Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
        child: PageView.builder(
         onPageChanged: (index) => setState(() {
          isLastPage=controller.items.length-1==index;
           
         }),
          itemCount: controller.items.length,
          controller: pageController,
          
          
          itemBuilder: (context, index) {
            
            return  Column(children: 
            [
            //Text("data",style: GoogleFonts.actor(),),
              SizedBox(height: screenHeight*0.25,),
              Image.asset(controller.items[index].images,height: 300,),
              Text(controller.items[index].title,style: const TextStyle(
                fontSize: 24,fontWeight: FontWeight.bold,),),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text(textAlign: TextAlign.center,
                  controller.items[index].descriptions,style: const TextStyle(color:textGreyColor2 ,),),
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
    decoration: const BoxDecoration(color: Colors.purple),
      child: TextButton(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Navigationscreen()));}, child: const Text("Get Started",style: TextStyle(color: Colors.white),)));
  }
}