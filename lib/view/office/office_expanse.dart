import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vendor/controller/office_controller/office_controller.dart';
import 'package:vendor/model/office_expanse/office_expanse.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view/office/widgets/office_expance_summary.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/bigText.dart';

class OfficeExpanse extends StatefulWidget {
  final ExpanseList? expanseList;
  final String? index;
  const OfficeExpanse({Key? key, this.expanseList, this.index}) : super(key: key);

  @override
  State<OfficeExpanse> createState() => _OfficeExpanseState();
}

class _OfficeExpanseState extends State<OfficeExpanse> {

  bool isLoading = false;
  ///=======get update expanse list =====//
  List<ExpanseList> expanseList = [];
  bool isDataFatch = false;
  void _officeExpanseListModel ()async{
    setState(() => isDataFatch = true);
     var data =await OfficeController.getOfficeExpanse(context: context);
     for(var i in data.expanseList!){
       setState(() {
         expanseList.add(i);
       });
     }
    setState(() => isDataFatch = false);

    print("expanseList ==== this ${expanseList}");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _officeExpanseListModel();


  }


  //text editing controller
  final expanseCose = TextEditingController();
  final expanseAmount = TextEditingController();
  final expanseDate = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage(pageIndex: 19,))),
                      icon: Icon(Icons.arrow_back, color: AppColors.green,),
                    ),
                    Container(
                      width: 10,
                      height: 25,
                      color: AppColors.green,
                    ),
                    SizedBox(width: 5,),
                    BigText(text: "Office Expanse"),
                  ],
                ),
                // AppButton(
                //     onClick: (){},
                //     text: "View Report",
                //     width: 100,
                //     height: 35,
                //     textSize: 12,
                // )
              ],
            ),
            SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 400,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppInput(
                        controller: expanseAmount,
                        title: "Amount",
                        prefixIcon: Icons.monetization_on_outlined,
                        hintText: "\$00",
                      ),
                      SizedBox(height: 10,),
                      AppInput(
                        onClick: ()=>_selectDate(context),
                        readOnly: true,
                        controller: expanseDate,
                        title: "Date",
                        prefixIcon: Icons.date_range_sharp,
                        hintText: "Date",
                      ),
                      // SizedBox(height: 10,),
                      // Row(
                      //   children: [
                      //     Text("Select Coses",
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 15,
                      //       ),
                      //     ),
                      //     SizedBox(width: 10,),
                      //     TextButton(
                      //         onPressed: ()=>_addOfficeCoses(context),
                      //         child: Text("Add new coses?",
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.w400,
                      //             fontSize: 12,
                      //             color: AppColors.green
                      //           ),
                      //         ),
                      //     )
                      //   ],
                      // ),
                      // SizedBox(height: 10,),
                      // Container(
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(width: 1, color: AppColors.green)
                      //   ),
                      //   child: DropdownButtonHideUnderline(
                      //     child: DropdownButton2<String>(
                      //       isExpanded: true,
                      //       hint: Text(
                      //         'Select Coses',
                      //         style: TextStyle(
                      //           fontSize: 14,
                      //           color: Theme.of(context).hintColor,
                      //         ),
                      //       ),
                      //       items: items
                      //           .map((String item) => DropdownMenuItem<String>(
                      //         value: item,
                      //         child: Text(
                      //           item,
                      //           style: const TextStyle(
                      //             fontSize: 14,
                      //           ),
                      //         ),
                      //       ))
                      //           .toList(),
                      //       value: selectCoses,
                      //       onChanged: (String? value) {
                      //         setState(() {
                      //           selectCoses = value;
                      //         });
                      //
                      //       },
                      //       buttonStyleData: const ButtonStyleData(
                      //         padding: EdgeInsets.symmetric(horizontal: 16),
                      //         height: 40,
                      //         width: 140,
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //       menuItemStyleData: const MenuItemStyleData(
                      //         height: 40,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 10,),
                      AppInput(
                        controller: expanseCose,
                        title: "Details",
                        maxLine: 4,
                        hintText: "Details",
                      ),
                      SizedBox(height: 10,),
                      AppButton(onClick: ()=> _addOfficeExpanse(), isLoading: isLoading, text: "Save", width: 200),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20,),
              OfficeExpanseSummery(expanseList: expanseList, isLoading: isDataFatch)
            ],
          )

          ],
        ),
      ),
    );
  }


  ///============== add office coses ============//
  // final coses = TextEditingController();
  // bool isAddingCosses = false;
  // Future<void> _addOfficeCoses(context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Add expanse coses'),
  //         content: StatefulBuilder(
  //           builder: (context, setState) {
  //             return SingleChildScrollView(
  //               child: ListBody(
  //                 children:  <Widget>[
  //                   AppInput(
  //                       controller: coses,
  //                       title: "Coses",
  //                       hintText: "Type Office Coses"
  //                   ),
  //                   SizedBox(height: 20,),
  //                   AppButton(
  //                       onClick: ()=>_addingCoses(),
  //                       text: "Add Coses",
  //                       width: 200,
  //                       isLoading: isAddingCosses,
  //                   )
  //                 ],
  //               ),
  //             );
  //           }
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  ///============== add office coses ============//
  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      expanseDate.text = DateFormat('yyyy-MM-dd').format(picked);

    }
  }




  //add
  void _addOfficeExpanse() async{
    setState(() =>isLoading = true);
    await OfficeController.addOfficeExpanse(context: context, date: expanseDate.text, amount: expanseAmount.text, details: expanseCose.text);
    _officeExpanseListModel();
    setState(() =>isLoading = false);
  }


 //  //add coses method
 // void _addingCoses() async{
 //   setState(() =>isAddingCosses = true);
 //   bool added = await OfficeController.addOfficeExpanseCoses(coses: coses.text, context: context);
 //   if(added){
 //     Navigator.pop(context);
 //   }
 //   setState(() =>isAddingCosses = false);
 // }

}
