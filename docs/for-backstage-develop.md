---
id: for-backstage-develop
title: for-backstage-develop
description: for-backstage-develop
---

```yaml
# app-config.yaml
catalog:
  rules:
    - allow: [Component, System, Group, Resource, Location, Template, API]
  locations:
  # Note: integrations.github[].apps must be correctly configured to read GitHub locations
    - type: url
      target: https://github.com/evelyn0410/backstage-custom/blob/main/catalog-entities/all.yaml
    - type: url
      target: https://github.com/evelyn0410/backstage-custom/blob/main/catalog-entities/templates.yaml
    - type: url
      target: https://github.com/evelyn0410/backstage-custom/blob/main/catalog-entities/users.yaml
      rules:
        - allow: [User]
```

```yaml
apiVersion: backstage.io/v1alpha1
kind: Location
metadata:
  name: openmsa-gpt-collection
  description: A collection of Backstage Golden Path Templates for openmsa-IDP
spec:
  type: url
  targets:
    - https://github.com/evelyn0410/software-templates/blob/main/templates/github/go-backend/template.yaml
    - https://github.com/evelyn0410/software-templates/blob/main/templates/github/nodejs-backend/template.yaml
    - https://github.com/evelyn0410/software-templates/blob/main/scaffolder-templates/springboot-grpc-template/template.yaml
```
 type: url 으로 지정할경우 github 의 url 을 참조하며, type: url 을 제거할경우 로컬 파일 경로를 참조합니다. 
 backstage 소스코드 위치를 기준으로 상대경로를 기재해줍니다.
```yaml
# app-config.yaml
catalog:
    rules:
    - allow: [Component, System, Group, Resource, Location, Template, API]
    locations:
    # --------------------------
    # for Local
    # Local example data, file locations are relative to the backend process, typically `packages/backend`
    # --------------------------
    - type: file
        target: ../../catalog-entities/all.yaml
    - type: file
        target: ../../catalog-entities/users.yaml
        rules:
        - allow: [User]
    - type: file
        target: ../../catalog-entities/templates.yaml
```