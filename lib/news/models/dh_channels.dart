class DHChannels {
  final int channelCount;
  final String nextPageUrl;
  final int pageNumber;
  final List<DHChannel> allChannels;
  DHChannels({
    this.channelCount,
    this.nextPageUrl,
    this.pageNumber,
    this.allChannels,
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
    return channelList;
  }
}

class DHChannel {
  final String channelId;
  final String channelName;
  final String contentUrl;
  final String deepLinkUrl;
  final String channelType;
  DHChannel({
    this.channelId,
    this.channelName,
    this.contentUrl,
    this.deepLinkUrl,
    this.channelType,
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
