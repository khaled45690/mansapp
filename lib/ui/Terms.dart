import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mansaapp/APIs/ContentApi.dart';
import 'package:mansaapp/Constants/_buildDrawer.dart';
import 'package:mansaapp/Constants/customcolors.dart';
import 'package:mansaapp/Models/ContentVM.dart';
import 'package:mansaapp/resources/fonts.dart';

import '../AboutApp.dart';
import '../localizations.dart';
import 'Ads.dart';
import 'CartScreen.dart';
import 'ContactUs.dart';
import 'MyCart.dart';
import 'Offers.dart';
import 'Ourservices.dart';
import 'PaymentScreen.dart';
import 'SigninScreen.dart';
import 'AboutApp.dart';

class Terms extends StatefulWidget{
  Terms():super();

  @override
  _TermsState createState()=>_TermsState();
}




class _TermsState extends State<Terms> {
BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String name="";
  String email="";
  String imageprofile="";
bool apiCall = true ;

  @override
  void initState() {
    super.initState();
    //post=getAboutApp();
    ContentApi.getTerms().then((response){
      if(response.code !=200){
        Navigator.pop(context);
      }else {
        setState(() {
          print("response.data.ValueAr");
         this.content = response.data;
         setState(() {
          this.apiCall = false ;
        });
          //this.apiCall = false;
        });
      }

    },onError: (error){
      setState(() {
        print("Error response.data.ValueAr");
         //this.content = response.data;
        //this.apiCall = false ;
      });
      print("getting moreDetails error : : : $error");
    });
  }

ContentVM content = new ContentVM();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     key: _scaffoldKey,
          backgroundColor: bgColor,
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [lightBgColor, transColor],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
            ),
            title: new Text(AppLocalizations.of(context).lblTerms_and_Conditions,  style: MansaFont.baseFontStyle() ,) ,
            centerTitle: true,
            automaticallyImplyLeading: true,
            elevation: 0.0,
            leading: new IconButton(
                  icon: new IconButton(icon:
                   new Image.asset("images/asset17.png")),iconSize: 40.0,
                  onPressed: () => _scaffoldKey.currentState.openDrawer()
              ),
            actions: <Widget>[
              IconButton(icon: AppLocalizations.of(context).locale=="en" ? Image.asset("images/1-01.png") : Image.asset("images/asset32.png"),iconSize: 30.0,
                onPressed: () => Navigator.of(context).pop()),
            ],

          ),
      body: ListView(
        children: <Widget>[
         
            new Image.asset(
              AppLocalizations.of(context).lblLogoSrc,
              height: 150.0,
              width: 150.0,
            ),
            new SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: this.apiCall ? Center(child: CircularProgressIndicator(),):Text(AppLocalizations.of(context).locale=="en" ? content.ValueEn.toString() :content.ValueAr.toString() , 
            style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                    // padding: EdgeInsets.all(24.0),
                    color: Colors.black)),
            ),
            
          ],
      ),
      drawer: buildDrawer()
    );
  }
}

