local base = import './base.libsonnet';

base {
  components+: {
    testapp+: {
      replicas: 3,
      hostname: 'testapp.yc.complife.ru',
      start_page+: {
        banner: 'This is <strong>prod</strong> meditate, please do not interfere',
      },

    },
  },
}
