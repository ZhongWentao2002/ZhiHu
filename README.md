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

<img width="242" alt="MVC Main Mudular" src="https://user-images.githubusercontent.com/88606535/151107954-1743a3cd-9b87-46db-9bf2-98071e7945d8.png">

> 我采用由一个`viewController`管理所有的模块，提供被push的模块Controller，实现每个模块互不影响。
>
> 例如Main Mudular模块，数据源代理将交由`SourseStory`处理，处理不了的数据将再由自己的代理转交给controller
>
> 关于UI的代理以及布局的代理将交由View去处理，同样，处理不了的数据将再由自己的代理转交给controller
>

## 程序数据演示

### 默认数据情况

若用户的网络速度慢（即加载不出数据），则要加载一些默认的数据。

![ZhiHu without data](https://user-images.githubusercontent.com/88606535/151108498-3a237618-9e6a-4f82-8c2f-3ca81387d5d7.gif)

>这种情况下，如GIF所示，可以实现基本的UI互动操作，无法进行后续操作。
>
>这里，当天的日期也拉入了默认。
>
>伪登录已做演示，后面将不做演示。
>
>此程序并没有做数据缓存（待完成）。
>
>但默认加载不出的数据，都将以这种形式加载出来。

### 网络请求数据

实现网络请求数据，banner页和cell都将实现，tableView也将实现无限滚动。


![无限滚动](https://user-images.githubusercontent.com/88606535/151112103-ca370c9b-64bb-462f-856e-d31ef204360a.gif)

>如GIF所示，tableView可以实现无限滚动。
>
>banner可以实现手动滚动；
>
>banner无法自动轮播（待实现）；
>
>banner也无法无限滚动（待实现）。
>
>所有的title和hint内容都做了粘性操作。
>
>并且没组的顶部都将显示当天的日期。

### 返回头部下拉

单击顶部回到最出的位置，banner页可以实现下拉放大的效果。

![返回头部下拉](https://user-images.githubusercontent.com/88606535/151121232-82ad873c-dcc5-4a45-bc1f-fcf35270edc9.gif)

>如GIF所示，单击顶部可以实现返回到头部。
>
>下拉可以使顶部视图放大，
>
>如果单击的是头像，则如第一个演示一样。

### 新闻页和返回

单击cell的新闻和banner的新闻可以到新闻页，返回时，cell的标题将永久变灰。

![新闻页和返回](https://user-images.githubusercontent.com/88606535/151121271-63f64921-38c9-4eec-a615-002bba773bef.gif)

> 如GIF所示，单击新闻可以到新闻页。
>
> 这里，新闻页将采用`loadRequest`操作，
>
> `loadHTML`所需要的数据已保存到模型，
>
> 用于之后探究`WKWebView`使用。
>
> 返回时，已被单击的新闻将永远灰掉，直到重新运行。

### 新闻其他反馈

单击4个按钮都会有事件响应，但再次进入同一新闻时，采用默认状态。

![新闻其他信息](https://user-images.githubusercontent.com/88606535/151121293-bde3eade-9601-4303-a52f-95cbb1de0830.gif)

> 如GIF所示，单击评论时，响应了事件，但无法跳转。
>
> 单击点赞，会高亮图标，数字+1，无弹窗（待实现）。
>
> 单击收藏，会高亮图标，无弹窗（待实现）。
>
> 单击转发，响应事件，但无法跳转。













