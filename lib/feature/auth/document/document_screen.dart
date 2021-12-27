import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/feature/auth/widgets/custom_scaffold.dart';
import 'package:app_edu/feature/routes.dart';
import 'package:flutter/material.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Tài liệu',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomImageNetwork(
            //   url: images[1],
            //   height: 232,
            //   width: double.infinity,
            // ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Tài liệu khi sử dụng hệ thống',
                style: AppTextTheme.mediumBlack,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                  '''It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).'''),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  Text(
                    'Danh sách các tài liệu',
                    style: AppTextTheme.mediumBlack,
                  ),
                  _item('Bài 1. Tài Liệu về Auto Card'),
                  _item('Bài 2. Tài Liệu về Photoshop'),
                  _item('Bài 3. Tài Liệu về Hoá trị'),
                  _item('Bài 4. Tài Liệu về Lập trình C'),
                  _item('Bài 5. Tài Liệu về Photoshop'),
                  const SizedBox(height:20),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _item(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(text)),
          Image.asset(
            IconConst.download,
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }
}
