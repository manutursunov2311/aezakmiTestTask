// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'painter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PainterStore on _PainterStore, Store {
  late final _$isLoadingAtom = Atom(
    name: '_PainterStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$eventAtom = Atom(name: '_PainterStore.event', context: context);

  @override
  PainterEvent? get event {
    _$eventAtom.reportRead();
    return super.event;
  }

  @override
  set event(PainterEvent? value) {
    _$eventAtom.reportWrite(value, super.event, () {
      super.event = value;
    });
  }

  late final _$isEditLoadingAtom = Atom(
    name: '_PainterStore.isEditLoading',
    context: context,
  );

  @override
  bool get isEditLoading {
    _$isEditLoadingAtom.reportRead();
    return super.isEditLoading;
  }

  @override
  set isEditLoading(bool value) {
    _$isEditLoadingAtom.reportWrite(value, super.isEditLoading, () {
      super.isEditLoading = value;
    });
  }

  late final _$detailsAtom = Atom(
    name: '_PainterStore.details',
    context: context,
  );

  @override
  String? get details {
    _$detailsAtom.reportRead();
    return super.details;
  }

  @override
  set details(String? value) {
    _$detailsAtom.reportWrite(value, super.details, () {
      super.details = value;
    });
  }

  late final _$editBytesAtom = Atom(
    name: '_PainterStore.editBytes',
    context: context,
  );

  @override
  Uint8List? get editBytes {
    _$editBytesAtom.reportRead();
    return super.editBytes;
  }

  @override
  set editBytes(Uint8List? value) {
    _$editBytesAtom.reportWrite(value, super.editBytes, () {
      super.editBytes = value;
    });
  }

  late final _$shareImageAsyncAction = AsyncAction(
    '_PainterStore.shareImage',
    context: context,
  );

  @override
  Future<void> shareImage(Uint8List bytes) {
    return _$shareImageAsyncAction.run(() => super.shareImage(bytes));
  }

  late final _$saveOrUpdateImageAsyncAction = AsyncAction(
    '_PainterStore.saveOrUpdateImage',
    context: context,
  );

  @override
  Future<void> saveOrUpdateImage(Uint8List bytes, String? documentId) {
    return _$saveOrUpdateImageAsyncAction.run(
      () => super.saveOrUpdateImage(bytes, documentId),
    );
  }

  late final _$loadEditBytesAsyncAction = AsyncAction(
    '_PainterStore.loadEditBytes',
    context: context,
  );

  @override
  Future<void> loadEditBytes({Uint8List? bytes, String? imageUrl}) {
    return _$loadEditBytesAsyncAction.run(
      () => super.loadEditBytes(bytes: bytes, imageUrl: imageUrl),
    );
  }

  late final _$_PainterStoreActionController = ActionController(
    name: '_PainterStore',
    context: context,
  );

  @override
  void clearEvent() {
    final _$actionInfo = _$_PainterStoreActionController.startAction(
      name: '_PainterStore.clearEvent',
    );
    try {
      return super.clearEvent();
    } finally {
      _$_PainterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetEditState() {
    final _$actionInfo = _$_PainterStoreActionController.startAction(
      name: '_PainterStore.resetEditState',
    );
    try {
      return super.resetEditState();
    } finally {
      _$_PainterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
event: ${event},
isEditLoading: ${isEditLoading},
details: ${details},
editBytes: ${editBytes}
    ''';
  }
}
