# vi/vim

这个是编辑软件用的。基本上 vi/vim 共分为三种模式，命令模式（Command Mode）、输入模式（Insert Mode）和命令行模式（Command-Line Mode）。

1. 我们使用`vim aa.txt`进入文件内，此时是命令模式，此状态下敲击键盘动作会被 Vim 识别为命令，而非输入字符。
2. 然后输入`i`开始编辑，进入输入模式。
3. 输入完毕以后按`Esc`按钮进入命令模式，在这个模式下输入`:`（英文冒号）就进入了底线命令模式。

* :w：保存文件。
* :q：退出 Vim 编辑器。
* :wq：保存文件并退出 Vim 编辑器。
* :q!：强制退出Vim编辑器，不保存修改。

更多内容见：[vim专栏](https://coding3min.com/tag/vim/)