import 'package:flutter/material.dart';

class RadioButtonState extends StatefulWidget {
  const RadioButtonState({super.key});

  @override
  State<RadioButtonState> createState() => _RadioButtonStateState();
}

class _RadioButtonStateState extends State<RadioButtonState> {
  int selectedOption = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: const Text('Option 1'),
                  leading: Radio(
                    value: 1,
                    groupValue: selectedOption,
                    onChanged: (int? value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Option 2'),
                  leading: Radio(
                    value: 2,
                    groupValue: selectedOption,
                    onChanged: (int? value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}






  //  Card(
  //                 child: Container(
  //                   padding: const EdgeInsets.symmetric(vertical: 10),
  //                   decoration: const BoxDecoration(
  //                     color: AppColor.acsentColor,
  //                   ),
  //                   child: Table(
  //                     children: [
  //                       TableRow(
  //                         children: [
  //                           TableCell(
  //                             child: Container(
  //                               child: Row(
  //                                 children: const [
  //                                   SizedBox(width: 15),
  //                                   Flexible(
  //                                     child: Text(
  //                                       "المبلغ",
  //                                       textAlign: TextAlign.center,
  //                                       style: TextStyle(
  //                                           fontFamily: AppColor.mainFont,
  //                                           color: Colors.white,
  //                                           fontWeight: FontWeight.w400,
  //                                           fontSize: 13,
  //                                           height: 2),
  //                                     ),
  //                                   ),
  //                                   Expanded(
  //                                     flex: 3,
  //                                     child: Text(
  //                                       " التقاصيل",
  //                                       textAlign: TextAlign.center,
  //                                       style: TextStyle(
  //                                           fontFamily: AppColor.mainFont,
  //                                           color: Colors.white,
  //                                           fontWeight: FontWeight.w400,
  //                                           fontSize: 12,
  //                                           height: 2),
  //                                       overflow: TextOverflow.ellipsis,
  //                                     ),
  //                                   ),
  //                                   SizedBox(width: 5),
  //                                   Flexible(
  //                                     child: Text(
  //                                       "الرصيد",
  //                                       textAlign: TextAlign.center,
  //                                       style: TextStyle(
  //                                           fontFamily: AppColor.mainFont,
  //                                           color: Colors.white,
  //                                           fontWeight: FontWeight.w400,
  //                                           fontSize: 13,
  //                                           height: 2),
  //                                     ),
  //                                   ),
  //                                   SizedBox(width: 40),
  //                                   Flexible(
  //                                     child: Text(
  //                                       "التاريخ",
  //                                       textAlign: TextAlign.center,
  //                                       style: TextStyle(
  //                                           fontFamily: AppColor.mainFont,
  //                                           color: Colors.white,
  //                                           fontWeight: FontWeight.w400,
  //                                           fontSize: 13,
  //                                           height: 2),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
          