import 'package:app_edu/common/bloc/event_bus/event_bus_bloc.dart';
import 'package:app_edu/common/bloc/event_bus/event_bus_event.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:app_edu/common/bloc/loading_bloc/loading_event.dart';
import 'package:app_edu/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:app_edu/common/const/icon_constant.dart';
import 'package:app_edu/common/customs/scaffold_custom.dart';
import 'package:app_edu/common/local/app_cache.dart';
import 'package:app_edu/common/navigation/route_names.dart';
import 'package:app_edu/common/network/client.dart';
import 'package:app_edu/common/theme/theme_text.dart';
import 'package:app_edu/common/ultils/common_util.dart';
import 'package:app_edu/common/model/notification_model.dart';
import 'package:app_edu/feature/auth/widgets/custom_scaffold.dart';
import 'package:app_edu/feature/injector_container.dart';
import 'package:app_edu/feature/routes.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> _newsModel = [];

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      AppCache appCache = injector<AppCache>();
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>()
          .get('get-notis?api_token=${appCache.profileModel?.apiToken}');
      data['data'].forEach((e) {
        _newsModel.add(NotificationModel.fromJson(e));
      });
      injector<EventBusBloc>().add(EventBusRequestInitDataNotificationEvent(
          count:
              _newsModel.where((element) => !element.readed).toList().length));
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  void _makeRead(int? notiId) async {
    AppCache appCache = injector<AppCache>();
    injector<AppClient>().get(
        'set-notis-readed/${notiId}?api_token=${appCache.profileModel?.apiToken}');
    _newsModel.clear();
    final data = await injector<AppClient>()
        .get('get-notis?api_token=${appCache.profileModel?.apiToken}');
    data['data'].forEach((e) {
      _newsModel.add(NotificationModel.fromJson(e));
    });
    injector<EventBusBloc>().add(EventBusRequestInitDataNotificationEvent(
        count: _newsModel.where((element) => !element.readed).toList().length));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Thông báo',
              style: AppTextTheme.mediumBlack,
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.zero,
            children: _newsModel.map((e) => _item(e)).toList(),
          ))
        ],
      ),
    );
  }

  Widget _item(NotificationModel newsModel) {
    return InkWell(
      onTap: () {
        _makeRead(newsModel.id);
        Routes.instance
            .navigateTo(RouteName.WebViewScreen, arguments: newsModel.link);
      },
      child: Container(
        color: newsModel.readed == true
            ? Colors.transparent
            : Colors.grey.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(width: 12),
            newsModel.readed == true
                ? Image.asset(
                    IconConst.bellGrey,
                    width: 35,
                    height: 35,
                    color: Colors.grey,
                  )
                : Image.asset(
                    IconConst.bell,
                    width: 35,
                    height: 35,
                  ),
            SizedBox(width: 8),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${newsModel.name}',
                  style: AppTextTheme.normalBlack,
                ),
                Text(
                  '${newsModel.dateTimeText}',
                  style: AppTextTheme.smallGrey,
                )
              ],
            )),
            SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
