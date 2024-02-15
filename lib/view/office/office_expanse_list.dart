import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vendor/controller/office_controller/office_controller.dart';
import 'package:vendor/model/office_expanse/office_expanse.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appIconButton.dart';
import 'package:vendor/view_controller/bigText.dart';
import 'package:vendor/view_controller/loadingWidget.dart';
import 'package:vendor/view_controller/pagination_widget.dart';

import 'widgets/edit_office_enxpanse.dart';

class OfficeExpanseList extends StatefulWidget {
  const OfficeExpanseList({Key? key}) : super(key: key);

  @override
  State<OfficeExpanseList> createState() => _OfficeExpanseListState();
}

class _OfficeExpanseListState extends State<OfficeExpanseList> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<OfficeExpanseListModel>? _officeExpanseListModel;

  ExpanseList? expanseList;
  int? index;

  final int itemsPerPage = 4;
   int totalItems = 0;
  List<ExpanseList> pageItems = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _officeExpanseListModel = OfficeController.getOfficeExpanse(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: EditOfficeExpanse(expanseList: expanseList, index: index,),
        body: Container(
            height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: ()=>Get.back(),
                        icon: Icon(Icons.arrow_back, color: AppColors.green,),
                      ),
                      Container(
                        width: 10,
                        height: 25,
                        color: AppColors.green,
                      ),
                      SizedBox(width: 5,),
                      BigText(text: "Office Expanse List"),
                    ],
                  ),
                  AppButton(
                      onClick: ()=>_selectDate(context),
                      text: "Search by date",
                      width: 100,
                      height: 35,
                      textSize: 12,
                  )
                ],
              ),
              SizedBox(height: 20,),

              FutureBuilder<OfficeExpanseListModel>(
                future: _officeExpanseListModel,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: LoadingWidget(title: "Loading..."),);
                  }else if(snapshot.hasData){
                   if(snapshot.data!.expanseList!.isNotEmpty){
                      // for(var pageIndex = 0; pageIndex<snapshot.data!.expanseList!.length!; pageIndex++){
                      //   totalItems = snapshot.data!.expanseList!.length;
                      //   final startIndex = pageIndex * itemsPerPage;
                      //   final endIndex = (pageIndex + 1) * itemsPerPage;
                      //    pageItems = snapshot.data!.expanseList!.sublist(startIndex, endIndex > snapshot.data!.expanseList!.length ? snapshot.data!.expanseList!.length : endIndex);
                      // }
                     return Expanded(
                       child:  Container(
                         //width: size.width * 0.32,
                         height: MediaQuery.of(context).size.height,
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
                         child:  SingleChildScrollView(
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Padding(
                                 padding: EdgeInsets.all(15),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("Expanse List",
                                       style: TextStyle(
                                           fontSize: 15,
                                           fontWeight: FontWeight.bold
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                               Container(
                                 width: MediaQuery.of(context).size.width,
                                 height: MediaQuery.of(context).size.height,

                                 child: DataTable(
                                   border: const TableBorder(left: BorderSide(width: 1, color: AppColors.grey), right: BorderSide(width: 1, color: AppColors.grey),),
                                   dividerThickness:0,
                                   sortAscending: true,
                                   headingRowColor: MaterialStateProperty.all(Colors.green) ,
                                   headingTextStyle: TextStyle(
                                       fontSize: 15,
                                       fontWeight: FontWeight.w600,
                                       color: AppColors.white
                                   ),
                                   columns: const [
                                     DataColumn(label: Text(
                                         'Date',
                                         style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                                     )),
                                     DataColumn(label: Text(
                                         'Amount',
                                         style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                                     )),
                                     DataColumn(label: Text(
                                         'Details',
                                         style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                                     )),
                                     DataColumn(label: Text(
                                         'Action',
                                         style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                                     )),

                                   ],
                                   rows: [
                                     for(var i=0;i<snapshot.data!.expanseList!.length; i++)

                                       DataRow(
                                           color: MaterialStateColor.resolveWith((states) {
                                             return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                                           }),
                                           cells: [
                                             DataCell(Text('${ DateFormat('yyyy-MM-dd').format(snapshot.data!.expanseList![i].date!)}', style: TextStyle(
                                                 fontSize: 12,
                                                 fontWeight: FontWeight.w500
                                             ),)),
                                             DataCell(Text('\$${snapshot.data!.expanseList![i].amount}',
                                               style: TextStyle(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.w600
                                               ),
                                             )),

                                             DataCell(
                                                 SizedBox(
                                                   width: 400,
                                                   child: Text('${snapshot.data!.expanseList![i]!.details}',
                                                     style: TextStyle(
                                                         fontSize: 12,
                                                         fontWeight: FontWeight.w600
                                                     ),
                                                   ),
                                                 )),
                                             DataCell(
                                                 Row(
                                                   children: [
                                                     AppIconButton(
                                                       icon: Icons.edit,
                                                       onClick: (){
                                                         setState(() {
                                                           expanseList = snapshot.data!.expanseList![i];
                                                           index = i;
                                                         });
                                                         _scaffoldKey.currentState!.openEndDrawer();

                                                       },
                                                       //onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage(pageIndex: 18, expanseList: snapshot.data!.expanseList![i], id: i.toString(),))),
                                                       bgColor: Colors.amber,
                                                     ),
                                                     SizedBox(width: 10,),
                                                     AppIconButton(
                                                       icon: Icons.delete_forever,
                                                       onClick: (){},
                                                       bgColor: AppColors.red,
                                                     ),
                                                   ],
                                                 )
                                             ),
                                           ]
                                       ),
                                   ],
                                 ),
                               ),
                               SizedBox(height: 20,),
                               // PaginationWidget(
                               //   totalPages: (totalItems / itemsPerPage).ceil(),
                               // ),
                             ],
                           ),
                         ),
                       ),
                     );
                   }else{
                     return Center(child: Text("No data found"),);
                   }
                  }else{
                    return Center(child: Text("Something went wrong."),);
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {

    }
  }

}
