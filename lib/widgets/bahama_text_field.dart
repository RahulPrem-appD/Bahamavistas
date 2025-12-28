import 'package:flutter/material.dart';
import '../theme/colors.dart';

class BahamaTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final VoidCallback? onSuffixTap;
  final String? Function(String?)? validator;

  const BahamaTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.onSuffixTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: BahamaColors.deepTeal,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(
            fontSize: 16,
            color: BahamaColors.deepTeal,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: BahamaColors.islandBlue)
                : null,
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: onSuffixTap,
                    child: Icon(suffixIcon, color: BahamaColors.greyPrimary),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class BahamaSearchBar extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final VoidCallback? onFilterTap;

  const BahamaSearchBar({
    super.key,
    this.hintText,
    this.controller,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: BahamaColors.whiteSand,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: BahamaColors.deepTeal.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          const Icon(Icons.search_rounded, color: BahamaColors.islandBlue),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText ?? 'Search...',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                hintStyle: const TextStyle(
                  color: BahamaColors.greyPrimary,
                  fontSize: 16,
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: BahamaColors.deepTeal,
              ),
            ),
          ),
          if (onFilterTap != null) ...[
            Container(
              width: 1,
              height: 24,
              color: BahamaColors.greyLight,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onFilterTap,
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(28)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.tune_rounded, color: BahamaColors.islandBlue),
                ),
              ),
            ),
          ] else
            const SizedBox(width: 20),
        ],
      ),
    );
  }
}

