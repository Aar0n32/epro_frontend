import 'package:flutter/material.dart';

class DropdownField<T> extends StatefulWidget {
  final String label;

  final bool disabled;

  final T? value;
  final Type type = T.runtimeType;

  final String? Function(T? value)? _validator;

  final Widget? icon;

  dynamic get validator => _validator != null ? (Object? value) => _validator(value as T?) : null;
  final List<T> items;
  final String Function(T? value) _onChanged;

  dynamic get onChanged => _onChanged;

  final Widget Function(T e) _itemMappingHandler;

  dynamic get itemMappingHandler => _itemMappingHandler;

  DropdownField({
    super.key,
    required this.label,
    required this.disabled,
    this.value,
    String? Function(T?)? validator,
    required this.items,
    required String Function(T? value) onChanged,
    required Widget Function(T e) itemMappingHandler,
    this.icon,
  })  : _onChanged = onChanged,
        _itemMappingHandler = itemMappingHandler,
        _validator = validator;

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState<U> extends State<DropdownField> {
  final TextEditingController textEditingController = TextEditingController();

  bool get isRequired => !widget.disabled && widget.validator != null && widget.validator!('') != null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.value != null) textEditingController.text = widget.value!.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null && !widget.items.contains(widget.value)) {
      widget.items.add(widget.value);
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: IgnorePointer(
        ignoring: widget.disabled,
        child: DropdownButtonFormField(
          isExpanded: true,
          iconEnabledColor: widget.disabled ? Colors.transparent : null,
          validator: widget.validator,
          onChanged: _handleOnChanged,
          items: widget.items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: widget.itemMappingHandler(e),
                ),
              )
              .toList(),
          value: widget.value,
          decoration: InputDecoration(
            counterText: ' ',
            border: widget.disabled ? InputBorder.none : const OutlineInputBorder(),
            label: Text(widget.label),
            hintText: widget.label,
          ),
          icon: widget.icon,
        ),
      ),
    );
  }

  void _handleOnChanged(newValue) {
    setState(() {
      textEditingController.text = widget.onChanged(newValue);
    });
  }
}
