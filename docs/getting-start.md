---
id: getting-start
title: Getting Start
description: Documentation on How to get started with Backstage
---

Created by [박진슬] on 2024 1월 29


- [개요](#개요)
- [Create Backstage App {#Backstage-1.GettingStart-CreateBackstageApp}](#create-backstage-app-backstage-1gettingstart-createbackstageapp)
  - [사전 설치 (Prerequisites) {#Backstage-1.GettingStart-사전설치(Prerequisites)}](#사전-설치-prerequisites-backstage-1gettingstart-사전설치prerequisites)
  - [app 생성 {#Backstage-1.GettingStart-app생성}](#app-생성-backstage-1gettingstart-app생성)
  - [app 시작 (Run the Backstage app)](#app-시작-run-the-backstage-app)
  - [브라우저에서 확인 {#Backstage-1.GettingStart-브라우저에서확인}](#브라우저에서-확인-backstage-1gettingstart-브라우저에서확인)
  - [General folder structure {#Backstage-1.GettingStart-Generalfolderstructure}](#general-folder-structure-backstage-1gettingstart-generalfolderstructure)
- [저장소를 PostgreSQL 로 변경 {#Backstage-1.GettingStart-저장소를PostgreSQL로변경}](#저장소를-postgresql-로-변경-backstage-1gettingstart-저장소를postgresql로변경)
  - [setting](#setting)
    - [postgres package 추가 {#Backstage-1.GettingStart-postgrespackage추가}](#postgres-package-추가-backstage-1gettingstart-postgrespackage추가)
    - [app-config.yaml 수정 {#Backstage-1.GettingStart-app-config.yaml수정}](#app-configyaml-수정-backstage-1gettingstart-app-configyaml수정)
- [env 관리 {#Backstage-1.GettingStart-env관리}](#env-관리-backstage-1gettingstart-env관리)


------------------------------------------------------------------------

# 개요

**참고**
-   [Backstage.io검토](https://osc-korea.atlassian.net/wiki/spaces/consulting/pages/955842620)
-   [GettingStarted](https://backstage.io/docs/getting-started/)
    

Kubernetes , Catalog 기능을 테스트 하기전에 BackStage App 을 만드는
과정이 필요합니다.

Backstage 의 Frontend 는 [**React**](https://react.dev)
 , Backend 는
[**Node.js**](https://nodejs.org/)  으로
개발돼있고 전부 [**Typescript**](https://www.typescriptlang.org/) 를 사용하고 있습니다.

 

# Create Backstage App {#Backstage-1.GettingStart-CreateBackstageApp}

## 사전 설치 (Prerequisites) {#Backstage-1.GettingStart-사전설치(Prerequisites)}

-   **node**
    -   install
        -   [https://jin2rang.tistory.com/entry/Window-Nodejs-%EC%84%A4%EC%B9%982](https://jin2rang.tistory.com/entry/Window-Nodejs-%EC%84%A4%EC%B9%982)
            card-appearance="inline" 

    -   nvm 은 node.js 를 여러개의 버전으로 설치하고 관리할 수 있는 도구입니다.
        
    -   node.js 만 설치해도 되지만, Node Version 을 여러개 쓰고 있으므로 NVM 을 통해 node js 를 설치했습니다.
        

-   **yarn**

    -   install command

        -   `npm install --global yarn`

    -   yarn 은 npm 과 같은 Javascript Package Manager 입니다.

    -   [npm vs yarn](https://joshua1988.github.io/vue-camp/package-manager/npm-vs-yarn.html)
         : npm 과 yarn 의 차이점은 해당 URL 에서 확인할 수 있습니다.

## app 생성 {#Backstage-1.GettingStart-app생성}

```shell
PS C:\_DEV> npx @backstage/create-app@latest

? Enter a name for the app [required] backstage-seul

Creating the app...

( 생략 )

 All set! Now you might want to:
  Run the app: cd backstage-seul && yarn dev
  Set up the software catalog: https://backstage.io/docs/features/software-catalog/configuration
  Add authentication: https://backstage.io/docs/auth/
```



## app 시작 (Run the Backstage app) 

 
 
```shell
# go to the application directory
PS C:\_DEV> cd backstage-seul

# Start the Backstage app
PS C:\_DEV\backstage-seul> yarn dev
```



`yarn dev` 명령은 프론트엔드와 백엔드를 동일한 창에서 별도의 프로세스(\[0\]과 \[1\]로 명명) 로 실행합니다.

## 브라우저에서 확인 {#Backstage-1.GettingStart-브라우저에서확인}

[http://localhost:3000](http://localhost:3000)
 으로 접속하면 아래와같은 Dashboard 를 확인할 수 있습니다.


![](assets/973373498/973373530.png?width=760)

## General folder structure {#Backstage-1.GettingStart-Generalfolderstructure}

아래는 앱을 만든 후 생성되는 파일과 폴더의 단순화된 layout 입니다.

 
```shell
app
├── app-config.yaml
├── catalog-info.yaml
├── lerna.json
├── package.json
└── packages
    ├── app
    └── backend
```



-   **app-config.yaml**
    -   앱의 기본 구성 파일
    -   자세한 내용은 [설정](https://backstage.io/docs/conf/) 을 참조
-   **catalog-info.yaml**
    -   Catalog Entities
-   **lerna.json**
    -   Mono-Repo 설정에 필요한 workspaces 및 기타 lerna 구성이
        포함돼있다.
    -   [[Lerna]{.underline}](https://lerna.js.org/)
        는 단일 저장소(Repository)에서 다양한 packages를
        구성하는 것을 도와주는 라이브러리이다.
-   **package.json**
    -   생성한 프로젝트의 메타정보 와 프로젝트가 의존하고 있는 모듈들에
        대한 정보
-   **packages/**
    -   Lerna 는 packages 폴더에 각각의 pakcage(프로젝트) 를 구성한다.
    -   packages 하위에 backend 와 app (frontend) 가 있다.
-   **packages/app/**
    -   Backstage frontend app
-   **packages/backend/**
    -   Backstage backend


```shell
warning Error running install script for optional dependency: "C:\\_git_evelyn\\backstage-custom\\node_modules\\tree-sitter-yaml: Command failed.
Exit code: 1
Command: node-gyp rebuild
Arguments:
Directory: C:\\_git_evelyn\\backstage-custom\\node_modules\\tree-sitter-yaml
Output:
gyp info it worked if it ends with ok
gyp info using node-gyp@9.4.1
gyp info using node@18.19.0 | win32 | x64


gyp ERR! find Python
gyp ERR! find Python **********************************************************
gyp ERR! find Python You need to install the latest version of Python.
gyp ERR! find Python Node-gyp should be able to find and use Python. If not,
gyp ERR! find Python you can try one of the following options:
gyp ERR! find Python - Use the switch --python=\"C:\\Path\\To\\python.exe\"
gyp ERR! find Python   (accepted by both node-gyp and npm)
gyp ERR! find Python - Set the environment variable PYTHON
gyp ERR! find Python - Set the npm configuration variable python:
gyp ERR! find Python   npm config set python \"C:\\Path\\To\\python.exe\"
gyp ERR! find Python For more information consult the documentation at:
gyp ERR! find Python https://github.com/nodejs/node-gyp#installation
gyp ERR! find Python **********************************************************
gyp ERR! find Python
```


# 저장소를 PostgreSQL 로 변경 {#Backstage-1.GettingStart-저장소를PostgreSQL로변경}

**참고**
[https://backstage.io/docs/getting-started/configuration](https://backstage.io/docs/getting-started/configuration)

기본적으로 SQLite 를 통해 저장하고 있는데, Backstage App 이 Restart 될
경우 ui 에서 설정한 모든 정보가 날아가게됩니다.

따라서 저장소를 Postgers 로 변경해줍니다.

```yaml
# postgres-docker-compose.yaml
version: '3.1'
services:
  db:
    image: postgres
    restart: always
    environment:
      POSTGRES_PASSWORD: example
    ports:
      - "5432:5432"
```



## setting 

### postgres package 추가 {#Backstage-1.GettingStart-postgrespackage추가}
 
```shell
 # From your Backstage root directory
 yarn add --cwd packages/backend pg
```

### app-config.yaml 수정 {#Backstage-1.GettingStart-app-config.yaml수정}

 
 
```yaml
backend:
  database:
    # config options: https://node-postgres.com/apis/client
    client: pg
    connection:
      host: ${POSTGRES_HOST}
      port: ${POSTGRES_PORT}
      user: ${POSTGRES_USER}
      password: ${POSTGRES_PASSWORD}
```



postgres 로 변경후 database 목록을 확인해보면 아래 4개의 database 가
생성된것을 확인해볼수 있습니다.

 
 
```shell
List of databases
            Name             |  Owner   | Encoding |  Collate   |   Ctype    | ICU Locale | Locale Provider | Access privileges 
-----------------------------+----------+----------+------------+------------+------------+-----------------+-------------------
 backstage_plugin_auth       | root     | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | 
 backstage_plugin_catalog    | root     | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | 
 backstage_plugin_scaffolder | root     | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | 
 backstage_plugin_search     | root     | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            |
```



# env 관리 {#Backstage-1.GettingStart-env관리}

env 를 운영환경 (dev,stg,prd) 마다 다르게 적용할 수도 있고, Github 에
public 으로 소스코드를 커밋할 경우 노출하고싶지 않은 정보를 하나의
파일에 작성후 .gitignore 에 등록하여 env 를 관리한다.

-   window 일경우 start.ps1 (for powershell)

 
 
```powershell
# vi start.ps1
Write-Host "Setting environment variables...";

$env:POSTGRES_HOST="localhost";
$env:POSTGRES_PORT="5432";
$env:POSTGRES_USER="root";
$env:POSTGRES_PASSWORD="root1234";

Write-Host "Initializing process..."
```



-   mac, linux 일경우 environment.sh
```shell
# vi environment.sh
export POSTGRES_HOST=localhost
export POSTGRES_PORT=5432
export POSTGRES_USER=root
export POSTGRES_PASSWORD=root1234
```





