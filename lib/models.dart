class Channel {
  final int id;
  final String name;
  final String description;
//  @SerializedName("created_at")
  final DateTime createdAt;
//  @SerializedName("last_entry_id")
  final int lastEntryId;
  final List<Tag> tags;

  Channel({this.id, this.name, this.description, this.createdAt, this.lastEntryId, this.tags});
}

class Tag {
  final int id;
  final String name;

  Tag({this.id, this.name});
}

class Feed {
  final DateTime createdAt;
  final int entryId;
  final String field1;
  final String field2;
  final String field4;
  final String field5;
  final String field6;
  final String field7;
  final String field8;

  Feed({this.createdAt, this.entryId, this.field1, this.field2, this.field4, this.field5, this.field6, this.field7, this.field8});
}