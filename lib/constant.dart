import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mmlearning_admin/app_icon.dart';
import 'package:mmlearning_admin/app_image.dart';

final HexColor lightBlueHexColor = HexColor("#37CCEC");
const Color lightBlue = Color(0xFF37CCEC);
final HexColor deeperBlue = HexColor("#326D87");
final HexColor sliver = HexColor("#838996");
const Color darkGreenColor = Color(0xFF004AAD);

final HexColor darkGreen2 = HexColor('004AAD');
final HexColor darkGreen = HexColor('004AAD');
final HexColor brightGreen2 = HexColor("0D6EF0");
final HexColor brightGreen = HexColor('0D6EF0');
final HexColor warmGreen = HexColor('033D8C');
final HexColor primaryColor = HexColor('033D8C');

/* final HexColor darkGreen2 = HexColor('07453B');
final HexColor darkGreen = HexColor('0A564A');
final HexColor brightGreen2 = HexColor("2A685F");
final HexColor brightGreen = HexColor('328478');
final HexColor warmGreen = HexColor('0B5F52'); */
final HexColor darkOrange = HexColor('F79F1C');
final HexColor brightOrange = HexColor('F4A52F');
final HexColor warmOrange = HexColor('FBB752');
final HexColor deepAmber = HexColor("FE8745");
final Color softAmber = HexColor('FE8745').withOpacity(0.3);
final HexColor greenishBlueDeep = HexColor("033D8C");
final HexColor greenishBlue = HexColor('004AAD');
final HexColor customGreyColor = HexColor('7F84A2' /*'C3C6CD'*/);
final HexColor customeBlackColor = HexColor('202125');
final HexColor ghostWhite = HexColor('F8F8FA');
final HexColor darkGhostWhite = HexColor('F7F7F8');
const themeDatabase = "theme";
const searchHistoryDatabase = "searchHistoryDatabase2";
const themeDatabaseKey = "isLightMode";
const userDatabase = "userBox";
const subsectionDatabase = "subsectionBox";
const courseDatabase = "courseBox";
const jwtKey = "userJwtKey";
const jwtBackUpKey = "userJwtBackUpKey";
final List<HexColor> categoryBackground = [
  ///HexColor('219C90'),
  darkGreen,
  HexColor('E1B01D'),
  HexColor('EE9322'),
  HexColor('D83F31'),
];
final border = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor,
    width: 3,
  ),
);
final List<Map<String, HexColor>> cartBackground = [
  {
    "parent": brightGreen2,
    "deep": darkGreen,
  },
  {
    "parent": HexColor('E1B01D'),
    "deep": HexColor('F9C939'),
  },
  {
    "parent": HexColor('EE9322'),
    "deep": HexColor('FDA73C'),
  },
  {
    "parent": HexColor('D83F31'),
    "deep": HexColor('FF6456'),
  }
];

class Constants {
  static const String bugBuckBunnyVideoUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  static const String forBiggerBlazesUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
  static const String fileTestVideoUrl = "testvideo.mp4";
  static const String fileTestVideoEncryptUrl = "testvideo_encrypt.mp4";
  static const String networkTestVideoEncryptUrl =
      "https://github.com/tinusneethling/betterplayer/raw/ClearKeySupport/example/assets/testvideo_encrypt.mp4";
  static const String fileExampleSubtitlesUrl = "example_subtitles.srt";
  static const String hlsTestStreamUrl =
      "https://mtoczko.github.io/hls-test-streams/test-group/playlist.m3u8";
  static const String hlsPlaylistUrl =
      "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8";
  static const Map<String, String> exampleResolutionsUrls = {
    "LOW":
        "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4",
    "MEDIUM":
        "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_640_3MG.mp4",
    "LARGE":
        "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1280_10MG.mp4",
    "EXTRA_LARGE":
        "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1920_18MG.mp4"
  };
  static const String phantomVideoUrl =
      "http://sample.vodobox.com/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8";
  static const String elephantDreamVideoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4";
  static const String forBiggerJoyridesVideoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4";
  static const String verticalVideoUrl =
      "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4";
  static String logo = "logo.png";
  static String placeholderUrl =
      "https://imgix.bustle.com/uploads/image/2020/8/5/23905b9c-6b8c-47fa-bc0f-434de1d7e9bf-avengers-5.jpg";
  static String elephantDreamStreamUrl =
      "http://cdn.theoplayer.com/video/elephants-dream/playlist.m3u8";
  static String tokenEncodedHlsUrl =
      "https://amssamples.streaming.mediaservices.windows.net/830584f8-f0c8-4e41-968b-6538b9380aa5/TearsOfSteelTeaser.ism/manifest(format=m3u8-aapl)";
  static String tokenEncodedHlsToken =
      "Bearer=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1cm46bWljcm9zb2Z0OmF6dXJlOm1lZGlhc2VydmljZXM6Y29udGVudGtleWlkZW50aWZpZXIiOiI5ZGRhMGJjYy01NmZiLTQxNDMtOWQzMi0zYWI5Y2M2ZWE4MGIiLCJpc3MiOiJodHRwOi8vdGVzdGFjcy5jb20vIiwiYXVkIjoidXJuOnRlc3QiLCJleHAiOjE3MTA4MDczODl9.lJXm5hmkp5ArRIAHqVJGefW2bcTzd91iZphoKDwa6w8";
  static String widevineVideoUrl =
      "https://storage.googleapis.com/wvmedia/cenc/h264/tears/tears_sd.mpd";
  static String widevineLicenseUrl =
      "https://proxy.uat.widevine.com/proxy?provider=widevine_test";
  static String fairplayHlsUrl =
      "https://fps.ezdrm.com/demo/hls/BigBuckBunny_320x180.m3u8";
  static String fairplayCertificateUrl =
      "https://github.com/koldo92/betterplayer/raw/fairplay_ezdrm/example/assets/eleisure.cer";
  static String fairplayLicenseUrl = "https://fps.ezdrm.com/api/licenses/";
  static String catImageUrl =
      "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_relaxing_on_patio_other/1800x1200_cat_relaxing_on_patio_other.jpg";
  static String dashStreamUrl =
      "https://bitmovin-a.akamaihd.net/content/sintel/sintel.mpd";
  static String segmentedSubtitlesHlsUrl =
      "https://eng-demo.cablecast.tv/segmented-captions/vod.m3u8";
}

List<Map<String, dynamic>> drawerItems = [
  {
    "name": "Category",
    "icon": AppIcon.category,
  },
  {
    "name": "Slider",
    "icon": AppIcon.slider,
  },
  {
    "name": "Courses",
    "icon": AppIcon.courses,
  },
  /* {
    "name": "Sections",
    "icon": AppIcon.sections,
  }, */
  {
    "name": "Discount",
    "icon": AppIcon.discount,
  },
  {
    "name": "Students",
    "icon": AppIcon.students,
  },
  {
    "name": "Enrollment",
    "icon": AppIcon.enrollment,
  },
  {
    "name": "Ratings",
    "icon": AppIcon.rating,
  },
  {
    "name": "Reviews",
    "icon": AppIcon.review,
  },
];

const emptyUser = "https://cdn-icons-png.flaticon.com/128/3177/3177440.png";
