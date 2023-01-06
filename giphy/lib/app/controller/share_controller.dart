import 'package:share_plus/share_plus.dart';

//EXPLANATION como usa shared 
Future<void> share(Map gif) async{
  String? url =  gif.values.toList()[0];
  // como é assyncona usa o await
  await Share.share(
    "$url",// link da url
    subject: "olhe o link",

  );
}
