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
          <p>__BANNER__</p>
          <img src="__PICTURE__" height="85%"/>
          </body></html>
        |||,
      },
    },
  },
}
