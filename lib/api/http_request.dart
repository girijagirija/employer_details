import 'package:employer_details/api/models/employee_list_model.dart';
import 'package:http/http.dart' as http;

class Repository{
  
static Future<List<EmployerModel?>> getEmployerDetails()async{
    String url = 'http://www.mocky.io/v2/5d565297300000680030a986';
   print('url -$url');
    try {
      var response = await http.get(Uri.parse(url));
      print('res -${response.body}');
      return employerModelFromJson(response.body);
    } on Exception catch (e) {
      print('Http Request error -$e');
     return [];
    }
  }
  
}