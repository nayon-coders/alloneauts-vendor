import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/auth/login.dart';
import 'package:vendor/view/auth/signup.dart';
import 'package:vendor/view_controller/appButton.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {

  ScrollController scrollController = ScrollController(); // 👈 Define scrollController

  @override
  void initState() { // 👈 create animation in initState
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 20*2), curve: Curves.linear);
    });

    // //👉 If you want infinite scrolling use the following code
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     // Scroll has reached the end, reset the position to the beginning.
    //     scrollController.jumpTo(scrollController.position.minScrollExtent);
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //backgroundColor: AppColors.bg,
        body: SingleChildScrollView(
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
                    Center(
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
                      height: 50,
                      width: size.width*.20,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0)
                      ),
                      child:  TabBar(
                        indicator: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius:  BorderRadius.circular(25.0)
                        ) ,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs:   [
                          Tab(text: 'Monthly',),
                          Tab(text: 'Yearly',),
                        ],
                      ),
                    ),


                    SizedBox(
                      height: 700,
                      width: size.width,
                      child: TabBarView(
                        children:  [
                          getMonthlyPlan(),
                          getYearlyPlan(),
                        ],
                      )
                    ),
                    SizedBox(height: 30,),
                    Center(
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            launchUrl(Uri.parse('https://wa.me/17187373202'));
          },
          child: Icon(Icons.whatsapp, size: 30, color: Colors.white,),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }

  getMonthlyPlan() {
    var size = MediaQuery.of(context).size; 
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSinglaMontlyPlan(
            size: size,
            price: "99",
            title: "STARTER"
          ),
          buildSinglaMontlyPlan(
              size: size,
              price: "129",
              title: "PROFESSIONAL"
          ),
          buildSinglaMontlyPlan(
              size: size,
              price: "150",
              title: "ENTERPRISE"
          ),
        ],
      ),
    );
  }

  getYearlyPlan() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSinglaMontlyPlan(
              size: size,
              price: "299",
              title: "STARTER"
          ),
          buildSinglaMontlyPlan(
              size: size,
              price: "399",
              title: "PROFESSIONAL"
          ),
          buildSinglaMontlyPlan(
              size: size,
              price: "500",
              title: "ENTERPRISE"
          ),
        ],
      ),
    );
  }


  Container buildSinglaMontlyPlan({
    required Size size,
    required String title,
    required String price,
}) {
    return Container(
        child: Row(
          children: [
            Container(
              width: size.width*.29,
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("$title",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: "themeFont",
                        color: AppColors.green
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text("Big or small, earn recurring subscription revenue from fleets of any size",
                      textAlign: TextAlign.center,
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
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp())),
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
                      //onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp())),
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
                  SizedBox(height: 30,),
                  Column(
                    children: [
                      buildFeatureList(
                        bold: "1-30",
                        text: " Vehicles management."
                      ),
                      const SizedBox(height: 5,),
                      buildFeatureList(
                          bold: "Ticket",
                          text: " management."
                      ),
                      const SizedBox(height: 5,),
                      buildFeatureList(
                          bold: "Unlimited",
                          text: " team members."
                      ),
                      const SizedBox(height: 5,),
                      buildFeatureList(
                          bold: "Unlimited",
                          text: " subscribers."
                      ),
                      const SizedBox(height: 5,),
                      buildFeatureList(
                          bold: "Ticket Notification.",
                          text: ""
                      ),

                      const SizedBox(height: 5,),
                      buildFeatureList(
                          bold: "Driver",
                          text: " Management."
                      ),
                      const SizedBox(height: 5,),
                      buildFeatureList(
                          bold: "Team",
                          text: " Management."
                      ),
                      const SizedBox(height: 5,),
                      buildFeatureList(
                          bold: "Billing and payments",
                          text: " Management"
                      ),

                      const SizedBox(height: 5,),
                      buildFeatureList(
                          bold: "Basic reporting",
                          text: ""
                      ),
                    ],
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
