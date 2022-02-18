import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:medskin/chatScreen/mainScreens/backEnd/firebase/OnlineDatabaseManagement/cloud_data_management.dart';
import 'package:medskin/chatScreen/mainScreens/global_Uses/enum_generation.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({Key key}) : super(key: key);

  @override
  _searchScreenState createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  List<Map<String, dynamic>> _availableUsers = [];
  List<Map<String, dynamic>> _sortedAvailableUsers = [];
  List<dynamic> _myConnectionRequestCollection = [];

  bool _isLoading = false;

  final CloudStoreDataManagement _cloudStoreDataManagement =
  CloudStoreDataManagement();

  Future<void> _initialDataFetchAndCheckUp() async {
    if (mounted) {
      setState(() {
        this._isLoading = true;
      });
    }

    final List<Map<String, dynamic>> takeUsers =
    await _cloudStoreDataManagement.getAllUsersListExceptMyAccount(
        currentUserEmail:
        FirebaseAuth.instance.currentUser.email.toString());

    final List<Map<String, dynamic>> takeUsersAfterSorted = [];

    if (mounted) {
      setState(() {
        takeUsers.forEach((element) {
          if (mounted) {
            setState(() {
              takeUsersAfterSorted.add(element);
            });
          }
        });
      });
    }

    final List<dynamic> _connectionRequestList =
    await _cloudStoreDataManagement.currentUserConnectionRequestList(
        email: FirebaseAuth.instance.currentUser.email.toString());

    if (mounted) {
      setState(() {
        this._availableUsers = takeUsers;
        this._sortedAvailableUsers = takeUsersAfterSorted;
        this._myConnectionRequestCollection = _connectionRequestList;
      });
    }

    if (mounted) {
      setState(() {
        this._isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _initialDataFetchAndCheckUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(34, 48, 60, 1),
        body: LoadingOverlay(
          isLoading: this._isLoading,
          color: Colors.black54,
          child: Container(
            margin: EdgeInsets.all(12.0),
            width: double.maxFinite,
            height: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Text(
                    'Available Doctors',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextField(
                    autofocus: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search User Name',
                      hintStyle: TextStyle(color: Colors.white70),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(width: 2.0, color: Colors.lightBlue)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(width: 2.0, color: Colors.lightBlue)),
                    ),
                    onChanged: (writeText) {
                      if (mounted) {
                        setState(() {
                          this._isLoading = true;
                        });
                      }

                      if (mounted) {
                        setState(() {
                          this._sortedAvailableUsers.clear();

                          print('Available Users: ${this._availableUsers}');

                          this._availableUsers.forEach((userNameMap) {
                            if (userNameMap.values.first
                                .toString()
                                .toLowerCase()
                                .startsWith('${writeText.toLowerCase()}'))
                              this._sortedAvailableUsers.add(userNameMap);
                          });
                        });
                      }

                      print(this._sortedAvailableUsers);

                      if (mounted) {
                        setState(() {
                          this._isLoading = false;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  height: MediaQuery.of(context).size.height - 50,
                  width: double.maxFinite,
                  //color: Colors.red,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: this._sortedAvailableUsers.length,
                    itemBuilder: (connectionContext, index) {
                      return connectionShowUp(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget connectionShowUp(int index) {
    return Container(
      height: 80.0,
      width: double.maxFinite,
      //color: Colors.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                this
                    ._sortedAvailableUsers[index]
                    .values
                    .first
                    .toString()
                    .split('[user-name-about-divider]')[0],
                style: TextStyle(color: Colors.orange, fontSize: 20.0),
              ),
              Text(
                this
                    ._sortedAvailableUsers[index]
                    .values
                    .first
                    .toString()
                    .split('[user-name-about-divider]')[1],
                style: TextStyle(color: Colors.lightBlue, fontSize: 16.0),
              ),
            ],
          ),
          TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    side: BorderSide(
                        color: _getRelevantButtonConfig(
                            connectionStateType:
                            ConnectionStateType.ButtonBorderColor,
                            index: index)),
                  )),
              child: _getRelevantButtonConfig(
                  connectionStateType: ConnectionStateType.ButtonNameWidget,
                  index: index),
              onPressed: () async {
                final String buttonName = _getRelevantButtonConfig(
                    connectionStateType: ConnectionStateType.ButtonOnlyName,
                    index: index);

                if (mounted) {
                  setState(() {
                    this._isLoading = true;
                  });
                }

                if (buttonName == ConnectionStateName.Connect.toString()) {
                  if (mounted) {
                    setState(() {
                      this._myConnectionRequestCollection.add({
                        this._sortedAvailableUsers[index].keys.first.toString():
                        OtherConnectionStatus.Request_Pending.toString(),
                      });
                    });
                  }

                  await _cloudStoreDataManagement.changeConnectionStatus(
                      oppositeUserMail: this
                          ._sortedAvailableUsers[index]
                          .keys
                          .first
                          .toString(),
                      currentUserMail:
                      FirebaseAuth.instance.currentUser.email.toString(),
                      connectionUpdatedStatus:
                      OtherConnectionStatus.Invitation_Came.toString(),
                      currentUserUpdatedConnectionRequest:
                      this._myConnectionRequestCollection);
                } else if (buttonName ==
                    ConnectionStateName.Accept.toString()) {
                  if (mounted) {
                    setState(() {
                      this._myConnectionRequestCollection.forEach((element) {
                        if (element.keys.first.toString() ==
                            this
                                ._sortedAvailableUsers[index]
                                .keys
                                .first
                                .toString()) {
                          this._myConnectionRequestCollection[this
                              ._myConnectionRequestCollection
                              .indexOf(element)] = {
                            this
                                ._sortedAvailableUsers[index]
                                .keys
                                .first
                                .toString():
                            OtherConnectionStatus.Invitation_Accepted
                                .toString(),
                          };
                        }
                      });
                    });
                  }

                  await _cloudStoreDataManagement.changeConnectionStatus(
                      storeDataAlsoInConnections: true,
                      oppositeUserMail: this
                          ._sortedAvailableUsers[index]
                          .keys
                          .first
                          .toString(),
                      currentUserMail:
                      FirebaseAuth.instance.currentUser.email.toString(),
                      connectionUpdatedStatus:
                      OtherConnectionStatus.Request_Accepted.toString(),
                      currentUserUpdatedConnectionRequest:
                      this._myConnectionRequestCollection);
                }

                if (mounted) {
                  setState(() {
                    this._isLoading = false;
                  });
                }
              }),
        ],
      ),
    );
  }

  dynamic _getRelevantButtonConfig(
      {ConnectionStateType connectionStateType,int index}) {
    bool _isUserPresent = false;
    String _storeStatus = '';

    this._myConnectionRequestCollection.forEach((element) {
      if (element.keys.first.toString() ==
          this._sortedAvailableUsers[index].keys.first.toString()) {
        _isUserPresent = true;
        _storeStatus = element.values.first.toString();
      }
    });

    if (_isUserPresent) {
      print('User Present in Connection List');

      if (_storeStatus == OtherConnectionStatus.Request_Pending.toString() ||
          _storeStatus == OtherConnectionStatus.Invitation_Came.toString()) {
        if (connectionStateType == ConnectionStateType.ButtonNameWidget)
          return Text(
            _storeStatus == OtherConnectionStatus.Request_Pending.toString()
                ? ConnectionStateName.Pending.toString()
                .split(".")[1]
                .toString()
                : ConnectionStateName.Accept.toString()
                .split(".")[1]
                .toString(),
            style: TextStyle(color: Colors.yellow),
          );
        else if (connectionStateType == ConnectionStateType.ButtonOnlyName)
          return _storeStatus ==
              OtherConnectionStatus.Request_Pending.toString()
              ? ConnectionStateName.Pending.toString()
              : ConnectionStateName.Accept.toString();

        return Colors.yellow;
      } else {
        if (connectionStateType == ConnectionStateType.ButtonNameWidget)
          return Text(
            ConnectionStateName.Connected.toString().split(".")[1].toString(),
            style: TextStyle(color: Colors.green),
          );
        else if (connectionStateType == ConnectionStateType.ButtonOnlyName)
          return ConnectionStateName.Connected.toString();

        return Colors.green;
      }
    } else {
      print('User Not Present in Connection List');

      if (connectionStateType == ConnectionStateType.ButtonNameWidget)
        return Text(
          ConnectionStateName.Connect.toString().split(".")[1].toString(),
          style: TextStyle(color: Colors.lightBlue),
        );
      else if (connectionStateType == ConnectionStateType.ButtonOnlyName)
        return ConnectionStateName.Connect.toString();

      return Colors.lightBlue;
    }
  }
}