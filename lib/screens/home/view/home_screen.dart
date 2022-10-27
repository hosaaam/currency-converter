import 'package:currency_converter/components/customLoading.dart';
import 'package:currency_converter/components/custom_text.dart';
import 'package:currency_converter/screens/home/controller/home_cubit.dart';
import 'package:currency_converter/screens/home/controller/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => HomeCubit()..createDB()..getItems(context),
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.05, vertical: h * 0.05),
                  child: state is GetDropDownItemLoadingState
                      ? CustomLoading(load: true)
                      : Column(
                          children: [
                            Center(
                              child: CustomText(
                                  text: "Currency converter",
                                  fontSize: 30),
                            ),
                            SizedBox(
                              height: h * 0.1,
                            ),
                            Row(
                              children: [
                                CustomText(text: "Amount : "),
                                SizedBox(width: w * 0.03,),
                                Expanded(
                                  child: TextFormField(
                                    controller: cubit.amountCtrl,
                                    decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(color: Colors.black)

                                      ),),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: h * 0.05,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: "From"),
                                SizedBox(
                                  height: h * 0.03,
                                ),
                                DropdownButtonFormField<String>(
                                  style: const TextStyle(fontSize: 10,color: Colors.black),
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      // borderSide: const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        // borderSide: const BorderSide(color: Colors.green)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      // borderSide: const BorderSide(color: Colors.green),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: "Select currency",
                                    // hintStyle: const TextStyle(
                                    //   color: Colors.green,
                                    //   fontSize: 15,
                                    // ),
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 29,
                                  ),
                                  items: List.generate(
                                      cubit.newCountryId.length,
                                          (index) => DropdownMenuItem(
                                          value: cubit.dropDownItemResponse!["data"][cubit.newCountryId[index]]["id"].toString(),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: w * 0.6,
                                                child: Text(cubit.dropDownItemResponse!["data"][cubit.countryId[index]]["currencyName"].toString(),
                                                style: const TextStyle(fontSize: 15),
                                                ),
                                              ),
                                              Image.network("https://www.countryflagicons.com/FLAT/64/${cubit.imageName[index]}.png",
                                              width: w * 0.1,
                                              )
                                            ],
                                          ))),
                                  onChanged: (val) {
                                    cubit.changeFromDrop(val);
                                  },
                                  value: cubit.dropDownValue,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.1,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: "To"),
                                SizedBox(
                                  height: h * 0.03,
                                ),
                                DropdownButtonFormField<String>(
                                  style: const TextStyle(fontSize: 10,color: Colors.black),
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: "Select currency",

                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 29,
                                  ),
                                  items: List.generate(
                                      cubit.newCountryId.length,
                                          (index) => DropdownMenuItem(
                                          value: cubit.dropDownItemResponse!["data"][cubit.newCountryId[index]]["id"].toString(),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: w * 0.6,
                                                child: Text(cubit.dropDownItemResponse!["data"][cubit.countryId[index]]["currencyName"].toString(),
                                                style: const TextStyle(fontSize: 15),
                                                ),
                                              ),
                                              Image.network("https://www.countryflagicons.com/FLAT/64/${cubit.imageName[index]}.png",
                                              width: w * 0.1,
                                              )
                                            ],
                                          ))),
                                  onChanged: (val) {
                                    cubit.changeToDrop(val);
                                  },
                                  value: cubit.dropDownValue2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.1,
                            ),
                            state is ConverResultLoadingState? CustomLoading(load: false):
                            InkWell(
                              onTap: (){
                                cubit.dropDownValue2==null || cubit.dropDownValue==null?
                                    print('sss'):
                                cubit.convertResult(from: cubit.dropDownValue, to: cubit.dropDownValue2);
                              },
                              child: Container(
                                width: w * 0.7,
                                height: h * 0.07,
                                decoration:  const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.blueGrey),
                                child: const Center(
                                    child: Text("convert" , style: TextStyle(color: Colors.white,fontSize: 25),)),
                              ),
                            ),
                            SizedBox(height: h * 0.03,),
                            cubit.result==false? const SizedBox.shrink():
                            Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: w *0.07, vertical: h *0.02),
                            child: Text(cubit.totalResult.toString()),
                          )
                          ],
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
