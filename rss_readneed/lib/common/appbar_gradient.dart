import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
/*复写系统appbar实现渐变appbar*/
const double _kLeadingWidth = kToolbarHeight; // So the leading button is square.

// Bottom justify the kToolbarHeight child which may overflow the top.
class _ToolbarContainerLayout extends SingleChildLayoutDelegate {
  const _ToolbarContainerLayout();

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.tighten(height: kToolbarHeight);
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, kToolbarHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height);
  }

  @override
  bool shouldRelayout(_ToolbarContainerLayout oldDelegate) => false;
}

class GradientAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// Creates a material design app bar.
  ///
  /// The arguments [elevation], [primary], [toolbarOpacity], [bottomOpacity]
  /// and [automaticallyImplyLeading] must not be null.
  ///
  /// Typically used in the [Scaffold.appBar] property.
  GradientAppBar({
    Key key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation = 4.0,
    this.backgroundColor,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.gradient,
    this.shadowColor,
  }) : assert(automaticallyImplyLeading != null),
        assert(elevation != null),
        assert(primary != null),
        assert(titleSpacing != null),
        assert(toolbarOpacity != null),
        assert(bottomOpacity != null),
        preferredSize = Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  /// A widget to display before the [title].
  ///
  /// If this is null and [automaticallyImplyLeading] is set to true, the
  /// [AppBar] will imply an appropriate widget. For example, if the [AppBar] is
  /// in a [Scaffold] that also has a [Drawer], the [Scaffold] will fill this
  /// widget with an [IconButton] that opens the drawer (using [Icons.menu]). If
  /// there's no [Drawer] and the parent [Navigator] can go back, the [AppBar]
  /// will use a [BackButton] that calls [Navigator.maybePop].
  ///
  /// {@tool sample}
  ///
  /// The following code shows how the drawer button could be manually specified
  /// instead of relying on [automaticallyImplyLeading]:
  ///
  /// ```dart
  /// AppBar(
  ///   leading: Builder(
  ///     builder: (BuildContext context) {
  ///       return IconButton(
  ///         icon: const Icon(Icons.menu),
  ///         onPressed: () { Scaffold.of(context).openDrawer(); },
  ///         tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
  ///       );
  ///     },
  ///   ),
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// The [Builder] is used in this example to ensure that the `context` refers
  /// to that part of the subtree. That way this code snippet can be used even
  /// inside the very code that is creating the [Scaffold] (in which case,
  /// without the [Builder], the `context` wouldn't be able to see the
  /// [Scaffold], since it would refer to an ancestor of that widget).
  ///
  /// See also:
  ///
  ///  * [Scaffold.appBar], in which an [AppBar] is usually placed.
  ///  * [Scaffold.drawer], in which the [Drawer] is usually placed.
  final Widget leading;

  /// Controls whether we should try to imply the leading widget if null.
  ///
  /// If true and [leading] is null, automatically try to deduce what the leading
  /// widget should be. If false and [leading] is null, leading space is given to [title].
  /// If leading widget is not null, this parameter has no effect.
  final bool automaticallyImplyLeading;

  /// The primary widget displayed in the appbar.
  ///
  /// Typically a [Text] widget containing a description of the current contents
  /// of the app.
  final Widget title;

  /// Widgets to display after the [title] widget.
  ///
  /// Typically these widgets are [IconButton]s representing common operations.
  /// For less common operations, consider using a [PopupMenuButton] as the
  /// last action.
  ///
  /// {@tool snippet --template=stateless_widget}
  ///
  /// This sample shows adding an action to an [AppBar] that opens a shopping cart.
  ///
  /// ```dart
  /// Scaffold(
  ///   appBar: AppBar(
  ///     title: Text('Hello World'),
  ///     actions: <Widget>[
  ///       IconButton(
  ///         icon: Icon(Icons.shopping_cart),
  ///         tooltip: 'Open shopping cart',
  ///         onPressed: () {
  ///           // ...
  ///         },
  ///       ),
  ///     ],
  ///   ),
  /// )
  /// ```
  /// {@end-tool}
  final List<Widget> actions;

  /// This widget is stacked behind the toolbar and the tabbar. It's height will
  /// be the same as the app bar's overall height.
  ///
  /// A flexible space isn't actually flexible unless the [AppBar]'s container
  /// changes the [AppBar]'s size. A [SliverAppBar] in a [CustomScrollView]
  /// changes the [AppBar]'s height when scrolled.
  ///
  /// Typically a [FlexibleSpaceBar]. See [FlexibleSpaceBar] for details.
  final Widget flexibleSpace;

  /// This widget appears across the bottom of the app bar.
  ///
  /// Typically a [TabBar]. Only widgets that implement [PreferredSizeWidget] can
  /// be used at the bottom of an app bar.
  ///
  /// See also:
  ///
  ///  * [PreferredSize], which can be used to give an arbitrary widget a preferred size.
  final PreferredSizeWidget bottom;

  /// The z-coordinate at which to place this app bar. This controls the size of
  /// the shadow below the app bar.
  ///
  /// Defaults to 4, the appropriate elevation for app bars.
  final double elevation;

  /// The color to use for the app bar's material. Typically this should be set
  /// along with [brightness], [iconTheme], [textTheme].
  ///
  /// Defaults to [ThemeData.primaryColor].
  final Color backgroundColor;

  /// The brightness of the app bar's material. Typically this is set along
  /// with [backgroundColor], [iconTheme], [textTheme].
  ///
  /// Defaults to [ThemeData.primaryColorBrightness].
  final Brightness brightness;

  /// The color, opacity, and size to use for app bar icons. Typically this
  /// is set along with [backgroundColor], [brightness], [textTheme].
  ///
  /// Defaults to [ThemeData.primaryIconTheme].
  final IconThemeData iconTheme;

  /// The color, opacity, and size to use for the icons that appear in the app
  /// bar's [actions]. This should only be used when the [actions] should be
  /// themed differently than the icon that appears in the app bar's [leading]
  /// widget.
  ///
  /// If this property is null, then [ThemeData.appBarTheme.actionsIconTheme] is
  /// used, if that is also null, then this falls back to [iconTheme].
  final IconThemeData actionsIconTheme;

  /// The typographic styles to use for text in the app bar. Typically this is
  /// set along with [brightness] [backgroundColor], [iconTheme].
  ///
  /// Defaults to [ThemeData.primaryTextTheme].
  final TextTheme textTheme;

  /// Whether this app bar is being displayed at the top of the screen.
  ///
  /// If true, the appbar's toolbar elements and [bottom] widget will be
  /// padded on top by the height of the system status bar. The layout
  /// of the [flexibleSpace] is not affected by the [primary] property.
  final bool primary;

  /// Whether the title should be centered.
  ///
  /// Defaults to being adapted to the current [TargetPlatform].
  final bool centerTitle;

  /// The spacing around [title] content on the horizontal axis. This spacing is
  /// applied even if there is no [leading] content or [actions]. If you want
  /// [title] to take all the space available, set this value to 0.0.
  ///
  /// Defaults to [NavigationToolbar.kMiddleSpacing].
  final double titleSpacing;

  /// How opaque the toolbar part of the app bar is.
  ///
  /// A value of 1.0 is fully opaque, and a value of 0.0 is fully transparent.
  ///
  /// Typically, this value is not changed from its default value (1.0). It is
  /// used by [SliverAppBar] to animate the opacity of the toolbar when the app
  /// bar is scrolled.
  final double toolbarOpacity;

  /// How opaque the bottom part of the app bar is.
  ///
  /// A value of 1.0 is fully opaque, and a value of 0.0 is fully transparent.
  ///
  /// Typically, this value is not changed from its default value (1.0). It is
  /// used by [SliverAppBar] to animate the opacity of the toolbar when the app
  /// bar is scrolled.
  final double bottomOpacity;

  //扩展背景
  final Gradient gradient;

  //扩展下阴影
  final Color shadowColor;

  /// A size whose height is the sum of [kToolbarHeight] and the [bottom] widget's
  /// preferred height.
  ///
  /// [Scaffold] uses this this size to set its app bar's height.
  @override
  final Size preferredSize;

  bool _getEffectiveCenterTitle(ThemeData themeData) {
    if (centerTitle != null)
      return centerTitle;
    assert(themeData.platform != null);
    switch (themeData.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return false;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return actions == null || actions.length < 2;
    }
    return null;
  }

  @override
  _AppBarState createState() => _AppBarState();
}

