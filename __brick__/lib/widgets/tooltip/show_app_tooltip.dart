import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_utils.dart';
import './bottom_arrow_clipper_shadow.dart';
import './tooltip_arrow_position_enum.dart';
import './top_arrow_clipper_shadow.dart';

// Todo: tooltip position is changing when width and content is changing so handle that
class ShowAppTooltip {
  static OverlayEntry? _infoWindowOverlay;
  static late OverlayEntry _backgroundOverlay;
  static bool isInfoWindowOpened = false;

  static void openToolTip({
    required BuildContext context,
    required Widget contentWidget,
    required infoBtnKey,
    required ToolTipArrowPosition toolTipArrowPosition,
  }) async {
    _backgroundOverlay = _getBackgroundOverlay();
    closeInfoWindow();
    final RenderBox? popupButtonObject =
    infoBtnKey.currentContext?.findRenderObject() as RenderBox?;
    if (!isInfoWindowOpened && popupButtonObject != null) {
      final RenderBox? overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox?;
      if (overlay != null) {
        final double screenWidth = MediaQuery.of(context).size.width;
        final buttonPosition = popupButtonObject.localToGlobal(Offset.zero);
        _infoWindowOverlay = _overlayEntryBuilder(
          renderBox: popupButtonObject,
          // Adjust width of tooltip here
          // Once you adjust width you need to arrange content position as well
          width: (screenWidth - (AppDimens.dimensScreenHorizontalMargin.w * 7)),
          marginEnd: (screenWidth -
              (AppDimens.dimensScreenHorizontalMargin.w * 2) -
              buttonPosition.dx),
          contentWidget: contentWidget,
          toolTipArrowPosition: toolTipArrowPosition,
        );
        OverlayState? os = Overlay.of(context);
        if (_infoWindowOverlay != null) {
          os.insert(_backgroundOverlay);
          os.insert(_infoWindowOverlay!);
          isInfoWindowOpened = true;
        }
      }
    }
  }

  static OverlayEntry _getBackgroundOverlay() {
    //To add dummy widget behind popup info window when window is shown, for detecting out of window touch events.
    return OverlayEntry(
      builder: (builder) {
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                closeInfoWindow();
              },
              onTapDown: (v) {
                closeInfoWindow();
              },
              onVerticalDragStart: (v) {
                closeInfoWindow();
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        );
      },
    );
  }

  static OverlayEntry _overlayEntryBuilder({
    required RenderBox renderBox,
    required double width,
    required double marginEnd,
    required Widget contentWidget,
    required ToolTipArrowPosition toolTipArrowPosition,
  }) {
    final buttonSize = renderBox.size;
    final buttonPosition = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          // Here: Once you adjust width you need to arrange content position
          // Here: Even when you change content height you need to change position
          top: toolTipArrowPosition == ToolTipArrowPosition.bottom
              ? buttonPosition.dy - (buttonSize.height * 6)
              : buttonPosition.dy + (buttonSize.height * 2),
          right: AppDimens.dimensScreenHorizontalMargin.w + AppDimens.dimens5.w,
          width: width,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: ShapeDecoration(
                shape: toolTipArrowPosition == ToolTipArrowPosition.bottom
                    ? BottomArrowClipperShadow(
                  arrowHeight: AppDimens.dimens10.h,
                  arrowWidth: AppDimens.dimens16.w,
                  rightMargin: marginEnd,
                )
                    : TopArrowClipperShadow(
                  arrowHeight: AppDimens.dimens10.h,
                  arrowWidth: AppDimens.dimens16.w,
                  rightMargin: marginEnd,
                ),
                color: AppColors.colorWhite,
                shadows: [
                  BoxShadow(
                    color: AppColors.colorBlack.withOpacity(0.25),
                    blurRadius: AppDimens.dimens5.r,
                    spreadRadius: AppDimens.dimens1.r,
                    offset: const Offset(
                      0,
                      1,
                    ), // Slight offset for a natural shadow
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.dimens10.w,
                vertical: AppDimens.dimens10.h,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppDimens.dimens5.r,
                ),
                child: contentWidget,
              ),
            ),
          ),
        );
      },
    );
  }

  static void closeInfoWindow() {
    if (isInfoWindowOpened) {
      _backgroundOverlay.remove();
    }
    if (isInfoWindowOpened && _infoWindowOverlay != null) {
      _infoWindowOverlay!.remove();
      isInfoWindowOpened = false;
    }
  }
}
