import 'package:pokpak_thingspeak/enums/feed_fields.dart';
import 'package:pokpak_thingspeak/models.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ParseFeedSeriesList {
  static List<charts.Series<FeedFieldData, DateTime>> parseFeedSeriesList(List<FeedFieldData> feedFieldData, FeedField feedField) {

    List<FeedFieldData> filteredFeed;
    switch (feedField)
    {
      case FeedField.field1:
        filteredFeed = feedFieldData.where((i) => i.value != "").toList();
        break;
      case FeedField.field2:
        filteredFeed = feedFieldData.where((i) => i.value != "").toList();
        break;
      case FeedField.field3:
        filteredFeed = feedFieldData.where((i) => i.value != "").toList();
        break;
      case FeedField.field4:
        filteredFeed = feedFieldData.where((i) => i.value != "").toList();
        break;
      case FeedField.field5:
        filteredFeed = feedFieldData.where((i) => i.value != "").toList();
        break;
      case FeedField.field6:
        filteredFeed = feedFieldData.where((i) => i.value != "").toList();
        break;
      case FeedField.field7:
        filteredFeed = feedFieldData.where((i) => i.value != "").toList();
        break;
      case FeedField.field8:
        filteredFeed = feedFieldData.where((i) => i.value != "").toList();
        break;
    }

    var seriesList = [
      charts.Series<FeedFieldData, DateTime>(
        id: 'Clicks',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (FeedFieldData feedFieldData, _) => feedFieldData.createdAt,
        measureFn: (FeedFieldData feedFieldData, _) => cleanFieldValue(feedFieldData.value),
        data: filteredFeed,
      ),
      charts.Series<FeedFieldData, DateTime>(
        id: 'Clicks',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (FeedFieldData feedFieldData, _) => feedFieldData.createdAt,
        measureFn: (FeedFieldData feedFieldData, _) => cleanFieldValue(feedFieldData.value),
        data: filteredFeed,
      )..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];

    return seriesList;
  }

  static int cleanFieldValue(String stringValue) {
    return int.tryParse(stringValue.replaceAll("/\n", "").replaceAll("/\r", "").replaceAll("�", ""));
  }
}
