import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_msgtemplates/pip_clients_msgtemplates.dart';

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

class MessageTemplatesClientFixtureV1 {
  IMessageTemplatesClientV1 _client;

  MessageTemplatesClientFixtureV1(IMessageTemplatesClientV1 client) {
    expect(client, isNotNull);
    _client = client;
  }

  void testCrudOperations() async {
    MessageTemplateV1 msgtemplate1, msgtemplate2;

    // Create the first msgtemplate
    msgtemplate1 = await _client.createTemplate(null, TEMPLATE1);
    expect(TEMPLATE1.id, msgtemplate1.id);
    expect(TEMPLATE1.name, msgtemplate1.name);
    expect(TEMPLATE1.status, msgtemplate1.status);
    expect(TEMPLATE1.text.get('en'), msgtemplate1.text.get('en'));

    // Create the second msgtemplate
    msgtemplate2 = await _client.createTemplate(null, TEMPLATE2);
    expect(TEMPLATE2.id, msgtemplate2.id);
    expect(TEMPLATE2.name, msgtemplate2.name);
    expect(TEMPLATE2.status, msgtemplate2.status);
    expect(TEMPLATE2.text.get('en'), msgtemplate2.text.get('en'));

    // Get all msgtemplates
    var page = await _client.getTemplates(null, FilterParams(), PagingParams());
    expect(page, isNotNull);
    expect(page.data.length, 2);

    var msgtemplate =
        await _client.getTemplateByIdOrName(null, msgtemplate1.name);
    expect(msgtemplate, isNotNull);
    expect(msgtemplate1.id, msgtemplate.id);

    // Update the msgtemplate
    msgtemplate1.text = MultiString({'en': 'Updated Content 1'});

    msgtemplate = await _client.updateTemplate(null, msgtemplate1);
    expect(msgtemplate, isNotNull);
    expect(msgtemplate1.id, msgtemplate.id);
    expect('Updated Content 1', msgtemplate.text.get('en'));

    // Delete the msgtemplate
    msgtemplate = await _client.deleteTemplateById(null, msgtemplate1.id);
    expect(msgtemplate, isNotNull);
    expect(msgtemplate1.id, msgtemplate.id);

    // Try to get deleted msgtemplate
    msgtemplate = await _client.getTemplateById(null, msgtemplate1.id);
    expect(msgtemplate, isNull);
  }
}
