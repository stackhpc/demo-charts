# nvme-rook-cephfs

This chart will install and configure in-cluster, NVME-backed CephFS storage. It will create a `ceph-filesystem` StorageClass that may be consumed by other resources.

**:warning: Ensure that you are deploying this chart into the `rook-ceph` namespace**

It requires the [Rook Ceph Operator](https://rook.io/docs/rook/v1.8/helm-operator.html) to be already installed. This can be achieved by adding the Rook-Ceph Helm Application Repository to KubeApps, and then installing the `rook-ceph` chart into the `rook-ceph` namespace, or by running the following Helm commands:

```
helm repo add rook-release https://charts.rook.io/release
helm install --create-namespace --namespace rook-ceph rook-ceph rook-release/rook-ceph
```