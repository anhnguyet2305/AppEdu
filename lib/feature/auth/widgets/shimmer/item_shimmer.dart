import 'package:app_edu/common/theme/theme_color.dart';
import 'package:flutter/material.dart';

class ItemShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 146.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColors.white,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: AppColors.white,
                    height: 20.0,
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    width: double.infinity,
                    color: AppColors.white,
                    height: 20.0,
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: double.infinity,
                    color: AppColors.white,
                    height: 15.0,
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: AppColors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
