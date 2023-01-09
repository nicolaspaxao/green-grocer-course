// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:quitanda_com_getx/src/config/colors.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    Key? key,
    required this.value,
    required this.suffixText,
    required this.result,
    this.isRemovable = false,
  }) : super(key: key);

  final int value;
  final String suffixText;
  final Function(int quantity) result;
  final bool? isRemovable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QuantityButton(
            color:!isRemovable! || value > 1 ? Colors.grey : Colors.red,
            icon: !isRemovable! || value > 1 ? Icons.remove : Icons.delete_forever,
            onTap: () {
              if (value == 1 && !isRemovable!) return;
              int resultCount = value - 1;
              result(resultCount);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '$value$suffixText',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          _QuantityButton(
            color: customSwatchColor,
            icon: Icons.add,
            onTap: () {
              int resultCount = value + 1;
              result(resultCount);
            },
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: Ink(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
