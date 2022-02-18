import 'dart:io';

import 'package:medskin/chatScreen/mainScreens/global_Uses/enum_generation.dart';
import 'package:sqflite/sqflite.dart';

class localDatabase {

  final String _importantTableData = "Important Table Data";
  final String _callUserName = "User Name";
  final String _callUserMail = "User Mail";
  final String _callUserToken = "User Token";
  final String _callProfileImagePath = "Profile Image Path";
  final String _callProfileImageURL = "Profile_Image_URL";
  final String _callAbout = "About";
  final String _callWalpeper = "Chat Wallpaper";
  final String _callNotification = "Notification_Status";
  final String _callMobNumber = "User_Mobile_Number";
  final String _callAccountCreationData = "Account_Creation_Data";
  final String _callAccountCreationTime = "Account_Creation_time";

  /// For Status Management
  /// final String _userStatusData = "__User_Status_Data__";
  // All Columns
  final String _colActivity = "Activity_path";
  final String _colActivityTime = "Activity_time";
  final String _colActivityMediaType = "Activity_media";
  final String _colActivityExtraText = "Activity_Extra_Text";
  final String _colActivityBGInformation = "Activity_BG_Information";



  static localDatabase _localstoreHelper;
  static Database _database;


  localDatabase._createInstance();


  factory localDatabase() {
    if (_localstoreHelper == null) {
      _localstoreHelper = localDatabase._createInstance();
      return _localstoreHelper;
    }
  }

    Future<Database> get database async{
    if(!_database.isOpen)
      _database = await initializeDatabase();
    return _database;
    }

  Future<Database> initializeDatabase() async {
      /// Get the directory path to store the database
      final String desirePath = await getDatabasesPath();

      final Directory newDirectory =
      await Directory(desirePath + '/.Databases/').create();
      final String path = newDirectory.path + '/generation_local_storage.db';

      // create the database
      final Database getDatabase = await openDatabase(path, version: 1);
      return getDatabase;
  }

  Future<void> createTableToStoreImportantData() async{
    try{
      final Database db = await this.database;
      await db.execute("CREATE TABLE ${this._importantTableData}($_callUserName TEXT PRIMARY KEY, $_callUserMail TEXT, $_callUserToken TEXT, $_callProfileImagePath TEXT, $_callProfileImageURL TEXT, $_callAbout TEXT, $_callWalpeper TEXT, $_callNotification TEXT, $_callMobNumber TEXT, $_callAccountCreationData TEXT, $_callAccountCreationTime TEXT)");
    }
    catch(e){
      print("Erro in Create Import Table: ${e.toString()}");
    }
  }

  Future<bool> insertOrUpdateDataForThisAccount({
    String userName,
    String userMail,
    String userToken,
    String userAbout,
    String userAccCreationDate,
    String userAccCreationTime,
    String chatWallpaper = '',
    String profileImagePath = '',
    String profileImageUrl = '',
    String purpose = 'insert',
  }) async {
    try {
      final Database db = await this.database;

      if (purpose != 'insert') {
        final int updateResult = await db.rawUpdate(
            "UPDATE $_importantTableData SET $_callUserToken = '$userToken', $_callAbout = '$userAbout', $_callUserMail = '$userMail', $_callAccountCreationData = '$userAccCreationDate', $_callAccountCreationTime = '$userAccCreationTime' WHERE $_callUserName = '$userName'");

        print('Update Result is: $updateResult');
      } else {
        final Map<String, dynamic> _accountData = Map<String, dynamic>();

        _accountData[_callUserName] = userName;
        _accountData[_callUserMail] = userMail;
        _accountData[_callUserToken] = userToken;
        _accountData[_callProfileImagePath] = profileImagePath;
        _accountData[_callProfileImageURL] = profileImageUrl;
        _accountData[_callAbout] = userAbout;
        _accountData[_callWalpeper] = chatWallpaper;
        _accountData[_callMobNumber] = '';
        _accountData[_callNotification] = "1";
        _accountData[_callAccountCreationData] = userAccCreationDate;
        _accountData[_callAccountCreationTime] = userAccCreationTime;

        await db.insert(this._importantTableData, _accountData);
      }
      return true;
    } catch (e) {
      print('Error in Insert or Update Important Data Table');
      return false;
    }
  }
  Future<bool> createTableForUserActivity({String tableName}) async {
    final Database db = await this.database;
    try {
      await db.execute(
          "CREATE TABLE ${tableName}_status($_colActivity, $_colActivityTime TEXT PRIMARY KEY, $_colActivityMediaType TEXT, $_colActivityExtraText TEXT, $_colActivityBGInformation TEXT)");

      print('User Activity table creatred');

      return true;
    } catch (e) {
      print("Error in Create Table For Status: ${e.toString()}");
      return false;
    }
  }

  /// Insert ActivityData to Activity Table
  Future<bool> insertDataInUserActivityTable(
      {String tableName, String statusLinkOrString,StatusMediaTypes mediaTypes, String activityTime, String extraText = '', String bgInformation = ''}) async {
    try {
      final Database db = await this.database;
      final Map<String, dynamic> _activityStoreMap = Map<String, dynamic>();

      _activityStoreMap[_colActivity] = statusLinkOrString;
      _activityStoreMap[_colActivityTime] = activityTime;
      _activityStoreMap[_colActivityMediaType] = mediaTypes.toString();
      _activityStoreMap[_colActivityExtraText] = extraText;
      _activityStoreMap[_colActivityBGInformation] = bgInformation;

      /// Result Insert to DB
      final int result =
      await db.insert('${tableName}_status', _activityStoreMap);

      return result > 0 ? true : false;
    } catch (e) {
      print('Error: Activity Table Data insertion Error: ${e.toString()}');
      return false;
    }
  }

  Future<String> getUserNameForCurrentUser(String userEmail) async {
    try {
      final Database db = await this.database;

      List<Map<String, Object>> result = await db.rawQuery(
          "SELECT $_callUserName FROM ${this._importantTableData} WHERE $_callUserMail='$userEmail'");

      return result[0].values.first.toString();
    } catch (e) {
      return null;
    }
  }
}