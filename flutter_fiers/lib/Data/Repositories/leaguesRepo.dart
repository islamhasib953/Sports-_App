import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_fiers/Data/Models/leaguesmodel.dart';

class LeaguesRepo {
  Future <LeaguesModel?> leagues (int id) async{
    try {
      var response = await http.get(
        Uri.parse(
"https://apiv2.allsportsapi.com/football/?met=Leagues&countryId=$id&APIkey=9819e7462cfeeb44124fd5f716823bdf526bfc2f97353aa89ec3ff0441895eb3"),
      );
      var decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        LeaguesModel myResponse = LeaguesModel.fromJson(decodedResponse);

        return myResponse;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}