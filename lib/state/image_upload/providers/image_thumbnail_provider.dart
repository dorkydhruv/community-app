import 'package:community_app/state/image_upload/exception/could_not_build_thumbnail_exception.dart';
import 'package:community_app/state/image_upload/extension/get_image_aspect_ratio.dart';
import 'package:community_app/state/image_upload/model/file_type.dart';
import 'package:community_app/state/image_upload/model/image_with_aspect_ratio.dart';
import 'package:community_app/state/image_upload/model/thumbnail_request.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final thumbnailProvider = FutureProvider.family
    .autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
        (ref, ThumbnailRequest request) async {
  final Image image;
  switch (request.fileType) {
    case FileType.image:
      image = Image.file(request.file);
      break;
    case FileType.video:
      final thumb = await VideoThumbnail.thumbnailData(
        video: request.file.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );
      if (thumb == null) {
        throw CouldNotBuildThumbnailException('Could not build thumbnail');
      } else {
        image = Image.memory(
          thumb,
          fit: BoxFit.fitHeight,
        );
      }

      break;
  }
  final aspectRatio = await image.getAspectRatio();
  return ImageWithAspectRatio(image: image, aspectRatio: aspectRatio);
});
