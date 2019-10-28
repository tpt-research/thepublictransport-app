import 'package:flutter/material.dart';

Type _typeOf<T>() => T;

abstract class LanguageBlocBase {
  void dispose();
}

class LanguageBlocProvider<T extends LanguageBlocBase> extends StatefulWidget {
  LanguageBlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }): super(key: key);

  final Widget child;
  final T bloc;

  @override
  _LanguageBlocProviderState<T> createState() => _LanguageBlocProviderState<T>();

  static T of<T extends LanguageBlocBase>(BuildContext context){
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider = context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _LanguageBlocProviderState<T extends LanguageBlocBase> extends State<LanguageBlocProvider<T>>{
  @override
  void dispose(){
    widget.bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return new _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}