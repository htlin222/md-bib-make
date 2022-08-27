## 簡介
Cite While You Write, 簡稱CWYW，顧名思意就是讓我們在寫作時可以即時引用，並且生成引用條目bibliography，如果你是word或open office的使用者，可以很簡單地裝好zotero的外掛即可以開始使用。如果是R語言的使用者，Rstuido也提供完整的寫作環境。但如果是日常習慣以markdown來寫作，想實現CWYW就不是一件簡單的事。

從兩個層面思考：(1)一個可以直接叫出如同zotero picker視窗的替代軟體，插入citation key，這裡使用Raycast (2)利用pandoc，把bib檔匯入。

## 前置作業
系統：Mac OS

需要安裝的項目：
### [Zotero Your personal research assistant](https://www.zotero.org/)
```shell
# 可以直接從官網下載安裝檔，或用：
brew install --cask zotero
```
#### Zotero需要安裝的plugin:
[Better BibTeX for Zotero :: Better BibTeX for Zotero](https://retorque.re/zotero-better-bibtex/)

### [Raycast](https://www.raycast.com/)
```shell
# 可以直接從官網下載安裝檔，或用：
brew install --cask raycast
```
#### Raycast 需要安裝的plugin:
[reckoning-dev/zotero - Raycast Store](https://www.raycast.com/reckoning-dev/zotero)
### [Make - GNU Project - Free Software Foundation](https://www.gnu.org/software/make/)
```shell
brew install make
```
### [Pandoc - About pandoc](https://pandoc.org/)
```shell
brew install pandoc
```

## Zotero設定：(以英文版說明)
* `prefereces`>`Better BibTex`>`Citation Keys`>`Citation Keys format`
> auth.lower + year+ veryshorttitle.lower

![image_22-08-27_16_18_03](https://i.imgur.com/1KIdKxl.png)

* `prefereces`>`Better BibTex`>`Export`>`Quick Copy`>`Quick Copy Format`>
> Pandoc Citation

![image_22-08-27_16_18_27](https://i.imgur.com/zrvgZWz.png)

### 刷新所有citation key
![image_22-08-27_16_17_31](https://i.imgur.com/HK6WEjv.png)
### 輸出成兩種格式：Better BibLaTex, Better CSL JSON
![image_22-08-27_16_19_14](https://i.imgur.com/PhWIGIn.png)
* `File`>`Export Library`>`Format`>`Better BibLaTex`
> 在Translator Options 選 Keep updated
把檔案存成以下路徑:
```shell
~/Zotero/zotero_main.bib
```
* `File`>`Export Library`>`Format`>`Better CSL JSON`
> 在Translator Options 選 Keep updated
把檔案存成以下路徑:
```shell
~/Zotero/zotero_main.json
```
## Raycast 設定
![image_22-08-27_16_20_29](https://i.imgur.com/Toxzuqv.png)
注意：這裡的路徑都要寫完整路徑，不能寫`~/`或`$HOME`
* Zotero Path
```
/Users/USER_NAME/Zotero/zotero.sqlite
```
* Better BibTex CSL JSON FILE
```
# 剛剛輸出的檔案
/Users/USER_NAME/Zotero/zotero_main.json
```
* CSL format
> 選你要的，例如我選AMA，對本次操作無關。
* 為zotero extension 設定一個快鍵，例如我用`ctrl+/`
## 如何使用
* 複製這個repo
* 編輯main.md這個檔案
### 如何加入citation?
* 叫出raycast
* 搜尋你要的文章
* command+K 列出所有選項，選擇`Copy BibTex Citation Key`
![image_22-08-27_16_29_57](https://i.imgur.com/WkSriZe.png)
* 在要加入citation的地方先寫一個`@`，然後貼上citation key，最後呈現如 `@tesfaye2022articles`
## Makefile文件設定：
```shell
# 改主檔案的名字：
PROJECT=main

# 引用格式 ，請把csl檔放在同一目錄下
CITATIONSTYLE=american-medical-association.csl

# 你的資料庫位置
BIBLIO=~/Zotero/zotero_main.bib
```
## 加好你要的citaion後，只要在這個目錄下，輸入：
```shell
make
```
輸出畫面應該會是：
```shell
make
pandoc --from=markdown -s --bibliography ~/Zotero/zotero_main.bib --citeproc --csl=american-medical-association.csl --metadata link-citations=true main.md --output=main_output.docx
rm -rf main_output.md
pandoc --from=markdown -s --bibliography ~/Zotero/zotero_main.bib --citeproc --csl=american-medical-association.csl --metadata link-citations=true main.md --to=gfm --output=main_output.md
完成啦，讚的
open .
```
你就會得到 `main_output.md`, `main_output.docx`這兩個檔案
