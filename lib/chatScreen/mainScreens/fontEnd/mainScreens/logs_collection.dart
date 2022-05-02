import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_overlay/loading_overlay.dart';

class logsCollection extends StatefulWidget {
  const logsCollection({Key key}) : super(key: key);

  @override
  _logsCollectionState createState() => _logsCollectionState();
}

class _logsCollectionState extends State<logsCollection> {

  bool _isLoading = false;
  final List<String> _callingConnection = ["Kushan","Yasiru","Walpola"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(34, 48, 60, 1),
        body: LoadingOverlay(
          color: const Color.fromRGBO(0, 0, 0, 0.5),
          progressIndicator: const CircularProgressIndicator(
            backgroundColor: Colors.black87,
          ),
          isLoading: this._isLoading,
          child: Container(
            margin: EdgeInsets.all(12.0),
            width: double.maxFinite,
            height: double.maxFinite,
              child: ListView.builder(
                  itemCount: this._callingConnection.length,
                itemBuilder: (upperContext, index)=> _everyConnectionHistory(index),
              ),
            ),
            ),
          )
    );
  }
  Widget _everyConnectionHistory(int index){
    return  Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundColor: const Color.fromRGBO(34, 48, 60, 1),
            backgroundImage:
            ExactAssetImage('images/medSkin.png'),
            // getProperImageProviderForConnectionsCollection(
            //    _userName),

          ),
          Text(
            this._callingConnection[index],
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
          IconButton(
            icon: Icon(Icons.call,size: 30.0,color: Colors.green,),
            onPressed: (){},
          )
        ],
      ),
    );
  }
  }
