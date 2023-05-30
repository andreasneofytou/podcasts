import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TextWrapper extends StatefulWidget {
  const TextWrapper({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<TextWrapper> createState() => _TextWrapperState();
}

class _TextWrapperState extends State<TextWrapper>
    with TickerProviderStateMixin {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: InkWell(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: ConstrainedBox(
            constraints: isExpanded
                ? const BoxConstraints()
                : const BoxConstraints(maxHeight: 70),
            child: Html(
              data: widget.text,
            ),
            // Text(
            //   widget.text,
            //   style: const TextStyle(fontSize: 16),
            //   softWrap: true,
            //   overflow: TextOverflow.fade,
            // )
          ),
        ));
  }
}
