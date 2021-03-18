import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

// ignore: must_be_immutable
class EditExamPage extends StatefulWidget {
  @override
  _EditExamPageState createState() => _EditExamPageState();
}

class _EditExamPageState extends State<EditExamPage> {
  @override
  Widget build(BuildContext context) {
    Future<int> indexQ;
    return ScrollSnapList(
        //   scrollDirection: Axis.horizontal,
        //   itemCount: template.listQuestion.length,
        //   dynamicItemSize: true,
        //   dynamicSizeEquation: (double num) =>
        //       1 - pow(num / MediaQuery.of(context).size.width / 2.5, 2),
        //   itemSize: MediaQuery.of(context).size.width,
        //   onItemFocus: (int i) {
        //     indexQ.asStream();
        //   },
        //   itemBuilder: (context, index) {
        //     return Container(
        //         alignment: Alignment.topCenter,
        //         height: MediaQuery.of(context).size.height,
        //         width: MediaQuery.of(context).size.width,
        //         child: DraggableScrollableSheet(
        //             expand: false,
        //             initialChildSize: 1,
        //             maxChildSize: 1,
        //             minChildSize: 1,
        //             builder: (context, controller) {
        //               return SingleChildScrollView(
        //                 controller: controller,
        //                 scrollDirection: Axis.vertical,
        //                 child: Column(children: [
        //                   Row(
        //                     children: [
        //                       Text(
        //                         template.listQuestion[index].question,
        //                         style: TextStyle(
        //                             fontSize: 24,
        //                             fontWeight: FontWeight.w500),
        //                       ),
        //                       IconButton(
        //                           icon: Icon(Icons.edit), onPressed: () {})
        //                     ],
        //                   ),
        //                   for (var answer
        //                       in template.listQuestion[index].answer)
        //                     Row(
        //                       children: [
        //                         Text(answer.answer,
        //                             style: TextStyle(
        //                                 fontSize: 22,
        //                                 fontWeight: FontWeight.w300)),
        //                         IconButton(
        //                             icon: Icon(Icons.edit), onPressed: () {}),
        //                         IconButton(
        //                             icon: Icon(Icons.remove),
        //                             onPressed: () {
        //                               template.listQuestion[index].answer
        //                                   .remove(answer);
        //                               userModel
        //                                   .changeTemplateInList(template);
        //                             }),
        //                       ],
        //                     ),
        //                   IconButton(
        //                       icon: Icon(Icons.add_box_outlined),
        //                       onPressed: () {
        //                       }),
        //                 ]),
        //               );
        //             }));
        //   },
        // )
        );
  }
}
