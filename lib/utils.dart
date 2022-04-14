import 'package:url_launcher/url_launcher.dart';

class Utils{

  static String employerListBox = 'employer_box';

static launchURL(String url)async{
  if (!await launch(url)) throw 'Could not launch $url';
}

}