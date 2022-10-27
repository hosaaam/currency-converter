import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class CustomLoading extends StatelessWidget {
  final bool load ;

  const CustomLoading({ required this.load});
  @override
  Widget build(BuildContext context) {
    return load==true? Column(
      children: [
        const SizedBox(height: 150),
        Center(
          child:SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              );
            },
          ),
        )
      ],
    ):Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child:SpinKitFadingCircle(
          itemBuilder: (BuildContext context, int index) {
            return const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}
