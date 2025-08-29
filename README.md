# GPT Researcher 安裝與使用指南

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
# 下載 Qwen2.5 7B 模型（用於文字生成）
ollama pull qwen2.5:7b

# 下載 Nomic Embed Text 模型（用於文字嵌入）
ollama pull nomic-embed-text
```

下載進度會顯示在終端機中，模型檔案較大，請耐心等待。

#### 驗證 Ollama 是否正常運作

```bash
# 檢查 Ollama 服務狀態
curl http://127.0.0.1:11434/api/tags

# 或使用 PowerShell
Invoke-WebRequest -Uri http://127.0.0.1:11434/api/tags
```

如果顯示已下載的模型列表，表示 Ollama 運作正常。

### 4. 下載 GPT Researcher

```bash
git clone https://github.com/assafelovic/gpt-researcher.git
cd gpt-researcher
```

或直接下載 ZIP 檔案並解壓縮

### 5. 安裝 Python 套件

在專案目錄中開啟命令提示字元或 PowerShell，執行：

```bash
pip install -r requirements.txt
```

如果沒有 requirements.txt，手動安裝核心套件：

```bash
pip install uvicorn fastapi weasyprint markdown python-docx python-dotenv langchain tavily-python
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

# 使用 Ollama 的 Qwen2.5 7B 模型
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
2. 點擊 "Sign Up" 註冊帳號
3. 登入後前往 [API Keys 頁面](https://app.tavily.com/home)
4. 複製你的 API 金鑰
5. 免費方案每月提供 1000 次搜尋

## Ollama 模型說明

### 查看可用模型

```bash
# 列出所有已下載的模型
ollama list

# 搜尋可用的模型
ollama search qwen
```

### 其他推薦模型選項

如果想使用其他模型，可以修改 `.env` 檔案：

```env
# 使用 Llama 3（Meta 的開源模型）
FAST_LLM=ollama:llama3:8b
SMART_LLM=ollama:llama3:8b
STRATEGIC_LLM=ollama:llama3:8b

# 使用 Mistral（法國開源模型）
FAST_LLM=ollama:mistral:7b
SMART_LLM=ollama:mistral:7b
STRATEGIC_LLM=ollama:mistral:7b

# 使用 DeepSeek（中國開源模型）
FAST_LLM=ollama:deepseek-coder:6.7b
SMART_LLM=ollama:deepseek-coder:6.7b
STRATEGIC_LLM=ollama:deepseek-coder:6.7b
```

記得先下載對應的模型：
```bash
ollama pull llama3:8b
ollama pull mistral:7b
ollama pull deepseek-coder:6.7b
```

### Ollama 基本網址說明

- **預設網址**：`http://127.0.0.1:11434/`
- **API 端點**：
  - 生成文字：`http://127.0.0.1:11434/api/generate`
  - 聊天：`http://127.0.0.1:11434/api/chat`
  - 嵌入：`http://127.0.0.1:11434/api/embeddings`
  - 模型列表：`http://127.0.0.1:11434/api/tags`

## 啟動 GPT Researcher

### 步驟 1：確保 Ollama 正在執行

Ollama 通常會自動在背景執行。如果沒有，手動啟動：

```bash
ollama serve
```

### 步驟 2：啟動 GPT Researcher

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

2. 開啟瀏覽器，訪問：
   - 主介面：http://localhost:8000
   - API 文件：http://localhost:8000/docs

3. 在網頁介面中：
   - 輸入你的研究主題
   - 選擇研究類型和報告格式
   - 點擊開始研究
   - 等待報告生成（使用本地模型可能需要較長時間）

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

## 常見問題

### Q1: Ollama 連接失敗
**A:** 
- 確認 Ollama 正在執行：`ollama serve`
- 檢查防火牆是否封鎖 11434 埠
- 嘗試重啟 Ollama 服務

### Q2: 模型下載很慢
**A:** 
- 模型檔案較大（7B 模型約 4-5GB）
- 可以使用較小的模型如 `qwen2.5:3b` 或 `phi3:mini`
- 確保網路連線穩定

### Q3: 記憶體不足
**A:** 
- 7B 模型需要約 8GB RAM
- 可以改用較小的模型
- 關閉其他應用程式釋放記憶體

### Q4: PDF 生成失敗
**A:** 確認已正確安裝 MSYS2 並將其加入 PATH

### Q5: Tavily API 配額用完
**A:** 
- 免費版每月 1000 次查詢
- 可以升級付費方案
- 或減少網路搜尋的使用

## 效能優化建議

1. **模型選擇**：
   - 快速回應：使用 3B 或更小的模型
   - 品質優先：使用 7B 或 13B 模型
   - 平衡選擇：Qwen2.5:7b 是不錯的選擇

2. **硬體需求**：
   - 最低：8GB RAM（3B 模型）
   - 建議：16GB RAM（7B 模型）
   - 最佳：32GB RAM + GPU（13B+ 模型）

3. **加速方法**：
   - 使用 GPU 版本的 Ollama（需要 NVIDIA 顯卡）
   - 調整模型參數（temperature、top_p）
   - 使用快取減少重複計算

## 停止程式

- GPT Researcher：在終端機視窗按 `Ctrl + C`
- Ollama：在系統托盤圖示右鍵選擇「退出」

## 更新專案

```bash
git pull origin main
pip install -r requirements.txt --upgrade
```

## 支援與協助

- GPT Researcher：[官方文件](https://docs.gptr.dev)
- Ollama：[官方文件](https://github.com/ollama/ollama)
- Tavily API：[官方文件](https://docs.tavily.com)
- 問題回報：[GitHub Issues](https://github.com/assafelovic/gpt-researcher/issues)

---

**注意事項：**
- 使用本地模型（Ollama）不會產生 API 費用
- Tavily API 有免費額度限制，請注意使用量
- 首次下載模型需要較長時間和足夠的硬碟空間
- 本地模型的品質可能不如 GPT-4 或 Claude，但完全免費且隱私安全