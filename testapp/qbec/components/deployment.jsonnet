local p = import '../params.libsonnet';
local params = p.components.testapp;


{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    name: params.appname,
  },
  spec: {
    selector: {
      matchLabels: {
        app: params.appname,
      },
    },
    replicas: params.replicas,
    template: {
      metadata: {
        labels: {
          app: params.appname,
        },
      },
      spec: {
        terminationGracePeriodSeconds: 3,
        imagePullSecrets: [
          {
            name: 'registry-secret',
          },
        ],
        containers: [
          {
            name: params.appname,
            image: params.image,
            ports: [
              {
                containerPort: 80,
              },
            ],
            volumeMounts: [
              {
                mountPath: '/html',
                readOnly: true,
                name: 'html-docs',
              },
            ],
          },
        ],
        volumes: [
          {
            name: 'html-docs',
            configMap: {
              name: params.appname + '-staff',
              items: [
                {
                  key: 'index.html',
                  path: 'index.html',
                },
              ],
            },
          },
        ],
      },
    },
  },
}
