---
id: for-backstage-develop
title: for-backstage-develop
description: for-backstage-develop
---


- Backstage's Github
간단하지만 시작하기에 아주 좋은 
https://github.com/backstage/software-templates/tree/main/scaffolder-templates

- Janus's Github
다른 많은 흥미로운 것들 중에서도 템플릿을 공유하는 방법을 보여줌
https://github.com/janus-idp
- Roadie's Github
템플릿 디버깅을 위한 몇 가지 팁을 찾을 수 있는 Roadie의 Github
https://github.com/RoadieHQ/software-templates/tree/main/scaffolder-templates
https://roadie.io/docs/scaffolder/debug-template/

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


1. node
2. yarn
3. python
[파이썬 path 확인](https://allhpy35.tistory.com/23)
4. [node-gyp](https://github.com/nodejs/node-gyp)
- C:\Program Files\Microsoft Visual Studio\2022\Community
- https://blog.aliencube.org/ko/2021/11/26/troubleshooting-node-gyp-package-on-windows11/

```powershell
PS C:\Users\wlstm> python
Python 3.12.1 (tags/v3.12.1:2305ca5, Dec  7 2023, 22:03:25) [MSC v.1937 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.executable
'C:\\Users\\wlstm\\AppData\\Local\\Microsoft\\WindowsApps\\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\\python.exe'
>>>
``` 

```shell
PS C:\_git_evelyn\backstage-custom> node-gyp rebuild --python "C:\Users\wlstm\AppData\Local\Microsoft\WindowsApps\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\python.exe"
gyp info it worked if it ends with ok
gyp info using node-gyp@10.0.1
gyp info using node@18.19.0 | win32 | x64
gyp info find Python using Python version 3.12.1 found at "C:\Users\wlstm\AppData\Local\Microsoft\WindowsApps\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\python.exe"

gyp http GET https://nodejs.org/download/release/v18.19.0/node-v18.19.0-headers.tar.gz
gyp http 200 https://nodejs.org/download/release/v18.19.0/node-v18.19.0-headers.tar.gz
gyp http GET https://nodejs.org/download/release/v18.19.0/SHASUMS256.txt
gyp http GET https://nodejs.org/download/release/v18.19.0/win-x64/node.lib
gyp http 200 https://nodejs.org/download/release/v18.19.0/SHASUMS256.txt
gyp http 200 https://nodejs.org/download/release/v18.19.0/win-x64/node.lib
gyp ERR! find VS
gyp ERR! find VS msvs_version not set from command line or npm config
gyp ERR! find VS VCINSTALLDIR not set, not running in VS Command Prompt
gyp ERR! find VS checking VS2022 (17.8.34408.163) found at:
gyp ERR! find VS "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools"
gyp ERR! find VS - found "Visual Studio C++ core features"
gyp ERR! find VS - missing any VC++ toolset
gyp ERR! find VS could not find a version of Visual Studio 2017 or newer to use
gyp ERR! find VS looking for Visual Studio 2015
gyp ERR! find VS - not found
gyp ERR! find VS not looking for VS2013 as it is only supported up to Node.js 8
gyp ERR! find VS
gyp ERR! find VS **************************************************************
gyp ERR! find VS You need to install the latest version of Visual Studio
gyp ERR! find VS including the "Desktop development with C++" workload.
gyp ERR! find VS For more information consult the documentation at:
gyp ERR! find VS https://github.com/nodejs/node-gyp#on-windows
gyp ERR! find VS **************************************************************
gyp ERR! find VS
gyp ERR! configure error
gyp ERR! stack Error: Could not find any Visual Studio installation to use
gyp ERR! stack at VisualStudioFinder.fail (C:\Users\wlstm\AppData\Roaming\nvm\v18.19.0\node_modules\node-gyp\lib\find-visualstudio.js:113:11)
gyp ERR! stack at VisualStudioFinder.findVisualStudio (C:\Users\wlstm\AppData\Roaming\nvm\v18.19.0\node_modules\node-gyp\lib\find-visualstudio.js:69:17)
gyp ERR! stack at process.processTicksAndRejections (node:internal/process/task_queues:95:5)
gyp ERR! stack at async createBuildDir (C:\Users\wlstm\AppData\Roaming\nvm\v18.19.0\node_modules\node-gyp\lib\configure.js:69:26)
gyp ERR! stack at async run (C:\Users\wlstm\AppData\Roaming\nvm\v18.19.0\node_modules\node-gyp\bin\node-gyp.js:81:18)
gyp ERR! System Windows_NT 10.0.22621
gyp ERR! command "C:\\Program Files\\nodejs\\node.exe" "C:\\Program Files\\nodejs\\node_modules\\node-gyp\\bin\\node-gyp.js" "rebuild" "--python" "C:\\Users\\wlstm\\AppData\\Local\\Microsoft\\WindowsApps\\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\\python.exe"
gyp ERR! cwd C:\_git_evelyn\backstage-custom
gyp ERR! node -v v18.19.0
gyp ERR! node-gyp -v v10.0.1
gyp ERR! not ok
```