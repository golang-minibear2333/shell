# 远程登录

Linux服务器说到底都是电脑，都是在机房里跑的，通过网络访问到服务器上，你不可以在机房操作Linux服务器，所以就需要远程登录。

Linux 系统中是通过 ssh 服务实现的远程登录功能，默认 ssh 服务端口号为 22。

Window 系统上 Linux 远程登录客户端有 SecureCRT, Putty, SSH Secure Shell 等。

## 登录命令

登录方法很简单。

```shell
ssh root@ip
```

在登录的时候指定用户为`root`，如果你的用户不是`root`比如`vagrant`那么你就要输入.

```shell
ssh vagrant@ip
```

## 工具

一般windows上使用xshell来登录，我的是`Mac`喜欢用`electerm`。

xshell登录参考首页的动图

https://www.netsarang.com/en/xshell/



