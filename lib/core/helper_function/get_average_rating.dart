
import 'package:am_adel_market/features/reviews/domain/entities/review_entity.dart';

double getAverageRating(List<ReviewEntity> reviewEntity) {
  if (reviewEntity.isEmpty) return 0.0;

  var sum = 0.0;
  for (var review in reviewEntity) {
    sum += review.rating ?? 0;
  }

  return sum / reviewEntity.length;
}