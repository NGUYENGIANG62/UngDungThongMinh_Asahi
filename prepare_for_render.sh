#!/bin/bash
# Script chuẩn bị project AsahiJapanTours để triển khai lên Render.com
# Chạy script: bash prepare_for_render.sh

echo "Bắt đầu chuẩn bị project cho Render..."

# Xóa các file thừa/trùng lặp/backup
echo "Đang xóa các file thừa..."
rm -f server/googleSheetsService.ts
rm -f server/googleSheetsService.ts.bak
rm -f server/fixGoogleSheetsRange.js

# Xóa thư mục con trùng lặp nếu tồn tại
if [ -d "AsahiJapanTourNew2025" ]; then
  echo "Đang xóa thư mục con AsahiJapanTourNew2025..."
  rm -rf AsahiJapanTourNew2025
fi

# Kiểm tra và đổi tên nếu cần thiết
if [ -f server/googleSheetsServiceFixed.ts ]; then
  echo "Đổi tên googleSheetsServiceFixed.ts thành googleSheetsService.ts..."
  mv server/googleSheetsServiceFixed.ts server/googleSheetsService.ts
  
  # Cập nhật import trong các file
  echo "Cập nhật tham chiếu trong các file khác..."
  find ./server -type f -name "*.ts" -exec sed -i 's/\.\/googleSheetsServiceFixed/\.\/googleSheetsService/g' {} \;
fi

# Kiểm tra và tạo file package.json build/start script
if ! grep -q '"build":' package.json; then
  echo "Thêm script build vào package.json..."
  sed -i 's/"scripts": {/"scripts": {\n    "build": "tsc -p tsconfig.json",/g' package.json
fi

if ! grep -q '"start":' package.json; then
  echo "Thêm script start vào package.json..."
  sed -i 's/"scripts": {/"scripts": {\n    "start": "node server\/index.js",/g' package.json
fi

# Tạo file .gitignore phù hợp
echo "Cập nhật file .gitignore..."
cat > .gitignore << EOL
# Dependencies
node_modules/
.pnp
.pnp.js

# Testing
coverage/

# Production
build/
dist/
out/

# Misc
.DS_Store
.env
.env.local
.env.development.local
.env.test.local
.env.production.local
.env.production

npm-debug.log*
yarn-debug.log*
yarn-error.log*

# IDE
.idea/
.vscode/
*.sublime-*

# Logs
logs
*.log

# Runtime data
pids
*.pid
*.seed

# Các file dự án cụ thể
fix-sheets.sh
*.bak
*.backup
*.tmp
admin_cookies.txt
customer_cookies.txt
cookies.txt
EOL

echo "Chuẩn bị thành công! Project đã sẵn sàng để đẩy lên GitHub và triển khai trên Render."
echo "Hãy xem tài liệu RENDER_DEPLOYMENT.md để biết hướng dẫn chi tiết triển khai."