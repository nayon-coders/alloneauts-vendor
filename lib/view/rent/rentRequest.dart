import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/app_config.dart';
import 'package:vendor/controller/rentCarController/rentCarController.dart';
import 'package:vendor/model/rentModels/rest_request_model.dart';
import 'package:vendor/view_controller/appNetworkImage.dart';
import 'package:vendor/view_controller/loadingWidget.dart';
import '../../response.dart';
import '../../utility/app_color.dart';
import '../../view_controller/appButton.dart';
import '../../view_controller/bigText.dart';
import '../../view_controller/richText.dart';

class RentRequestList extends StatefulWidget {
  const RentRequestList({Key? key}) : super(key: key);

  @override
  State<RentRequestList> createState() => _RentRequestListState();
}

class _RentRequestListState extends State<RentRequestList> {

  Future<RentRequestListModel>? getRentRequestFuture()async{
    return await  RentCarController.getRentRequest();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRentRequestFuture();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: FutureBuilder<RentRequestListModel>(
            future: getRentRequestFuture(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: LoadingWidget(title: "Request is loading..."),);
              }else if(snapshot.hasData){
                print("snapshot.data!.data!.requests![i]!.car!.plateNo ${snapshot.data!.data!.requests![1]!.car!.name}");
                return ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BigText(text: "Rent Request List"),
                        SizedBox(
                          width: Responsive.isDesktop(context) ? size.width*.20 : size.width*.40,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Search...",
                                fillColor: AppColors.white,
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: AppColors.green.withOpacity(0.2)),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                contentPadding: EdgeInsets.only(left: 10,right: 10, top: 0, bottom: 0),
                                prefixIcon: Icon(Icons.search, size: 20,)
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      // width: size.width*.55,
                      width: MediaQuery.of(context).size.width, //to get the width of screen
                      padding: const EdgeInsets.all(15),
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
                      child: DataTable(
                        dividerThickness:0,
                        sortAscending: false,
                        columns: [
                          DataColumn(label: Text(
                              'Car',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                          )),
                          DataColumn(label: Text(
                              'Car Name',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                          )),
                          DataColumn(label: Text(
                              'Plate No.',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                          )),
                          DataColumn(label: Text(
                              'Status',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                          )),
                          DataColumn(label: Text(
                              'Date',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                          )),
                          DataColumn(label: Text(
                              'Action',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                          )),
                        ],
                        rows: [
                          for(var i=0;i<snapshot.data!.data!.requests!.length;i++)
                            DataRow(
                                color: MaterialStateColor.resolveWith((states) {
                                  return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                                }),
                                cells: [
                                  DataCell(
                                      AppNetworkImage(url: "${AppConfig.DOMAIN}/${snapshot.data!.data!.requests![i]!.car!.image}", width: 50, height: 50)
                                  ),
                                  DataCell(Text('${snapshot.data!.data!.requests![i]!.car!.name}')),
                                  DataCell(Text('#${snapshot.data!.data!.requests![i]!.car!.plateNo}')),
                                  DataCell(
                                      Container(
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                                        decoration: BoxDecoration(
                                            color: snapshot.data!.data!.requests![i]!.status == "Approved" ? AppColors.green : AppColors.blue,
                                            borderRadius: BorderRadius.circular(4)
                                        ),
                                        child: Text("${snapshot.data!.data!.requests![i]!.status}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.white
                                          ),
                                        ),
                                      )
                                  ),
                                  DataCell(Text('25 March, 2023')),
                                  DataCell(
                                     Row(
                                       children: [
                                         TextButton(
                                             style: ButtonStyle(
                                               backgroundColor: MaterialStatePropertyAll(Colors.amber),
                                             ),
                                             onPressed: ()=>ShowSingleCar(id:snapshot.data!.data!.requests![i]!.requestId.toString(), carInfo: snapshot.data!.data!.requests![i]!.car, driver: snapshot.data!.data!.requests![i]!.driver, msg: snapshot.data!.data!.requests![i]!.message),
                                             child: Text("VIEW ",
                                               style: TextStyle(
                                                   fontSize: 12,
                                                   color: AppColors.white
                                               ),
                                             )),
                                         SizedBox(width: 10,),
                                         TextButton(
                                             style: ButtonStyle(
                                               backgroundColor: MaterialStatePropertyAll(AppColors.green),
                                             ),
                                             onPressed: ()async{
                                               setState((){});
                                               setState(() =>isLoading = true);
                                               var res = await RentCarController.approveRentRequest("${snapshot.data!.data!.requests![i]!.requestId.toString()}/status/accept");
                                               if(res.statusCode == 200){
                                                 getRentRequestFuture();
                                                 setState(() {});
                                                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                   content: Text("Rent request has been approve."),
                                                   backgroundColor: Colors.green,
                                                   duration: Duration(milliseconds: 3000),
                                                 ));
                                               }else{
                                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                   content: Text("Something went wrong. Please try again."),
                                                   backgroundColor: Colors.red,
                                                   duration: Duration(milliseconds: 3000),
                                                 ));
                                               }
                                               setState(() =>isLoading = false);

                                             },
                                             child:  isLoading? CircularProgressIndicator(color: Colors.white,) :  Text("Approved",
                                               style: TextStyle(
                                                   fontSize: 12,
                                                   color: AppColors.white
                                               ),
                                             )),
                                         SizedBox(width: 10,),
                                         TextButton(
                                             style: ButtonStyle(
                                               backgroundColor: MaterialStatePropertyAll(AppColors.red),
                                             ),
                                             onPressed: ()async{
                                                  setState((){});
                                                  setState(() =>isLoading = true);
                                                  var res = await RentCarController.approveRentRequest("${snapshot.data!.data!.requests![i]!.requestId.toString()}/status/cancel");
                                                  print("res == ${res.statusCode}");
                                                  print("res == ${res.body}");
                                                  if(res.statusCode == 200){
                                                  // Navigator.of(context).pop();
                                                    getRentRequestFuture();
                                                  setState(() {});
                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  content: Text("Rent request has been cancel."),
                                                  backgroundColor: Colors.green,
                                                  duration: Duration(milliseconds: 3000),
                                                  ));
                                                  }else{
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  content: Text("Something went wrong. Please try again."),
                                                  backgroundColor: Colors.red,
                                                  duration: Duration(milliseconds: 3000),
                                                  ));
                                                  }
                                                  setState(() =>isLoading = false);
                                             },
                                             child: isLoading? CircularProgressIndicator(color: Colors.white,) : Text("Reject",
                                               style: TextStyle(
                                                   fontSize: 12,
                                                   color: AppColors.white
                                               ),
                                             ))
                                       ],
                                     )
                                  ),
                                ]
                            ),

                        ],
                      ),
                    ),
                  ],
                );
              }else{
                return Center(child: Text("Data not found."),);
              }
            }
          ),
        ),
        isLoading ? Center(child: CircularProgressIndicator(color: AppColors.menuColor,),): Center()
      ],
    );
  }

  bool isLoading = false;
  Future<void> ShowSingleCar({String? id, Car? carInfo, Driver? driver, String? msg}) async {

    print("id === ${id}");
    var size = MediaQuery.of(context).size;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content:  StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  width: size.width*.50,
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppNetworkImage(url: "${AppConfig.DOMAIN}/${carInfo!.image}", width: 100, height: 100),
                                    RichTextWidget(
                                      leftText: "Car Name: ",
                                      rightText: "${carInfo.name}",
                                    ),
                                    SizedBox(height: 7,),
                                    RichTextWidget(
                                      leftText: "Plate No: ",
                                      rightText: "${carInfo.plateNo}",
                                    ),
                                    SizedBox(height: 7,),
                                    RichTextWidget(
                                      leftText: "Model No: ",
                                      rightText: "${carInfo.vmodel}",
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            driver!=null? Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: AppNetworkImage(url: "${driver!.avatar}", width: 100, height: 10,),
                                    ),
                                    SizedBox(height: 10,),
                                    RichTextWidget(
                                      leftText: "Driver Name: ",
                                      rightText: "${driver.firstName} ${driver.lastName}",
                                    ),
                                    SizedBox(height: 7,),
                                    RichTextWidget(
                                      leftText: "Phone Number: ",
                                      rightText: "${driver.phone}",
                                    ),
                                    SizedBox(height: 7,),
                                    RichTextWidget(
                                      leftText: "Email Address:",
                                      rightText: "${driver.email}",
                                    ),

                                  ],
                                ),
                              ),
                            ) :Center(),
                          ],
                        ),
                        SizedBox(height: 30,),
                        BigText(text: "Messages"),
                        SizedBox(height: 8,),
                        Text("${msg}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
