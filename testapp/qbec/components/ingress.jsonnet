local p = import '../params.libsonnet';
local params = p.components.testapp;

{
  apiVersion: 'networking.k8s.io/v1',
  kind: 'Ingress',
  metadata: {
    name: params.appname,
  },
  spec: {
    rules: [
      {
        host: params.hostname,
        http: {
          paths: [
            {
              backend: {
                service: {
                  name: params.appname,
                  port: {
                    number: 80,
                  },
                },
              },
              path: '/',
              pathType: 'Prefix',
            },
          ],
        },
      },
    ],
  },
}
