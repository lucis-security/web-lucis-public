0:{"page:/blog/nos-salteamos-la-suscripcion-paga-de-una-startup-de-eventos":"$L1","layout:/":"$L2","route:/blog/nos-salteamos-la-suscripcion-paga-de-una-startup-de-eventos":"$L3","__route":"route:/blog/nos-salteamos-la-suscripcion-paga-de-una-startup-de-eventos","__interceptionContext":null,"__layoutIds":["layout:/"],"__rootLayout":"/","__bfcacheSegmentIdentities":{"layout:/":"[\"layout\",\"layout:/\",\"root-boundary:/\",\"\"]","page:/blog/nos-salteamos-la-suscripcion-paga-de-una-startup-de-eventos":"[\"page\",\"page:/blog/:slug\",\"root-boundary:/\",\"[\\\"blog\\\",\\\"slug|nos-salteamos-la-suscripcion-paga-de-una-startup-de-eventos|d\\\"]\"]"},"__srcPage":["blog","[slug]","page"],"__layoutFlags":{"layout:/":"s"},"__artifactCompatibility":{"schemaVersion":1,"graphVersion":"app-route-graph:1dc2cad8b8c78a84","deploymentVersion":"00b29bbe-9b3c-438d-964f-ed0c972f19c3","appElementsSchemaVersion":1,"rscPayloadSchemaVersion":1,"rootBoundaryId":"/","renderEpoch":null}}
4:I["4b74a4ed29a1",[],"LanguageProvider",1]
5:I["8c0f216c4604",[],"Children",1]
6:I["593f344dc510",[],"GlobalErrorBoundary",1]
7:I["0b874ad30386",[],"default",1]
8:I["593f344dc510",[],"ErrorBoundary",1]
9:I["15c18cfaeeff",[],"LayoutSegmentProvider",1]
a:I["8c0f216c4604",[],"Slot",1]
b:I["593f344dc510",[],"NotFoundBoundary",1]
c:I["9276801271d6",[],"AppRouterScrollTarget",1]
d:I["593f344dc510",[],"RedirectBoundary",1]
:HL["/_next/static/css/index.0qvNW788.css","style"     ]
2:[[["$","link","css:/_next/static/css/index.0qvNW788.css",{"rel":"stylesheet","precedence":"vite-rsc/importer-resources","href":"/_next/static/css/index.0qvNW788.css","data-rsc-css-href":"/_next/static/css/index.0qvNW788.css"}],"$undefined"],["$","html",null,{"lang":"en","children":["$","body",null,{"children":["$","$L4",null,{"children":["$","$L5",null,{}]}]}]}]]
3:[[["$","meta",null,{"charSet":"utf-8"}],[["$","title","0",{"children":"We skipped a startup's paid subscription by changing one field in Supabase / Lucis"}],["$","meta","1",{"name":"description","content":"During an authorized pentest we found an authorization flaw: a regular account could change the attribute that defined its privileges and reach internal functions."}],["$","link","2",{"data-vinext-streamed-icon":"$undefined","rel":"shortcut icon","href":"/favicon.svg","type":"$undefined","sizes":"$undefined","color":"$undefined","media":"$undefined","fetchPriority":"$undefined"}],["$","link","3",{"data-vinext-streamed-icon":"$undefined","rel":"icon","href":"/favicon.svg","type":"image/svg+xml","sizes":"$undefined","color":"$undefined","media":"$undefined","fetchPriority":"$undefined"}]],[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}]]],["$","$L6",null,{"fallback":"$7","children":["$","$L8",null,{"fallback":"$7","children":["$","$L9",null,{"providerId":"layout:/","segmentMap":{"children":["blog","nos-salteamos-la-suscripcion-paga-de-una-startup-de-eventos"]},"children":["$","$La",null,{"id":"layout:/","parallelSlots":"$undefined","children":["$","$Lb",null,{"resetKey":"blog","fallback":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":404}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"children":["$","$Lc",null,{"children":["$","$Ld",null,{"children":[["$","$L9",null,{"providerId":"page:/blog/nos-salteamos-la-suscripcion-paga-de-una-startup-de-eventos","segmentMap":{"children":["__PAGE__"]},"children":["$","$La",null,{"id":"page:/blog/nos-salteamos-la-suscripcion-paga-de-una-startup-de-eventos"}]}],null]}]}]}]}]}]}]}],null,null]
e:I["9fb86276be8f",[],"default",1]
f:I["71cc61263ac9",[],"default",1]
10:T2b5c,<blockquote><strong>The short version:</strong> an RLS policy can stop a user from editing someone else’s row and still allow them to change sensitive columns in their own profile. In this case, a regular account could change the attribute that defined its privileges because authorization controlled the row, but not the editable columns.</blockquote>
<h2>The context</h2>
<p>During an authorized pentest, we reviewed a ticketing platform built with Next.js and Supabase. The goal was to understand what a regular account could do, what data was exposed and which internal operations could be called from the client.</p>
<p>We were not trying to “break” the platform. We wanted clear answers:</p>
<p><em> What can an authenticated account see outside its organization? </em> Which operations does the browser’s API actually allow? * Can a user change data the system treats as trusted?</p>
<p>The most important answer appeared in the last question.</p>
<h2>We started with the browser</h2>
<p>We used the application like any other person: registration, sign in, profile and ticket related flows. We reviewed requests, routes, edit parameters and the JavaScript delivered to the browser.</p>
<p>That revealed part of the architecture: Next.js on the frontend and Supabase for authentication, the database and part of the backend logic. The browser used Auth endpoints and the REST API that Supabase generates over PostgreSQL through PostgREST.</p>
<p>The public JavaScript included the project URL and the client’s <code>anon</code> key:</p>
<pre><code>createClient(
  &quot;https://&lt;PROJECT&gt;.supabase.co&quot;,
  &quot;&lt;ANON_KEY&gt;&quot;
)</code></pre>
<p>That was not a vulnerability by itself. A project URL and a public key can be part of a normal integration. Security depended on something else: Row Level Security policies, PostgreSQL permissions, the columns each role could edit and the execution permissions of RPC functions.</p>
<p>So we stopped looking only at the interface and started understanding the API.</p>
<h2>The API told us more than it seemed to</h2>
<p>PostgREST responded differently when we queried a missing table, a valid table with no visible rows or a table with accessible information. The test was controlled, with anonymized names and no enumeration of real data:</p>
<pre><code>GET /rest/v1/&lt;CANDIDATE_TABLE&gt;?select=*
apikey: &lt;ANON_KEY&gt;</code></pre>
<p>In general, we could distinguish between:</p>
<pre><code>404 / PGRST205  -&gt; table missing or not exposed
200 []          -&gt; valid table with no visible rows
200 [{...}]     -&gt; valid table with accessible information</code></pre>
<p>We could also test column names in a bounded way. When a column did not exist, some errors suggested similar names. Step by step, we built a partial map of the application without administrative access.</p>
<p>We will not publish the real table, column or entity names. To explain the issue, it is enough to know that we identified objects related to accounts, listings, ticket types and internal operations. One of those resources exposed commercial information without authentication.</p>
<h2>Then the internal functions appeared</h2>
<p>Supabase also exposes PostgreSQL functions through PostgREST RPC routes:</p>
<pre><code>POST /rest/v1/rpc/&lt;FUNCTION_NAME&gt;</code></pre>
<p>We tested names found in the frontend and others related to the behavior we had observed. But an error such as <code>PGRST202</code> does not prove that a function is vulnerable. It may mean that the function does not exist, expects different parameters or has another signature.</p>
<p>We only treated a function as vulnerable when we could execute it with valid data and receive a real response.</p>
<p>One function returned operational information without requiring a signed in user. The simplified and anonymized request looked like this:</p>
<pre><code>POST /rest/v1/rpc/&lt;INTERNAL_FUNCTION&gt;
apikey: &lt;ANON_KEY&gt;
Content-Type: application/json

{
  &quot;identifiers&quot;: [&quot;&lt;TEST_ID&gt;&quot;]
}</code></pre>
<p>Without an <code>Authorization</code> header, we received HTTP 200 with structured commercial information. Negative controls using an empty list and a nonexistent UUID returned empty responses. The problem was that the <code>anon</code> role could execute a function that did not need to be available to visitors:</p>
<pre><code>GRANT EXECUTE
ON FUNCTION &lt;INTERNAL_FUNCTION&gt;(...)
TO anon;</code></pre>
<h2>Another function could generate internal values</h2>
<p>We also found an RPC function that generated codes used by the platform. We called it several times, always within the authorized scope and with test values.</p>
<p>The result was consistent:</p>
<p><em> every response succeeded; </em> each execution returned a different value; <em> signing in was not required; </em> we saw no limits during the bounded test.</p>
<p>That showed that an anonymous user could invoke the generator. It did not show that those values could be used to obtain a benefit or complete another operation. Proving that would have required validating another flow.</p>
<p>That distinction matters. We have to separate what appears possible from what we can actually demonstrate.</p>
<h2>The most serious issue was in the profile</h2>
<p>We then created a test account through Supabase Auth and compared what a visitor could do with what an authenticated user could do.</p>
<p>The configuration issued a valid session without requiring prior email confirmation. The registration endpoint also responded differently when an email already existed, which allowed account enumeration. We reported that as an additional weakness, but it was not the main path to privilege escalation.</p>
<p>First, we tried to read other users’ profiles. We could not. Each user could only query their own record. That control worked correctly.</p>
<p>We then changed normal fields in our own profile. That also behaved as expected. So we added an internal attribute related to the account’s access level to the same update request.</p>
<p>The anonymized example was equivalent to:</p>
<pre><code>PATCH /rest/v1/&lt;PROFILE_TABLE&gt;?id=eq.&lt;OUR_UID&gt;
apikey: &lt;ANON_KEY&gt;
Authorization: Bearer &lt;TEST_TOKEN&gt;
Content-Type: application/json

{
  &quot;&lt;INTERNAL_ATTRIBUTE&gt;&quot;: &quot;&lt;PRIVILEGED_STATE&gt;&quot;
}</code></pre>
<p>The API returned <code>HTTP 204 No Content</code>. A successful response was not enough: a later validation, trigger or background process could still revert the value.</p>
<p>We queried our profile again with an authenticated GET and requested only the internal attribute we had changed. The change was still there.</p>
<p>A regular account had just obtained a privileged state by editing its own record.</p>
<h2>What had failed</h2>
<p>The RLS policy controlled which row each user could edit, but not which columns they could change inside that row. The logic was similar to this:</p>
<pre><code>CREATE POLICY &quot;user_updates_own_profile&quot;
ON &lt;PROFILE_TABLE&gt;
FOR UPDATE
USING (auth.uid() = id);</code></pre>
<p>The profile mixed two kinds of information:</p>
<p><em> data owned by the user and meant to be editable; </em> internal attributes that defined permissions or sensitive states.</p>
<p>The policy stopped one person from changing another person’s profile. But once the change to their own row was authorized, the API also accepted attributes that only the system should control.</p>
<p>This was not an authentication bypass. The user had signed in correctly.</p>
<p>It was an authorization flaw.</p>
<h2>We also demonstrated what was not vulnerable</h2>
<p>We tested other attributes to understand the boundary. Some changes persisted. Others were accepted initially but showed their previous value when we queried the profile again. That suggested a second layer of protection for some properties, although it was not applied consistently.</p>
<p>We also tried to modify other users’ records and could not confirm that it was possible.</p>
<p>The demonstrated scope was:</p>
<p><em> privilege escalation on the test account: confirmed; </em> persistence of the privileged state: confirmed; <em> modification of other accounts: not confirmed; </em> downstream impact: validated only as far as the agreed scope allowed; * test account: restored to its original state.</p>
<p>Not everything we tested was vulnerable. The application had controls that worked: restrictions on other users’ data, server side validation, protection for sensitive operations, sign in limits and controls around files and redirects.</p>
<p>A pentest is not about collecting strange responses and calling them vulnerabilities. It is about showing what an attacker can actually do and, with the same clarity, what we could not do.</p>
<h2>How to fix it</h2>
<p>Hiding the attribute in the frontend does not help. Anyone can manually change a request sent from their browser.</p>
<p>User editable data must be separated from attributes that define permissions, roles or internal states. The API should accept an explicit list of allowed fields and reject anything else.</p>
<p>In PostgreSQL, permissions on the sensitive column can also be revoked while <code>UPDATE</code> is granted only for editable columns:</p>
<pre><code>REVOKE UPDATE (&lt;INTERNAL_ATTRIBUTE&gt;)
ON &lt;PROFILE_TABLE&gt;
FROM authenticated;

GRANT UPDATE (&lt;EDITABLE_FIELDS&gt;)
ON &lt;PROFILE_TABLE&gt;
TO authenticated;</code></pre>
<p>Privilege changes should go through a separate operation that:</p>
<p><em> requires authentication; </em> verifies that the caller has permission; <em> validates that the transition is legitimate; </em> records the operation; * raises alerts when appropriate.</p>
<p>Internal RPC functions should not be executable by roles that do not need them:</p>
<pre><code>REVOKE EXECUTE
ON FUNCTION &lt;INTERNAL_FUNCTION&gt;(...)
FROM anon, authenticated;</code></pre>
<p>Each function has to be reviewed individually, both for its permissions and for the information it returns and the effects it produces.</p>
<h2>What this pentest left us with</h2>
<p>The chain started by looking at browser requests, continued by understanding how the API responded and ended by changing the authorization logic of an account.</p>
<p>We did not need to break Next.js, Supabase, PostgREST or PostgreSQL. The system behaved according to the permissions that had been configured. The problem was that those permissions did not correctly represent the business rules.</p>
<p>It can all be reduced to one question:</p>
<blockquote>If a user can update their own profile, can they also change the attribute that defines their privileges?</blockquote>
<p>In this case, the answer was yes.</p>
<p>When a person can decide their own privileges, login can keep working perfectly while authorization is compromised.</p>
<p>The fix was not another visual layer. It was making the boundary explicit: what the user can edit, what the system controls and what evidence remains when someone tries to cross it.</p>1:["$","main",null,{"className":"blogPage articlePage","children":[["$","header",null,{"className":"blogNav shell","children":[["$","a",null,{"href":"/","className":"blogBrand","aria-label":"Volver a Lucis","children":["$","$Le",null,{"src":"/brand/lucis-logo.svg","alt":"Lucis","width":782,"height":271,"priority":true}]}],["$","div",null,{"className":"blogNavActions","children":[["$","a",null,{"className":"blogBack","href":"/blog","children":[["$","span",null,{"className":"blogCopyEn","children":"All notes"}],["$","span",null,{"className":"blogCopyEs","children":"Todas las notas"}]]}],["$","$Lf",null,{}]]}]]}],["$","article",null,{"className":"article","children":["$","div",null,{"className":"shell articleShell","children":[["$","section",null,{"className":"articleLocale blogCopyEn","lang":"en","children":[["$","div",null,{"className":"articleMeta","children":[["$","span",null,{"children":"Pentesting"}],["$","time",null,{"dateTime":"2026-08-26","children":"2026-08-26"}],["$","span",null,{"children":"12 min read"}]]}],["$","h1",null,{"children":"We skipped a startup's paid subscription by changing one field in Supabase"}],["$","p",null,{"className":"articleDeck","children":"During an authorized pentest we found an authorization flaw: a regular account could change the attribute that defined its privileges and reach internal functions."}],["$","div",null,{"className":"articleByline","children":["Lucis team"," · Lucis"]}],["$","div",null,{"className":"articleBody","dangerouslySetInnerHTML":{"__html":"$10"}}]]}],"$L11"]}]}],"$L12"]}]
13:T2ef9,<blockquote><strong>Respuesta breve:</strong> una política RLS puede impedir que un usuario edite filas ajenas y, aun así, permitir que modifique columnas sensibles de su propio perfil. En este caso, una cuenta común podía cambiar el atributo que definía sus privilegios porque la autorización controlaba la fila, pero no las columnas editables.</blockquote>
<h2>El contexto</h2>
<p>Durante un pentest autorizado revisamos una plataforma de venta de entradas desarrollada con Next.js y Supabase. El objetivo era entender qué podía hacer una cuenta común, qué datos quedaban expuestos y qué operaciones internas podían invocarse desde el cliente.</p>
<p>No buscábamos “romper” la plataforma. Queríamos responder preguntas concretas:</p>
<p><em> ¿Qué puede ver una cuenta autenticada fuera de su organización? </em> ¿Qué operaciones permite realmente la API que usa el navegador? * ¿Puede un usuario modificar datos que el sistema trata como confiables?</p>
<p>La respuesta más importante apareció en el último punto.</p>
<h2>Empezamos por el navegador</h2>
<p>Usamos la aplicación como cualquier otra persona: registro, inicio de sesión, perfil y recorridos relacionados con entradas. Revisamos las solicitudes, las rutas, los parámetros de edición y el JavaScript que llegaba al navegador.</p>
<p>Así pudimos entender parte de la arquitectura: Next.js en el frontend y Supabase para autenticación, base de datos y parte de la lógica backend. Desde el navegador se utilizaban los endpoints de Auth y la API REST que Supabase genera sobre PostgreSQL mediante PostgREST.</p>
<p>En el JavaScript público aparecían la URL del proyecto y la clave <code>anon</code> del cliente:</p>
<pre><code>createClient(
  &quot;https://&lt;PROYECTO&gt;.supabase.co&quot;,
  &quot;&lt;ANON_KEY&gt;&quot;
)</code></pre>
<p>Eso, por sí solo, no era una vulnerabilidad. Una URL de proyecto y una clave pública pueden formar parte de una integración normal. La seguridad dependía de otra cosa: las políticas Row Level Security (RLS), los permisos de PostgreSQL, las columnas editables por rol y los permisos de ejecución de las funciones RPC.</p>
<p>Por eso dejamos de mirar solo la interfaz y empezamos a entender la API.</p>
<h2>La API contaba más de lo que parecía</h2>
<p>PostgREST respondía de forma diferente cuando consultábamos una tabla inexistente, una tabla válida sin filas visibles o una tabla con información accesible. La prueba se hizo de forma controlada, con nombres anonimizados y sin enumerar datos reales:</p>
<pre><code>GET /rest/v1/&lt;TABLA_CANDIDATA&gt;?select=*
apikey: &lt;ANON_KEY&gt;</code></pre>
<p>En términos generales, podíamos distinguir entre:</p>
<pre><code>404 / PGRST205  -&gt; tabla inexistente o no expuesta
200 []          -&gt; tabla válida sin filas visibles
200 [{...}]     -&gt; tabla válida con información accesible</code></pre>
<p>También podíamos probar nombres de columnas de forma acotada. Cuando una columna no existía, algunos errores sugerían nombres similares. Poco a poco armamos un mapa parcial de la aplicación sin acceso administrativo.</p>
<p>No publicamos los nombres reales de tablas, columnas ni entidades. Para explicar el problema alcanza con saber que identificamos objetos relacionados con cuentas, publicaciones, tipos de entradas y operaciones internas. Uno de esos recursos exponía información comercial sin autenticación.</p>
<h2>Después aparecieron las funciones internas</h2>
<p>Supabase también expone funciones de PostgreSQL mediante rutas RPC de PostgREST:</p>
<pre><code>POST /rest/v1/rpc/&lt;NOMBRE_DE_FUNCION&gt;</code></pre>
<p>Probamos nombres obtenidos del frontend y otros relacionados con el comportamiento observado. Pero recibir un error como <code>PGRST202</code> no demuestra que una función sea vulnerable: puede significar que no existe, que espera otros parámetros o que tiene otra firma.</p>
<p>Solo consideramos vulnerable una función cuando pudimos ejecutarla con datos válidos y obtuvimos una respuesta real.</p>
<p>Una función devolvía información operativa sin que el usuario hubiera iniciado sesión. La request, simplificada y anonimizada, era parecida a esta:</p>
<pre><code>POST /rest/v1/rpc/&lt;FUNCION_INTERNA&gt;
apikey: &lt;ANON_KEY&gt;
Content-Type: application/json

{
  &quot;identificadores&quot;: [&quot;&lt;ID_DE_PRUEBA&gt;&quot;]
}</code></pre>
<p>Sin enviar un header <code>Authorization</code>, recibimos un HTTP 200 con información comercial estructurada. Hicimos controles negativos con una lista vacía y con un UUID inexistente; ambos devolvían respuestas vacías. El problema era que el rol <code>anon</code> tenía permiso para ejecutar una función que no necesitaba estar disponible para visitantes:</p>
<pre><code>GRANT EXECUTE
ON FUNCTION &lt;FUNCION_INTERNA&gt;(...)
TO anon;</code></pre>
<h2>Otra función podía generar valores internos</h2>
<p>Encontramos además una función RPC que generaba códigos utilizados por la plataforma. La ejecutamos varias veces, siempre dentro del alcance autorizado y con valores de prueba.</p>
<p>El resultado fue consistente:</p>
<p><em> las respuestas fueron exitosas; </em> cada ejecución devolvió un valor diferente; <em> no fue necesario iniciar sesión; </em> no observamos límites durante la prueba acotada.</p>
<p>Eso demostraba que un usuario anónimo podía invocar el generador. No demostraba, en cambio, que esos valores pudieran utilizarse para obtener un beneficio o completar otra operación. Para afirmar eso habríamos tenido que validar un flujo adicional.</p>
<p>Esa diferencia importa: hay que separar lo que parece posible de lo que realmente se pudo demostrar.</p>
<h2>El problema más grave estaba en el perfil</h2>
<p>Después creamos una cuenta de prueba mediante Supabase Auth y comparamos lo que podía hacer un visitante con lo que podía hacer un usuario autenticado.</p>
<p>La configuración entregaba una sesión válida sin exigir la confirmación previa del correo. Además, el endpoint de registro respondía de manera diferente cuando el correo ya existía, lo que permitía enumerar cuentas. Lo reportamos como una debilidad adicional, pero no era el camino principal hacia la escalada.</p>
<p>Primero intentamos leer perfiles ajenos. No pudimos: cada usuario solo podía consultar su propio registro. Ese control funcionaba correctamente.</p>
<p>Después modificamos datos normales de nuestro perfil. También funcionó como esperaba la aplicación. Entonces agregamos a la misma petición un atributo interno relacionado con el nivel de acceso de la cuenta.</p>
<p>El ejemplo anonimizado era equivalente a:</p>
<pre><code>PATCH /rest/v1/&lt;TABLA_DE_PERFILES&gt;?id=eq.&lt;NUESTRO_UID&gt;
apikey: &lt;ANON_KEY&gt;
Authorization: Bearer &lt;TOKEN_DE_PRUEBA&gt;
Content-Type: application/json

{
  &quot;&lt;ATRIBUTO_INTERNO&gt;&quot;: &quot;&lt;ESTADO_PRIVILEGIADO&gt;&quot;
}</code></pre>
<p>La API respondió <code>HTTP 204 No Content</code>. Pero una respuesta exitosa no era suficiente: podía existir una validación posterior, un trigger o un proceso que revirtiera el valor.</p>
<p>Volvimos a consultar nuestro perfil con un GET autenticado y pedimos únicamente el atributo interno que habíamos modificado. El cambio seguía ahí.</p>
<p>Una cuenta común acababa de obtener un estado privilegiado modificando directamente su propio registro.</p>
<h2>Qué había fallado</h2>
<p>La política RLS controlaba qué fila podía editar cada usuario, pero no qué columnas podía modificar dentro de esa fila. La lógica era parecida a esta:</p>
<pre><code>CREATE POLICY &quot;usuario_actualiza_su_perfil&quot;
ON &lt;TABLA_DE_PERFILES&gt;
FOR UPDATE
USING (auth.uid() = id);</code></pre>
<p>El perfil mezclaba dos tipos de información:</p>
<p><em> datos que pertenecían al usuario y debían ser editables; </em> atributos internos que definían permisos o estados sensibles.</p>
<p>La política evitaba que una persona modificara el perfil de otra. Pero, una vez autorizado el cambio sobre su propio registro, la API aceptaba también atributos que solo debía controlar el sistema.</p>
<p>No era un bypass de autenticación. El usuario había iniciado sesión correctamente.</p>
<p>Era un fallo de autorización.</p>
<h2>También demostramos qué no era vulnerable</h2>
<p>Probamos otros atributos para entender hasta dónde llegaba el problema. Algunos cambios persistieron. Otros fueron aceptados inicialmente, pero al volver a consultar el perfil conservaban el valor anterior. Eso sugería una segunda capa de protección para ciertas propiedades, aunque no se aplicaba de forma consistente.</p>
<p>También intentamos modificar registros ajenos y no pudimos confirmar que fuera posible.</p>
<p>El alcance demostrado quedó así:</p>
<p><em> escalada de privilegios sobre la propia cuenta: confirmada; </em> persistencia del estado privilegiado: confirmada; <em> modificación de cuentas ajenas: no confirmada; </em> impacto posterior: validado únicamente hasta donde permitía el alcance acordado; * cuenta de prueba: restaurada a su estado original.</p>
<p>No todo lo que probamos era vulnerable. La aplicación tenía controles que funcionaban: restricciones sobre datos de otros usuarios, validaciones del lado del servidor, protección de operaciones sensibles, límites en el inicio de sesión y controles sobre archivos y redirecciones.</p>
<p>Un pentest no consiste en juntar respuestas raras y llamarlas vulnerabilidades. Consiste en demostrar qué puede hacer realmente un atacante y, con la misma claridad, qué no pudimos hacer.</p>
<h2>Cómo se corrige</h2>
<p>Ocultar el atributo en el frontend no sirve. Cualquier persona puede modificar manualmente una request enviada desde su navegador.</p>
<p>Los datos editables por el usuario tienen que estar separados de los atributos que definen permisos, roles o estados internos. La API debería aceptar una lista explícita de campos permitidos y rechazar cualquier otro.</p>
<p>En PostgreSQL también se pueden revocar los permisos sobre la columna sensible y conceder <code>UPDATE</code> únicamente sobre las columnas editables:</p>
<pre><code>REVOKE UPDATE (&lt;ATRIBUTO_INTERNO&gt;)
ON &lt;TABLA_DE_PERFILES&gt;
FROM authenticated;

GRANT UPDATE (&lt;CAMPOS_EDITABLES&gt;)
ON &lt;TABLA_DE_PERFILES&gt;
TO authenticated;</code></pre>
<p>Los cambios de privilegios deberían pasar por una operación separada que:</p>
<p><em> exija autenticación; </em> verifique que quien realiza el cambio tenga permisos; <em> valide que la transición sea legítima; </em> registre la operación; * genere alertas cuando corresponda.</p>
<p>Las funciones RPC internas tampoco deberían poder ejecutarse por roles que no las necesitan:</p>
<pre><code>REVOKE EXECUTE
ON FUNCTION &lt;FUNCION_INTERNA&gt;(...)
FROM anon, authenticated;</code></pre>
<p>Cada función tiene que revisarse individualmente, tanto por sus permisos como por la información que devuelve y los efectos que produce.</p>
<h2>Lo que nos dejó este pentest</h2>
<p>La cadena empezó mirando requests desde el navegador, siguió entendiendo cómo respondía la API y terminó modificando la lógica de autorización de una cuenta.</p>
<p>No hizo falta romper Next.js, Supabase, PostgREST ni PostgreSQL. El sistema funcionaba de acuerdo con los permisos configurados; el problema era que esos permisos no representaban correctamente las reglas del negocio.</p>
<p>Todo se puede resumir en una pregunta:</p>
<blockquote>Si un usuario puede actualizar su propio perfil, ¿también puede modificar el atributo que define sus privilegios?</blockquote>
<p>En este caso, la respuesta era sí.</p>
<p>Cuando una persona puede decidir sus propios privilegios, el login puede seguir funcionando perfectamente mientras la autorización queda comprometida.</p>
<p>La solución no fue agregar otra capa visual. Fue hacer explícita la frontera: qué puede editar el usuario, qué controla el sistema y qué evidencia queda cuando alguien intenta cruzarla.</p>11:["$","section",null,{"className":"articleLocale blogCopyEs","lang":"es","children":[["$","div",null,{"className":"articleMeta","children":[["$","span",null,{"children":"Pentesting"}],["$","time",null,{"dateTime":"2026-08-26","children":"2026-08-26"}],["$","span",null,{"children":"12 min de lectura"}]]}],["$","h1",null,{"children":"Nos salteamos la suscripción paga de una startup tocando un solo campo en Supabase"}],["$","p",null,{"className":"articleDeck","children":"Durante un pentest autorizado encontramos un fallo de autorización: una cuenta común podía modificar el atributo que definía sus privilegios y acceder a funciones internas."}],["$","div",null,{"className":"articleByline","children":["Equipo Lucis"," · Lucis"]}],["$","div",null,{"className":"articleBody","dangerouslySetInnerHTML":{"__html":"$13"}}]]}]
12:["$","footer",null,{"className":"footer","children":["$","div",null,{"className":"shell footerInner","children":[["$","a",null,{"href":"/blog","children":[["$","span",null,{"className":"blogCopyEn","children":"Back to the blog"}],["$","span",null,{"className":"blogCopyEs","children":"Volver al blog"}]]}],["$","p",null,{"className":"footerMeta","children":["© 2026 Lucis · ",["$","span",null,{"className":"blogCopyEn","children":"Applied security, with evidence."}],["$","span",null,{"className":"blogCopyEs","children":"Seguridad aplicada, con evidencia."}]]}]]}]}]
