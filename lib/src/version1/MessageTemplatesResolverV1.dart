import 'package:pip_clients_msgtemplates/pip_clients_msgtemplates.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

class MessageTemplatesResolverV1 implements IReferenceable, IReconfigurable {
  MessageTemplatesResolverV1([ConfigParams config, IReferences references]) {
    if (config != null) {
      configure(config);
    }
    if (references != null) {
      setReferences(references);
    }
  }

  IMessageTemplatesClientV1 client;
  ConfigParams _config = ConfigParams();
  final templates = <String, MessageTemplateV1>{};

  @override
  void configure(ConfigParams config) {
    _config = config.getSection('message_templates');
  }

  @override
  void setReferences(IReferences references) {
    client = references.getOneOptional<IMessageTemplatesClientV1>(
        Descriptor('pip-services-msgtemplates', 'client', '*', '*', '1.0'));
  }

  void put(String name, dynamic template) {
    _config[name] = template;
  }

  Future<MessageTemplateV1> _retrieveTemplate(
      String name, String templateName) async {
    if (client == null) {
      return null;
    }

    var template =
        await client.getTemplateByIdOrName('msg_resolve', templateName);
    if (template != null) {
      templates[name] = template;
    }

    return template;
  }

  MessageTemplateV1 _createTemplate(String name, ConfigParams config) {
    if (config == null || config.isEmpty) {
      return null;
    }

    var template = MessageTemplateV1(
        name: name,
        subject: MultiString({'en': config.getAsObject('subject')}),
        text: MultiString({'en': config.getAsObject('text')}),
        html: MultiString({'en': config.getAsObject('html')}));

    if (template.subject == null &&
        template.text == null &&
        template.html == null) {
      return null;
    }

    templates[name] = template;
    return template;
  }

  Future<MessageTemplateV1> resolve(String name) async {
    if (name == null) {
      throw AssertionError('Dependency name cannot be null');
    }

    // Retrieve template first

    var template = templates[name];
    if (template != null) {
      return template;
    }

    // Get configuration
    var config = _config.getSection(name);
    var templateName = _config.getAsNullableString(name) ??
        config.getAsNullableString('template');

    if (templateName != null) {
      return _retrieveTemplate(name, templateName);
    } else {
      return _createTemplate(name, config);
    }
  }

  static MessageTemplatesResolverV1 fromTuples(List tuples) {
    var result = MessageTemplatesResolverV1();

    if (tuples == null || tuples.isEmpty) {
      return result;
    }

    for (var index = 0; index < tuples.length; index += 2) {
      if (index + 1 >= tuples.length) break;

      var name = StringConverter.toString2(tuples[index]);
      var template = tuples[index + 1];

      result.put(name, template);
    }

    return result;
  }
}
