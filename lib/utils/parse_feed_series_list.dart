import 'package:pokpak_thingspeak/enums/feed_fields.dart';
import 'package:pokpak_thingspeak/models.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ParseFeedSeriesList {
  static List<charts.Series<Feed, DateTime>> parseFeedSeriesList(List<Feed> feeds, FeedField feedField) {

    List<Feed> filteredFeed;
    switch (feedField)
    {
      case FeedField.field1:
        filteredFeed = feeds.where((i) => i.field1 != "").toList();
        break;
      case FeedField.field2:
        filteredFeed = feeds.where((i) => i.field2 != "").toList();
        break;
      case FeedField.field3:
        filteredFeed = feeds.where((i) => i.field3 != "").toList();
        break;
      case FeedField.field4:
        filteredFeed = feeds.where((i) => i.field4 != "").toList();
        break;
      case FeedField.field5:
        filteredFeed = feeds.where((i) => i.field5 != "").toList();
        break;
      case FeedField.field6:
        filteredFeed = feeds.where((i) => i.field6 != "").toList();
        break;
      case FeedField.field7:
        filteredFeed = feeds.where((i) => i.field7 != "").toList();
        break;
      case FeedField.field8:
        filteredFeed = feeds.where((i) => i.field8 != "").toList();
        break;
    }

    var seriesList = [
      charts.Series<Feed, DateTime>(
        id: 'Clicks',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Feed feed, _) => feed.createdAt,
        measureFn: (Feed feed, _) => cleanFieldValue(feed, feedField),
        data: filteredFeed,
      ),
      charts.Series<Feed, DateTime>(
        id: 'Clicks',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Feed feed, _) => feed.createdAt,
        measureFn: (Feed feed, _) => cleanFieldValue(feed, feedField),
        data: filteredFeed,
      )..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];

    return seriesList;
  }

  static int cleanFieldValue(Feed feed, FeedField feedField) {
    String field;
    switch (feedField)
    {
      case FeedField.field1:
        field = feed.field1;
        break;
      case FeedField.field2:
        field = feed.field2;
        break;
      case FeedField.field3:
        field = feed.field3;
        break;
      case FeedField.field4:
        field = feed.field4;
        break;
      case FeedField.field5:
        field = feed.field5;
        break;
      case FeedField.field6:
        field = feed.field6;
        break;
      case FeedField.field7:
        field = feed.field7;
        break;
      case FeedField.field8:
        field = feed.field8;
        break;
    }
    return int.tryParse(field.replaceAll("/\n", "").replaceAll("/\r", "").replaceAll("�", ""));
  }
}
