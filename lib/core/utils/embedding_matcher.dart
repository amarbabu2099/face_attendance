import 'dart:math';

/// Holds similarity score + match result
class MatchResult {
  final double score;
  final bool isMatch;

  const MatchResult({
    required this.score,
    required this.isMatch,
  });
}

class EmbeddingMatcher {
  static double cosineSimilarity(
      List<double> e1,
      List<double> e2,
      ) {
    double dot = 0, norm1 = 0, norm2 = 0;

    for (int i = 0; i < e1.length; i++) {
      dot += e1[i] * e2[i];
      norm1 += e1[i] * e1[i];
      norm2 += e2[i] * e2[i];
    }

    return dot / (sqrt(norm1) * sqrt(norm2));
  }

  /// Returns similarity score + match decision
  static MatchResult match(
      List<double> e1,
      List<double> e2, {
        double threshold = 0.60,
      }) {
    final score = cosineSimilarity(e1, e2);

    return MatchResult(
      score: score,
      isMatch: score >= threshold,
    );
  }
}
