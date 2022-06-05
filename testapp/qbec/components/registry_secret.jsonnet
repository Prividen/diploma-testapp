local p = import '../params.libsonnet';
local params = p.components.testapp;
local registry_auth = std.extVar('registry_auth');

{
  apiVersion: 'v1',
  kind: 'Secret',
  type: 'kubernetes.io/dockerconfigjson',
  metadata: {
    name: 'registry-secret',
  },
  data: {
    '.dockerconfigjson': registry_auth,
  },
}