class _AppBarState extends State<GradientAppBar> {
  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  void _handleDrawerButtonEnd() {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    assert(!widget.primary || debugCheckHasMediaQuery(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData themeData = Theme.of(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final ScaffoldState scaffold = Scaffold.of(context, nullOk: true);
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);

    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton = parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    IconThemeData overallIconTheme = widget.iconTheme
        ?? appBarTheme.iconTheme
        ?? themeData.primaryIconTheme;
    IconThemeData actionsIconTheme = widget.actionsIconTheme
        ?? appBarTheme.actionsIconTheme
        ?? overallIconTheme;
    TextStyle centerStyle = widget.textTheme?.title
        ?? appBarTheme.textTheme?.title
        ?? themeData.primaryTextTheme.title;
    TextStyle sideStyle = widget.textTheme?.body1
        ?? appBarTheme.textTheme?.body1
        ?? themeData.primaryTextTheme.body1;

    if (widget.toolbarOpacity != 1.0) {
      final double opacity = const Interval(0.25, 1.0, curve: Curves.fastOutSlowIn).transform(widget.toolbarOpacity);
      if (centerStyle?.color != null)
        centerStyle = centerStyle.copyWith(color: centerStyle.color.withOpacity(opacity));
      if (sideStyle?.color != null)
        sideStyle = sideStyle.copyWith(color: sideStyle.color.withOpacity(opacity));
      overallIconTheme = overallIconTheme.copyWith(
          opacity: opacity * (overallIconTheme.opacity ?? 1.0)
      );
      actionsIconTheme = actionsIconTheme.copyWith(
          opacity: opacity * (actionsIconTheme.opacity ?? 1.0)
      );
    }

    Widget leading = widget.leading;
    if (leading == null && widget.automaticallyImplyLeading) {
      if (hasDrawer) {
        leading = IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _handleDrawerButton,
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      } else {
        if (canPop)
          leading = useCloseButton ? const CloseButton() : const BackButton();
      }
    }
    if (leading != null) {
      leading = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: _kLeadingWidth),
        child: leading,
      );
    }

    Widget title = widget.title;
    if (title != null) {
      bool namesRoute;
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          namesRoute = true;
          break;
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          break;
      }
      title = DefaultTextStyle(
        style: centerStyle,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: Semantics(
          namesRoute: namesRoute,
          child: title,
          header: true,
        ),
      );
    }

