// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// class JobOpeningLoader extends StatelessWidget {
//   const JobOpeningLoader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
//             child: Container(
//               decoration: ShapeDecoration(
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 8.0, vertical: 5),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Shimmer.fromColors(
//                               baseColor: Colors.grey.shade300,
//                               highlightColor: Colors.grey.shade400,
//                               child: Container(
//                                   width: 30,
//                                   height: 30,
//                                   decoration: BoxDecoration(
//                                       color: Colors.grey.shade300,
//                                       borderRadius: BorderRadius.circular(00))),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               // mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Shimmer.fromColors(
//                                   baseColor: Colors.grey.shade300,
//                                   highlightColor: Colors.grey.shade400,
//                                   child: Container(
//                                       width: 130,
//                                       height: 15,
//                                       decoration: BoxDecoration(
//                                           color: Colors.grey.shade300,
//                                           borderRadius:
//                                               BorderRadius.circular(00))),
//                                 ),
//                                 SizedBox(
//                                   height: 3,
//                                 ),
//                                 Shimmer.fromColors(
//                                   baseColor: Colors.grey.shade300,
//                                   highlightColor: Colors.grey.shade400,
//                                   child: Container(
//                                       width: 150,
//                                       height: 15,
//                                       decoration: BoxDecoration(
//                                           color: Colors.grey.shade300,
//                                           borderRadius:
//                                               BorderRadius.circular(00))),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Shimmer.fromColors(
//                           baseColor: Colors.grey.shade300,
//                           highlightColor: Colors.grey.shade400,
//                           child: Container(
//                               width: 30,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   borderRadius: BorderRadius.circular(00))),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Shimmer.fromColors(
//                           baseColor: Colors.grey.shade300,
//                           highlightColor: Colors.grey.shade400,
//                           child: Container(
//                               width: 25,
//                               height: 15,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   borderRadius: BorderRadius.circular(00))),
//                         ),
//                         Shimmer.fromColors(
//                           baseColor: Colors.grey.shade300,
//                           highlightColor: Colors.grey.shade400,
//                           child: Container(
//                               width: 25,
//                               height: 15,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   borderRadius: BorderRadius.circular(00))),
//                         ),
//                         Shimmer.fromColors(
//                           baseColor: Colors.grey.shade300,
//                           highlightColor: Colors.grey.shade400,
//                           child: Container(
//                               width: 25,
//                               height: 15,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   borderRadius: BorderRadius.circular(00))),
//                         ),
//                         Shimmer.fromColors(
//                           baseColor: Colors.grey.shade300,
//                           highlightColor: Colors.grey.shade400,
//                           child: Container(
//                               width: 25,
//                               height: 15,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   borderRadius: BorderRadius.circular(00))),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 4.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Shimmer.fromColors(
//                           baseColor: Colors.grey.shade300,
//                           highlightColor: Colors.grey.shade400,
//                           child: Container(
//                               width: 45,
//                               height: 15,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   borderRadius: BorderRadius.circular(00))),
//                         ),
//                         Shimmer.fromColors(
//                           baseColor: Colors.grey.shade300,
//                           highlightColor: Colors.grey.shade400,
//                           child: Container(
//                               width: 45,
//                               height: 15,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   borderRadius: BorderRadius.circular(00))),
//                         ),
//                         Shimmer.fromColors(
//                           baseColor: Colors.grey.shade300,
//                           highlightColor: Colors.grey.shade400,
//                           child: Container(
//                               width: 45,
//                               height: 15,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   borderRadius: BorderRadius.circular(00))),
//                         ),
//                         Shimmer.fromColors(
//                           baseColor: Colors.grey.shade300,
//                           highlightColor: Colors.grey.shade400,
//                           child: Container(
//                               width: 45,
//                               height: 15,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   borderRadius: BorderRadius.circular(00))),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Shimmer.fromColors(
//                             baseColor: Colors.grey.shade300,
//                             highlightColor: Colors.grey.shade400,
//                             child: Container(
//                                 height: 15,
//                                 decoration: BoxDecoration(
//                                     color: Colors.grey.shade300,
//                                     borderRadius: BorderRadius.circular(00))),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Shimmer.fromColors(
//                             baseColor: Colors.grey.shade300,
//                             highlightColor: Colors.grey.shade400,
//                             child: Container(
//                                 height: 35,
//                                 decoration: BoxDecoration(
//                                     color: Colors.grey.shade300,
//                                     borderRadius: BorderRadius.circular(00))),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
