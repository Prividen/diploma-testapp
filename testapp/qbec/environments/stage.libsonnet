local base = import './base.libsonnet';

base {
  components+: {
    testapp+: {
      replicas: 1,
      hostname: 'testapp-stage.yc.complife.ru',
      start_page+: {
        banner: 'This is <strong>stage</strong> meditate, please do not hesitate ask for a wizdom',
      },
    },
  },
}
