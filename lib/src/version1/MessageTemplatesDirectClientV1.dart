import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_services_msgtemplates/pip_services_msgtemplates.dart';
import './IMessageTemplatesClientV1.dart';

class MessageTemplatesDirectClientV1 extends DirectClient<dynamic>
    implements IMessageTemplatesClientV1 {
  MessageTemplatesDirectClientV1() : super() {
    dependencyResolver.put('controller',
        Descriptor('pip-services-msgtemplates', 'controller', '*', '*', '1.0'));
  }

  /// Gets a page of templates retrieved by a given filter.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [filter]            (optional) a filter function to filter items
  /// - [paging]            (optional) paging parameters
  /// Return         Future that receives a data page
  /// Throws error.
  @override
  Future<DataPage<MessageTemplateV1>> getTemplates(
      String correlationId, FilterParams filter, PagingParams paging) async {
    var timing = instrument(correlationId, 'message_templates.get_templates');
    var page = await controller.getTemplates(correlationId, filter, paging);
    timing.endTiming();
    return page;
  }

  /// Gets a template by its unique id.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [id]                an id of template to be retrieved.
  /// Return         Future that receives template or error.
  @override
  Future<MessageTemplateV1> getTemplateById(
      String correlationId, String id) async {
    var timing =
        instrument(correlationId, 'message_templates.get_template_by_id');
    var template = await controller.getTemplateById(correlationId, id);
    timing.endTiming();
    return template;
  }

  /// Gets a template by its unique id or name.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [idOrName]                an unique id or name of template to be retrieved.
  /// Return         Future that receives template or error.
  @override
  Future<MessageTemplateV1> getTemplateByIdOrName(
      String correlationId, String idOrName) async {
    var timing = instrument(
        correlationId, 'message_templates.get_template_by_id_or_name');
    var template =
        await controller.getTemplateByIdOrName(correlationId, idOrName);
    timing.endTiming();
    return template;
  }

  /// Creates a template.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [template]              an template to be created.
  /// Return         (optional) Future that receives created template or error.
  @override
  Future<MessageTemplateV1> createTemplate(
      String correlationId, MessageTemplateV1 template) async {
    var timing = instrument(correlationId, 'message_templates.create_template');
    var result = await controller.createTemplate(correlationId, template);
    timing.endTiming();
    return result;
  }

  /// Updates a template.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [template]              an template to be updated.
  /// Return         (optional) Future that receives updated template
  /// Throws error.
  @override
  Future<MessageTemplateV1> updateTemplate(
      String correlationId, MessageTemplateV1 template) async {
    var timing = instrument(correlationId, 'message_templates.update_template');
    var result = await controller.updateTemplate(correlationId, template);
    timing.endTiming();
    return result;
  }

  /// Deleted a template by it's unique id.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [id]                an id of the template to be deleted
  /// Return                Future that receives deleted template
  /// Throws error.
  @override
  Future<MessageTemplateV1> deleteTemplateById(
      String correlationId, String id) async {
    var timing =
        instrument(correlationId, 'message_templates.delete_template_by_id');
    var template = await controller.deleteTemplateById(correlationId, id);
    timing.endTiming();
    return template;
  }
}
