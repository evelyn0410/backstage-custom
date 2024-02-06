---
id: techdocs
title: techdocs
description: techdocs
---

1. mkdocs.yaml 생성

프로젝트 ROOT 위치에 mkdocs.yaml 파일을 생성합니다.
```yaml
# vi mkdocs.yaml
site_name: starter-techdocs
site_description: Contains the techdocs for starter
repo_url: https://github.com/evelyn0410/starter
edit_uri: edit/main/docs

plugins:
  - techdocs-core
```

2. catalog-info.yaml 작성 (annotation 추가)


