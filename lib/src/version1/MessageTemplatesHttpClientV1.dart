import 'dart:async';
import 'dart:convert';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_services_msgtemplates/pip_services_msgtemplates.dart';
import './IMessageTemplatesClientV1.dart';

class MessageTemplatesHttpClientV1 extends CommandableHttpClient
    implements IMessageTemplatesClientV1 {
  MessageTemplatesHttpClientV1([config]) : super('v1/message_templates') {
    if (config != null) {
      configure(ConfigParams.fromValue(config));
    }
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
    var result = await callCommand(
      'get_templates',
      correlationId,
      {'filter': filter, 'paging': paging},
    );
    return DataPage<MessageTemplateV1>.fromJson(json.decode(result), (item) {
      var template = MessageTemplateV1();
      template.fromJson(item);
      return template;
    });
  }

  /// Gets a template by its unique id.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [id]                an id of template to be retrieved.
  /// Return         Future that receives template or error.
  @override
  Future<MessageTemplateV1> getTemplateById(
      String correlationId, String id) async {
    var result = await callCommand(
        'get_template_by_id', correlationId, {'template_id': id});
    if (result == null) return null;
    var item = MessageTemplateV1();
    item.fromJson(json.decode(result));
    return item;
  }

  /// Gets a template by its unique id or name.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [idOrName]                an unique id or name of template to be retrieved.
  /// Return         Future that receives template or error.
  @override
  Future<MessageTemplateV1> getTemplateByIdOrName(
      String correlationId, String idOrName) async {
    var result = await callCommand(
        'get_template_by_id_or_name', correlationId, {'id_or_name': idOrName});
    if (result == null) return null;
    var item = MessageTemplateV1();
    item.fromJson(json.decode(result));
    return item;
  }

  /// Creates a template.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [template]              an template to be created.
  /// Return         (optional) Future that receives created template or error.
  @override
  Future<MessageTemplateV1> createTemplate(
      String correlationId, MessageTemplateV1 template) async {
    var result = await callCommand(
        'create_template', correlationId, {'template': template});
    if (result == null) return null;
    var item = MessageTemplateV1();
    item.fromJson(json.decode(result));
    return item;
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
    var result = await callCommand(
        'update_template', correlationId, {'template': template});
    if (result == null) return null;
    var item = MessageTemplateV1();
    item.fromJson(json.decode(result));
    return item;
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
    var result = await callCommand(
        'delete_template_by_id', correlationId, {'template_id': id});
    if (result == null) return null;
    var item = MessageTemplateV1();
    item.fromJson(json.decode(result));
    return item;
  }
}
