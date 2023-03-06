Vault OSS Backup
=================

[![License](https://img.shields.io/:license-mit-blue.svg)](https://badges.mit-license.org)

Helm chart to deploy Vault OSS backup on Kubernetes.

The chart deploys CronJob that periodially create snapshots of Vault integrated storage (Raft) and store it in S3 compatible storage. 

```
This chart requires AppRole authenication enabled and configured on Vault
```

Variables
----------
| Variable | Description | Default |
| --- | --- | --- |
| backupConfigs.schedule | CronJob Schedule | @every 1h |
| backupConfigs.successfulJobsHistoryLimit | CronJob Successful job history limit | 2 |
| backupConfigs.failedJobsHistoryLimit | CronJob Failed job history limit| 1 |
| approle.roleId | Vault AppRole Role id | null |
| approle.secretId | Vault AppRole Secret id | null |
| approle.authPath | Vault AppRole Auth mount path | null |
| minio.accessKeyId | Minio Access key | null |
| minio.secretAccesskey | Minio Secret key | null |
| minio.region | S3/Minio Region | null |
| minio.url | S3/Minio URL | null |
| minio.bucketName | S3/Minio Bucket name | null |
| minio.backupFilename | Backup file name | Release name |

License
-------

MIT

Author Information
------------------
Muhammed Iqbal <iquzart@hotmail.com>
