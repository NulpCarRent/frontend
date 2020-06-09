import 'dart:async';
import 'package:frontend/api/car.dart';
import 'package:frontend/api/request.dart';
import 'dart:convert';
import '../config/api_config.dart';
import 'package:http/http.dart' as http;

class Api{
  Data carsFromJson(String str) =>
      Data.fromJson(json.decode(str));

  RequestData requestsFromJson(String str) =>
      RequestData.fromJson(json.decode(str));

  String transportToJson(Car data) => json.encode(data.toJson());
  String requestToJson(Request data) => json.encode(data.toJson());

  Future<Data> getTransports() async {
    final response = await http.get(car_url);
    print(car_url);
    return carsFromJson(response.body);
  }

    Future<RequestData> getRequests() async {
    final response = await http.get(req_url);
    return requestsFromJson(response.body);
  }
  
  Future<int> postTransport(Car worker) async {
    final json = worker.toJson();
    final response = await http.post(api_url, headers: {'Content-type' : 'application/json', },  body: jsonEncode(json));
    print(response.toString());
    return response.statusCode;
  }

  Future<int> postRequest(Request req) async {
    final json = req.toJson();
    final response = await http.post(req_url, headers: {'Content-type' : 'application/json', },  body: jsonEncode(json));
    print(response.toString());
    return response.statusCode;
  }


}

class Data {
  List<Car> cars;

  Data({
    this.cars,
  });

  factory Data.fromJson(List<dynamic> json) => Data(
        cars:
            List<Car>.from(json.map((x) => Car.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "autos": List<dynamic>.from(cars.map((x) => x.toJson())),
      };
}

class RequestData {
  List<Request> requests;

  RequestData({
    this.requests,
  });

  factory RequestData.fromJson(List<dynamic> json) => RequestData(
        requests:
            List<Request>.from(json.map((x) => Request.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "requests": List<dynamic>.from(requests.map((x) => x.toJson())),
      };
}