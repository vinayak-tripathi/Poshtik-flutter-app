import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vt/data/data.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
//import 'package:vt/screens/Finalscreen.dart';

import 'Foodscreen.dart';
import 'home.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  get bottomNavigationBar => null;
  DatabaseReference order = FirebaseDatabase.instance.reference().child("Food Order");
  DatabaseReference users = FirebaseDatabase.instance.reference().child("Users");
  User? result = FirebaseAuth.instance.currentUser;
  double cost = 0;
  String time = "0";
  String food = "";
  late Razorpay razorpay;
  
  @override
  Widget build(BuildContext context) {
    
    
    for (int i = 0; i < cart.length; i++) {
      cost += cart[i].price;
      food = food + cart[i].name + "|";
    }
    if (cart.length > 0) {
      time = "10";
    }
    if (cart.length > 5) {
      time = "20";
    }

    

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CartScreen(),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${cart.length} Items',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple,
        currentIndex: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,  //CHANGE THIS TO GREY ON SELECTED
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
              ),
              label: "Pay & Checkout"),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(uid:result!.uid)),
              );
          }
          else{
            if (cart.length==0){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Your Cart is Empty"),
                    content: Text("Looks like you haven't added anything to your cart yet"),
                    actions: [
                      TextButton(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home(uid:result!.uid)),
                            );
                        },
                      )
                    ],
                  );
                }
              );
            }
            else{
              //pay();
              foodOrder(time);
            }
          }
        }

      ),

      resizeToAvoidBottomInset: false,
      body: Container(
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [
                          0.3,
                          0.6,
                          0.8
                        ],
                        colors: [
                          Colors.deepPurple,
                          Colors.deepOrangeAccent,
                          Colors.orange
                        ],
                      )
                  ),
                  child: Positioned(
                    top: 20,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  width: size.width,
                                  height: 120,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Foodscreen(
                                                  county: cart[index]),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image(
                                              height: 120,
                                              width: 130,
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                cart[index].image,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cart[index].name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    letterSpacing: 1.2,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Text(
                                                  "Rs. ${cart[index].price}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: Row(
                                                  children: [
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 30,
                                right: 20,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cart.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.white
                                            .withOpacity(0.8), // change color
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 1,
                            color: Theme.of(context).primaryColor,
                          );
                        },
                        itemCount: cart.length),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    
    );
  
  }

  void foodOrder(time){
    String food="";
    double cost=0;
    for (int i = 0; i < cart.length; i++) {
            cost += cart[i].price;
            food = food + cart[i].name + "|";
          }
    order.child(result!.uid).set({
      "Item": food,
      "Cost": cost
    }).then((_){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Happy eating"),
              content: Text("Your order is sent. Please check in " + time + " min"+"\nPlease pay the amount."),
              actions: [
                TextButton(
                  child: Text("Pay"),
                  onPressed: () {
                      pay();
                      Navigator.of(context,rootNavigator:true).pop(context);
                  },
                )
              ],
            );
          }
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
    void dispose() {
      super.dispose();
    razorpay.clear(); // Removes all listeners
  }

  void pay(){
    String phone='',email='', food="";
    double cost=0;
    users.child(result!.uid).once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
          // setState((){
          //   email=values['email'];
          // });
          // setState((){
          //   phone=values['phone'];
          // });
          email=values["email"];
          phone=values["phone"];
          
          // List itemList=[];
          // itemList.add(values);
          print("this is VT"); 
          print(phone);
          
          //print("vinayak___________________________________________________________________");
          print(email);
          var options = {
            'key': 'rzp_test_I61OgCCUr759ee',
            'amount': cost*100, //in the smallest currency sub-unit.
            'name': 'Poshtik App',
            //'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
            'description': food,
            'theme':{'color': '#673ab7'},
            //'timeout': 60, // in seconds
            'prefill': {
              'contact': phone,
              'email': email
            },
            'external': {
              'wallets': 'paytm'
            }
          };
          //print("vinayak------------------------------------------------------------------------------");
          try {
            razorpay.open(options);
          } catch (e) {
            print(e.toString());
          }
          
    });
    
  }

  void handlePaymentSuccess(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(uid:result!.uid))
    );
    
  }

  void handlePaymentError(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(uid:result!.uid))
    );
  }

  void handleExternalWallet(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(uid:result!.uid))
    );
  }

}
