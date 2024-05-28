part of flutter_mentions;

// import 'package:flutter/material.dart';

class OptionList extends StatelessWidget {
  const OptionList({
    super.key,
    required this.data,
    required this.onTap,
    required this.suggestionListHeight,
    this.suggestionBuilder,
    this.suggestionListDecoration,
  });

  final Widget Function(Map<String, dynamic>)? suggestionBuilder;

  final List<Map<String, dynamic>> data;

  final Function(Map<String, dynamic>) onTap;

  final double suggestionListHeight;

  final BoxDecoration? suggestionListDecoration;

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: suggestionListDecoration?.copyWith(
                    borderRadius: BorderRadius.circular(12),
                  ) ??
                  const BoxDecoration(color: Colors.white),
              constraints: BoxConstraints(
                maxHeight: data.length * 60 > 300 ? 300 : data.length * 60,
                minHeight: 0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onTap(data[index]);
                          },
                          child: suggestionBuilder != null
                              ? suggestionBuilder!(data[index])
                              : Container(
                                  color: Colors.blue,
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    data[index]['display'],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
