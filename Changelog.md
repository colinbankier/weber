#### Weber-0.0.3 [In development]

  * Ability to create new weber project with relative path;
  * Removed `use_ws` option from config.
  * Replaced `link` with `style` in resource helper.
  * Added `image` resource helper.
  * Sessions support.
  * Added favicon.ico to the generated project.
  * `link` helper renamed to `style`.

#### Weber-0.0.2 [Released]

  * HTTPS support;
  * `test` directory with tests template added to weber application;
  * Automatic `chmod` for `start.sh`;
  * `mimetypes` added to dependecies;
  * Redirect support;
  * Websocket support;
  * Binding error fixed. Now every controller getting second parameter as [binding_name: binding_val];
  * New config options in `webserver` section: `use_ws`, `ws_port`, `ws_mod`;
  * New example - SimpleTodo;
  * `weber.new` mix task instead of `weber`;
  * Creation directories for static files (`css`/`js`/`img`) at weber project initialization;
  * Added ability to send headers in controller's response;
  * HTML helpers;
  * [Weber at github pages](http://0xax.github.io/weber/index.html);
  * New directory [structure](https://github.com/0xAX/weber/wiki/Weber-project-directory-structure);
  * New `include_view` helper;
  * Resource helpers;
  * Empty response with headers support;
  * Plain text response support;
  * Rendering inline template support added;
  * Query string parameters;
  * Send file in response;
  * `controller#action` syntax support in router.

#### Weber-0.0.1 [Released]

  * Initial release.
