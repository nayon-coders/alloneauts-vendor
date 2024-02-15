import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/controller/rentCarController/rentCarController.dart';
import 'package:vendor/model/rentModels/car_repots_list_model.dart';
import 'package:vendor/model/rentModels/single_car_reports_model.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/utility/app_const.dart';
import 'package:vendor/view_controller/appIconButton.dart';
import 'package:vendor/view_controller/loadingWidget.dart';
import 'package:vendor/view_controller/richText.dart';

class VehiclesCostingList extends StatefulWidget {
  final List<SingleCarReport>? reports;
  final VoidCallback onReload;
  final bool isLoading;
  const VehiclesCostingList({
    super.key,
    required this.size, this.reports, required this.onReload, this.isLoading = false
  });

  final Size size;

  @override
  State<VehiclesCostingList> createState() => _VehiclesCostingListState();
}

class _VehiclesCostingListState extends State<VehiclesCostingList> {

  final int itemsPerPage = 10;
  int currentPage = 0;
  List<SingleCarReport> get currentPageData {
    final startIndex = currentPage * itemsPerPage;
    final endIndex = int.parse("${(currentPage + 1) * itemsPerPage}");
    return widget.reports!.sublist(startIndex, endIndex!.clamp(0, widget.reports!.length));
  }

  // final List<DataRow> rows = List.generate(
  //   _singleCarReports!.length,
  //       (index) => DataRow(
  //     cells: [
  //       DataCell(Text('${AppConst.converDate(_singleCarReports![i]!.date) }', style: TextStyle(
  //           fontSize: 14,
  //           fontWeight: FontWeight.w500
  //       ),)),
  //       DataCell(Text('\$${_singleCarReports![i]!.amount}',
  //         style: TextStyle(
  //             fontSize: 14,
  //             fontWeight: FontWeight.w600
  //         ),
  //       )),
  //       DataCell(
  //         AppIconButton(
  //             icon: Icons.visibility,
  //             onClick: ()=>_showInfo(_singleCarReports![i])
  //           // onClick: (){
  //           //   Get.defaultDialog(
  //           //       title: "${widget.carDetails!.plateNo} - Reports",
  //           //       contentPadding: EdgeInsets.all(10),
  //           //       content: Column(
  //           //         mainAxisAlignment: MainAxisAlignment.start,
  //           //         crossAxisAlignment: CrossAxisAlignment.start,
  //           //         children: [
  //           //           RichTextWidget(leftText: "Date: ", rightText: AppConst.converDate(_singleCarReports![i]!.date)),
  //           //           SizedBox(height: 10,),
  //           //           RichTextWidget(leftText: "Amount: ", rightText: AppConst.converDate(singleCarReport!.amount)),
  //           //           SizedBox(height: 10,),
  //           //           RichTextWidget(leftText: "Details: ", rightText: AppConst.converDate(singleCarReport!.details)),
  //           //         ],
  //           //       )
  //           //   );
  //           // },
  //         ),
  //       ),
  //       // Add more cells as needed
  //     ],
  //   ),
  // );


