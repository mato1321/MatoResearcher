# MatoResearcher 安裝與使用指南

## 系統需求

- Windows 10/11
- Python 3.8 或更高版本
- Git（用於下載專案）
- Ollama（本地 AI 模型）

## 安裝步驟

### 1. 安裝 Python

1. 前往 [Python 官網](https://www.python.org/downloads/) 下載最新版本
2. 安裝時**務必勾選** "Add Python to PATH"
3. 驗證安裝：
   ```bash
   python --version
   ```

### 2. 安裝 MSYS2（用於 PDF 生成功能）

1. 從 [MSYS2 官網](https://www.msys2.org/) 下載安裝程式
2. 執行安裝程式，使用預設路徑 `C:\msys64`
3. 安裝完成後，開啟 MSYS2 終端機
4. 在 MSYS2 終端機中執行以下指令：
   ```bash
   pacman -S mingw-w64-x86_64-gtk3 mingw-w64-x86_64-gobject-introspection
   ```
5. 將 `C:\msys64\mingw64\bin` 加入系統環境變數 PATH：
   - 右鍵點擊「本機」→「內容」
   - 點選「進階系統設定」→「環境變數」
   - 在「系統變數」中找到 Path，點選「編輯」
   - 新增 `C:\msys64\mingw64\bin`
   - 確定儲存

### 3. 安裝 Ollama（本地 AI 模型）

#### Windows 安裝 Ollama

1. 前往 [Ollama 官網](https://ollama.com/download/windows) 下載 Windows 版本
2. 執行安裝程式（OllamaSetup.exe）
3. 安裝完成後，Ollama 會在背景自動執行

#### 下載需要的模型

開啟命令提示字元或 PowerShell，執行以下指令：

```bash
# 範例: 下載 Qwen2.5 7B 模型（用於文字生成）
ollama pull qwen2.5:7b

# 下載 Nomic Embed Text 模型（用於文字嵌入）
ollama pull nomic-embed-text
```

### 4. 下載 MatoResearcher

```bash
git clone https://github.com/mato1321/MatoResearcher.git
cd gpt-researcher
```

或直接下載 ZIP 檔案並解壓縮

### 5. 安裝 Python 套件

在專案目錄中開啟命令提示字元或 PowerShell，執行：

```bash
pip install -r requirements.txt
```

### 6. 設定環境變數

在專案根目錄建立 `.env` 檔案，加入以下內容：

```env
# Tavily API（用於網路搜尋）
TAVILY_API_KEY=你的_Tavily_API_金鑰

# 文件路徑（存放本地文件）
DOC_PATH=./my-docs

# Ollama 設定
OLLAMA_BASE_URL=http://127.0.0.1:11434/

# 範例: 使用 Ollama 的 Qwen2.5 7B 模型
FAST_LLM=ollama:qwen2.5:7b
SMART_LLM=ollama:qwen2.5:7b
STRATEGIC_LLM=ollama:qwen2.5:7b

# 使用 Ollama 的嵌入模型
EMBEDDING=ollama:nomic-embed-text

# 如果需要指定 API 網址（選填）
# NEXT_PUBLIC_GPTR_API_URL=http://0.0.0.0:8000
```

#### 獲取 Tavily API 金鑰

1. 前往 [Tavily 官網](https://tavily.com/)
2. 登入後前往 [API Keys 頁面](https://app.tavily.com/home)
3. 複製你的 API 金鑰

## 啟動 MatoResearcher

### 步驟 1：確保 Ollama 正在執行

Ollama 通常會自動在背景執行。如果沒有，手動啟動：

```bash
ollama serve
```

### 步驟 2：啟動 MatoResearcher

#### 方法一：使用批次檔（推薦）
直接雙擊執行 `start.bat` 檔案

#### 方法二：手動啟動
開啟命令提示字元，導航到專案目錄，執行：
```bash
uvicorn main:app --reload
```

## 使用說明

1. 啟動後，終端機會顯示：
   ```
   INFO:     Uvicorn running on http://127.0.0.1:8000
   ```
   在網址上ctrl+滑鼠左鍵導入頁面

2. 在網頁介面中：
   - 輸入你的研究主題
   - 選擇研究類型和報告格式
   - 點擊開始研究
   - 等待報告生成

## 輸出檔案

研究報告會儲存在 `outputs` 資料夾中，支援格式：
- `.docx` - Microsoft Word 文件
- `.pdf` - PDF 文件（需要 MSYS2）
- `.md` - Markdown 格式

## 本地文件功能

將你的文件放在 `./my-docs` 資料夾中，GPT Researcher 可以搜尋和引用這些文件：
- 支援格式：PDF、TXT、DOCX、MD
- 文件會被自動索引和嵌入
- 研究時會優先參考本地文件