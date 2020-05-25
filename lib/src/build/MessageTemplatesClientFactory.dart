import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../version1/MessageTemplatesNullClientV1.dart';
import '../version1/MessageTemplatesDirectClientV1.dart';
import '../version1/MessageTemplatesHttpClientV1.dart';

class MessageTemplatesClientFactory extends Factory {
  static final NullClientDescriptor =
      Descriptor('pip-services-msgtemplates', 'client', 'null', '*', '1.0');
  static final DirectClientDescriptor =
      Descriptor('pip-services-msgtemplates', 'client', 'direct', '*', '1.0');
  static final HttpClientDescriptor =
      Descriptor('pip-services-msgtemplates', 'client', 'http', '*', '1.0');

  MessageTemplatesClientFactory() : super() {
    registerAsType(MessageTemplatesClientFactory.NullClientDescriptor,
        MessageTemplatesNullClientV1);
    registerAsType(MessageTemplatesClientFactory.DirectClientDescriptor,
        MessageTemplatesDirectClientV1);
    registerAsType(MessageTemplatesClientFactory.HttpClientDescriptor,
        MessageTemplatesHttpClientV1);
  }
}
