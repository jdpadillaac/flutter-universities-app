# Carga de datos

No hay page de carga. El texto de un `Failure` para la UI vive en `lib/features/universities/presentation/helpers/failure_message_resolver.dart`.

`UniversitiesRemoteDataSourceImpl` pide el cuerpo como texto a `ApiClient.get` con `ApiConfig.universitiesPath`. Base `https://tyba-assets.s3.amazonaws.com`. Timeouts de conexión, recepción y envío: 15 segundos.

`ApiClient` devuelve `Ok` con el cuerpo. Un cuerpo `null` es `ParsingFailure`. `DioException` es `NetworkFailure` con el mensaje del cliente, o `A network error occurred.` si no hay mensaje, y con el status code cuando la respuesta lo trae.

`UniversitiesJsonParser.parse` ejecuta el decode, el DTO y el mapeo dentro de `Isolate.run`. Si el JSON no es una lista, el resultado es `ParsingFailure` con mensaje `Expected a JSON list.`. Si un elemento no es un `Map`, el mensaje es `Expected a JSON object.`. `jsonDecode`, `fromJson` y `mapper.map` pasan por `Result<T, Object>.of` y el error se mapea a `ParsingFailure` con `error.toString()`.

`UniversityDto` mapea `alpha_two_code` a `countryCode`, `web_pages` a `webPages` y `state-province` a `stateProvince`.

`UniversityDtoMapper` decodifica el nombre con `HtmlEntityDecoder` y arma el id con `UniversityIdGenerator`: `slug(nombre)--slug(primer dominio)`. El slug pasa a minúsculas y sustituye cada tramo que no sea `[a-z0-9]` por `-`. Sin dominios, el segundo slug queda vacío. El decoder cubre `amp`, `lt`, `gt`, `quot`, `apos`, `nbsp` y las referencias decimales y hexadecimales. Una entidad desconocida se deja igual.

`UniversitiesRepositoryImpl` guarda la lista solo cuando el resultado es `Ok`. Un `Err` no se cachea; la siguiente llamada vuelve al data source.