    Widget actions;
    if (widget.actions != null && widget.actions.isNotEmpty) {
      actions = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.actions,
      );
    } else if (hasEndDrawer) {
      actions = IconButton(
        icon: const Icon(Icons.menu),
        onPressed: _handleDrawerButtonEnd,
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }

    // Allow the trailing actions to have their own theme if necessary.
    if (actions != null) {
      actions = IconTheme.merge(
        data: actionsIconTheme,
        child: actions,
      );
    }

    final Widget toolbar = NavigationToolbar(
      leading: leading,
      middle: title,
      trailing: actions,
      centerMiddle: widget._getEffectiveCenterTitle(themeData),
      middleSpacing: widget.titleSpacing,
    );

    // If the toolbar is allocated less than kToolbarHeight make it
    // appear to scroll upwards within its shrinking container.
    Widget appBar = ClipRect(
      child: CustomSingleChildLayout(
        delegate: const _ToolbarContainerLayout(),
        child: IconTheme.merge(
          data: overallIconTheme,
          child: DefaultTextStyle(
            style: sideStyle,
            child: toolbar,
          ),
        ),
      ),
    );
    if (widget.bottom != null) {
      appBar = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: kToolbarHeight),
              child: appBar,
            ),
          ),
          widget.bottomOpacity == 1.0 ? widget.bottom : Opacity(
            opacity: const Interval(0.25, 1.0, curve: Curves.fastOutSlowIn).transform(widget.bottomOpacity),
            child: widget.bottom,
          ),
        ],
      );
    }

    // The padding applies to the toolbar and tabbar, not the flexible space.
    if (widget.primary) {
      appBar = SafeArea(
        top: true,
        child: appBar,
      );
    }

    appBar = Align(
      alignment: Alignment.topCenter,
      child: appBar,
    );

    if (widget.flexibleSpace != null) {
      appBar = Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          widget.flexibleSpace,
          appBar,
        ],
      );
    }

    // <--- gradient --->
    if (widget.gradient != null) {
      appBar = Container(
        decoration: BoxDecoration(
          gradient: widget.gradient,
//          boxShadow: [
//            BoxShadow(color: Colors.green,offset: Offset(0, 0),blurRadius: 4)//shadowColor默认效果类似
//          ]
        ),
        child: appBar,
      );
    }
    // <--- gradient --->

    final Brightness brightness = widget.brightness ?? themeData.primaryColorBrightness;
    final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Material(
          color: widget.gradient != null
              ? Colors.transparent
              : widget.backgroundColor ?? themeData.primaryColor,
          elevation: widget.elevation,
          shadowColor: widget.shadowColor ?? Color(0xFF000000),// ---> shadowColor
          child: appBar,
        ),
      ),
    );
  }
}
