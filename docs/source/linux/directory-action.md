# 文件与目录

## 一切皆文件

文件就是通俗意义上理解的文件，比如在Windows上的文件和文件夹。实际上在Linux里所有的东西都是文件，包括网卡等硬件设备。所以文件自然就涉及了读写等操作，要读写自然就要有权限。

Linux 系统是一种典型的多用户系统，不同的用户处于不同的地位，拥有不同的权限。

为了保护系统的安全性，Linux 系统对不同的用户访问同一文件（包括目录文件）的权限做了不同的规定。

在 Linux 中我们通常使用以下两个命令来修改文件或目录的所属用户与权限：

* chown (change owner) ： 修改所属用户与组。
* chmod (change mode) ： 修改用户的权限。

在 Linux 中我们可以使用 ll 或者 ls –l 命令来显示一个文件的属性以及文件所属的用户和组，如：

```shell
[root@www /]# ls -l
total 64
dr-xr-xr-x   2 root root 4096 Dec 14  2012 bin
dr-xr-xr-x   4 root root 4096 Apr 19  2012 boot
……
```

实例中，**bin** 文件的第一个属性用 d 表示。d 在 Linux 中代表该文件是一个目录文件。

在 Linux 中第一个字符代表这个文件是目录、文件或链接文件等等。

* 当为 d 则是目录
* 当为 - 则是文件；
* 若是 l 则表示为链接文档(link file)；
* 若是 b 则表示为装置文件里面的可供储存的接口设备(可随机存取装置)；
* 若是 c 则表示为装置文件里面的串行端口设备，例如键盘、鼠标(一次性读取装置)。

接下来的字符中，以三个为一组，且均为 rwx 的三个参数的组合。其中， r 代表可读(read)、 w 代表可写(write)、 x 代表可执行(execute)。 要注意的是，这三个权限的位置不会改变，如果没有权限，就会出现减号 - 而已。

