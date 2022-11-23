//  Card(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0)),
//                           color: Color.fromARGB(255, 243, 243, 243),
//                           elevation: 10,
//                           child: ExpansionTile(
//                               leading: Icon(Icons.blur_on_rounded),
//                               controlAffinity: ListTileControlAffinity.trailing,
//                               childrenPadding: const EdgeInsets.symmetric(
//                                   vertical: 25, horizontal: 20),
//                               expandedCrossAxisAlignment:
//                                   CrossAxisAlignment.end,
//                               maintainState: true,
//                               title: Text(
//                                 data.docs[index]['Order Id'],
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w400, fontSize: 13),
//                               ),
//                               trailing: Text(
//                                 "Date &Time : " +
//                                     data.docs[index]['Date']
//                                         .toDate()
//                                         .toString(),
//                                 style: TextStyle(fontWeight: FontWeight.w200),
//                               ),
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Grand Total : " +
//                                         data.docs[index]['Grand Total']
//                                             .toString()),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     // Text("Price : " +
//                                     //     data.docs[index]['Total Amount']
//                                     //         .toString()),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     // Text(
//                                     //   "Payment : " +
//                                     //       data.docs[index]['Payment Mode'],
//                                     //   style: TextStyle(color: Colors.green),

//                                     //   // +data.docs[index]['Total Amount']
//                                     //   //               .toString()
//                                     // )
//                                   ],
//                                 )
//                               ]));