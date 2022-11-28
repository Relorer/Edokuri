// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ReaderTextSelectionControls extends MaterialTextSelectionControls {
  final void Function(String text) handleTranslate;
  final String Function(TextSelection) getSelectedText;
  final bool Function(String text) canTranslate;

  ReaderTextSelectionControls(
      {required this.handleTranslate,
      required this.canTranslate,
      required this.getSelectedText});

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ClipboardStatusNotifier? clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    final selectedText = getSelectedText(delegate.textEditingValue.selection);

    return _TextSelectionControlsToolbar(
      globalEditableRegion: globalEditableRegion,
      textLineHeight: textLineHeight,
      selectionMidpoint: selectionMidpoint,
      endpoints: endpoints,
      delegate: delegate,
      clipboardStatus: clipboardStatus,
      handleCopy: canCopy(delegate)
          ? () async {
              handleCopy(delegate);
              await Clipboard.setData(ClipboardData(text: selectedText));
            }
          : null,
      handleSelectAll:
          canSelectAll(delegate) ? () => handleSelectAll(delegate) : null,
      handleTranslate: canTranslate(selectedText)
          ? () async {
              handleTranslate(selectedText);
            }
          : null,
      handleSearch: canTranslate(selectedText)
          ? (() {
              launchUrl(
                  Uri.https("www.google.com", "search", {'q': selectedText}));
            })
          : null,
    );
  }
}

class _TextSelectionControlsToolbar extends StatefulWidget {
  const _TextSelectionControlsToolbar(
      {required this.clipboardStatus,
      required this.delegate,
      required this.endpoints,
      required this.globalEditableRegion,
      required this.handleCopy,
      required this.handleSelectAll,
      required this.handleTranslate,
      required this.selectionMidpoint,
      required this.textLineHeight,
      required this.handleSearch});

  final ClipboardStatusNotifier? clipboardStatus;
  final TextSelectionDelegate delegate;
  final List<TextSelectionPoint> endpoints;
  final Rect globalEditableRegion;
  final VoidCallback? handleCopy;
  final VoidCallback? handleSelectAll;
  final VoidCallback? handleTranslate;
  final VoidCallback? handleSearch;
  final Offset selectionMidpoint;
  final double textLineHeight;

  @override
  _TextSelectionControlsToolbarState createState() =>
      _TextSelectionControlsToolbarState();
}

class _TextSelectionControlsToolbarState
    extends State<_TextSelectionControlsToolbar> with TickerProviderStateMixin {
  // Padding between the toolbar and the anchor.
  static const double _kToolbarContentDistanceBelow = 20.0;
  static const double _kToolbarContentDistance = 8.0;

  void _onChangedClipboardStatus() {
    setState(() {
      // Inform the widget that the value of clipboardStatus has changed.
    });
  }

  @override
  void initState() {
    super.initState();
    widget.clipboardStatus?.addListener(_onChangedClipboardStatus);
  }

  @override
  void didUpdateWidget(_TextSelectionControlsToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.clipboardStatus != oldWidget.clipboardStatus) {
      widget.clipboardStatus?.addListener(_onChangedClipboardStatus);
      oldWidget.clipboardStatus?.removeListener(_onChangedClipboardStatus);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.clipboardStatus?.removeListener(_onChangedClipboardStatus);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.handleCopy == null && widget.handleSelectAll == null) {
      return const SizedBox.shrink();
    }

    if (widget.clipboardStatus?.value == ClipboardStatus.unknown) {
      return const SizedBox.shrink();
    }

    // Calculate the positioning of the menu. It is placed above the selection
    // if there is enough room, or otherwise below.
    final TextSelectionPoint startTextSelectionPoint = widget.endpoints[0];
    final TextSelectionPoint endTextSelectionPoint =
        widget.endpoints.length > 1 ? widget.endpoints[1] : widget.endpoints[0];
    final Offset anchorAbove = Offset(
      widget.globalEditableRegion.left + widget.selectionMidpoint.dx,
      widget.globalEditableRegion.top +
          startTextSelectionPoint.point.dy -
          widget.textLineHeight -
          _kToolbarContentDistance,
    );
    final Offset anchorBelow = Offset(
      widget.globalEditableRegion.left + widget.selectionMidpoint.dx,
      widget.globalEditableRegion.top +
          endTextSelectionPoint.point.dy +
          _kToolbarContentDistanceBelow,
    );

    // Determine which buttons will appear so that the order and total number is
    // known. A button's position in the menu can slightly affect its
    // appearance.
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final List<_TextSelectionToolbarItemData> itemDatas =
        <_TextSelectionToolbarItemData>[
      if (widget.handleCopy != null)
        _TextSelectionToolbarItemData(
          label: localizations.copyButtonLabel,
          onPressed: widget.handleCopy!,
        ),
      if (widget.handleSelectAll != null)
        _TextSelectionToolbarItemData(
          label: localizations.selectAllButtonLabel,
          onPressed: widget.handleSelectAll!,
        ),
      if (widget.handleTranslate != null)
        _TextSelectionToolbarItemData(
          label: "Translate",
          onPressed: widget.handleTranslate!,
        ),
      if (widget.handleSearch != null)
        _TextSelectionToolbarItemData(
          label: "Search",
          onPressed: widget.handleSearch!,
        ),
    ];

    // If there is no option available, build an empty widget.
    if (itemDatas.isEmpty) {
      return const SizedBox(width: 0.0, height: 0.0);
    }

    return TextSelectionToolbar(
      anchorAbove: anchorAbove,
      anchorBelow: anchorBelow,
      children: [
        ...itemDatas
            .asMap()
            .entries
            .map((MapEntry<int, _TextSelectionToolbarItemData> entry) {
          return TextSelectionToolbarTextButton(
            padding: TextSelectionToolbarTextButton.getPadding(
                entry.key, itemDatas.length),
            onPressed: entry.value.onPressed,
            child: Text(entry.value.label),
          );
        }),
      ],
    );
  }
}

class _TextSelectionToolbarItemData {
  const _TextSelectionToolbarItemData({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;
}

//https://stackoverflow.com/questions/72499847/custom-text-selection-toolbar-in-flutter