![](https://coding3min.oss-accelerate.aliyuncs.com/uPic/20231030/19-56-15-xzg5Bn.png)

每个文件的属性由左边第一部分的 10 个字符来确定（如下图）。

![](https://coding3min.oss-accelerate.aliyuncs.com/uPic/20231030/19-56-29-EzLSqQ.png)

从左至右用 **0-9** 这些数字来表示。

第 **0** 位确定文件类型，第 **1-3** 位确定属主（该文件的所有者）拥有该文件的权限。

第4-6位确定属组（所有者的同组用户）拥有该文件的权限，第7-9位确定其他用户拥有该文件的权限。

其中，第 **1、4、7** 位表示读权限，如果用 r 字符表示，则有读权限，如果用 - 字符表示，则没有读权限；

第 **2、5、8** 位表示写权限，如果用 w 字符表示，则有写权限，如果用 - 字符表示没有写权限；第 **3、6、9** 位表示可执行权限，如果用 x 字符表示，则有执行权限，如果用 - 字符表示，则没有执行权限。

---
## Linux文件属主和属组
```shell
[root@www /]# ls -l
total 64
drwxr-xr-x 2 root  root  4096 Feb 15 14:46 cron
drwxr-xr-x 3 mysql mysql 4096 Apr 21  2014 mysql
……
```

对于文件来说，它都有一个特定的所有者，也就是对该文件具有所有权的用户。

同时，在Linux系统中，用户是按组分类的，一个用户属于一个或多个组。

文件所有者以外的用户又可以分为文件所属组的同组用户和其他用户。

因此，Linux系统按文件所有者、文件所有者同组用户和其他用户来规定了不同的文件访问权限。

在以上实例中，mysql 文件是一个目录文件，属主和属组都为 mysql，属主有可读、可写、可执行的权限；与属主同组的其他用户有可读和可执行的权限；其他用户也有可读和可执行的权限。

对于 root 用户来说，一般情况下，文件的权限对其不起作用。

---

## 更改文件属性
### 1、chgrp：更改文件属组
语法：

```shell
chgrp [-R] 属组名 文件名
```
参数选项

* \-R：递归更改文件属组，就是在更改某个目录文件的属组时，如果加上 -R 的参数，那么该目录下的所有文件的属组都会更改。

### 2、chown：更改文件所有者（owner），也可以同时更改文件所属组。
语法：

```shell
chown [–R] 所有者 文件名
chown [-R] 所有者:属组名 文件名
```
进入 /root 目录（\~）将install.log的拥有者改为bin这个账号：

```shell
[root@www ~] cd ~
[root@www ~]# chown bin install.log
[root@www ~]# ls -l
-rw-r--r--  1 bin  users 68495 Jun 25 08:53 install.log
```
将install.log的拥有者与群组改回为root：

```shell
[root@www ~]# chown root:root install.log
[root@www ~]# ls -l
-rw-r--r--  1 root root 68495 Jun 25 08:53 install.log
```
### 3、chmod：更改文件9个属性
Linux文件属性有两种设置方法，一种是数字，一种是符号。

Linux 文件的基本权限就有九个，分别是 **owner/group/others(拥有者/组/其他)** 三种身份各有自己的 **read/write/execute** 权限。

先复习一下刚刚上面提到的数据：文件的权限字符为： -rwxrwxrwx ， 这九个权限是三个三个一组的！其中，我们可以使用数字来代表各个权限，各权限的分数对照表如下：

* r:4
* w:2
* x:1

每种身份(owner/group/others)各自的三个权限(r/w/x)分数是需要累加的，例如当权限为： -rwxrwx--- 分数则是：

* owner = rwx = 4+2+1 = 7
* group = rwx = 4+2+1 = 7
* others= --- = 0+0+0 = 0

所以等一下我们设定权限的变更时，该文件的权限数字就是 **770**。变更权限的指令 chmod 的语法是这样的：

```shell
 chmod [-R] xyz 文件或目录
```
选项与参数：

* **xyz** : 就是刚刚提到的数字类型的权限属性，为 **rwx** 属性数值的相加。
* **\-R** : 进行递归(recursive)的持续变更，以及连同次目录下的所有文件都会变更

举例来说，如果要将 **.bashrc** 这个文件所有的权限都设定启用，那么命令如下：

```shell
[root@www ~]# ls -al .bashrc
-rw-r--r--  1 root root 395 Jul  4 11:45 .bashrc
[root@www ~]# chmod 777 .bashrc
[root@www ~]# ls -al .bashrc
-rwxrwxrwx  1 root root 395 Jul  4 11:45 .bashrc
```
那如果要将权限变成 *-rwxr-xr--* 呢？那么权限的分数就成为 \[4+2+1\]\[4+0+1\]\[4+0+0\]=754。

### 符号类型改变文件权限
还有一个改变权限的方法，从之前的介绍中我们可以发现，基本上就九个权限分别是：

* user：用户
* group：组
* others：其他

那么我们就可以使用 **u, g, o** 来代表三种身份的权限。

此外， **a** 则代表 **all**，即全部的身份。读写的权限可以写成 r, w, x，也就是可以使用下表的方式来看：

|chmod|u<br>g<br>o<br>a|+(加入)<br>-(除去)<br>=(设定)|r<br>w<br>x|文件或目录|
| ----- | ----- | ----- | ----- | ----- |

如果我们需要将文件权限设置为 **-rwxr-xr--** ，可以使用 chmod u=rwx,g=rx,o=r 文件名 来设定:

```shell
#  touch test1    // 创建 test1 文件
# ls -al test1    // 查看 test1 默认权限
-rw-r--r-- 1 root root 0 Nov 15 10:32 test1
# chmod u=rwx,g=rx,o=r  test1    // 修改 test1 权限
# ls -al test1
-rwxr-xr-- 1 root root 0 Nov 15 10:32 test1
```
而如果是要将权限去掉而不改变其他已存在的权限呢？例如要拿掉全部人的可执行权限，则：

```shell
#  chmod  a-x test1
# ls -al test1
-rw-r--r-- 1 root root 0 Nov 15 10:32 test1
```

## 文件和目录管理常用命令

* ls（英文全拼：list files）: 列出目录及文件名
* cd（英文全拼：change directory）：切换目录
* pwd（英文全拼：print work directory）：显示目前的目录
* mkdir（英文全拼：make directory）：创建一个新的目录
* rmdir（英文全拼：remove directory）：删除一个空的目录
* cp（英文全拼：copy file）: 复制文件或目录
* rm（英文全拼：remove）: 删除文件或目录
* mv（英文全拼：move file）: 移动文件与目录，或修改文件与目录的名称

你可以使用 *man \[命令\]* 来查看各个命令的使用文档，如 ：man cp。

### ls (列出目录)

在Linux系统当中， ls 命令可能是最常被运行的。

语法：

```shell
[root@www ~]# ls [-aAdfFhilnrRSt] 目录名称
[root@www ~]# ls [--color={never,auto,always}] 目录名称
[root@www ~]# ls [--full-time] 目录名称
```
选项与参数：

* \-a ：全部的文件，连同隐藏文件( 开头为 . 的文件) 一起列出来(常用)
* \-d ：仅列出目录本身，而不是列出目录内的文件数据(常用)
* \-l ：长数据串列出，包含文件的属性与权限等等数据；(常用)

将目录下的所有文件列出来(含属性与隐藏档)

```shell
[root@www ~]# ls -al ~
```
### cd (切换目录)
cd是Change Directory的缩写，这是用来变换工作目录的命令。

语法：

```shell
 cd [相对路径或绝对路径]
```
```shell
#使用 mkdir 命令创建 runoob 目录
[root@www ~]# mkdir runoob

#使用绝对路径切换到 runoob 目录
[root@www ~]# cd /root/runoob/

#使用相对路径切换到 runoob 目录
[root@www ~]# cd ./runoob/

# 表示回到自己的家目录，亦即是 /root 这个目录
[root@www runoob]# cd ~

# 表示去到目前的上一级目录，亦即是 /root 的上一级目录的意思；
[root@www ~]# cd ..
```
接下来大家多操作几次应该就可以很好的理解 cd 命令的。

### pwd (显示目前所在的目录)
pwd 是 **Print Working Directory** 的缩写，也就是显示目前所在目录的命令。

```shell
[root@www ~]# pwd [-P]
```
选项与参数：

* \-P ：显示出确实的路径，而非使用链接 (link) 路径。

实例：单纯显示出目前的工作目录：

```shell
[root@www ~]# pwd
/root   <== 显示出目录啦～
```
实例显示出实际的工作目录，而非链接档本身的目录名而已。

```shell
[root@www ~]# cd /var/mail   <==注意，/var/mail是一个链接档
[root@www mail]# pwd
/var/mail         <==列出目前的工作目录
[root@www mail]# pwd -P
/var/spool/mail   <==怎么回事？有没有加 -P 差很多～
[root@www mail]# ls -ld /var/mail
lrwxrwxrwx 1 root root 10 Sep  4 17:54 /var/mail -> spool/mail
# 看到这里应该知道为啥了吧？因为 /var/mail 是链接档，链接到 /var/spool/mail 
# 所以，加上 pwd -P 的选项后，会不以链接档的数据显示，而是显示正确的完整路径啊！
```
### mkdir (创建新目录)
如果想要创建新的目录的话，那么就使用mkdir (make directory)吧。

语法：

```shell
mkdir [-mp] 目录名称
```
选项与参数：

* \-m ：配置文件的权限喔！直接配置，不需要看默认权限 (umask) 的脸色～
* \-p ：帮助你直接将所需要的目录(包含上一级目录)递归创建起来！

实例：请到/tmp底下尝试创建数个新目录看看：

```shell
[root@www ~]# cd /tmp
[root@www tmp]# mkdir test    <==创建一名为 test 的新目录
[root@www tmp]# mkdir test1/test2/test3/test4
mkdir: cannot create directory `test1/test2/test3/test4': 
No such file or directory       <== 没办法直接创建此目录啊！
[root@www tmp]# mkdir -p test1/test2/test3/test4
```
加了这个 -p 的选项，可以自行帮你创建多层目录！

实例：创建权限为 **rwx--x--x** 的目录。

```shell
[root@www tmp]# mkdir -m 711 test2
[root@www tmp]# ls -l
drwxr-xr-x  3 root  root 4096 Jul 18 12:50 test
drwxr-xr-x  3 root  root 4096 Jul 18 12:53 test1
drwx--x--x  2 root  root 4096 Jul 18 12:54 test2
```
上面的权限部分，如果没有加上 -m 来强制配置属性，系统会使用默认属性。

如果我们使用 -m ，如上例我们给予 -m 711 来给予新的目录 drwx--x--x 的权限。

### rmdir (删除空的目录)
语法：

```shell
 rmdir [-p] 目录名称
```
选项与参数：

* **\-p ：**从该目录起，一次删除多级空目录

删除 runoob 目录

```shell
[root@www tmp]# rmdir runoob/
```
将 mkdir 实例中创建的目录(/tmp 底下)删除掉！

```shell
[root@www tmp]# ls -l   <==看看有多少目录存在？
drwxr-xr-x  3 root  root 4096 Jul 18 12:50 test
drwxr-xr-x  3 root  root 4096 Jul 18 12:53 test1
drwx--x--x  2 root  root 4096 Jul 18 12:54 test2
[root@www tmp]# rmdir test   <==可直接删除掉，没问题
[root@www tmp]# rmdir test1  <==因为尚有内容，所以无法删除！
rmdir: `test1': Directory not empty
[root@www tmp]# rmdir -p test1/test2/test3/test4
[root@www tmp]# ls -l        <==您看看，底下的输出中test与test1不见了！
drwx--x--x  2 root  root 4096 Jul 18 12:54 test2
```
利用 -p 这个选项，立刻就可以将 test1/test2/test3/test4 一次删除。

不过要注意的是，这个 rmdir 仅能删除空的目录，你可以使用 rm 命令来删除非空目录。

### cp (复制文件或目录)
cp 即拷贝文件和目录。

语法:

```shell
[root@www ~]# cp [-adfilprsu] 来源档(source) 目标档(destination)
[root@www ~]# cp [options] source1 source2 source3 .... directory
```
选项与参数：

* **\-a：**相当於 -pdr 的意思，至於 pdr 请参考下列说明；(常用)
* **\-d：**若来源档为链接档的属性(link file)，则复制链接档属性而非文件本身；
* **\-f：**为强制(force)的意思，若目标文件已经存在且无法开启，则移除后再尝试一次；
* **\-i：**若目标档(destination)已经存在时，在覆盖时会先询问动作的进行(常用)
* **\-l：**进行硬式链接(hard link)的链接档创建，而非复制文件本身；
* **\-p：**连同文件的属性一起复制过去，而非使用默认属性(备份常用)；
* **\-r：**递归持续复制，用於目录的复制行为；(常用)
* **\-s：**复制成为符号链接档 (symbolic link)，亦即『捷径』文件；
* **\-u：**若 destination 比 source 旧才升级 destination ！

用 root 身份，将 root 目录下的 .bashrc 复制到 /tmp 下，并命名为 bashrc

```shell
[root@www ~]# cp ~/.bashrc /tmp/bashrc
[root@www ~]# cp -i ~/.bashrc /tmp/bashrc
cp: overwrite `/tmp/bashrc'? n  <==n不覆盖，y为覆盖
```
### rm (移除文件或目录)
语法：

```shell
 rm [-fir] 文件或目录
```
选项与参数：

* \-f ：就是 force 的意思，忽略不存在的文件，不会出现警告信息；
* \-i ：互动模式，在删除前会询问使用者是否动作
* \-r ：递归删除啊！最常用在目录的删除了！这是非常危险的选项！！！

将刚刚在 cp 的实例中创建的 bashrc 删除掉！

```shell
[root@www tmp]# rm -i bashrc
rm: remove regular file `bashrc'? y
```
如果加上 -i 的选项就会主动询问喔，避免你删除到错误的档名！

### mv (移动文件与目录，或修改名称)
语法：

```shell
[root@www ~]# mv [-fiu] source destination
[root@www ~]# mv [options] source1 source2 source3 .... directory
```
选项与参数：

* \-f ：force 强制的意思，如果目标文件已经存在，不会询问而直接覆盖；
* \-i ：若目标文件 (destination) 已经存在时，就会询问是否覆盖！
* \-u ：若目标文件已经存在，且 source 比较新，才会升级 (update)

复制一文件，创建一目录，将文件移动到目录中

```shell
[root@www ~]# cd /tmp
[root@www tmp]# cp ~/.bashrc bashrc
[root@www tmp]# mkdir mvtest
[root@www tmp]# mv bashrc mvtest
```
将某个文件移动到某个目录去，就是这样做！

将刚刚的目录名称更名为 mvtest2

```shell
[root@www tmp]# mv mvtest mvtest2
```
---
## Linux 文件内容查看
Linux系统中使用以下命令来查看文件的内容：

* cat  由第一行开始显示文件内容
* tac  从最后一行开始显示，可以看出 tac 是 cat 的倒着写！
* nl   显示的时候，顺道输出行号！
* more 一页一页的显示文件内容
* less 与 more 类似，但是比 more 更好的是，他可以往前翻页！
* head 只看头几行
* tail 只看尾巴几行

你可以使用 \_man \[命令\]\_来查看各个命令的使用文档，如 ：man cp。

### cat
由第一行开始显示文件内容

语法：

```shell
cat [-AbEnTv]
```
选项与参数：

* \-A ：相当於 -vET 的整合选项，可列出一些特殊字符而不是空白而已；
* \-b ：列出行号，仅针对非空白行做行号显示，空白行不标行号！
* \-E ：将结尾的断行字节 \$ 显示出来；
* \-n ：列印出行号，连同空白行也会有行号，与 -b 的选项不同；
* \-T ：将 \[tab\] 按键以 ^I 显示出来；
* \-v ：列出一些看不出来的特殊字符

检看 /etc/issue 这个文件的内容：

```shell
[root@www ~]# cat /etc/issue
CentOS release 6.4 (Final)
Kernel \r on an \m
```
### tac
tac与cat命令刚好相反，文件内容从最后一行开始显示，可以看出 tac 是 cat 的倒着写！如：

```shell
[root@www ~]# tac /etc/issue

Kernel \r on an \m
CentOS release 6.4 (Final)
```
### nl
显示行号

语法：

```shell
nl [-bnw] 文件
```
选项与参数：

* \-b ：指定行号指定的方式，主要有两种：
-b a ：表示不论是否为空行，也同样列出行号(类似 cat -n)；
-b t ：如果有空行，空的那一行不要列出行号(默认值)；\* -n ：列出行号表示的方法，主要有三种：
-n ln ：行号在荧幕的最左方显示；
-n rn ：行号在自己栏位的最右方显示，且不加 0 ；
-n rz ：行号在自己栏位的最右方显示，且加 0 ；\* -w ：行号栏位的占用的位数。

实例一：用 nl 列出 /etc/issue 的内容

```shell
[root@www ~]# nl /etc/issue
     1  CentOS release 6.4 (Final)
     2  Kernel \r on an \m
```
### more
一页一页翻动

```shell
[root@www ~]# more /etc/man_db.config 
#
# Generated automatically from man.conf.in by the
# configure script.
#
# man.conf from man-1.6d
....(中间省略)....
--More--(28%)  <== 重点在这一行喔！你的光标也会在这里等待你的命令
```
在 more 这个程序的运行过程中，你有几个按键可以按的：

* 空白键 (space)：代表向下翻一页；
* Enter         ：代表向下翻『一行』；
* /字串         ：代表在这个显示的内容当中，向下搜寻『字串』这个关键字；
* :f            ：立刻显示出档名以及目前显示的行数；
* q             ：代表立刻离开 more ，不再显示该文件内容。
* b 或 \[ctrl\]-b ：代表往回翻页，不过这动作只对文件有用，对管线无用。

### less
一页一页翻动，以下实例输出/etc/man.config文件的内容：

```shell
[root@www ~]# less /etc/man.config
#
# Generated automatically from man.conf.in by the
# configure script.
#
# man.conf from man-1.6d
....(中间省略)....
:   <== 这里可以等待你输入命令！
```
less运行时可以输入的命令有：

* 空白键    ：向下翻动一页；
* \[pagedown\]：向下翻动一页；
* \[pageup\]  ：向上翻动一页；
* /字串     ：向下搜寻『字串』的功能；
* ?字串     ：向上搜寻『字串』的功能；
* n         ：重复前一个搜寻 (与 / 或 ? 有关！)
* N         ：反向的重复前一个搜寻 (与 / 或 ? 有关！)
* q         ：离开 less 这个程序；

### head
取出文件前面几行

语法：

```shell
head [-n number] 文件 
```
选项与参数：

* \-n ：后面接数字，代表显示几行的意思

```shell
[root@www ~]# head /etc/man.config
```
默认的情况中，显示前面 10 行！若要显示前 20 行，就得要这样：

```shell
[root@www ~]# head -n 20 /etc/man.config
```
### tail
取出文件后面几行

语法：

```shell
tail [-n number] 文件 
```
选项与参数：

* \-n ：后面接数字，代表显示几行的意思
* \-f ：表示持续侦测后面所接的档名，要等到按下\[ctrl\]-c才会结束tail的侦测

```shell
[root@www ~]# tail /etc/man.config
# 默认的情况中，显示最后的十行！若要显示最后的 20 行，就得要这样：
[root@www ~]# tail -n 20 /etc/man.config
```


