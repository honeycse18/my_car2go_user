import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AutocompleteWidget<T extends Object> extends StatelessWidget {
  /// Derived from material autocomplete widget
  const AutocompleteWidget({
    super.key,
    required this.optionsBuilder,
    this.displayStringForDefaultOptionWidget =
        RawAutocomplete.defaultStringForOption,
    this.fieldViewBuilder = _defaultFieldViewBuilder,
    this.onSelected,
    this.optionsMaxHeight = 200.0,
    // this.optionsViewBuilder,
    this.optionsViewOpenDirection = OptionsViewOpenDirection.down,
    this.initialValue,
    this.optionWidget,
    this.separatorWidget,
    this.optionsBackgroundElevation = 4,
    this.optionsBackgroundColor,
    this.optionsBackgroundBorderRadius,
    this.optionsBackgroundShape,
    this.optionBorderRadius,
    this.optionShape,
    this.focusNode,
    this.textEditingController,
  });

  /// {@macro flutter.widgets.RawAutocomplete.displayStringForOption}
  /// If optionWidget provided, this callback would not work
  final AutocompleteOptionToString<T> displayStringForDefaultOptionWidget;

  /// {@macro flutter.widgets.RawAutocomplete.fieldViewBuilder}
  ///
  /// If not provided, will build a standard Material-style text field by
  /// default.
  final AutocompleteFieldViewBuilder fieldViewBuilder;

  /// {@macro flutter.widgets.RawAutocomplete.onSelected}
  final AutocompleteOnSelected<T>? onSelected;

  /// {@macro flutter.widgets.RawAutocomplete.optionsBuilder}
  final AutocompleteOptionsBuilder<T> optionsBuilder;

  /// {@macro flutter.widgets.RawAutocomplete.optionsViewBuilder}
  ///
  /// If not provided, will build a standard Material-style list of results by
  /// default.
  // final AutocompleteOptionsViewBuilder<T>? optionsViewBuilder;

  /// {@macro flutter.widgets.RawAutocomplete.optionsViewOpenDirection}
  final OptionsViewOpenDirection optionsViewOpenDirection;

  /// The maximum height used for the default Material options list widget.
  ///
  /// When [optionsViewBuilder] is `null`, this property sets the maximum height
  /// that the options widget can occupy.
  ///
  /// The default value is set to 200.
  final double optionsMaxHeight;

  /// {@macro flutter.widgets.RawAutocomplete.initialValue}
  final TextEditingValue? initialValue;
  final Widget Function(T option, bool isHighlighted)? optionWidget;
  final Widget Function(T option, bool isHighlighted)? separatorWidget;
  final double optionsBackgroundElevation;
  final Color? optionsBackgroundColor;
  final BorderRadius? optionsBackgroundBorderRadius;
  final ShapeBorder? optionsBackgroundShape;
  final BorderRadius? optionBorderRadius;
  final ShapeBorder? optionShape;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;

  static Widget _defaultFieldViewBuilder(
      BuildContext context,
      TextEditingController textEditingController,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted) {
    return _AutocompleteFieldWidget(
      focusNode: focusNode,
      textEditingController: textEditingController,
      onFieldSubmitted: onFieldSubmitted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RawAutocomplete<T>(
        displayStringForOption: displayStringForDefaultOptionWidget,
        fieldViewBuilder: fieldViewBuilder,
        initialValue: initialValue,
        optionsBuilder: optionsBuilder,
        optionsViewOpenDirection: optionsViewOpenDirection,
        focusNode: focusNode,
        textEditingController: textEditingController,
        optionsViewBuilder:
            // optionsViewBuilder ??
            (BuildContext context, AutocompleteOnSelected<T> onSelected,
                Iterable<T> options) {
          return _AutocompleteOptionsWidget<T>(
            outerConstraints: constraints,
            displayStringForDefaultOptionWidget:
                displayStringForDefaultOptionWidget,
            onSelected: onSelected,
            options: options,
            openDirection: optionsViewOpenDirection,
            maxOptionsHeight: optionsMaxHeight,
            optionWidget: optionWidget,
            separatorWidget: separatorWidget,
            elevation: optionsBackgroundElevation,
            backgroundColor: optionsBackgroundColor,
            outerBorderRadius: optionsBackgroundBorderRadius,
            outerShape: optionsBackgroundShape,
            optionBorderRadius: optionBorderRadius,
            optionShape: optionShape,
          );
        },
        onSelected: onSelected,
      ),
    );
  }
}

