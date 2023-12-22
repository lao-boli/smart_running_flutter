import 'dart:async';

import 'package:flutter/material.dart';

const Duration fakeAPIDuration = Duration(milliseconds: 200);
const Duration debounceDuration = Duration(milliseconds: 500);

class AppAutocomplete extends StatefulWidget {
  final String labelText;
  final String? suffixText;
  final String? permanentSuffixText;

  const AppAutocomplete(
      {super.key,
      required this.labelText,
      this.suffixText,
      this.permanentSuffixText});

  @override
  State<AppAutocomplete> createState() => _AppAutocompleteState();
}

class _AppAutocompleteState extends State<AppAutocomplete> {
  String? _currentQuery;
  String? labelText;
  String? suffixText;
  String? permanentSuffixText;

  // The most recent options received from the API.
  late Iterable<String> _lastOptions = <String>[];

  late final _Debounceable<Iterable<String>?, String> _debouncedSearch;

  Future<Iterable<String>?> _search(String query) async {
    _currentQuery = query;

    // In a real application, there should be some error handling here.
    final Iterable<String> options = await _FakeAPI.search(_currentQuery!);

    // If another search happened after this one, throw away these options.
    if (_currentQuery != query) {
      return null;
    }
    _currentQuery = null;

    return options;
  }

  @override
  void initState() {
    super.initState();
    _debouncedSearch = _debounce<Iterable<String>?, String>(_search);
    labelText = widget.labelText;
    suffixText = widget.suffixText;
    permanentSuffixText = widget.permanentSuffixText;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) async {
                final Iterable<String>? options =
                    await _debouncedSearch(textEditingValue.text);
                if (options == null) {
                  return _lastOptions;
                }
                _lastOptions = options;
                return options;
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: permanentSuffixText != null
                        ? Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(permanentSuffixText!,
                                style: TextStyle(color: Colors.grey)),
                          )
                        : null,
                    labelText: labelText,
                  ),
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                    print('You just typed a new entry  $value');
                  },
                );
              },
              onSelected: (String selection) {
                debugPrint('You just selected $selection');
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: Material(
                      elevation: 4,
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                          height: 52.0 * options.length,
                          width: constraints.biggest.width, // <-- Right here !
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: options.length,
                            shrinkWrap: false,
                            itemBuilder: (BuildContext context, int index) {
                              final String option = options.elementAt(index);
                              return InkWell(
                                onTap: () => onSelected(option),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(option),
                                ),
                              );
                            },
                          )),
                    ),
                  ),
                );
              },
            ));
  }
}

// Mimics a remote API.
class _FakeAPI {
  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  // Searches the options, but injects a fake "network" delay.
  static Future<Iterable<String>> search(String query) async {
    await Future<void>.delayed(fakeAPIDuration); // Fake 1 second delay.
    if (query == '') {
      return const Iterable<String>.empty();
    }
    return _kOptions.where((String option) {
      return option.contains(query.toLowerCase());
    });
  }
}

typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

/// Returns a new function that is a debounced version of the given function.
///
/// This means that the original function will be called only after no calls
/// have been made for the given Duration.
_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } catch (error) {
      if (error is _CancelException) {
        return null;
      }
      rethrow;
    }
    return function(parameter);
  };
}

// A wrapper around Timer used for debouncing.
class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(debounceDuration, _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

// An exception indicating that the timer was canceled.
class _CancelException implements Exception {
  const _CancelException();
}
