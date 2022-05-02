
import 'package:flutter/material.dart';
import 'package:medskin/daily_Tips/Provider.dart';
import 'package:medskin/daily_Tips/bottom_Container.dart';
import 'package:medskin/daily_Tips/dailyTip_model.dart';
import 'package:medskin/lalindu/bottom_Container.dart';
import 'package:medskin/lalindu/doctor_model.dart';
import 'package:provider/provider.dart';

class dailytipListPage extends StatefulWidget {
  @override
  _dailytipListPageState createState() => _dailytipListPageState();
}

class _dailytipListPageState extends State<dailytipListPage> {


  List<dailytipListModel> singledoctorList = [];





  @override
  Widget build(BuildContext context) {
    MydailytipProvider provider = Provider.of<MydailytipProvider>(context);

    provider.getFoodList();
    singledoctorList = provider.throwFoodModleList;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Doctor List",
        style: TextStyle(
          color: Colors.white,
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search Food",
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Color(0xff3a3e3e),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 510,
            child: GridView.count(
                shrinkWrap: false,
                primary: false,
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: singledoctorList
                    .map(
                      (e) => dailytipContainer(
                    onTap: () {
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => DetailPage(
                      //       image: e.image,
                      //       name: e.name,
                      //       age: e.age,
                      //     ),
                      //   ),
                      // );
                    },
                    image: e.image,
                    name: e.name,
                  ),
                )
                    .toList()
            ),
          )
        ],
      ),
    );
  }
}

