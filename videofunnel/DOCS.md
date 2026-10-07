# VideoFunnel

## 安装
设置 → 加载项 → 加载项商店 → ⋮ → 仓库，添加 `https://github.com/huiyuanai709/VideoFunnel-releases`，安装 **VideoFunnel** 并启动。版本跟随本仓库 Releases，发布新版后商店里会出现更新。

## 访问
- Web UI：`http://<HA_IP>:8080/`（侧边栏“打开网页界面”）
- WebDAV：`http://<HA_IP>:8080/dav`，网易爆米花 STRM 用 `/dav/strm`
- SMB（在 Web UI 里开启）：`smb://<HA_IP>:1445/VideoFunnel`

使用 host 网络，局域网播放器可直接访问；不支持 Ingress（程序没有路径前缀支持）。

## 选项
| 选项 | 默认 | 说明 |
|---|---|---|
| port | 8080 | 监听端口（host 网络，改了要同时改播放器地址） |
| host | 0.0.0.0 | 监听地址 |
| update_check | false | 是否让程序自己检查更新（加载项请用商店更新） |

侧边栏「打开网页界面」和看门狗固定指向 8080；改了 `port` 请直接访问新端口。日志也写在 `/config/VideoFunnel/vf-console.log`。

## 配置文件
保存在加载项配置目录 `/addon_configs/<repo-hash>_videofunnel/videofunnel.json`（容器内 `/config/videofunnel.json`），含网盘登录凭据，**不要分享**。

## 从本地加载项 local_videofunnel 迁移
新仓库安装的加载项 slug 不同（`<hash>_videofunnel`），配置不会自动带过来：
1. 停止 `local_videofunnel`（两者都占 8080，不能同时运行）。
2. 安装本加载项，先启动一次再停止（生成目录），或直接：
   `cp /addon_configs/local_videofunnel/videofunnel.json /addon_configs/<hash>_videofunnel/videofunnel.json`
   也可放到 `/share/videofunnel/videofunnel.json`，首次启动若无配置会自动导入。
3. 启动并确认登录状态正常后，再卸载 `local_videofunnel`。

## 代理 / 旁路由
如通过 Mihomo 等旁路由，网盘域名（*.189.cn、*.ctyunxs.cn、cloudcube.wuxi.cn、aliyundrive、quark 等）应走 DIRECT。

## 国内构建
加载项在本机构建时需访问 GitHub Releases。下载慢可在 `build.yaml` 的 `args` 里加
`GH_MIRROR: https://ghfast.top/https://github.com`（或其它镜像），或让 HA 走代理。
