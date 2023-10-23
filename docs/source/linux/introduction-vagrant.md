# 安装虚拟机

我们使用 `VirtualBox` 来安装虚拟机，后续要使用 `Vagrant` 来管理虚拟机， `Vagrant` 是一个虚拟机外挂软件，可以通过命令和 `Vagrantfile`来控制编排虚拟机，如果需要一个环境用这个再好不过，只需要复制必要的文件和脚本，别人就能启动一个一模一样的虚拟机。

同时 `Vagrant` 还可以控制虚拟机的生命周期，比如启停。

>PS: 经过实践，这一套没有办法在win7的系统上跑，建议升级到win10，或者买虚拟机来用。

## VirtulBox下载

### 下载主程序和插件

**Windows请下载**

* [下载主程序安装包exe](https://download.virtualbox.org/virtualbox/7.0.10/VirtualBox-7.0.10-158379-Win.exe)

**Mac 下载**
* [mac安装包dmg](https://download.virtualbox.org/virtualbox/7.0.10/VirtualBox-7.0.10-158379-OSX.dmg)

**插件（所有平台）**

* [https://download.virtualbox.org/virtualbox/7.0.10/Oracle\_VM\_VirtualBox\_Extension\_Pack-7.0.10-158379.vbox-extpack](https://download.virtualbox.org/virtualbox/7.0.10/Oracle_VM_VirtualBox_Extension_Pack-7.0.10-158379.vbox-extpack)

其他系统访问网站 [https://download.virtualbox.org/virtualbox/7.0.10/](https://download.virtualbox.org/virtualbox/7.0.10/) 下载【**主程序】**，按自己的操作系统类型来下载。

> PS: 上面给出的链接是当前最新的版本，也可以直接访问 [https://download.virtualbox.org/virtualbox](https://download.virtualbox.org/virtualbox) 来安装更新的版本。


VirtualBox主程序的安装包是以图形化向导的方式来执行的，初学者只需要一路按照其默认选项完成安装即可。在安装完成VirtualBox之后，我们还需要对其进行一些全局配置。为此，我们需要启动VirtualBox，然后依次单击其主菜单中的「管理」 -> 「全局设定」或按下快捷键`Ctrl + g`，在「常规」中修改「默认虚拟电脑位置」，以免日后虚拟机占用了过多Windows系统分区的空间。

![](https://coding3min.oss-accelerate.aliyuncs.com/uPic/20231023/20-52-37-xU1R9I.jpg)

### 导入插件

在「扩展」中导入我们之前下载好的扩展程序。

![](https://coding3min.oss-accelerate.aliyuncs.com/uPic/20231023/20-52-54-kDmzQS.jpg)

> PS: 扩展程序是为了增强虚拟机功能的。


## Vagrant下载

`Vagrant` 自动化虚拟机管理工具。 [点此下载](https://developer.hashicorp.com/vagrant/downloads?product_intent=vagrant)

![](https://coding3min.oss-accelerate.aliyuncs.com/uPic/20231023/20-55-26-SVihXA.jpg)


### 安装插件

在 `Vagrant` 中安装 `vagrant-vbguest` `插件后，Vagrant` 会自动在虚拟机中安装 `vbguest` 。

这个插件可以自动挂载iso，然后安装，非常重要。


```bash
vagrant plugin install vagrant-vbguest --plugin-version 0.31.0
```

可以用以下命令来检查是否安装成功了。

```bash
vagrant plugin list
```

## Centos7镜像下载

此镜像是为了预防准备的镜像无法使用时重新安装用。

下载 [https://vagrantcloud.com/centos/boxes/7/versions/1804.02/providers/virtualbox/unknown/vagrant.box](https://vagrantcloud.com/centos/boxes/7/versions/1804.02/providers/virtualbox/unknown/vagrant.box)

下载后出现文件`CentOS-7.box`进入此目录，打开命令行，执行以下内容

执行

```bash
$ vagrant box add CentOS-7.box --name centos/7
==> box: Box file was not detected as metadata. Adding it directly...
==> box: Adding box 'centos/7' (v1804.02) for provider: 
    box: Unpacking necessary files from: file:///Users/xxx/Downloads/CentOS-7.box
==> box: Successfully added box 'centos/7' (v1804.02) for 'virtualbox'!
```
检查

```bash
$ vagrant box list
centos/7 (virtualbox, 1804.02)
```

## Centos7 启动

现在需要新增一个名为`Vagrantfile`的文件，来启动虚拟机了，我这里提供了一个样例，可以创建一个纯净的虚拟机。你可以在这个文件里指定很多内容比如。

* 使用哪个镜像。
* 主机信息：主机名、主机IP。
* 主机配置：内存大小、CPU个数。
* 用户名密码。

```bash
# -*- mode: ruby -*-
# vi: set ft=ruby :
# on win10, you need `vagrant plugin install vagrant-vbguest` and change synced_folder.type="virtualbox"
# reference `https://www.dissmeyer.com/2020/02/11/issue-with-centos-7-vagrant-boxes-on-windows-10/`


Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"
  config.vm.provider 'virtualbox' do |vb|
  vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]
  end  
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.vm.define "node" do |node|
    # 设置虚拟机的Box镜像
    node.vm.box = "centos/7"
    node.vbguest.installer_options = { allow_kernel_upgrade: true }
    node.vm.box_version = "1804.02"
    # 设置虚拟机的主机名
    node.vm.hostname = "master"
    # 设置虚拟机的IP
    node.vm.network "private_network", ip: "172.17.8.1"
    # VirtaulBox相关配置
    node.vm.provider "virtualbox" do |vb|
      # 设置虚拟机的内存大小
      vb.memory = "3072"
      # 设置虚拟机的CPU个数
      vb.cpus = 2
      # 设置虚拟机的名称
      vb.name = "master"
    end
  end
end
```

然后运行命令`vagrant up`来启动。

* 我们创建了一个叫 master 的虚拟机，使用了 Centos7的镜像。
* 设置了 3GB 内存和 2 核CPU。
* 把当前目录挂载到了虚拟机内的`/vagrant`目录，如果你要传输什么文件比较方便。


### 其他：vagrant常用命令

`vagrantfile`文件中的配置代码通常只在第一次执行`vagrant up`命令时被执行。之后，如果我们不明确使用`vagrant reload --provision`命令进行重新加载，这些配置就不会再被执行了。

使用SSH的方式进入指定虚拟机

```bash
vagrant ssh
# 如果当前项目下管辖有多台虚拟机，就执行
vagrant ssh <主机名>
```
在执行虚拟机的启动、重启与关闭等操作时，我们常会用到以下命令

```bash
# 启动所有虚拟机
vagrant up
# 启动指定的虚拟机
vagrant up <主机名>
# 重启所有虚拟机
vagrant reload
# 重启指定的虚拟机
vagrant reload <主机名>
# 关闭所有虚拟机
vagrant halt
# 关闭指定的虚拟机
vagrant halt <主机名>
# 挂起所有虚拟机
vagrant suspend
# 挂起指定的虚拟机
vagrant suspend <主机名>
```

在需要销毁项目中的虚拟机时，我们需要用到以下命令。

```bash
# 销毁所有虚拟机
vagrant destroy -f
# 销毁指定的虚拟机
vagrant destroy <主机名> -f
```
对现有虚拟机的镜像打包操作

```bash
vagrant package 主机名 --output xxx
```