import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  final String? text;
  final Color? bgColor;
  final GestureTapCallback? onTap;
  const CustomAppButton({
    Key? key, this.text, this.bgColor,this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: bgColor ?? const Color(0xFF12B8E2),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
      onTap: onTap,      
        child: Container(
          height: 45,
          width: double.maxFinite,
          alignment: Alignment.center,            
          child: Text(text ?? "",style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: Colors.white),),
        ),
      ),
    );
  }
}
