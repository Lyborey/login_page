import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFeild extends StatelessWidget{
  final String? label;
  final String? value;
  final TextInputType? inputType;
  final bool? isHaveText;
  final bool? isPassword;
  final Function(String?)? onChange;
  final GestureTapCallback? onView;
  final bool? isView;
  final List<TextInputFormatter>? format;

  const CustomTextFeild({
    Key? key,
    required this.label,
    required this.inputType,
    required this.onChange,
    this.isHaveText = false,
    this.value,
    this.format, this.isPassword=false, this.isView=false, this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isHaveText! ? Colors.transparent : const Color(0xFF2B2F7E),
        borderRadius: BorderRadius.circular(10),
        ),
      child: TextFormField(
        inputFormatters: format,
        initialValue: value,
        onChanged: onChange,
        keyboardType: inputType,
        obscureText: isPassword! ? (isView!) ? false:true : false,        
        obscuringCharacter: '●',        
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderSide: isHaveText!
                  ? const BorderSide(color: Colors.white)
                  : const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          hintText: label,
          label: RichText(
              text: TextSpan(
                  text: label,
                  style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
                  children: const [ TextSpan(text: ' *', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600))
                  ]),
            ),
          hintStyle: const TextStyle(color: Colors.white),          
          suffix: isPassword! ? GestureDetector(
            onTap: onView,
            child: isView! ? SvgPicture.asset('assets/view_pass.svg',height: 20,) : SvgPicture.asset('assets/hide_pass.svg',height: 16,),
          ): Column()
        ),
        scrollPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      ),
    );
  }  
}