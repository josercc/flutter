import 'package:flutter/material.dart';

/// 获取Widget的子控件
class GetSubWidget {
  /// 对应的元素
  final Element _element;

  /// 初始化
  GetSubWidget(this._element);

  /// 获取对应的子Widget
  List<Widget> subWidget() {
    return _getSubWidgetFromElement(_element);
  }

  /// 根据element获取对应下面所有的子Widget
  List<Widget> _getSubWidgetFromElement(Element element) {
    if (element == null) {
      return [];
    }
    List<Widget> subWidgets = [];
    if (element != this._element && element.widget != null) {
      subWidgets.add(element.widget);
    }
    if (element is ComponentElement) {
      subWidgets += _getSubWidgetFromElement(element.child);
    } else if (element is InheritedElement) {
      subWidgets += _getSubWidgetFromElement(element.child);
    } else if (element is MultiChildRenderObjectElement) {
      Iterable<Element> elements = element.children;
      List<Widget> widgets = [];
      elements.forEach((element) {
        widgets += _getSubWidgetFromElement(element);
      });
      subWidgets += widgets;
    } else if (element is SingleChildRenderObjectElement) {
      subWidgets += _getSubWidgetFromElement(element.child);
    } else {
      print("${element.widget.runtimeType.toString()} not found");
      subWidgets += [];
    }
    return subWidgets;
  }
}
