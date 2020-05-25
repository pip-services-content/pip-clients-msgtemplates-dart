# <img src="https://github.com/pip-services/pip-services/raw/master/design/Logo.png" alt="Pip.Services Logo" style="max-width:30%"> <br> MessageTemplates Microservice Client SDK for Dart

This is a Dart client SDK for [pip-services-msgtemplates](https://github.com/pip-services-content/pip-services-msgtemplates-dart) microservice.

## Download

Right now the only way to get the microservice is to check it out directly from github repository
```bash
git clone git@github.com:pip-services-content/pip-clients-msgtemplates-dart.git
```

Pip.Service team is working to implement packaging and make stable releases available for your 
as zip downloadable archieves.

## Contract

Logical contract of the microservice is presented below. For physical implementation (HTTP/REST),
please, refer to documentation of the specific protocol.

```dart
class MessageTemplateV1 implements IStringIdentifiable {  
  String id;  
  String name;
  String from;
  MultiString subject;
  MultiString text;
  MultiString html;
  String status;
}

class MessageTemplateStatusV1 {
  static final New = 'new';
  static final Writing = 'writing';
  static final Translating = 'translating';
  static final Verifying = 'verifying';
  static final Completed = 'completed';
}

abstract class IMessageTemplatesV1 {
  Future<DataPage<TemplateV1>> getTemplates(
      String correlationId, FilterParams filter, PagingParams paging);

  Future<TemplateV1> getTemplateById(String correlationId, String id);

  Future<TemplateV1> getTemplateByIdOrName(String correlationId, String idOrName);

  Future<TemplateV1> createTemplate(String correlationId, TemplateV1 msgtemplate);

  Future<TemplateV1> updateTemplate(String correlationId, TemplateV1 msgtemplate);

  Future<TemplateV1> deleteTemplateById(String correlationId, String msgtemplateId);
}
```

## Use

The easiest way to work with the microservice is to use client SDK. 

Define client configuration parameters that match the configuration of the microservice's external API
```dart
// Client configuration
var httpConfig = ConfigParams.fromTuples(
	"connection.protocol", "http",
	"connection.host", "localhost",
	"connection.port", 8080
);
```

Instantiate the client and open connection to the microservice
```dart
// Create the client instance
var client = TemplatesHttpClientV1(config);

// Configure the client
client.configure(httpConfig);

// Connect to the microservice
try{
  await client.open(null)
}catch() {
  // Error handling...
}       
// Work with the microservice
// ...
```

Now the client is ready to perform operations
```dart
// Create a new msgtemplate
final TEMPLATE = MessageTemplateV1(
    id: '1',
    name: 'template1',
    from: null,
    subject: MultiString({ 'en': 'Text 1' }),
    text: MultiString({ 'en': 'Text 1' }),
    html: MultiString({ 'en': 'Text 1' }),
    status: MessageTemplateStatusV1.Completed);

    // Create the msgtemplate
    try {
      var msgtemplate = await client.createTemplate('123', TEMPLATE);
      // Do something with the returned msgtemplate...
    } catch(err) {
      // Error handling...     
    }
```

```dart
// Get the msgtemplate
try {
var msgtemplate = await client.getTemplateByIdOrName(
    null,
    'template1');
    // Do something with msgtemplate...

    } catch(err) { // Error handling}
```

## Acknowledgements

This microservice was created and currently maintained by
- **Sergey Seroukhov**
- **Nuzhnykh Egor**.
