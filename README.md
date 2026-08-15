# Video Funnel

本地 HTTP 代理：把限速的远程视频拆成块并行下载，再按 HTTP Range 流给播放器，所以可以拖动进度条。

源码仓库是私有的。这里只发布编译好的 Native AOT 二进制，解压即可运行，不需要安装 .NET。

## 下载

最新版：[Releases](https://github.com/huiyuanai709/VideoFunnel-releases/releases/latest)

| 平台 | 文件 |
| --- | --- |
| Windows x64 | [vf-win-x64.zip](https://github.com/huiyuanai709/VideoFunnel-releases/releases/latest/download/vf-win-x64.zip) |
| Windows ARM64 | [vf-win-arm64.zip](https://github.com/huiyuanai709/VideoFunnel-releases/releases/latest/download/vf-win-arm64.zip) |
| Linux x64 | [vf-linux-x64.tar.gz](https://github.com/huiyuanai709/VideoFunnel-releases/releases/latest/download/vf-linux-x64.tar.gz) |
| Linux ARM64 | [vf-linux-arm64.tar.gz](https://github.com/huiyuanai709/VideoFunnel-releases/releases/latest/download/vf-linux-arm64.tar.gz) |
| macOS Apple Silicon | [vf-osx-arm64.tar.gz](https://github.com/huiyuanai709/VideoFunnel-releases/releases/latest/download/vf-osx-arm64.tar.gz) |

## 使用

默认监听 `0.0.0.0:8080`。

```bat
vf.exe
```

浏览器打开 http://127.0.0.1:8080 ，粘贴远程视频地址即可播放，或把漏斗链接交给 VLC / mpv。

局域网其它设备用 `http://<这台机器的IP>:8080`。只想本机访问时加上 `-H 127.0.0.1`。

```
-u, --url          远程视频 URL（单视频模式，直接挂在 "/"）
-H, --host         监听地址（默认 0.0.0.0）
-P, --port         监听端口（默认 8080）
-b, --block-size   块大小，MB（默认 4）
-p, --piece-size   片大小，MB，块内并行下载（默认 1）
-c, --max-blocks   预取块数（默认 2）
-n, --connections  同时连接数上限（默认 8）
-C, --config       videofunnel.json 路径（默认：系统用户配置目录）
```

配置文件位置：

- Windows: `%APPDATA%\VideoFunnel\videofunnel.json`
- macOS: `~/Library/Application Support/VideoFunnel/videofunnel.json`
- Linux: `~/.config/VideoFunnel/videofunnel.json`

天翼云盘（189）可在网页 UI 里粘贴 Cookie 后扫描；文件通过 WebDAV（`http://<host>:8080/dav`）或 SMB（`smb://<host>:1445/VideoFunnel`）暴露。189 会把 Cookie 绑到当时的公网 IP，请在同一台机器（或同一出口）上复制 Cookie 并运行。
