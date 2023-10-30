# yum和apt

## yum

这两个命令是在[不同操作系统](./introduction.md)内核安装包的。包可以理解为软件包。

yum 语法

```shell
yum [options] [command] [package ...]
```

* options：可选，选项包括-h（帮助），-y（当安装过程提示选择全部为 "yes"），-q（不显示安装的过程）等等。
* command：要进行的操作。
* package：安装的包名。

### yum常用命令

* 1\. 列出所有可更新的软件清单命令：yum check-update
* 2\. 更新所有软件命令：yum update
* 3\. 仅安装指定的软件命令：yum install <package\_name>
* 4\. 仅更新指定的软件命令：yum update <package\_name>
* 5\. 列出所有可安裝的软件清单命令：yum list
* 6\. 删除软件包命令：yum remove <package\_name>
* 7\. 查找软件包命令：yum search 
* 8\. 清除缓存命令:
* yum clean packages: 清除缓存目录下的软件包
* yum clean headers: 清除缓存目录下的 headers
* yum clean oldheaders: 清除缓存目录下旧的 headers
* yum clean, yum clean all (= yum clean packages; yum clean oldheaders) :清除缓存目录下的软件包及旧的 headers

### 实例 1
安装 pam-devel

```shell
[root@www ~]# yum install pam-devel
Setting up Install Process
Parsing package install arguments
Resolving Dependencies  <==先检查软件的属性相依问题
--> Running transaction check
---> Package pam-devel.i386 0:0.99.6.2-4.el5 set to be updated
--> Processing Dependency: pam = 0.99.6.2-4.el5 for package: pam-devel
--> Running transaction check
---> Package pam.i386 0:0.99.6.2-4.el5 set to be updated
filelists.xml.gz          100% |=========================| 1.6 MB    00:05
filelists.xml.gz          100% |=========================| 138 kB    00:00
-> Finished Dependency Resolution
……(省略)
```

### 实例 2

移除 pam-devel

```shell
[root@www ~]# yum remove pam-devel
Setting up Remove Process
Resolving Dependencies  <==同样的，先解决属性相依的问题
--> Running transaction check
---> Package pam-devel.i386 0:0.99.6.2-4.el5 set to be erased
--> Finished Dependency Resolution

Dependencies Resolved

=============================================================================
 Package                 Arch       Version          Repository        Size
=============================================================================
Removing:
 pam-devel               i386       0.99.6.2-4.el5   installed         495 k

Transaction Summary
=============================================================================
Install      0 Package(s)
Update       0 Package(s)
Remove       1 Package(s)  <==还好，并没有属性相依的问题，单纯移除一个软件

Is this ok [y/N]: y
Downloading Packages:
Running rpm_check_debug
Running Transaction Test
Finished Transaction Test
Transaction Test Succeeded
Running Transaction
  Erasing   : pam-devel                    ######################### [1/1]

Removed: pam-devel.i386 0:0.99.6.2-4.el5
Complete!
```

### 实例 3
利用 yum 的功能，找出以 pam 为开头的软件名称有哪些？

```shell
[root@www ~]# yum list pam*
Installed Packages
pam.i386                  0.99.6.2-3.27.el5      installed
pam_ccreds.i386           3-5                    installed
pam_krb5.i386             2.2.14-1               installed
pam_passwdqc.i386         1.0.2-1.2.2            installed
pam_pkcs11.i386           0.5.3-23               installed
pam_smb.i386              1.1.7-7.2.1            installed
Available Packages <==底下则是『可升级』的或『未安装』的
pam.i386                  0.99.6.2-4.el5         base
pam-devel.i386            0.99.6.2-4.el5         base
pam_krb5.i386             2.2.14-10              base
```
---
## 国内 yum 源
网易（163）yum 源是国内较好的 yum 源之一 ，无论是速度还是软件版本，都非常的不错。

将yum源设置为163 yum，可以提升软件包安装和更新的速度，同时避免一些常见软件版本无法找到。

### 安装步骤
首先备份/etc/yum.repos.d/CentOS-Base.repo

```shell
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
```
下载对应版本 repo 文件, 放入 /etc/yum.repos.d/ (操作前请做好相应备份)

* [CentOS5](http://mirrors.163.com/.help/CentOS5-Base-163.repo) ：http://mirrors.163.com/.help/CentOS5-Base-163.repo
* [CentOS6](http://mirrors.163.com/.help/CentOS6-Base-163.repo) ：http://mirrors.163.com/.help/CentOS6-Base-163.repo
* [CentOS7](http://mirrors.163.com/.help/CentOS7-Base-163.repo) ：http://mirrors.163.com/.help/CentOS7-Base-163.repo

```shell
wget http://mirrors.163.com/.help/CentOS6-Base-163.repo
mv CentOS6-Base-163.repo CentOS-Base.repo
```
运行以下命令生成缓存

```shell
yum clean all
yum makecache
```
除了网易之外，国内还有其他不错的 yum 源，比如中科大和搜狐。

中科大的 yum 源，安装方法查看：[https://lug.ustc.edu.cn/wiki/mirrors/help/centos](https://lug.ustc.edu.cn/wiki/mirrors/help/centos)

sohu 的 yum 源安装方法查看: [http://mirrors.sohu.com/help/centos.html](http://mirrors.sohu.com/help/centos.html)

阿里云的源：[https://developer.aliyun.com/mirror/centos](https://developer.aliyun.com/mirror/centos)

## apt

功能都是一样的，只不过是话音不同罢了。

### apt 语法

```shell
  apt [options] [command] [package ...]
```

* options：可选，选项包括 -h（帮助），-y（当安装过程提示选择全部为"yes"），-q（不显示安装的过程）等等。
* command：要进行的操作。
* package：安装的包名。

### apt 常用命令

* 列出所有可更新的软件清单命令：`sudo apt update`
* 升级软件包：`sudo apt upgrade`
* 列出可更新的软件包及版本信息：`apt list --upgradeable`
* 升级软件包，升级前先删除需要更新软件包：`sudo apt full-upgrade`
* 安装指定的软件命令：`sudo apt install <package_name>`
* 安装多个软件包：`sudo apt install <package_1> <package_2> <package_3>`
* 更新指定的软件命令：`sudo apt update <package_name>`
* 显示软件包具体信息,例如：版本号，安装大小，依赖关系等等：`sudo apt show <package_name>`
* 删除软件包命令：`sudo apt remove <package_name>`
* 清理不再使用的依赖和库文件: `sudo apt autoremove`
* 移除软件包及配置文件: `sudo apt purge <packagename>`
* 查找软件包命令： `sudo apt search <keyword>`
* 列出所有已安装的包：`apt list --installed`
* 列出所有已安装的包的版本信息：`apt list --all-versions`