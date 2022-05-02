

import 'package:medskin/new/Global_Uses/enum_generation.dart';

class PreviousMessageStructure {
  String actualMessage;
   String messageDate;
   String messageTime;
   bool messageHolder;
   ChatMessageTypes messageType;

  PreviousMessageStructure({String actualMessage,
    String messageType,
    String messageDate,
     String messageTime,
    String messageHolder}) {
    this.actualMessage = actualMessage;
    this.messageType = _getChatMessageTypePerfectly(messageType);
    this.messageTime = messageTime;
    this.messageDate = messageDate;
    this.messageHolder = _getChatMessageHolderType(messageHolder);
  }

  factory PreviousMessageStructure.toJson(Map<String, dynamic> map) {
    return PreviousMessageStructure(
        actualMessage: map["Message"],
        messageType: map["Message_Type"],
        messageDate: map["Message_Date"],
        messageTime: map["Message_Time"],
        messageHolder: map["Message_Holder"]);
  }

  ChatMessageTypes _getChatMessageTypePerfectly(String messageType) {
    if (messageType == ChatMessageTypes.Text.toString())
      return ChatMessageTypes.Text;
    else if (messageType == ChatMessageTypes.Image.toString())
      return ChatMessageTypes.Image;
    else if (messageType == ChatMessageTypes.Video.toString())
      return ChatMessageTypes.Video;
    else if (messageType == ChatMessageTypes.Audio.toString()) {
      return ChatMessageTypes.Audio;
    } else if (messageType == ChatMessageTypes.Document.toString()) {
      return ChatMessageTypes.Document;
    } else if (messageType == ChatMessageTypes.Location.toString()) {
      return ChatMessageTypes.Location;
    } else {
      return ChatMessageTypes.None;
    }
  }

  bool _getChatMessageHolderType(String messageHolderTypeString) {
    return messageHolderTypeString == MessageHolderType.Me.toString()?false:true;
  }
}
