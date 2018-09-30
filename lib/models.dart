class Channel {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final int lastEntryId;
  final int ranking;
  final List<Tag> tags;
  final List<ApiKey> apiKeys;

  Channel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.lastEntryId,
    this.ranking,
    this.tags,
    this.apiKeys
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      lastEntryId: json['last_entry_id'],
      ranking: json['ranking'],
      tags: (json['tags'] as List).map((i) => Tag.fromJson(i)).toList(),
      apiKeys: (json['api_keys'] as List).map((i) => ApiKey.fromJson(i)).toList(),
    );
  }
}

class ChannelList {
  final List<Channel> channels;

  ChannelList({
    this.channels,
  });

  factory ChannelList.fromJson(List<dynamic> parsedJson) {
    return ChannelList(
      channels: parsedJson.map((i)=>Channel.fromJson(i)).toList(),
    );
  }
}

class Tag {
  final int id;
  final String name;

  Tag({this.id, this.name});

  factory Tag.fromJson(Map<String, dynamic> parsedJson) {
    return Tag(
        id: parsedJson['id'],
        name: parsedJson['name'],
    );
  }
}

class ApiKey {
  final String apiKey;
  final bool writeFlag;

  ApiKey({this.apiKey, this.writeFlag});

  factory ApiKey.fromJson(Map<String, dynamic> parsedJson) {
    return ApiKey(
      apiKey: parsedJson['api_key'],
      writeFlag: parsedJson['write_flag'],
    );
  }
}

class FeedChannel {
  final int id;
  final String name;
  final String latitude;
  final String longitude;
  final String field1;
  final String field2;
  final String field3;
  final String field4;
  final String field5;
  final String field6;
  final String field7;
  final String field8;
  final DateTime createdAt;
  final DateTime updatedAt;

  FeedChannel({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.field1,
    this.field2,
    this.field3,
    this.field4,
    this.field5,
    this.field6,
    this.field7,
    this.field8,
    this.createdAt,
    this.updatedAt,
  });

  factory FeedChannel.fromJson(Map<String, dynamic> parsedJson) {
    return FeedChannel(
      id: parsedJson['id'],
      name: parsedJson['name'],
      field1: parsedJson['field1'],
      field2: parsedJson['field2'],
      field3: parsedJson['field3'],
      field4: parsedJson['field4'],
      field5: parsedJson['field5'],
      field6: parsedJson['field6'],
      field7: parsedJson['field7'],
      field8: parsedJson['field8'],
      createdAt: DateTime.parse(parsedJson['created_at']),
      updatedAt: DateTime.parse(parsedJson['updated_at']),
    );
  }
}

class Feed {
  final DateTime createdAt;
  final int entryId;
  final String field1;
  final String field2;
  final String field3;
  final String field4;
  final String field5;
  final String field6;
  final String field7;
  final String field8;

  Feed({
    this.createdAt,
    this.entryId,
    this.field1,
    this.field2,
    this.field3,
    this.field4,
    this.field5,
    this.field6,
    this.field7,
    this.field8
  });

  factory Feed.fromJson(Map<String, dynamic> parsedJson) {
    return Feed(
      createdAt: DateTime.parse(parsedJson['created_at']),
      entryId: parsedJson['entry_id'],
      field1: parsedJson['field1'] ?? "",
      field2: parsedJson['field2'] ?? "",
      field3: parsedJson['field3'] ?? "",
      field4: parsedJson['field4'] ?? "",
      field5: parsedJson['field5'] ?? "",
      field6: parsedJson['field6'] ?? "",
      field7: parsedJson['field7'] ?? "",
      field8: parsedJson['field8'] ?? "",
    );
  }
}