import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_msgtemplates/pip_clients_msgtemplates.dart';

void main() {
  group('MessageTemplatesResolverV1', () {
    MessageTemplatesResolverV1 resolver;

    setUp(() async {
      resolver = MessageTemplatesResolverV1();
    });

    test('Resolve hardcoded template', () async {
      resolver.configure(ConfigParams.fromTuples([
        'message_templates.template1.subject',
        'Subject1',
        'message_templates.template1.text',
        'Text1',
        'message_templates.template1.html',
        'Html1'
      ]));

      var template = await resolver.resolve('template1');
      expect(template, isNotNull);
      expect(template.subject.get('en'), 'Subject1');
      expect(template.text.get('en'), 'Text1');
      expect(template.html.get('en'), 'Html1');
    });

    test('Resolve missing template', () async {
      resolver.configure(ConfigParams.fromTuples([
        'message_templates.template1.subject',
        'Subject1',
        'message_templates.template1.text',
        'Text1',
        'message_templates.template1.html',
        'Html1'
      ]));

      var template = await resolver.resolve('template2');
      expect(template, isNull);
    });

    test('Resolve template by id', () async {
      resolver.configure(
          ConfigParams.fromTuples(['message_templates.template1', '123']));

      var template = await resolver.resolve('template2');
      expect(template, isNull);
    });
  });
}
