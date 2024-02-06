---
id: Kubernetes
title: Kubernetes
sidebar_label: Kubernetes
description: Monitoring Kubernetes based services with the software catalog
---

Created by [ 박진슬] on 2024 1월 29
 
- [개요 {#Backstage-4.Kubernetes-개요}](#개요-backstage-4kubernetes-개요)
  - [Your Clusters (Container Monitoring) {#Backstage-4.Kubernetes-YourClusters(ContainerMonitoring)}](#your-clusters-container-monitoring-backstage-4kubernetes-yourclusterscontainermonitoring)
    - [container info, cluster info {#Backstage-4.Kubernetes-containerinfo,clusterinfo}](#container-info-cluster-info-backstage-4kubernetes-containerinfoclusterinfo)
    - [Pod describe {#Backstage-4.Kubernetes-Poddescribe}](#pod-describe-backstage-4kubernetes-poddescribe)
    - [Pod yaml , Log {#Backstage-4.Kubernetes-Podyaml,Log}](#pod-yaml--log-backstage-4kubernetes-podyamllog)
  - [Error Reporting {#Backstage-4.Kubernetes-ErrorReporting}](#error-reporting-backstage-4kubernetes-errorreporting)
- [Kubernetes Cluster Config {#Backstage-4.Kubernetes-KubernetesClusterConfig}](#kubernetes-cluster-config-backstage-4kubernetes-kubernetesclusterconfig)
    - [Auth Provider - Service Account Token {#Backstage-4.Kubernetes-AuthProvider-ServiceAccountToken}](#auth-provider---service-account-token-backstage-4kubernetes-authprovider-serviceaccounttoken)
      - [ClusterRoleBinding 생성 {#Backstage-4.Kubernetes-ClusterRoleBinding생성}](#clusterrolebinding-생성-backstage-4kubernetes-clusterrolebinding생성)
      - [Generate ServiceAccount Token {#Backstage-4.Kubernetes-GenerateServiceAccountToken}](#generate-serviceaccount-token-backstage-4kubernetes-generateserviceaccounttoken)
    - [Example deployment.yaml {#Backstage-4.Kubernetes-Exampledeployment.yaml}](#example-deploymentyaml-backstage-4kubernetes-exampledeploymentyaml)
- [Setting {#Backstage-4.Kubernetes-Setting}](#setting-backstage-4kubernetes-setting)
  - [app-config.yaml {#Backstage-4.Kubernetes-app-config.yaml}](#app-configyaml-backstage-4kubernetes-app-configyaml)
  - [catalog-info.yaml {#Backstage-4.Kubernetes-catalog-info.yaml}](#catalog-infoyaml-backstage-4kubernetes-catalog-infoyaml)
- [참고 {#Backstage-4.Kubernetes-참고}](#참고-backstage-4kubernetes-참고)
    - [Kubernetes 플러그인 {#Backstage-4.Kubernetes-Kubernetes플러그인}](#kubernetes-플러그인-backstage-4kubernetes-kubernetes플러그인)


------------------------------------------------------------------------

# 개요 {#Backstage-4.Kubernetes-개요}

-   **참고**
    -   [Backstage.io 검토](https://osc-korea.atlassian.net/wiki/spaces/consulting/pages/955842620)
    -   [New Backstage feature: Kubernetes for Service owners](https://backstage.io/blog/2021/01/12/new-backstage-feature-kubernetes-for-service-owners/)
    -   [backstage - kubernetes](https://backstage.io/docs/features/kubernetes/)

## Your Clusters (Container Monitoring) {#Backstage-4.Kubernetes-YourClusters(ContainerMonitoring)}

### container info, cluster info {#Backstage-4.Kubernetes-containerinfo,clusterinfo}

![image-20240111-074044.png](assets/973373871/973373913.png?width=760)

Backstage의 Kubernetes는 여러 클러스터에서 서비스를 검색하도록 구성할 수
있습니다. 그런 다음 이를 단일 보기로 집계합니다.

따라서 여러 클러스터에 배포하는 경우 서비스의 현재 상태를 파악하기 위해
더 이상 kubectl 컨텍스트를 전환할 필요가 없습니다.

### Pod describe {#Backstage-4.Kubernetes-Poddescribe}

![image-20240111-074140.png](assets/973373871/973373910.png?width=736)

-   Deployment

    -   Container - Name , Phase, Status

-   HPA (Horizontal Pod Autoscaler)

    -   Min, Max Replicas

    -   current CPU usage

    -   target CPU usage

-   Pod

    -   배포된 Pod 개수

    -   에러가 발생한 Pod 개수

### Pod yaml , Log {#Backstage-4.Kubernetes-Podyaml,Log}

![image-20240111-075600.png](assets/973373871/973373901.png?width=357)


![image-20240111-072726.png](assets/973373871/973373922.png?width=380)

k8s 리소스 를 YAML 형태로 볼수 있고, Pod 의 로그 조회도 가능하다.

## Error Reporting {#Backstage-4.Kubernetes-ErrorReporting}

![image-20240111-074416.png](assets/973373871/973373907.png?width=760)

Pod , Deployment 등 K8s 리소스에서 Error 가 발생할경우 Error Reporting
테이블이 생성되며 Cluster Name, k8s api resource 종류와 이름, Message 를
확인할 수 있습니다.

# Kubernetes Cluster Config {#Backstage-4.Kubernetes-KubernetesClusterConfig}

-   참고
    -   [https://backstage.io/docs/features/kubernetes/installation](https://backstage.io/docs/features/kubernetes/installation)

### Auth Provider - Service Account Token {#Backstage-4.Kubernetes-AuthProvider-ServiceAccountToken}

k8s API 를 사용하려면 인증 설정이 필요한데, 기본적인 service Account
Token 을 이용하여 연동했습니다.

#### ClusterRoleBinding 생성 {#Backstage-4.Kubernetes-ClusterRoleBinding생성}
 
 
```shell
kubectl create clusterrolebinding default-cluster-admin --clusterrole cluster-admin --serviceaccount default:default
# clusterrolebinding.rbac.authorization.k8s.io/default-cluster-admin created
```



`default`라는 사용자(`ServiceAccount`)에 `cluster-admin` 권한을
부여했습니다.

운영환경에서는 매우 위험한 행위니 적절한 권한을 부여해 주시기 바랍니다.

#### Generate ServiceAccount Token {#Backstage-4.Kubernetes-GenerateServiceAccountToken}

[**kubernetes 1.24 미만**](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.24.md#no-really-you-must-read-this-before-you-upgrade-1)일 경우 자동으로 생성돼있으므로 아래 커맨드로 확인 가능합니다.

 
 
```shell
kubectl -n <NAMESPACE> get secret $(kubectl -n <NAMESPACE> get sa <SERVICE_ACCOUNT_NAME> -o=json \
| jq -r '.secrets[0].name') -o=json \
| jq -r '.data["token"]' \
| base64 --decode
```


[**kubernetes 1.24 이상**](https://kubernetes.io/docs/concepts/configuration/secret/#service-account-token-secrets)은 아래 방식으로 service account token 을 생성해야합니다.

 
```shell 
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: <SECRET_NAME>
  namespace: <NAMESPACE>
  annotations:
    kubernetes.io/service-account.name: <SERVICE_ACCOUNT_NAME>
type: kubernetes.io/service-account-token
EOF
```

 
```shell
kubectl -n <NAMESPACE> get secret <SECRET_NAME> -o go-template='{{.data.token | base64decode}}'
```


### Example deployment.yaml {#Backstage-4.Kubernetes-Exampledeployment.yaml}
 
 
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    backstage.io/kubernetes-id: starter
  name: starter
spec:
  replicas: 2
  selector:
    matchLabels:
      app: starter
      backstage.io/kubernetes-id: starter
  template:
    metadata:
      labels:
        app: starter
        backstage.io/kubernetes-id: starter
    spec:
      containers:
        - image: 'oscka/api-start:0.0.10'
          name: starter
          ports:
            - containerPort: 8080
              name: http
              protocol: TCP
          resources:
            limits:
              cpu: 600m
              memory: 500Mi
            requests:
              cpu: 250m
              memory: 128Mi
```



-   label 입력

    -   `backstage.io/kubernetes-id: starter` 를 입력해야합니다.

    -   catalog-info.yaml 의 annotation 과 k8s resource 의 label 이
        동일해야합니다.

# Setting {#Backstage-4.Kubernetes-Setting}

## app-config.yaml {#Backstage-4.Kubernetes-app-config.yaml}

```yaml
kubernetes:
  serviceLocatorMethod:
    type: multiTenant
  clusterLocatorMethods:
    - type: config
      clusters:
        - url: ${K8S_MINIKUBE_URL}
          name: minikube
          authProvider: serviceAccount
          skipTLSVerify: true
          skipMetricsLookup: false
          serviceAccountToken: ${K8S_MINIKUBE_TOKEN}
```


-   `K8S_MINIKUBE_URL` : kubernetes api server url 입력

```shell
$ kubectl cluster-info
Kubernetes control plane is running at https://127.0.0.1:53071
CoreDNS is running at https://127.0.0.1:53071/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

-   `K8S_MINIKUBE_TOKEN` : 위에서 조회한 ServiceAccount Token 입력

## catalog-info.yaml {#Backstage-4.Kubernetes-catalog-info.yaml}
```yaml
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: starter
  annotations:
    backstage.io/kubernetes-id: starter
```

-   annotation 추가

    -   `backstage.io/kubernetes-id: starter`

    -   해당 kubernets-id 는 k8s api resource 의 label 과 일치해야한다.

------------------------------------------------------------------------

# 참고 {#Backstage-4.Kubernetes-참고}

-   [How to monitor your services on Kubernetes with Backstage (Demo)](https://www.youtube.com/watch?v=VivuOxn3VQ8&t=12s)

### Kubernetes 플러그인 {#Backstage-4.Kubernetes-Kubernetes플러그인}

-   Application Topology for Kubernetes

    -   모든 Kubernetes 클러스터에 배포된 애플리케이션의 배포 상태와
        관련 리소스를 시각화

    -   [https://janus-idp.io/plugins/topology/](https://janus-idp.io/plugins/topology/)

-   BackStage Provider Kubernetes

    -   [https://github.com/AntoineDao/backstage-provider-kubernetes#readme](https://github.com/AntoineDao/backstage-provider-kubernetes#readme)

-   Multi Cluster View with OCM

    -   Open Cluster Management plugin for Backstage

    -   [https://janus-idp.io/plugins/ocm/](https://janus-idp.io/plugins/ocm/)








