import 'package:flutter/material.dart';import 'package:intl/intl.dart';import 'package:vendor/controller/office_controller/office_controller.dart';import 'package:vendor/model/office_expanse/office_expanse.dart';import 'package:vendor/view/main_pages.dart';import 'package:vendor/view_controller/appInput.dart';import 'package:vendor/view_controller/appButton.dart';class EditOfficeExpanse extends StatefulWidget {  final ExpanseList? expanseList;  final int? index;  const EditOfficeExpanse({Key? key, this.expanseList, this.index}) : super(key: key);  @override  State<EditOfficeExpanse> createState() => _EditOfficeExpanseState();}class _EditOfficeExpanseState extends State<EditOfficeExpanse> {  bool isLoading = false;  //text editing controller  final expanseCose = TextEditingController();  final expanseAmount = TextEditingController();  final expanseDate = TextEditingController();  @override  void initState() {    // TODO: implement initState    super.initState();    //check expanseList is empty or not    if(widget.expanseList != null){      expanseAmount.text = widget.expanseList!.amount.toString();      expanseCose.text = widget.expanseList!.details.toString();      expanseDate.text = DateFormat('yyyy-MM-dd').format(widget.expanseList!.date!);    }  }  @override  Widget build(BuildContext context) {    return Container(        width: MediaQuery.of(context).size.width*.50,        child: Drawer(      // Add a ListView to the drawer. This ensures the user can scroll      // through the options in the drawer if there isn't enough vertical      // space to fit everything.      child: Padding(        padding: EdgeInsets.all(30),        child: ListView(          // Important: Remove any padding from the ListView.          padding: EdgeInsets.zero,          children: [            Text("Edit Office Expanse",              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,),            ),            SizedBox(height: 20,),            AppInput(              controller: expanseAmount,              title: "Amount",              prefixIcon: Icons.monetization_on_outlined,              hintText: "\$00",            ),            SizedBox(height: 10,),            AppInput(              onClick: ()=>_selectDate(context),              readOnly: true,              controller: expanseDate,              title: "Date",              prefixIcon: Icons.date_range_sharp,              hintText: "Date",            ),            // SizedBox(height: 10,),            // Row(            //   children: [            //     Text("Select Coses",            //       style: TextStyle(            //         fontWeight: FontWeight.w600,            //         fontSize: 15,            //       ),            //     ),            //     SizedBox(width: 10,),            //     TextButton(            //         onPressed: ()=>_addOfficeCoses(context),            //         child: Text("Add new coses?",            //           style: TextStyle(            //             fontWeight: FontWeight.w400,            //             fontSize: 12,            //             color: AppColors.green            //           ),            //         ),            //     )            //   ],            // ),            // SizedBox(height: 10,),            // Container(            //   width: double.infinity,            //   decoration: BoxDecoration(            //       color: Colors.white,            //     borderRadius: BorderRadius.circular(5),            //     border: Border.all(width: 1, color: AppColors.green)            //   ),            //   child: DropdownButtonHideUnderline(            //     child: DropdownButton2<String>(            //       isExpanded: true,            //       hint: Text(            //         'Select Coses',            //         style: TextStyle(            //           fontSize: 14,            //           color: Theme.of(context).hintColor,            //         ),            //       ),            //       items: items            //           .map((String item) => DropdownMenuItem<String>(            //         value: item,            //         child: Text(            //           item,            //           style: const TextStyle(            //             fontSize: 14,            //           ),            //         ),            //       ))            //           .toList(),            //       value: selectCoses,            //       onChanged: (String? value) {            //         setState(() {            //           selectCoses = value;            //         });            //            //       },            //       buttonStyleData: const ButtonStyleData(            //         padding: EdgeInsets.symmetric(horizontal: 16),            //         height: 40,            //         width: 140,            //         decoration: BoxDecoration(            //           color: Colors.white,            //         ),            //       ),            //       menuItemStyleData: const MenuItemStyleData(            //         height: 40,            //       ),            //     ),            //   ),            // ),            SizedBox(height: 10,),            AppInput(              controller: expanseCose,              title: "Details",              maxLine: 4,              hintText: "Details",            ),            SizedBox(height: 10,),            AppButton(                onClick: ()=> widget.expanseList != null ? _editOfficeExpanse() : null,                isLoading: isLoading,                text: "Save",                width: 200            ),          ],        ),      ),    ));  }  ///============== add office coses ============//  Future<void> _selectDate(BuildContext context) async {    DateTime selectedDate = DateTime.now();    final DateTime? picked = await showDatePicker(      context: context,      initialDate: selectedDate,      firstDate: DateTime(2000),      lastDate: DateTime(2101),    );    if (picked != null && picked != selectedDate) {      expanseDate.text = DateFormat('yyyy-MM-dd').format(picked);    }  }  void _editOfficeExpanse()async{      setState(() => isLoading = true);      var updatedData = {        "date" : expanseDate.text,        "amount" : expanseAmount.text,        "details" : expanseCose.text,      };      var res = await OfficeController.editOfficeExpnase(context: context, updatedData: updatedData, index: widget.index!);      Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 19,)));      print("res ===== $res");      setState(() => isLoading = false);  }}