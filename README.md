# merge bilibili client flv

## 简介

这是一个用来合并转码哔哩哔哩 Windows 10 客户端下载的视频的 shell 脚本。由于 Windows 10 客户端下载的视频是按照 `${av_id}/${P}/${av_id}_${p_id}_${num}.flv` 文件夹目录的方式存储，不方便整里视频，所以就使用 ffmpeg 来合并转码 .flv 文件为 .mp4 并根据 `${av_id}.info` 文件里的`Title`,`PartName`,`CreateDate` 三项信息来重命名新生成的 mp4 文件。

### 功能

- 批量合并视频并转码为 mp4 保存，将脚本放到 UWP 哔哩哔哩动画客户端视频下载主目录执行即可。
- 根据视频的元数据信息 (.info 文件)里的字段值重命名合并转码成的 mp4 文件。
- 根据 .info 文件里的 `Title`,`PartName`,`CreateDate` 三个字段值来命名 mp4 文件，根据自己需求更改即可。 
- 目前自己已经处理了 400GB 的 flv 文件，成功率 100% ，操作环境为 `Windows  WSL GNU/Debian`。

## 使用方法

### 依赖环境

- Linux 命令行下操作，推荐使用 Windows 10 WSL Ubuntu 或者 Debian。
- 需要安装 ffmpeg 和 jq，Ubuntu 和 Debian 下使用 `apt install ffmpeg jq -y` 即可。
- 需要哔哩哔哩官方 Windows 10 客户端来下载视频，将视频下载的主目录复制或移动到合适的工作目录下。


### bilibili 客户端

下载大量的视频，在这里值得大量是和我一样通常是几百 GB 大小哈，最佳的方式是选用客户端来下载。目前来讲 bilibili 仅有官方 Windows 10 客户端、Android 客户、iOS 客户端，Windows 桌面版并没有。而为了方便存储最好使用 UWP 客户端。从自己的使用体验来讲，使用官方 Windows 10 客户端下载 400GB 的视频速度比较好，效率也比价高，基本上能跑满自己的 100M 带宽。

[哔哩哔哩动画](https://www.microsoft.com/en-us/p/%E5%93%94%E5%93%A9%E5%93%94%E5%93%A9%E5%8A%A8%E7%94%BB/9nblggh5q5fv)

> 本应用是哔哩哔哩弹幕网(www.bilibili.com)的官方Windows 10客户端。哔哩哔哩弹幕网是国内知名的弹幕视频分享网站，常被动漫迷们昵称为"bilibili"、"B站"。

### Linux 命令行环境

既然是使用的 Windows 10 客户端，那就装个 WSL 吧，推荐 ubuntu 或者 Debian。装完之后在 WSL 中安装好 ffmpeg 和 jq。

### 执行

将脚本下载保存到哔哩哔哩 Windows 10 客户端的下载主目录，打开 WSL 进入 Linux 命令行环境执行该脚本即可，默认输出的 mp4 文件放在脚本工作路径的 mp4 文件夹内，如果磁盘不够用可以去掉末尾提示的那行注释，转换完成一部视频后会跳出 for 循环删除掉该原视频文件夹。

### 速度和效率

最大的瓶颈在于 IO ，因此最好将客户端视频下载主目录复制或移动到固态硬盘中执行，速度会提升很多。在普通机械硬盘下处理 100 GB 的 .flv 耗时 1h 左右，在固态硬盘下速度会快 2~3 倍。
