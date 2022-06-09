import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:users_app/assistants/assistant_methods.dart';
import 'package:users_app/global/constants.dart';
import 'package:users_app/global/global.dart';

class SelectNearestActiveDriversScreen extends StatefulWidget {
  DatabaseReference? referenceRideRequest;

  SelectNearestActiveDriversScreen({this.referenceRideRequest});

  @override
  _SelectNearestActiveDriversScreenState createState() =>
      _SelectNearestActiveDriversScreenState();
}

class _SelectNearestActiveDriversScreenState
    extends State<SelectNearestActiveDriversScreen> {
  String fareAmount = "";

  getFareAmountAccordingToVehicleType(int index) {
    if (tripDirectionDetailsInfo != null) {
      if (dList[index]["car_details"]["type"].toString() ==
          "Basic Life Support") {
        fareAmount =
            (AssistantMethods.calculateFareAmountFromOriginToDestination(
                        tripDirectionDetailsInfo!) /
                    2)
                .toStringAsFixed(1);
      }
      if (dList[index]["car_details"]["type"].toString() ==
          "Advanced Life Support") //means executive type of car - more comfortable pro level
      {
        fareAmount =
            (AssistantMethods.calculateFareAmountFromOriginToDestination(
                        tripDirectionDetailsInfo!) *
                    2)
                .toStringAsFixed(1);
      }
      if (dList[index]["car_details"]["type"].toString() ==
          "CCA") // non - executive car - comfortable
      {
        fareAmount =
            (AssistantMethods.calculateFareAmountFromOriginToDestination(
                        tripDirectionDetailsInfo!) *
                    3)
                .toString();
      }
      if (dList[index]["car_details"]["type"].toString() ==
          "Air Ambulance") // non - executive car - comfortable
      {
        fareAmount =
            (AssistantMethods.calculateFareAmountFromOriginToDestination(
                        tripDirectionDetailsInfo!) *
                    6)
                .toString();
      }
    }
    return fareAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kHeadingColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text(
            "Nearest Online Drivers",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              //delete/remove the ride request from database
              widget.referenceRideRequest!.remove();
              Fluttertoast.showToast(
                  msg: 'You have cancelled the ride request');
              SystemNavigator.pop();
            },
          ),
        ),
        // body: ListView.builder(
        //   itemCount: dList.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return Card(
        //       color: Colors.grey,
        //       elevation: 3,
        //       shadowColor: Colors.green,
        //       margin: const EdgeInsets.all(8),
        //       child: ListTile(
        //         leading: Padding(
        //           padding: const EdgeInsets.only(top: 2.0),
        //           child: Image.asset(
        //             "images/" +
        //                 dList[index]["car_details"]["type"].toString() +
        //                 ".png",
        //             width: 70,
        //           ),
        //         ),
        //         title: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Text(
        //               dList[index]["name"],
        //               style: const TextStyle(
        //                 fontSize: 14,
        //                 color: Colors.black54,
        //               ),
        //             ),
        //             Text(
        //               dList[index]["car_details"]["car_model"],
        //               style: const TextStyle(
        //                 fontSize: 12,
        //                 color: Colors.white54,
        //               ),
        //             ),
        //             SmoothStarRating(
        //               rating: 3.5,
        //               color: Colors.black,
        //               borderColor: Colors.black,
        //               allowHalfRating: true,
        //               starCount: 5,
        //               size: 15,
        //             ),
        //           ],
        //         ),
        //         trailing: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(
        //               "Rs. " + getFareAmountAccordingToVehicleType(index),
        //               style: const TextStyle(
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             const SizedBox(
        //               height: 2,
        //             ),
        //             Text(
        //               tripDirectionDetailsInfo != null
        //                   ? tripDirectionDetailsInfo!.duration_text!
        //                   : "",
        //               style: const TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.black54,
        //                   fontSize: 12),
        //             ),
        //             const SizedBox(
        //               height: 2,
        //             ),
        //             Text(
        //               tripDirectionDetailsInfo != null
        //                   ? tripDirectionDetailsInfo!.distance_text!
        //                   : "",
        //               style: const TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.black54,
        //                   fontSize: 12),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
        body: Column(
          children: <Widget>[
            Container(
              color: kBackgroundColor,
              height: 70,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('images/Basic Life Support.png'),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          'Basic Life Support Ambulance',
                          style: TextStyle(fontSize: 11),
                        ),
                        const Text(
                          'Driver : Mayank',
                          style: TextStyle(fontSize: 11),
                        ),
                        const Text(
                          'Color : Blue',
                          style: TextStyle(fontSize: 11),
                        ),
                        SmoothStarRating(
                            allowHalfRating: true,
                            filledIconData: Icons.star,
                            rating: 4,
                            size: 15,
                            starCount: 5,
                            color: kSecondaryColor,
                            borderColor: kTextColor,
                            spacing: 0.0)
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    margin: const EdgeInsets.all(6),
                    color: kSecondaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          '2 Mins Away',
                          style: TextStyle(color: kBackgroundColor),
                        ),
                        Text(
                          'Rs. 109.5',
                          style: TextStyle(color: kBackgroundColor),
                        ),
                        Text(
                          'Tap to Book',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: kBackgroundColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: kBackgroundColor,
              height: 70,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('images/Advanced Life Support.png'),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          'Advanced Life Support Ambulance',
                          style: TextStyle(fontSize: 11),
                        ),
                        const Text(
                          'Driver : Saroj',
                          style: TextStyle(fontSize: 11),
                        ),
                        const Text(
                          'Color : Red',
                          style: TextStyle(fontSize: 11),
                        ),
                        SmoothStarRating(
                            allowHalfRating: true,
                            filledIconData: Icons.star,
                            rating: 4,
                            size: 15,
                            starCount: 5,
                            color: kSecondaryColor,
                            borderColor: kTextColor,
                            spacing: 0.0)
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    margin: const EdgeInsets.all(6),
                    color: kSecondaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          '9 Mins Away',
                          style: TextStyle(color: kBackgroundColor),
                        ),
                        Text(
                          'Rs. 147.5',
                          style: TextStyle(color: kBackgroundColor),
                        ),
                        Text(
                          'Tap to Book',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: kBackgroundColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: kBackgroundColor,
              height: 70,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('images/Basic Life Support.png'),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          'Basic Life Support Ambulance',
                          style: TextStyle(fontSize: 11),
                        ),
                        const Text(
                          'Driver : Aman',
                          style: TextStyle(fontSize: 11),
                        ),
                        const Text(
                          'Color : Red',
                          style: TextStyle(fontSize: 11),
                        ),
                        SmoothStarRating(
                            allowHalfRating: true,
                            filledIconData: Icons.star,
                            rating: 4,
                            size: 15,
                            starCount: 5,
                            color: kSecondaryColor,
                            borderColor: kTextColor,
                            spacing: 0.0)
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    margin: const EdgeInsets.all(6),
                    color: kSecondaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          '12 Mins Away',
                          style: TextStyle(color: kBackgroundColor),
                        ),
                        Text(
                          'Rs. 127.55',
                          style: TextStyle(color: kBackgroundColor),
                        ),
                        Text(
                          'Tap to Book',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: kBackgroundColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: kBackgroundColor,
              height: 70,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('images/Advanced Life Support.png'),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          'Advanced Life Support Ambulance',
                          style: TextStyle(fontSize: 11),
                        ),
                        const Text(
                          'Driver : Shubham',
                          style: TextStyle(fontSize: 11),
                        ),
                        const Text(
                          'Color : Blue',
                          style: TextStyle(fontSize: 11),
                        ),
                        SmoothStarRating(
                            allowHalfRating: true,
                            filledIconData: Icons.star,
                            rating: 0,
                            size: 15,
                            starCount: 5,
                            color: kSecondaryColor,
                            borderColor: kTextColor,
                            spacing: 0.0)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Container(
                        height: 100,
                        width: 100,
                        color: kPrimaryColor,
                      );
                      Fluttertoast.showToast(
                          msg: "Your Ambulance has been booked");
                      print('Ride Booked');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.all(6),
                      color: kSecondaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            '13 Mins Away',
                            style: TextStyle(color: kBackgroundColor),
                          ),
                          Text(
                            'Rs. 158.9',
                            style: TextStyle(color: kBackgroundColor),
                          ),
                          Text(
                            'Tap to Book',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: kBackgroundColor),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ));
  }
}
