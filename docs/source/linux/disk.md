# 磁盘管理

这个我们不用学那么深入，只用知道怎么看磁盘容量和文件大小就行了。

* df
* du

## df

df命令参数功能：检查文件系统的磁盘空间占用情况。可以利用该命令来获取硬盘被占用了多少空间，目前还剩下多少空间等信息。

语法：
```shell
df [-ahikHTm] [目录或文件名]
```

选项与参数：

* -a ：列出所有的文件系统，包括系统特有的 /proc 等文件系统；
* -k ：以 KBytes 的容量显示各文件系统；
* -m ：以 MBytes 的容量显示各文件系统；
* -h ：以人们较易阅读的 GBytes, MBytes, KBytes 等格式自行显示；
* -H ：以 M=1000K 取代 M=1024K 的进位方式；
* -T ：显示文件系统类型, 连同该 partition 的 filesystem 名称 (例如 ext3) 也列出；
* -i ：不用硬盘容量，而以 inode 的数量来显示

最常用的是`df -h`
```shell
[root@www ~]# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hdc2             9.5G  3.7G  5.4G  41% /
/dev/hdc3             4.8G  139M  4.4G   4% /home
/dev/hdc1              99M   11M   83M  12% /boot
tmpfs                 363M     0  363M   0% /dev/shm
```

可以看到有几个分区，类比Windows的`C D E F`盘。

## du

Linux du 命令也是查看使用空间的，但是与 df 命令不同的是 Linux du 命令是查看文件和目录大小的。

语法：
```shell
du [-ahskm] 文件或目录名称
```

选项与参数：

* -a ：列出所有的文件与目录容量，因为默认仅统计目录底下的文件量而已。
* -h ：以人们较易读的容量格式 (G/M) 显示；
* -s ：仅显示指定目录或文件的总大小，而不显示其子目录的大小。
* -S ：包括子目录下的总计，与 -s 有点差别。
* -k ：以 KBytes 列出容量显示；
* -m ：以 MBytes 列出容量显示；

### 样例1

只列出当前目录下的所有文件夹容量（包括隐藏文件夹）:

```shell
[root@www ~]# du
8       ./test4     <==每个目录都会列出来
8       ./test2
....中间省略....
12      ./.gconfd   <==包括隐藏文件的目录
220     .           <==这个目录(.)所占用的总量
```

直接输入 du 没有加任何选项时，则 du 会分析当前所在目录里的子目录所占用的硬盘空间。

### 样例2

将文件的容量也列出来

```shell
[root@www ~]# du -a
12      ./install.log.syslog   <==有文件的列表了
8       ./.bash_logout
8       ./test4
8       ./test2
....中间省略....
12      ./.gconfd
220     .
```

### 常用命令

```shell
du -h -d 1
```

其中`-d`是指定层级，一层。`-h`是显示格式 (G/M) 显示。