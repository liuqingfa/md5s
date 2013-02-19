# MD5S

Markdown + S5 网络幻灯片实用工具

针对本程序斑驳不担保任何责任，欲知详细请查看 [GPL.txt][1]  
这是一个自由的程序，欢迎您在特定条件下再次发布本程序。

[1]:gpl.txt

## 使用说明

+ 编辑 `todo.markdown` 文件，即幻灯片内容。  
更多语法详见 [Wiki](http://zh.wikipedia.org/wiki/Markdown)

	- `#` 表示幻灯片标题 (h1)
	- `##` 表示子标题 (h2)
	- `###` 表示小标题 (h3)
	- `+` 表示条目 (li)
	- `*` 表示强调 (em)
	- `**` 表示进一步强调 (strong)
	- `******` 表示水平线 (hr)

+ 运行 `./md5s`

> Linux 版本的 md5s 依赖 markdown 的支持～

	- 输入 HTML 标题
	- 输入 footer 标题
	- 输入 生成文件 名称
	- 输入 是否要发布 (y/n)

+ 查看生成的文件，默认是 `../why-not-php.html`

	- 使用浏览器打开该页面
	- 通过编辑器查看源码

