import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vt/data/data.dart';
import 'package:vt/screens/Finalscreen.dart';

import 'Foodscreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double cost = 0.00;
    String time = "0";

    for (int i = 0; i < cart.length; i++) {
      cost += cart[i].price;
    }
    if (cart.length > 0) {
      time = "10";
    }
    if (cart.length > 5) {
      time = "20";
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "My Cart",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 1.2),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "${cart.length} Items",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                letterSpacing: 1.2),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Container(
                  child: Positioned(
                    top: 60,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ListView.separated(
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
                                        padding: const EdgeInsets.all(8.0),
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
                                                padding: const EdgeInsets.all(8.0),
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
                                                    Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        border: Border.all(
                                                          width: 2,
                                                          color: Colors.white.withOpacity(
                                                              0.8),  // change color
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons.remove,
                                                        size: 15,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(2.0),
                                                      child: Text(" 1 "),
                                                    ),
                                                    Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        border: Border.all(
                                                          width: 2,
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.8), // change color
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 15,
                                                      ),
                                                    ),
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
                                      cart.removeLast();
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
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
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
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor.withOpacity(0.9),
                  ),
                  height: 140,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Estimated time for food: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                  letterSpacing: 1.2),
                            ),
                            Text(
                              "$time minutes",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                  letterSpacing: 1.2),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total cost:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                  letterSpacing: 1.2),
                            ),
                            Text(
                              'Rs. ${cost.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                letterSpacing: 1.2,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange.withOpacity(1)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Finalscreen(cost: cost),
                                ),
                              );
                            },
                            child: Text(
                              "Checkout",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: Colors.black,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    
    );
  
  }
}
