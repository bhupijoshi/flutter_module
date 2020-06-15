/*
 * @author Bhoopi
 * @email bhoopendra.joshi@snapdeal.com
 * @create date 2020-06-01 22:18:56
 * @modify date 2020-06-01 22:18:56
 * @desc [description]
 */
class DHChannels {
  final int channelCount;
  final String nextPageUrl;
  final int pageNumber;
  int initialSelected;
  List<DHChannel> allChannels;
  DHChannels({
    this.channelCount,
    this.nextPageUrl,
    this.pageNumber,
    this.allChannels,
    this.initialSelected = 0,
  });

  factory DHChannels.fromJson(Map<String, Object> channelJson){
    return DHChannels(
      channelCount: channelJson['count'],
      nextPageUrl: channelJson['nextPageUrl'],
      pageNumber: channelJson['pageNumber'],
      allChannels: parseChannelsList(channelJson),

    );
  }

 static List<DHChannel> parseChannelsList(channelsList){
    var list = channelsList['rows'] as List;
    List<DHChannel> channelList = list.map((channelJson){
      return DHChannel.fromJson(channelJson);
    }).toList();
    // return channelList.sublist(0,3);
    return channelList;
  }
}

class DHChannel {
  final String channelId;
  String channelName;
  final String contentUrl;
  final String deepLinkUrl;
  final String channelType;
  bool selectedState;
  DHChannel({
    this.channelId,
    this.channelName,
    this.contentUrl,
    this.deepLinkUrl,
    this.channelType,
    this.selectedState=false,
  });

  factory DHChannel.fromJson(Map<String, Object> json) {
    return DHChannel(
      channelId: json['id'],
      channelName: json['name'],
      contentUrl: json['contentUrl'],
      deepLinkUrl: json['deepLinkUrl'],
      channelType: json['type'],
    );
  }
}
