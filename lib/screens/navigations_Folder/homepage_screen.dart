import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/screens/onboardingScreen/onboarding_items.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final TextEditingController _controller =TextEditingController();
    final listViewController = ListViewItems();
    final featuredJobsController = FeaturedJobsItems();

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
backgroundColor: const Color(0xfff0f3fa),
      body: Padding(
      padding: const EdgeInsets.symmetric(horizontal:25.0),
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.08,),
          const Text("Welcome Back!",style: TextStyle(color: textGreyColor,fontSize: 16),),
           Row(
             children: [
               const Text("Ritesh Dixit",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
               Padding(
                 padding: const EdgeInsets.only(left:8.0),
                 child: Image.asset("lib/assets/images/hello.png",height: 20,),
               ),
             ],
           ),
          Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Container(padding: const EdgeInsets.only(left: 10),
                height: 50,width: 290,decoration:  BoxDecoration(color: whiteColor,borderRadius: BorderRadius.circular(10)),
                child:  TextField(controller: _controller,
                  decoration: const InputDecoration(hintText:"Search a job or position" ,
                  hintStyle: TextStyle(color: textGreyColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                      ),),),),
                Container(height: 50,width: 40,
                  decoration:  BoxDecoration(color:whiteColor,borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.tune))
              ],
            
            ),
          ),
            
        
             
           Padding(
             padding: const EdgeInsets.only(top:10.0),
             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text("Our Categories",style: TextStyle(color: blackColor,fontWeight: FontWeight.bold,fontSize: 18),),
                     InkWell(onTap: () {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(seconds:2 ),
              content: Text("This will Work Soon")));
              
                     },
              child: const Text("See all",style: TextStyle(color: textGreyColor),))
                     ],),
           ),
               GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20,
              crossAxisCount: 3,
              crossAxisSpacing: 20
            ),
            itemCount: listViewController.items.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration:  BoxDecoration(color: whiteColor,
                borderRadius: BorderRadius.circular(10)
                ,border:Border.all(color: const Color.fromARGB(255, 243, 243, 245)) ),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Image.asset(listViewController.items[index].images,height: 60,),
                 Text(listViewController.items[index].name)],),);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.170,
              decoration:  const BoxDecoration(color: Colors.grey),
              child: Image.asset("lib/assets/images/apply_job_banner.jpg",fit: BoxFit.fill,),),
          ),
           Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text("Featured Jobs",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              InkWell(onTap: () {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("This will Work soon")));
                
              },
                child: const Text("See all",style: TextStyle(color: textGreyColor),))],),
          ),


          ListView.builder(shrinkWrap: true,
          
            itemCount: featuredJobsController.items.length,
            physics:  const NeverScrollableScrollPhysics(),
            
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(decoration: const BoxDecoration(color: whiteColor),
                  child: ListTile(
                    leading: Image.asset(featuredJobsController.items[index].images,height: 30,),
                  
                    title: Text(featuredJobsController.items[index].name),
                    subtitle:Text(featuredJobsController.items[index].locations) ,
                    trailing: Container(decoration: const BoxDecoration(),
                      child: InkWell(onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Applied Successfully")));
                      },
                        child: const Text("Apply Now",style: TextStyle(fontSize: 14),)),),
                    ),
                ),
              ) ;
            },
          ),





          // GridView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
            
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisSpacing: 10,mainAxisSpacing: 10,
          //     crossAxisCount: 2,
              
          //   ),
          //   itemCount: 4,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Container(decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: const Color.fromARGB(255, 254, 254, 255),
          //       border:Border.all(color: const Color.fromARGB(255, 243, 243, 245))),) ;
          //   },
          // ),
          const SizedBox(height: 10,)
          
          
         
            ],),
      ),
    ));
  }
}