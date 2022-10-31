import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SliderWidget extends StatefulWidget {
  final int max;
  final ValueChanged<int>? onChanged;
  final int initValue;

  const SliderWidget(
      {Key? key, required this.max, this.onChanged, required this.initValue})
      : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late int _value;

  @override
  void initState() {
    _value = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfSlider(
      onChanged: (value) {
        setState(() {
          _value = (value as double).toInt();
          if (widget.onChanged != null) {
            widget.onChanged!(_value);
          }
        });
      },
      max: widget.max,
      enableTooltip: true,
      value: _value,
    );
  }
}
