# Carga de datos

Esta feature no tiene archivos en `presentation/`. El texto de un `Failure` para la UI vive en `lib/features/universities/presentation/helpers/failure_message_resolver.dart`.

`UniversitiesRemoteDataSourceImpl` pide el cuerpo como texto a `ApiClient.get` con `ApiConfig.universitiesPath`.

`ApiClient` devuelve `Ok` con el cuerpo. Un cuerpo `null` es `ParsingFailure`. `DioException` es `NetworkFailure` con el mensaje del cliente, o `A network error occurred.` si no hay mensaje, y con el status code cuando la respuesta lo trae.

`UniversitiesJsonParser.parse` ejecuta el decode, el DTO y el mapeo dentro de `Isolate.run`. Si el JSON no es una lista, el resultado es `ParsingFailure` con mensaje `Expected a JSON list.`. Si un elemento no es un objeto, el mensaje es `Expected a JSON object.`. `jsonDecode` y `fromJson` pasan por `Result<T, Object>.of` y el error se mapea a `ParsingFailure`.

`UniversityDtoMapper` decodifica el nombre con `HtmlEntityDecoder` y arma el id con `UniversityIdGenerator`: `slug(nombre)--slug(primer dominio)`. Sin dominios, el segundo slug queda vacío. El decoder cubre `amp`, `lt`, `gt`, `quot`, `apos`, `nbsp` y las referencias decimales y hexadecimales. Una entidad desconocida se deja igual.

`UniversitiesRepositoryImpl` guarda la lista solo cuando el resultado es `Ok`. Un `Err` no se cachea; la siguiente llamada vuelve al data source.
