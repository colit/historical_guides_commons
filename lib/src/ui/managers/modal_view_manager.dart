import 'package:flutter/material.dart';
import 'package:historical_guides_commons/historical_guides_commons.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ModalViewManager extends StatefulWidget {
  const ModalViewManager({
    Key? key,
    required this.child,
    required ModalViewService modalViewService,
  })  : _galleryService = modalViewService,
        super(key: key);
  final Widget child;
  final ModalViewService _galleryService;
  @override
  _ModalViewManagerState createState() => _ModalViewManagerState();
}

class _ModalViewManagerState extends State<ModalViewManager> {
  late ModalViewService viewService;

  bool visible = false;

  @override
  void initState() {
    super.initState();
    viewService = widget._galleryService;
    viewService.registerViewListener(
      opener: _showGallery,
      completer: _closeGallery,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
            child: PointerInterceptor(
          child: Container(),
          intercepting: visible,
        ))
      ],
    );
  }

  void _closeGallery() {
    setState(() {
      visible = false;
    });
    Navigator.of(context).pop();
  }

  void _showGallery(content) {
    setState(() {
      visible = true;
    });
    showDialog(
      barrierColor: Colors.black.withAlpha(200),
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) => Stack(
        alignment: Alignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(UIHelper.kHorizontalSpaceLarge),
              child: content,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(UIHelper.kHorizontalSpaceSmall),
                child: RoundIconButton(
                  icon: const Icon(Icons.close),
                  onTap: () {
                    _closeGallery();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
