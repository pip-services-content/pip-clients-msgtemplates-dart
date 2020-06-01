import 'package:pip_clients_msgtemplates/pip_clients_msgtemplates.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services_msgtemplates/pip_services_msgtemplates.dart';

Future<void> main(List<String> argument) async {
  try {
    var correlationId = '123';
    var config = ConfigParams.fromTuples([
      'connection.type',
      'http',
      'connection.host',
      'localhost',
      'connection.port',
      8080
    ]);
    var client = MessageTemplatesHttpClientV1();
    client.configure(config);
    final TEMPLATE1 = MessageTemplateV1(
        id: '1',
        name: 'template1',
        from: null,
        subject: MultiString({'en': 'Text 1'}),
        text: MultiString({'en': 'Text 1'}),
        html: MultiString({'en': 'Text 1'}),
        status: MessageTemplateStatusV1.Completed);
    final TEMPLATE2 = MessageTemplateV1(
        id: '2',
        name: 'template2',
        from: null,
        subject: MultiString({'en': 'Text 2'}),
        text: MultiString({'en': 'Text 2'}),
        html: MultiString({'en': 'Text 2'}),
        status: MessageTemplateStatusV1.Completed);
    await client.open(correlationId);
    // Create 2 templates
    await client.createTemplate(correlationId, TEMPLATE1);
    await client.createTemplate(correlationId, TEMPLATE2);
    var page = await client.getTemplates(null, null, null);
    if (page.data.length == 2) {
      print('Get templates length: ' +
          page.data.length.toString() +
          '! Everything works well!');
    } else {
      print('Get templates length: ' +
          page.data.length.toString() +
          ' is not equal! Something was wrong!');
    }
    // Delete all templates
    await client.deleteTemplateById(correlationId, '1');
    await client.deleteTemplateById(correlationId, '2');
    await client.close(correlationId);
  } catch (ex) {
    print(ex);
  }
}
