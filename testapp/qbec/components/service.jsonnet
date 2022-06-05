local p = import '../params.libsonnet';
local params = p.components.testapp;

{
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: params.appname,
  },
  spec: {
    type: 'ClusterIP',
    ports: [
      {
        port: 80,
        targetPort: 80,
      },
    ],
    selector: {
      app: params.appname,
    },
  },
}
