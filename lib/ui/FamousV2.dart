import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mansaapp/APIs/FamousApi.dart';
import 'package:mansaapp/APIs/ShoppingCartApi.dart';
import 'package:mansaapp/Constants/customcolors.dart';
import 'package:mansaapp/Constants/strings.dart';
import 'package:mansaapp/Models/FamousVM.dart';
import 'package:mansaapp/Models/ShoppingCartVM.dart';
import 'package:mansaapp/utilis/CustomizedWidgets.dart';

import '../localizations.dart';
class FamousV2 extends StatefulWidget {
  FamousV2({Key key, this.shoppingCart}) :super(key: key);
  ShoppingCartVM shoppingCart;
  @override
  _FamousV2State createState() => _FamousV2State();
}

class _FamousV2State extends State<FamousV2> {
  List<SocialFamousVM> SocialFamousVMs = new List<SocialFamousVM>();
  List<ItemModel> prepareData = new List<ItemModel>();
    List<int> myList = List<int>();

  double totalPrice = 0;
  @override
  void initState() {
    totalPrice = widget.shoppingCart.Price;
    FamousApi.selectAll().then((response){
      if(response.code !=200){
        Navigator.pop(context);
      }else {
        prepareData = <ItemModel>[
        ItemModel(header: AppLocalizations.of(context).lblFacebook, bodyModel: BodyModel(price: 20, quantity: 10,SocialFamousVMs: new List<FamousVM>())),
        ItemModel(header: AppLocalizations.of(context).lblGoogle, bodyModel: BodyModel(price: 35, quantity: 5,SocialFamousVMs: new List<FamousVM>())),
        ItemModel(header: AppLocalizations.of(context).lblInstagram, bodyModel: BodyModel(price: 800, quantity: 15,SocialFamousVMs: new List<FamousVM>())),
        ItemModel(header: AppLocalizations.of(context).lblTwitter, bodyModel: BodyModel(price: 80, quantity: 150,SocialFamousVMs: new List<FamousVM>())),
      ItemModel(header: AppLocalizations.of(context).lblSnapShat, bodyModel: BodyModel(price: 80, quantity: 150,SocialFamousVMs: new List<FamousVM>())),
      ItemModel(header: AppLocalizations.of(context).lblYoutube, bodyModel: BodyModel(price: 80, quantity: 150,SocialFamousVMs: new List<FamousVM>()))
      ];
        response.data.forEach((famousObj){
          setState(() {
            if(famousObj.SocialMediaId == 1){
            prepareData[0].bodyModel.SocialFamousVMs.add(famousObj);
          }else if(famousObj.SocialMediaId == 2){
            prepareData[1].bodyModel.SocialFamousVMs.add(famousObj);
          }else if(famousObj.SocialMediaId == 3){
            prepareData[2].bodyModel.SocialFamousVMs.add(famousObj);
          }else if(famousObj.SocialMediaId == 4){
            prepareData[3].bodyModel.SocialFamousVMs.add(famousObj);
          }else if(famousObj.SocialMediaId == 5){
            prepareData[4].bodyModel.SocialFamousVMs.add(famousObj);
          }else if(famousObj.SocialMediaId == 6){
            prepareData[5].bodyModel.SocialFamousVMs.add(famousObj);
          }
          });
        });
        setState(() {
         setState(() {
          this.apiCall = false ;
        });
          //this.apiCall = false;
        });
      }

    },onError: (error){
      setState(() {
        print("Error response.data.ValueAr");
      });
      print("getting moreDetails error : : : $error");
    });
    
  }
  
bool apiCall = true ;
 BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).lblFamous),
      ),
      body: this.apiCall ? Center(child: CircularProgressIndicator(),):
      
      ListView.builder(
        itemCount: prepareData.length+1,
        itemBuilder: (context, i) {
          if (i == prepareData.length){
            return Column(
              children: <Widget>[
                Text(totalPrice.toString()+AppLocalizations.of(context).lblRyal),
          appButtonbgimage(
                              // Strings.Next(),
                              // () => Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => Emarkiting_campaigns())),
                              AppLocalizations.of(context).lblNext,
                              (){ send_data();},
                              bgColor: lightBgColor,
                              bgColor2: transColor),
              ],
            );
          }
          return new ExpansionTile(
            title: new Text(
              prepareData[i].header,
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue),
            ),
            children: <Widget>[
              new Column(
                children: _buildExpandableContent(prepareData[i]),
              ),
            ],
          );
        },
      ),
    //     floatingActionButton: new FloatingActionButton(
    //   onPressed: () {
    //     // Add your onPressed code here!
    //   },
    //   elevation: 0.0,
    //   child: new Icon(Icons.thumb_up),
    //   backgroundColor: new Color(0xFFE57373),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    // ),
      
    );
  }
  // appButtonbgimage(
  //                             // Strings.Next(),
  //                             // () => Navigator.of(context).push(MaterialPageRoute(
  //                             //     builder: (context) => Emarkiting_campaigns())),
  //                             AppLocalizations.of(context).lblNext,
  //                             (){ send_data();},
  //                             bgColor: lightBgColor,
  //                             bgColor2: transColor),
   _buildExpandableContent(ItemModel policies) {
    List<Widget> columnContent = [];

    for (var content in policies.bodyModel.SocialFamousVMs)
      columnContent.add(
        // new ListTile(
        //     title: new Text(
        //       content,
        //       style: new TextStyle(fontSize: 18.0, color: Colors.lightBlue),
        //     ),

        //     onTap: () {
        //       _openWebUrl(Websites.endpoints[content], content);
        //     }),
        new ListTile(
        onTap:null,
        
        leading: new Container(
          //backgroundColor: Colors.blue,
          child: CircleAvatar(
                radius: 25.0,
                backgroundImage:
                    NetworkImage(content.Image),
                backgroundColor: Colors.transparent,
              ),
        ),

        title: Container(
          margin: EdgeInsets.only(right: 0, left: 0, bottom: 0, top: 10),
            width: MediaQuery.of(context).size.width,
            color: grey_ligth,
          // decoration: BoxDecoration(
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey.withOpacity(0.8),
          //       spreadRadius: 5,
          //       blurRadius: 5,
          //       offset: Offset(0, 7), // changes position of shadow
          //     ),
          //   ],
          // ),
          child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(AppLocalizations.of(context).locale=="en"?content.NameEn:content.NameAr
                  ,style: TextStyle( fontSize: 16), textAlign: TextAlign.right,),
                  Text(content.Followers.toString() + AppLocalizations.of(context).lblFollowers, style: TextStyle( fontSize: 15), textAlign: TextAlign.right, ),
                  //Text(content.Rate.toString() + AppLocalizations.of(context).lblFollowers, style: TextStyle( fontSize: 15), textAlign: TextAlign.right, ),
                  Container(
                      child: content.Rate>=5?
                      new Image(image: new AssetImage('images/fiveStars.PNG') , height: 40,width: 60,)
                      :(content.Rate>=4?
                          new Image(image: new AssetImage('images/fourStars.PNG') , height: 40,width: 50,)
                        :(content.Rate>=3?
                            new Image(image: new AssetImage('images/threeStars.PNG') , height: 40,width: 40,)
                            :((content.Rate>=2?
                              new Image(image: new AssetImage('images/twoStars.PNG') , height: 40,width: 30,)
                                :(content.Rate>=1?
                                  new Image(image: new AssetImage('images/oneStars.PNG') , height: 40,width: 20,)
                                  :new Image(image: new AssetImage('images/oneStars.PNG') , height: 40,width: 10,)))))),
                    )
                ],
              ),
              flex: 2,
            ),
            Expanded(
              child: Column(
                  children: <Widget>[
                    new Checkbox(value: content.isCheck, onChanged: (bool value) {
                      setState(() {
                        content.isCheck = value;
                        if(value){
                          totalPrice =totalPrice +content.Price;
                          myList.add(content.Id);
                        }else{
                          totalPrice =totalPrice -content.Price;
                          myList.remove(content.Id);
                        }
                      });
                    }),
                     Text(content.Price.toString() + AppLocalizations.of(context).lblRyal  ,style: TextStyle( fontSize: 15),)
                  ],
                ),
              flex: 1,
            )
            
            
          ],
        ),
        )
        
        
        
        
    ),
      );

    return columnContent;
  }

 send_data() {

    
    try {
      showAppLoading(context);
      widget.shoppingCart.Price = totalPrice;
      widget.shoppingCart.famous = myList;
     print("MyList "+myList.length.toString());
      ShoppingCartApi.addToShoppingCar(widget.shoppingCart).then((response) {
          if (response.code ==200 ) {
            hideAppDialog(context);
           // showInSnackBar("تم اضافه الخدمه الي سله الطلبات", context, _scaffoldKey);
            showInSnackBarAfterAddService(AppLocalizations.of(context).lblServiceAdded, context, _scaffoldKey);
   
           // showSnack("تم اضافه الخدمه الي سله المهملات");
          } else {
            print("${response.message}");
            //showInSnackBar("${response.message}", context, _scaffoldKey);
          }
          setState(() {
          //this.loginApi = false;
          });
        }, onError: (error) {
          print("login Error : : :$error");
          setState(() {
          // this.loginApi = false;
          });
        });
      
    }catch(error) {
      print("object");
      print(error.toString());
      hideAppDialog(context);
    };

  }
  
}
class ItemModel {
  bool isExpanded;
  String header;
  BodyModel bodyModel;

  ItemModel({this.isExpanded: false, this.header, this.bodyModel});
}

class BodyModel {
  int price;
  int quantity;
List<FamousVM> SocialFamousVMs;
  BodyModel({this.price, this.quantity ,this.SocialFamousVMs});
}
class SocialFamousVM {
  int id=0;
  String name;
  double price;
  String avatarImage;
  bool isCheck;
  SocialFamousVM({this.name, this.avatarImage, this.isCheck , this.id , this.price});
}
