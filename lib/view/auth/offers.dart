import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/auth/login.dart';
import 'package:vendor/view/auth/signup.dart';
import '../../firebase/model/pricing_model.dart';
import '../../view_controller/loadingWidget.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {

  ScrollController scrollController = ScrollController(); // 👈 Define scrollController

  Future<PricingModel>? getDataFuture;


  bool isMonthly = true;
  bool isYearly = false;

  @override
  void initState() { // 👈 create animation in initState
    getDataFuture = _getPricing();

    // Future.delayed(const Duration(milliseconds: 100), () {
    //   scrollController.animateTo(scrollController.position.maxScrollExtent,
    //       duration: Duration(seconds: 20*2), curve: Curves.linear);
    // });
    // super.initState();

  }

  Future getOfferData()async{


  }

  Future<PricingModel> _getPricing()async{
    // Reference to the "users" collection
    DocumentSnapshot pricingData = await FirebaseFirestore.instance.collection('admin').doc("admin_285962").collection("admin_pricing").doc("admin_pricing").get();
    PricingModel pricingModel = PricingModel.fromJson(pricingData.data() as Map<String, dynamic>);
    return pricingModel;
  }





  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //backgroundColor: AppColors.bg,
        body: FutureBuilder<PricingModel>(
          future: getDataFuture,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return  LoadingWidget(
                title: "Pricing is loading for you.",
              );
            }else if(snapshot.hasData){
              print("snapshor ==== ${snapshot.data}");
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: AppColors.bg,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Login())),
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: AppColors.green,
                                      border: Border.all(width: 1, color: AppColors.green),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Center(
                                    child: Text("Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.white
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20,),
                              IconButton(
                                onPressed: ()=>Navigator.pop(context),
                                icon: Icon(Icons.close, size: 20, color: Colors.grey,),
                              )
                            ],
                          ),
                          SizedBox(height: 40,),
                          Container(
                            
                            child: Center(
                                child: RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "Car Subscription Software",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 50,
                                                  color: AppColors.black,
                                                  fontFamily: "themeFont"
                                              )
                                          ),
                                          TextSpan(
                                              text: " Pricing ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 50,
                                                  color: AppColors.blue,
                                                  fontFamily: "themeFont"
                                              )
                                          ),
                                          TextSpan(
                                              text: "&",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 50,
                                                  color: AppColors.black,
                                                  fontFamily: "themeFont"
                                              )
                                          ),
                                          TextSpan(
                                              text: " Plans ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 50,
                                                  color: AppColors.blue,
                                                  fontFamily: "themeFont"
                                              )
                                          ),
                                        ]
                                    )

                                )
                            ),
                          ),
                          SizedBox(height: 5,),
                          const Center(
                            child: Text("Big or small, Loopit provides the world's leading car subscription software with pricing that gives you the freedom to grow.",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                  fontFamily: "themeFont"
                              ),
                            ),
                          ),
                          SizedBox(height: 40,),
                          Container(
                              width: size.width*.20,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25.0)
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      if(mounted){
                                        setState(() {
                                          isMonthly = true;
                                          isYearly = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10,),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: isMonthly? Colors.blue : Colors.white,
                                          border: Border.all(width: 1, color: Colors.blue)
                                      ),
                                      child: Text("Monthly",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color:isMonthly? Colors.white : Colors.blue
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  InkWell(
                                    onTap: (){
                                      if(mounted){
                                        setState(() {
                                          isYearly = true;
                                          isMonthly = false;
                                        });
                                      }},
                                    child: Container(
                                      padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10,),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: isYearly? Colors.blue: Colors.white,
                                          border: Border.all(width: 1, color: Colors.blue)
                                      ),
                                      child: Text("Yearly",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: isYearly?AppColors.white : Colors.blue
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),


                          SizedBox(
                            height: 700,
                            width: size.width,
                            child: isMonthly
                                ?  Padding(
                              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20, top: 40),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.adminPricing!.monthly!.length,
                                itemBuilder: (_, index){
                                  var monthlyData = snapshot.data!.adminPricing!.monthly![index];
                                  return buildSinglaMontlyPlan(
                                    size: size,
                                    price: "${double.parse("${monthlyData?.price}")}",
                                    title: "${monthlyData?.planName}",
                                    short: "${monthlyData?.description}",
                                    details: monthlyData!.details!.toList(),
                                    onClick:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp(pricingModel: monthlyData)))
                                  );
                                },
                              ),
                            )
                                :  Padding(
                              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20, top: 40),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.adminPricing!.yearly!.length,
                                itemBuilder: (_, index){
                                  var yearlly = snapshot.data!.adminPricing!.yearly![index];
                                  return buildSinglaMontlyPlan(
                                    size: size,
                                    price: "${yearlly!.price}",
                                    title: "${yearlly!.planName}",
                                    short: "${yearlly.description}",
                                    details: yearlly!.details!.toList(),
                                      onClick:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp(pricingModel: yearlly)))
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          const Center(
                            child: Text("'\$' indicates usage and third party charges may apply. All fees shown in USD.",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey
                              ),
                            ),
                          ),
                          SizedBox(height: 40,),
                          SizedBox(
                            width: size.width,
                            height: 160,
                            child: ListView.builder(
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: 20,
                              physics: NeverScrollableScrollPhysics(),
                              reverse: true,
                              shrinkWrap: true,
                              itemBuilder: (_, index){
                                return Container(
                                  height: 160,
                                  width: 200,
                                  margin: EdgeInsets.only(left: 20),
                                  child: Image.asset("assets/images/partner.png"),
                                );
                              },
                            ),
                          )


                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      padding: EdgeInsets.only(top: 40, bottom: 50),
                      color: AppColors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: size.width*.60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text("Frequently Asked Questions",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                      fontFamily: "themeFont"
                                  ),
                                ),
                              ),
                              SizedBox(height: 40,),
                              ExpandablePanel(
                                header: Text("Do you offer a free trial?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "themeFont",
                                    fontSize: 15,
                                  ),),
                                collapsed: Text("Lorem Ipsum is simply dummy text of the... ",
                                  softWrap: true, maxLines: 2,
                                  overflow: TextOverflow.ellipsis,

                                ),
                                expanded: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ", softWrap: true, ),
                              ),
                              SizedBox(height: 30,),
                              ExpandablePanel(
                                header: Text("Do you offer a free trial?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "themeFont",
                                    fontSize: 15,
                                  ),),
                                collapsed: Text("Lorem Ipsum is simply dummy text of the... ",
                                  softWrap: true, maxLines: 2,
                                  overflow: TextOverflow.ellipsis,

                                ),
                                expanded: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ", softWrap: true, ),
                              ),
                              SizedBox(height: 30,),
                              ExpandablePanel(
                                header: Text("Do you offer a free trial?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "themeFont",
                                    fontSize: 15,
                                  ),),
                                collapsed: Text("Lorem Ipsum is simply dummy text of the... ",
                                  softWrap: true, maxLines: 2,
                                  overflow: TextOverflow.ellipsis,

                                ),
                                expanded: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ", softWrap: true, ),
                              ),
                              SizedBox(height: 30,),
                              ExpandablePanel(
                                header: Text("Do you offer a free trial?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "themeFont",
                                    fontSize: 15,
                                  ),),
                                collapsed: Text("Lorem Ipsum is simply dummy text of the... ",
                                  softWrap: true, maxLines: 2,
                                  overflow: TextOverflow.ellipsis,

                                ),
                                expanded: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ", softWrap: true, ),
                              ),
                              SizedBox(height: 30,),
                              ExpandablePanel(
                                header: Text("Do you offer a free trial?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "themeFont",
                                    fontSize: 15,
                                  ),),
                                collapsed: Text("Lorem Ipsum is simply dummy text of the... ",
                                  softWrap: true, maxLines: 2,
                                  overflow: TextOverflow.ellipsis,

                                ),
                                expanded: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ", softWrap: true, ),
                              ),
                              SizedBox(height: 30,),
                              ExpandablePanel(
                                header: Text("Do you offer a free trial?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "themeFont",
                                    fontSize: 15,
                                  ),),
                                collapsed: Text("Lorem Ipsum is simply dummy text of the... ",
                                  softWrap: true, maxLines: 2,
                                  overflow: TextOverflow.ellipsis,

                                ),
                                expanded: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ", softWrap: true, ),
                              ),
                              SizedBox(height: 30,),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }else if(snapshot.hasError){
              return Text("${snapshot.error}");
            }else{
              return Center(
                child: Text("Error"),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            launchUrl(Uri.parse('https://wa.me/17187373202'));
          },
          child: Icon(Icons.support, size: 30, color: Colors.white,),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Container buildSinglaMontlyPlan({
    required Size size,
    required String title,
    required String price,
    required String short,
    required List<String> details,
    required VoidCallback onClick
}) {
    return Container(

        child: Row(
          children: [
            Container(
              width: size.width*.29,
              // padding: EdgeInsets.only(left: 18, right: 18, top: 30),
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),)
                    ),
                    child: Center(
                      child: Text("$title",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "themeFont",
                          color: AppColors.white
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text("$short",
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: "themeFont",
                        color: AppColors.black,
                        letterSpacing: 1,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(height: 1, color: Colors.grey,),
                  SizedBox(height: 10,),
                  Center(
                    child: RichText(text:  TextSpan(
                      children: [
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(0.0, -22.0),
                            child: Text(
                              "\$",
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        TextSpan(text: "$price",
                          style: TextStyle(
                            fontFamily: "themeFont",
                            fontSize: 50,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(0.0, -22.0),
                            child: Text(
                              "-10%",
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.red),
                            ),
                          ),
                        ),
                      ]
                    )),
                  ),
                  Center(
                    child: Text("USD per month",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: onClick,
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Get Start",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.white
                                ),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.arrow_forward, color: AppColors.white,size: 20,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      //onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp(pricingModel: adminPricing,))),
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: AppColors.black),
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(
                          child: Text("Reqest for demo",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColors.black
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 275,
                    child: Padding(
                      padding:  EdgeInsets.all(30.0),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: details.length,
                        itemBuilder: (_, index){
                          return buildFeatureList(
                              bold: "",
                              text: "${details[index]}"
                          );
                        },
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
  }

  Row buildFeatureList({required String bold, required String text}) {
    return Row(
      children:[
        Icon(Icons.check_circle, color: AppColors.green,),
        SizedBox(width: 10,),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: "$bold",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "themeFont",
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              )
            ),
            TextSpan(
                text: "$text",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  fontFamily: "themeFont",
                )
            )
          ]
        ))],
    );
  }
}

