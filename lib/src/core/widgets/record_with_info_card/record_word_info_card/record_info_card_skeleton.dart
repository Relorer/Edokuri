// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import 'package:edokuri/src/core/widgets/skeleton.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class RecordInfoCardSkeleton extends StatelessWidget {
  const RecordInfoCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(runSpacing: defaultMargin, children: [
      const Center(child: Skeleton(160, 28)),
      SizedBox(
        width: double.maxFinite,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: defaultMargin / 2,
          runSpacing: defaultMargin / 2,
          children: const [
            Skeleton(100, 30, r: 20),
            Skeleton(120, 30, r: 20),
            Skeleton(80, 30, r: 20),
            Skeleton(170, 30, r: 20),
            Skeleton(130, 30, r: 20),
            Skeleton(90, 30, r: 20),
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(top: defaultMargin),
        child: Skeleton(double.maxFinite, 50),
      ),
      ...Iterable.generate(5).map((e) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: defaultMargin),
                child: Skeleton(170, 28),
              ),
              SizedBox(
                height: defaultMargin,
              ),
              Skeleton(200, 22),
              SizedBox(
                height: defaultMargin / 2,
              ),
              Skeleton(180, 20),
            ],
          ))
    ]);
  }
}
