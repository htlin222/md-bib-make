# 改主檔案的名字：
PROJECT=main

# 引用格式 ，請把csl檔放在同一目錄下
CITATIONSTYLE=american-medical-association.csl

# 你的資料庫位置
BIBLIO=~/Zotero/zotero_main.bib

# ---下面的不要動----
SOURCE=$(PROJECT).md
OUTPUT=$(PROJECT)_output
TARGET=$(OUTPUT).docx $(OUTPUT).md

PANDOC=pandoc \
			 --from=markdown \
			 -s --bibliography $(BIBLIO) \
			 --citeproc \
			 --csl=$(CITATIONSTYLE) \
			 --metadata link-citations=true \
			 $(SOURCE)

# create docx
$(OUTPUT).docx: $(SOURCE) $(METADATA)
	$(PANDOC) --output=$(OUTPUT).docx

# create github flavored markdown
$(OUTPUT).md: $(SOURCE) $(METADATA)
	rm -rf $(OUTPUT).md
	$(PANDOC) --to=gfm --output=$(OUTPUT).md

all: $(TARGET)
	@echo 完成啦，讚的
	open .

clean:
	rm -rf $(OUTPUT).* 
	
.PHONY: all clean $(TARGET)
.DEFAULT_GOAL := all
