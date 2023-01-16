// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:weather/style/styles.dart';

// class DropDownWidget extends StatefulWidget {

//   const DropDownWidget({Key? key,required this.controller,required this.list}) : super(key: key);
  
//   final TextEditingController controller;
//   final List list;


//   @override
//   State<DropDownWidget> createState() => _DropDownWidgetState();
// }

// class _DropDownWidgetState extends State<DropDownWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       readOnly: true,
//       controller: widget.controller,
//       onTap: (){
//         Get.bottomSheet(
//           Container(
//             color: white,
//             height: MediaQuery.of(context).size.height*0.3,
//             child: Column(
//               children: [
//                 Container(
//                   color: white70,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       MaterialButton(
//                         onPressed: (){
//                           Get.back();
//                         },
//                         child: Text("Cancel",style: gotuRegular1,),
//                       ),
//                       MaterialButton(
//                         onPressed: (){
//                           if(widget.controller.text == ''){
//                             setState(() {
//                               widget.controller.text = widget.list[0];
//                             });
//                           }
//                           Get.back();
//                         },
//                         child: Text("Done".tr,style: gotuRegular1),
//                       )
//                     ]
//                   ),
//                 ),
//                 Expanded(
//                   child: CupertinoPicker(
//                     onSelectedItemChanged: (value) => setState(() {
//                       widget.controller.text = widget.list[value];
//                     }),
//                     children: widget.list.map((value) => Center(child: Text(value,style: gotuRegular1))).toList(),
//                     itemExtent: 40,
//                   ),
//                 )
//               ],
//             ),
//           )
//         );
//       },
//       style: gotuRegular1,
//       decoration: InputDecoration(
//         enabledBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(color: white45, width: 1.2),
//         ),
//         focusedBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(color: white45, width: 1.2),
//         ),
//         disabledBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(color: white45, width: 1.2),
//         ),
//         hintText: "dropDownHint".tr,
//         fillColor: transparent,
//         hintStyle:  gotuRegular1,
//         contentPadding : const EdgeInsets.only(
//           left: 10,
//           right: 10,
//           top: 14
//         ),
//       ),
//     );
//   }
// }