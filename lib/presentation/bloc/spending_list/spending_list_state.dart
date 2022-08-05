part of 'spending_list_bloc.dart';

class SpendingListState extends Equatable {
  final bool isLoading;
  final String searchQuery;
  final List<DummyObject> objects;
  final List<DummyObject> filteredObjects;
  final String? message;

  const SpendingListState({
    required this.isLoading,
    required this.searchQuery,
    required this.objects,
    required this.filteredObjects,
    this.message,
  });

  SpendingListState copyWith({
    bool? isLoading,
    String? searchQuery,
    List<DummyObject>? objects,
    List<DummyObject>? filteredObjects,
    String? message,
  }) =>
      SpendingListState(
        isLoading: isLoading ?? this.isLoading,
        searchQuery: searchQuery ?? this.searchQuery,
        objects: objects ?? this.objects,
        filteredObjects: filteredObjects ?? this.filteredObjects,
        message: message,
      );

  @override
  List<Object?> get props => [
        isLoading,
        searchQuery,
        objects,
        message,
        filteredObjects,
      ];
}
