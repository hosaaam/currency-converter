import 'package:currency_converter/core/remote/my_dio.dart';
import 'package:currency_converter/screens/home/controller/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';


class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  var database;
  void createDB()async{
    database = await openDatabase(
      "Currency.db",
      version: 1,
      onCreate: (database,version){
        database.execute("Create TABLE currency ( id INTEGER PRIMARY KEY , from TEXT ,to TEXT ,from_flag TEXT ,to_flag TEXT ,value TEXT)").then((value) {
        }).catchError ((onError){
          print("Error while creating table ${onError.toString()}");
        });
      },
      onOpen: (database){

      }
    );
  }

  Map<dynamic,dynamic>? getRequestTypesResponse;
  Map<dynamic, dynamic>? dropDownItemResponse;
  Map<dynamic, dynamic>? countryResponse;

  List currencyName=[];
  /// request currency
  List currencyId=[];
  List imageName=[];
  /// request country
  List countryId=[];
  List newCountryId=[];

  Future<void> getItems(context) async {
    amountCtrl.text = "1";

    emit(GetDropDownItemLoadingState());
    try {
      dropDownItemResponse = await myDio(
        appLanguage: "ar",
        url: "https://free.currconv.com/api/v7/currencies?apiKey=66c2d9bfff9dbcc5e82c",
        methodType: 'get',
        context: context,
      );
      countryResponse = await myDio(
        appLanguage: "ar",
        url: "https://free.currconv.com/api/v7/countries?apiKey=66c2d9bfff9dbcc5e82c",
        methodType: 'get',
        context: context,
      );


      if (dropDownItemResponse!['status'] == false) {
        emit(GetDropDownItemErrorState());
      } else {
        countryResponse!["data"].forEach((key, value) {
          imageName.add(value["id"]);
          countryId.add(value["currencyId"]);
        });
        print(countryId.toString());
        print("---0");
        newCountryId=countryId.toSet().toList();
        print("---0");
        print(newCountryId.toString());
        var ids = [1, 4, 4, 4, 5, 6, 6];
        var distinctIds = ids.toSet().toList();
        print(distinctIds.toString());

        dropDownItemResponse!["data"].forEach((k,v) {
          currencyName.add(v["currencyName"]);
          currencyId.add(k);
        } );
        print(dropDownItemResponse!["data"]);
        emit(GetDropDownItemSuccessState());
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
  String? dropDownValue ;
  String? dropDownValue2 ;
  TextEditingController amountCtrl = TextEditingController();
  void changeFromDrop(String? val) {
    dropDownValue = val;
    emit(ChangeDropState());
  }
  void changeToDrop(String? val) {
    dropDownValue2 = val;
    emit(ChangeSecDropState());
  }
  Map<dynamic,dynamic>? convertResultResponse;
  List? convertResultList = [];
  bool result = false;
  Future<void> convertResult({context , required String? from , required String? to}) async {
    convertResultList = [];
    result=false;
    emit(ConverResultLoadingState());
    try {
      convertResultResponse = await myDio(
        appLanguage: "ar",
        url: "https://free.currconv.com/api/v7/convert?q=${from}_${to}&apiKey=66c2d9bfff9dbcc5e82c&compact",
        methodType: 'get',
        context: context,
      );

      if (convertResultResponse!['status'] == false) {
        emit(GetDropDownItemErrorState());
      } else {
        convertResultResponse!["data"].forEach((key, value) {
          convertResultList!.add(value["val"]);
        });
        print(amountCtrl.text);
        print(convertResultList![0].toString());
        totalResult = double.parse(convertResultList![0].toString()) * double.parse(amountCtrl.text);
        print(totalResult);
        result=true;
        emit(ConvertSuccessState());
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
  double totalResult=0;
}
