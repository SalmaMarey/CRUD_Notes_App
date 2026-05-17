import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final bool expand;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        if (expand)
          Expanded(
            child: _buildTextField(),
          )
        else
          _buildTextField(),
      ],
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: controller,
      maxLines: expand ? null : maxLines,
      expands: expand,
      textAlignVertical: expand ? TextAlignVertical.top : TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}
