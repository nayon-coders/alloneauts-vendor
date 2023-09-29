import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:vendor/app_config.dart';
import 'package:vendor/response.dart';
import 'package:vendor/view/employ/editEmployee.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/dataLoading.dart';
import 'dart:html' as html;
import '../../controller/EmployeeController/employeeController.dart';
import '../../model/employeeModel/employeeModel.dart';
import '../../utility/app_color.dart';
import '../../view_controller/appIconButton.dart';
import '../../view_controller/appNetworkImage.dart';
import '../../view_controller/appPoup.dart';
import '../../view_controller/bigText.dart';

class EmployManagement extends StatefulWidget {
  const EmployManagement({Key? key}) : super(key: key);

  @override
  State<EmployManagement> createState() => _EmployManagementState();
}

class _EmployManagementState extends State<EmployManagement> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFuture = EmployeeController.employeeList();
  }

  Future<EmployeeListModel>? _getDataFuture;



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(text: "Employ Management"),
              SizedBox(
                width: size.width*.20,
                child: AppButton(
                  onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 16,))),
                  text: "Add Employ",
                  bgColor: AppColors.green,
                  width: 100,
                )
              )
            ],
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width, //to get the width of screen
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 2, blurRadius: 3,
                      offset: Offset(0,2)
                  )
                ]
            ),
            child: FutureBuilder<EmployeeListModel>(
              future: _getDataFuture,
              builder: (BuildContext context, AsyncSnapshot<EmployeeListModel> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return DataLoading(text: "Locading...");
                }else if(snapshot.hasData){
                  return FittedBox(
                    child: DataTable(
                      dividerThickness:0,
                      sortAscending: false,
                      columns: const [
                        DataColumn(label: Text(
                          'Profile',
                        )),

                        DataColumn(label: Text(
                          'Employ Name',
                        )),
                        DataColumn(label: Text(
                          'Email',
                        )),
                        DataColumn(label: Text(
                          'Phone',
                        )),
                        DataColumn(label: Text(
                          'Documents',
                        )),
                        DataColumn(label: Text(
                          'Staus',
                        )),
                        DataColumn(label: Text(
                          'Action',
                        )),
                      ],
                      rows: [
                        for(var i=0;i<snapshot!.data!.data!.length;i++)
                          DataRow(
                              color: MaterialStateColor.resolveWith((states) {
                                return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                              }),
                              cells: [
                                DataCell(
                                    AppNetworkImage(
                                      url: 'https://alloneautos.com/documents/230923222807_nayon_document.jpg',
                                      width: 50,
                                      height: 50,

                                    )

                                ),
                                DataCell(Text('${snapshot.data!.data![i].details!.firstName} ${snapshot.data!.data![i].details!.lastName}', style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),)),
                                DataCell(Text('${snapshot.data!.data![i].details!.email}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                  ),
                                )),
                                DataCell(Text('${snapshot.data!.data![i].details!.phone}',style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),)),

                                DataCell(Container(
                                    padding: EdgeInsets.only(left: 7, right: 7, bottom: 3,top: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text('${snapshot.data!.data![i].status == 1 ? "Active" : "Deactive"}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ))),
                                DataCell(InkWell(
                                  onTap:()=>viewDocument("${AppConfig.DOMAIN}/${snapshot.data!.data![i].details!.document}"),
                                  child: Container(
                                      padding: EdgeInsets.only(left: 7, right: 7, bottom: 3,top: 3),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Text('View Documnets',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      )),
                                )),
                                DataCell(
                                  Row(
                                    children: [
                                      SizedBox(width: 5,),
                                      AppIconButton(
                                        icon: Icons.edit,
                                        onClick: (){}, //=>Get.to(EditEmployee(employeeid: snapshot.data!.data![i]!.id.toString())),
                                        bgColor: Colors.amber,
                                      ),
                                      SizedBox(width: 5,),
                                      AppIconButton(
                                        icon: Icons.delete_outline_outlined,
                                        onClick: ()=>openDilog(snapshot.data!.data![i]!.id.toString()),
                                        bgColor: AppColors.red,
                                      ),
                                      SizedBox(width: 5,),
                                    ],
                                  ),

                                ),
                              ]
                          ),

                      ],
                    ),
                  );
                }else{
                  return Text("something web wrong");
                }
              },

            )
          ),
        ],
      ),
    );
  }

  viewDocument(String? document) {
    print("document === $document");
    Get.defaultDialog(
      title: "Documents",
      contentPadding: EdgeInsets.all(10),
      content: AppNetworkImage(url: "https://alloneautos.com/documents/230923222807_nayon_document.jpg", width: 100, height: 200),
      onConfirm: ()=>_downloadDocument(document),
      onCancel: (){},
      confirm: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(100)
        ),
        child: Text("Download"),
      )
    );
  }

  bool isDownload = false;
  void _downloadDocument(url) async{
    setState(() {
      isDownload = true;
    });
    await WebImageDownloader.downloadImageFromWeb(url);
    Get.snackbar("Download Complete", "Document download complete.");
    setState(() {
      isDownload = false;
    });
  }

  openDilog(String id) {
    var size = MediaQuery.of(context).size;
    Get.defaultDialog(
      title: "Are you sure?",
      content: Container(
            width: Responsive.isDesktop(context) ? size.width*.40 : size.width*.90,
          child: Text("Are you sure? You want to delete this employee. or Temporary block? If you delete, you can not recovery the data.")),
      confirm: isLoading ? CircularProgressIndicator(strokeWidth: 1, color:AppColors.black,): TextButton(onPressed: ()=>deleteEmployee(id), child: Text("Permanently Delete")),
      cancel: TextButton(onPressed: (){}, child: Text("Temporary Block",
        style: TextStyle(
          color: Colors.redAccent
        ),
      ),

      ),
    );
  }

  bool isLoading = false;
  //delete employee
  deleteEmployee(id) async{
    setState(() {
      isLoading = true;
    });
    var res = await EmployeeController.deleteEmployee(id);
    if(res.statusCode == 200){
      AppPopup.appPopup(
        context: context,
        title: "Employee information is Removed.",
        body: "This Employee is deleted successfully. It can not back. ",
        dialogType: DialogType.success,
        onOkBtn: ()=>Get.to(MainPage(pageIndex: 12,)),
      );
    }else{
      AppPopup.appPopup(
        context: context,
        title: "Something went wrong.",
        body: "Something went wrong while deleting employee.",
        dialogType: DialogType.error,
        onOkBtn: (){},
      );
    }
    setState(() {
      isLoading = false;
    });
  }





}
