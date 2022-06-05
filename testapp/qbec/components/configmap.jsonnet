local p = import '../params.libsonnet';
local params = p.components.testapp;
local pic_url = std.extVar('pic_url');

{
  apiVersion: 'v1',
  kind: 'ConfigMap',
  metadata: {
    name: params.appname + '-staff',
  },
  data: {
    'index.html': std.strReplace(
      std.strReplace(params.start_page.template,
                     '__BANNER__',
                     params.start_page.banner),
      '__PICTURE__',
      pic_url
    ),
  },
}
