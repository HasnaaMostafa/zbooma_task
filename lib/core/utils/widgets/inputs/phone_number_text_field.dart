import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:zbooma_task/core/function/extract_phone_number.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/theme/colors.dart';

class PhoneNumberTextField extends StatefulWidget {
  const PhoneNumberTextField({
    super.key,
    required this.phoneController,
    this.isData,
    this.text,
    this.onCountryChanged,
    this.phone,
  });

  final TextEditingController phoneController;
  final bool? isData;
  final String? text;
  final void Function(String?)? onCountryChanged;
  final String? phone;

  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  String? countryCode;

  @override
  void initState() {
    super.initState();
    _setInitialCountryCode();
  }

  void _setInitialCountryCode() {
    final String phoneNumber = widget.phone ?? "";
    if (phoneNumber.isNotEmpty) {
      if (phoneNumber.startsWith('20')) {
        countryCode = 'EG';
      } else if (phoneNumber.startsWith('966')) {
        countryCode = 'SA';
      } else {
        countryCode = getCountryCodeFromPhoneNumber(phoneNumber);
      }
    } else {
      countryCode = 'EG';
    }
    widget.onCountryChanged?.call("20");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: IntlPhoneField(
                validator: (PhoneNumber? value) {
                  if (value!.number.isEmpty) {
                    return "Field Required";
                  }
                  return null;
                },
                enabled: widget.isData == true ? false : true,
                style: AppStyles.regular14Grey7F.copyWith(
                  color: Color(0xffBABABA),
                ),
                pickerDialogStyle: PickerDialogStyle(
                  searchFieldInputDecoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    hintText: "Search Country",
                  ),
                ),
                invalidNumberMessage: "Invalid Number",
                languageCode: "En",
                disableLengthCheck: false,
                controller: widget.phoneController,
                initialCountryCode:
                    widget.isData == true ? countryCode ?? "EG" : "EG",
                dropdownIconPosition: IconPosition.trailing,
                dropdownIcon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.grey78,
                ),
                dropdownTextStyle: AppStyles.regular14Grey7F.copyWith(
                  color: AppColors.grey3F,
                ),
                flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 8),
                onCountryChanged: (Country? country) {
                  setState(() {
                    countryCode = country!.fullCountryCode;
                    widget.onCountryChanged?.call(countryCode ?? "20");
                    if (kDebugMode) {
                      print(countryCode);
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: AppStyles.regular14Grey7F.copyWith(
                    color: Color(0xffBABABA),
                  ),
                  contentPadding:
                      widget.isData == true
                          ? const EdgeInsets.all(18)
                          : const EdgeInsets.all(18),
                  counter: const SizedBox(),
                  filled:
                      Theme.of(context).brightness == Brightness.light
                          ? (widget.isData == true ? true : false)
                          : true,
                  fillColor: Colors.white,
                  border: outlineInputBorderTextField(),
                  enabledBorder: outlineInputBorderTextField(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  errorBorder: outlineInputBorderTextField(),
                  disabledBorder: editOutlineInputBorderTextField(),
                  errorStyle: AppStyles.regular14Grey6E.copyWith(
                    color: AppColors.red7D,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorderTextField() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.borderColor),
    );
  }

  OutlineInputBorder editOutlineInputBorderTextField() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.borderColor),
    );
  }
}
