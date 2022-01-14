import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medskin/models/skincaretip_model.dart';
import 'package:medskin/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

class userHome extends StatefulWidget {
  const userHome({Key? key}) : super(key: key);

  @override
  _userHomeState createState() => _userHomeState();
}

class _userHomeState extends State<userHome> {

  List<SkinCareTipModel> tipList  =[];

  Widget skincaretipsContainer({required String image,required String topic,required String description}){
    return Column(
      children: [
        Container(
          height: 270.0,
          width: 400.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(image),
            ),
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),SizedBox(height: 10.0,),
        Text(topic, style: TextStyle(color: Colors.black,fontSize: 20.0),),
        Text(description, style: TextStyle(color: Colors.black,fontSize: 20.0),)
      ],
    );
  }

  /****************Drawer********************/
  Widget drawerItemList(@required String name,@required IconData icon){
    return ListTile(
      leading: Icon(icon,color: Colors.white,),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.blueGrey,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/drawer.jpg'),
                    ),
                  ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('images/wala.jpg'),
                    ),
                    accountName: Text(
                      "Kushan Yasiru",
                    ),
                    accountEmail: Text(
                      'kushanyasiruwalpola@gmail.com',
                    )
                ),
                drawerItemList('User Profile', Icons.person),
                drawerItemList('Scan Disease', Icons.scanner_outlined),
                drawerItemList('History', Icons.history),
                drawerItemList('Chat with Doctor', Icons.question_answer),
                drawerItemList('Find Location', Icons.location_city),
                Divider(
                  thickness: 3.0,
                  color: Colors.white,
                ),

                drawerItemList('About US', Icons.shop),
                drawerItemList('Log Out', Icons.exit_to_app),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Icon(Icons.sort),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                   backgroundImage: AssetImage('images/wallpaper.jpg'),
                ),
                SizedBox(width: 5.0,),
                InkWell(
                  onTap: () {

                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 15.0
                    ),
                  ),
                ),
              ],
            ),
            
          )
        ],
      ),
    body: Container(
    height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
    image: DecorationImage(
    fit: BoxFit.cover,
    image: AssetImage('images/wallpaper.jpg'),
    ),
    ),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search ",
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search,color: Colors.grey,),
              filled: true,
              fillColor: Colors.white60,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0)
              )
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [

                skincaretipsContainer(image: 'images/wallpaper.jpg', topic: 'Kushan',description: "walaa"),
                SizedBox(width: 15.0,),
                skincaretipsContainer(image: 'images/wala.jpg', topic: 'Yasiru',description: "walaa"),
              ],
            ),
          ),
          Container(
            height: 290.0,
            width: 400.0,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15.0),
            ),
          )
        ],
      ),
      ),
    );
  }
}
