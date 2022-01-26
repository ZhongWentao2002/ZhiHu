# ZhiHu

## 程序基本信息

- 作者：`SSR`
- GitHub：[HONEY-SSR](https://github.com/HONEY-SSR)
- 仿写内容：[知乎日报](https://github.com/HONEY-SSR/ZhiHu)
- 仿写版本：`3.1.2`
- 仿写平台：`iPhone`
- 使用语言：`Objective-C`

## 程序架构简介

该程序采用MVC设计理论，实现了基本的数据展示。

![Main Mudular模块MVC设计展示](https://github.com/HONEY-SSR/ZhiHu/blob/main/ReadMe/MVC%20Main%20Mudular.png)

> 我才用由一个`viewController`管理所有的模块，提供被push的模块Controller，实现每个模块互不影响。
>
> 例如Main Mudular模块，数据源代理将交由`SourseStory`处理，处理不了的数据将再由自己的代理转交给controller
>
> 关于UI的代理以及布局的代理将交由View去处理，同样，处理不了的数据将再由自己的代理转交给controller
>

## 程序初始化数据

### 默认数据情况

若用户的网络速度慢（即加载不出数据），则要加载一些默认的数据。

![如果没有数据，应加载这种视图](https://github.com/HONEY-SSR/ZhiHu/blob/main/ReadMe/ZhiHu%20without%20data.gif)

>这种情况下，如GIF所示，可以实现基本的UI互动操作，无法进行后续操作。
>
>此程序并没有做数据缓存（待完成）。
