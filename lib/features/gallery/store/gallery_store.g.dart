// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GalleryStore on _GalleryStore, Store {
  late final _$imagesAtom = Atom(
    name: '_GalleryStore.images',
    context: context,
  );

  @override
  ObservableList<ImageEntity> get images {
    _$imagesAtom.reportRead();
    return super.images;
  }

  @override
  set images(ObservableList<ImageEntity> value) {
    _$imagesAtom.reportWrite(value, super.images, () {
      super.images = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_GalleryStore.isLoading',
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

  late final _$errorAtom = Atom(name: '_GalleryStore.error', context: context);

  @override
  GalleryError? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(GalleryError? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$errorDetailsAtom = Atom(
    name: '_GalleryStore.errorDetails',
    context: context,
  );

  @override
  String? get errorDetails {
    _$errorDetailsAtom.reportRead();
    return super.errorDetails;
  }

  @override
  set errorDetails(String? value) {
    _$errorDetailsAtom.reportWrite(value, super.errorDetails, () {
      super.errorDetails = value;
    });
  }

  late final _$loadImagesAsyncAction = AsyncAction(
    '_GalleryStore.loadImages',
    context: context,
  );

  @override
  Future<void> loadImages() {
    return _$loadImagesAsyncAction.run(() => super.loadImages());
  }

  late final _$deleteImageAsyncAction = AsyncAction(
    '_GalleryStore.deleteImage',
    context: context,
  );

  @override
  Future<void> deleteImage(String imageId) {
    return _$deleteImageAsyncAction.run(() => super.deleteImage(imageId));
  }

  late final _$logoutAsyncAction = AsyncAction(
    '_GalleryStore.logout',
    context: context,
  );

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$_GalleryStoreActionController = ActionController(
    name: '_GalleryStore',
    context: context,
  );

  @override
  void clearError() {
    final _$actionInfo = _$_GalleryStoreActionController.startAction(
      name: '_GalleryStore.clearError',
    );
    try {
      return super.clearError();
    } finally {
      _$_GalleryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
images: ${images},
isLoading: ${isLoading},
error: ${error},
errorDetails: ${errorDetails}
    ''';
  }
}