 late bool isHide;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isHide = false;
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: widget.size.width * 0.32,
      height:  650,
      decoration: BoxDecoration(
          color: AppColors.white,
          //borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 2, blurRadius: 3,
                offset: Offset(0,2)
            )
          ]
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Vehicle's Costing Report",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
                IconButton(onPressed: widget.onReload, icon: Icon(Icons.refresh)),
                // Row(
                //   children: [
                //     IconButton(onPressed: widget.onReload, icon: Icon(Icons.refresh)),
                //     // IconButton(
                //     //     onPressed: (){
                //     //       setState(() {
                //     //         isHide ? isHide = false : isHide = true;
                //     //         print("celick");
                //     //       });
                //     //     }, icon: Icon( isHide ? Icons.visibility_off : Icons.visibility)),
                //   ],
                // )
              ],
            ),
          ),
          widget.reports!.isEmpty
              ? Center(
                child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
                children: [
                  Image.asset("assets/images/not-found.jpeg",
                    height: 100, width: 100,
                  ),
                  SizedBox(height: 10,),
                  Text("No reports found.",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  )
                ],
            ),
          ),
              )
              : Container(
            width: MediaQuery.of(context).size.width,
            child: widget.isLoading ? LoadingWidget(title: "Update data loading...") : DataTable(
              // border: const TableBorder(left: BorderSide(width: 1, color: AppColors.grey), right: BorderSide(width: 1, color: AppColors.grey),),
              // dividerThickness:0,
              sortAscending: false,
              // headingRowColor: MaterialStateProperty.all(Colors.green) ,
              // headingTextStyle: TextStyle(
              //     fontSize: 15,
              //     fontWeight: FontWeight.w600,
              //     color: AppColors.white
              // ),
              columns: const [
                DataColumn(label: Text(
                    'Date',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                )),
                DataColumn(label: Text(
                    'Cost/Income',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                )),
                DataColumn(label: Text(
                    'View Details',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                )),

              ],

              rows: [
                for(var i=0;i<currentPageData!.length; i++)
                  DataRow(
                      color: MaterialStateColor.resolveWith((states) {
                        return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                      }),
                      cells: [
                        DataCell(Text('${AppConst.converDate( widget.reports![i]!.date) }', style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),)),
                        DataCell(Text('\$${ widget.reports![i]!.amount}',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),
                        )),
                        DataCell(
                          AppIconButton(
                              icon: Icons.visibility,
                              onClick: ()=>_showInfo( widget.reports![i])
                            // onClick: (){
                            //   Get.defaultDialog(
                            //       title: "${widget.carDetails!.plateNo} - Reports",
                            //       contentPadding: EdgeInsets.all(10),
                            //       content: Column(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           RichTextWidget(leftText: "Date: ", rightText: AppConst.converDate(_singleCarReports![i]!.date)),
                            //           SizedBox(height: 10,),
                            //           RichTextWidget(leftText: "Amount: ", rightText: AppConst.converDate(singleCarReport!.amount)),
                            //           SizedBox(height: 10,),
                            //           RichTextWidget(leftText: "Details: ", rightText: AppConst.converDate(singleCarReport!.details)),
                            //         ],
                            //       )
                            //   );
                            // },
                          ),
                        ),
                      ]
                  ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          widget.reports!.length > 10
              ? Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          currentPage = int.parse("${(currentPage - 1).clamp(0, ( widget.reports!.length / itemsPerPage).ceil() - 1)}");
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: AppColors.green,
                          ),
                          child: Icon(Icons.arrow_back_ios, size: 12, color: Colors.white,)
                      ),
                    ),

                    SizedBox(width: 100,),
                    // InkWell(
                    //   onTap: (){},
                    //   child: Container(
                    //       margin: EdgeInsets.only(right: 10),
                    //       width: 30,
                    //       height: 30,
                    //       padding: EdgeInsets.all(7),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(3),
                    //           color: Colors.blue
                    //       ),
                    //       child: Center(
                    //         child: Text("1",
                    //           style: TextStyle(
                    //               fontSize: 12,
                    //               color: Colors.white
                    //           ),
                    //         ),
                    //       )
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: (){},
                    //   child: Container(
                    //       margin: EdgeInsets.only(right: 10),
                    //       width: 30,
                    //       height: 30,
                    //       padding: EdgeInsets.all(7),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(3),
                    //           color: Colors.white,
                    //           border: Border.all(width: 1, color: AppColors.blue)
                    //       ),
                    //       child: Center(
                    //         child: Text("2",
                    //           style: TextStyle(
                    //               fontSize: 12,
                    //               color: Colors.blue
                    //           ),
                    //         ),
                    //       )
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: (){},
                    //   child: Container(
                    //       margin: EdgeInsets.only(right: 10),
                    //       width: 30,
                    //       height: 30,
                    //       padding: EdgeInsets.all(7),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(3),
                    //           color: Colors.white,
                    //           border: Border.all(width: 1, color: AppColors.blue)
                    //       ),
                    //       child: Center(
                    //         child: Text("3",
                    //           style: TextStyle(
                    //               fontSize: 12,
                    //               color: Colors.blue
                    //           ),
                    //         ),
                    //       )
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: (){},
                    //   child: Container(
                    //       margin: EdgeInsets.only(right: 10),
                    //       width: 30,
                    //       height: 30,
                    //       padding: EdgeInsets.all(7),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(3),
                    //           color: Colors.white,
                    //           border: Border.all(width: 1, color: AppColors.blue)
                    //       ),
                    //       child: Center(
                    //         child: Text("4",
                    //           style: TextStyle(
                    //               fontSize: 12,
                    //               color: Colors.blue
                    //           ),
                    //         ),
                    //       )
                    //   ),
                    // ),
                    // Text("........"),
                    // InkWell(
                    //   onTap: (){
                    //
                    //   },
                    //   child: Container(
                    //       margin: EdgeInsets.only(right: 10, left: 10),
                    //       width: 30,
                    //       height: 30,
                    //       padding: EdgeInsets.all(7),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(3),
                    //           color: Colors.white,
                    //           border: Border.all(width: 1, color: AppColors.blue)
                    //       ),
                    //       child: Center(
                    //         child: Text("4",
                    //           style: TextStyle(
                    //               fontSize: 12,
                    //               color: Colors.blue
                    //           ),
                    //         ),
                    //       )
                    //   ),
                    // ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          currentPage = int.parse("${(currentPage + 1).clamp(0, ( widget.reports!.length / itemsPerPage).ceil() - 1)}");
                        });
                      },
                      child: Container(

                          width: 30,
                          height: 30,
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: AppColors.green,
                          ),
                          child: Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white,)
                      ),
                    ),
                  ],
                )
              : Center()
        ],
      ),

    );
  }

  //show info
  Future _showInfo(SingleCarReport? singleCarReport) async{
    print("click === ");
   return  Get.defaultDialog(
      title: "Reports Details",
      contentPadding: EdgeInsets.all(10),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextWidget(leftText: "Date: ", rightText: AppConst.converDate(singleCarReport?.date)),
          SizedBox(height: 10,),
          RichTextWidget(leftText: "Amount: ", rightText: "${singleCarReport?.amount}"),
          SizedBox(height: 10,),
          RichTextWidget(leftText: "Details: ", rightText:"${singleCarReport?.details}"),
        ],
      )
    );
  }
}


class _DataSource extends DataTableSource {
  final List<DataRow> _rows;

  _DataSource(this._rows);

  @override
  DataRow getRow(int index) {
    return _rows[index];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _rows.length;

  @override
  int get selectedRowCount => 0;
}