// The default Material-style Autocomplete text field.
class _AutocompleteFieldWidget extends StatelessWidget {
  const _AutocompleteFieldWidget({
    required this.focusNode,
    required this.textEditingController,
    required this.onFieldSubmitted,
  });

  final FocusNode focusNode;

  final VoidCallback onFieldSubmitted;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  }
}

// The custom Autocomplete options from default Material-style Autocomplete options.
class _AutocompleteOptionsWidget<T extends Object> extends StatelessWidget {
  const _AutocompleteOptionsWidget({
    super.key,
    required this.displayStringForDefaultOptionWidget,
    required this.onSelected,
    this.openDirection = OptionsViewOpenDirection.down,
    required this.options,
    this.maxOptionsHeight = 200,
    required this.outerConstraints,
    this.optionWidget,
    this.separatorWidget,
    this.elevation = 4,
    this.backgroundColor,
    this.outerBorderRadius,
    this.outerShape,
    this.optionBorderRadius,
    this.optionShape,
  });

  final AutocompleteOptionToString<T> displayStringForDefaultOptionWidget;

  final AutocompleteOnSelected<T> onSelected;
  final OptionsViewOpenDirection openDirection;

  final Iterable<T> options;
  final double maxOptionsHeight;
  final BoxConstraints outerConstraints;
  final Widget Function(T option, bool isHighlighted)? optionWidget;
  final Widget Function(T option, bool isHighlighted)? separatorWidget;
  final double elevation;
  final Color? backgroundColor;
  final BorderRadius? outerBorderRadius;
  final ShapeBorder? outerShape;
  final BorderRadius? optionBorderRadius;
  final ShapeBorder? optionShape;

  @override
  Widget build(BuildContext context) {
    final AlignmentDirectional optionsAlignment = switch (openDirection) {
      OptionsViewOpenDirection.up => AlignmentDirectional.bottomStart,
      OptionsViewOpenDirection.down => AlignmentDirectional.topStart,
    };
    return Align(
      alignment: optionsAlignment,
      child: Material(
        elevation: elevation,
        borderRadius: outerBorderRadius,
        color: backgroundColor,
        shape: outerShape,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: maxOptionsHeight, maxWidth: outerConstraints.maxWidth),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final T option = options.elementAt(index);
              return InkWell(
                onTap: () {
                  onSelected(option);
                },
                borderRadius: optionBorderRadius,
                customBorder: optionShape,
                child: Builder(builder: (BuildContext context) {
                  final bool highlight =
                      AutocompleteHighlightedOption.of(context) == index;
                  if (highlight) {
                    SchedulerBinding.instance.addPostFrameCallback(
                        (Duration timeStamp) {
                      Scrollable.ensureVisible(context, alignment: 0.5);
                    }, debugLabel: 'AutocompleteOptions.ensureVisible');
                  }
                  return optionWidget?.call(option, highlight) ??
                      Container(
                        color: highlight ? Theme.of(context).focusColor : null,
                        padding: const EdgeInsets.all(16.0),
                        child:
                            Text(displayStringForDefaultOptionWidget(option)),
                      );
                }),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              final T option = options.elementAt(index);
              return Builder(builder: (BuildContext context) {
                final bool highlight =
                    AutocompleteHighlightedOption.of(context) == index;
                if (highlight) {
                  SchedulerBinding.instance.addPostFrameCallback(
                      (Duration timeStamp) {
                    Scrollable.ensureVisible(context, alignment: 0.5);
                  }, debugLabel: 'AutocompleteOptions.ensureVisible');
                }
                return separatorWidget?.call(option, highlight) ??
                    const SizedBox();
              });
            },
          ),
        ),
      ),
    );
  }
}
