local p = import '../params.libsonnet';
local params = p.components.testapp;
local pic_url = std.extVar('pic_url');
local image_tag = std.extVar('image_tag');
local build_ref = std.extVar('build_ref');

{
  apiVersion: 'v1',
  kind: 'ConfigMap',
  metadata: {
    name: params.appname + '-staff',
  },
  data: {
    'index.html': params.start_page.template % {
        BANNER: params.start_page.banner,
        PICTURE: pic_url,
        IMAGE_TAG: image_tag,
        BUILD_REF: build_ref,
    }
  },
}
