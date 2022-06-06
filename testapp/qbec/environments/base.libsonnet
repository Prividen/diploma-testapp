local registry = std.extVar('registry');
local image_tag = std.extVar('image_tag');

{
  components: {
    testapp: {
      appname: 'testapp',
      image: registry + '/testapp:' + image_tag,
      start_page: {
        template: |||
          <html><body>
          <h1>Meditating cat</h1>
          <p>%(BANNER)s (image tag: <tt>%(IMAGE_TAG)s</tt>, build ref: <tt>%(BUILD_REF)s</tt>)</p>
          <img src="%(PICTURE)s" height="85%%"/>
          </body></html>
        |||,
      },
    },
  },
}
