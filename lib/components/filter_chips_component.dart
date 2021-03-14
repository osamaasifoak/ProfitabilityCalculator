import 'package:flutter/material.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';

class FilterChipsComponent extends StatelessWidget {
  final String label;
  final Function(bool) onSelected;
  final bool selected;
  const FilterChipsComponent(
      {Key key, this.label, this.onSelected, this.selected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FilterChip(
        selected: selected,
        backgroundColor: selected ? ColorConstant.black : ColorConstant.white,
        showCheckmark: false,
        selectedColor: ColorConstant.black,
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextComponent(
            text: label,
            textStyle: FontStyles.inter(
                color: selected
                    ? ColorConstant.white
                    : ColorConstant.greyishBrownTwo,
                fontWeight: FontWeight.w600),
          ),
        ),
        onSelected: onSelected);
  }
}
