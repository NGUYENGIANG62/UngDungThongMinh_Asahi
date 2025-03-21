# Hướng dẫn triển khai AsahiJapanTours lên Render.com

Tài liệu này hướng dẫn cách triển khai ứng dụng AsahiJapanTours lên nền tảng Render.com và cấu hình domain tùy chỉnh.

## Yêu cầu

- Một tài khoản GitHub chứa mã nguồn dự án
- Một tài khoản Render.com (có thể đăng ký miễn phí)
- Domain tùy chỉnh (nếu muốn sử dụng)

## Bước 1: Chuẩn bị mã nguồn

1. Đảm bảo rằng dự án của bạn đã được đẩy lên GitHub và không chứa các file thừa/trùng lặp
2. Chạy script chuẩn bị: `bash prepare_for_render.sh` để tự động dọn dẹp dự án
3. Xác nhận file .env.example đã được cập nhật với các biến môi trường cần thiết
4. Xác nhận file `package.json` có chứa script build và start (đã có sẵn trong dự án)

## Bước 2: Tạo dịch vụ Web trên Render.com

1. Đăng nhập vào tài khoản Render.com
2. Nhấp vào nút "New +" và chọn "Web Service"
3. Kết nối với repository GitHub của bạn
4. Cấu hình dịch vụ web như sau:
   - **Name**: AsahiJapanTours (hoặc tên bạn muốn)
   - **Environment**: Node
   - **Region**: Singapore (hoặc region gần với người dùng của bạn)
   - **Branch**: main (hoặc nhánh chứa code mới nhất)
   - **Build Command**: `npm install && npm run build`
   - **Start Command**: `NODE_ENV=production node dist/index.js` (hoặc `npm start` nếu đã được cấu hình)
   - **Plan**: Free (hoặc lựa chọn plan phù hợp với nhu cầu)

## Bước 3: Cấu hình Environment Variables

Thêm các biến môi trường quan trọng sau (dựa trên file .env):

```
EMAIL_USER=AsahiJapanTours
EMAIL_PASSWORD=xdppaohryuhknygk
SESSION_SECRET=AsahiJapanToursSecretKey_2024
APP_DOMAIN=asahivietlife.tokyo

GOOGLE_SPREADSHEET_URL=https://docs.google.com/spreadsheets/d/1DQ1e6k4I65O5NxmX8loJ_SKUI7aoIj3WCu5BMLUCznw/edit?usp=sharing
AGENCY_NAMN_SPREADSHEET_URL=https://docs.google.com/spreadsheets/d/1Z7o-i4dfVlXKp599OGDOZCgxwSS3epxgMLi57-t3r6A/edit?usp=sharing
LEO_KNOWLEDGE_BASE_URL=https://docs.google.com/spreadsheets/d/1DQ1e6k4I65O5NxmX8loJ_SKUI7aoIj3WCu5BMLUCznw/edit?usp=sharing
ACCOUNT_MANAGEMENT_SHEET_URL=https://docs.google.com/spreadsheets/d/1IixX89SIKJkGRBhsOyFNXZhAEC98N6kn8q8T8STcMmg/edit?usp=sharing

GOOGLE_API_KEY=AIzaSyCzg4Agl7nMTpq0J5x2z1rygcqDNIPQrAU

GOOGLE_SERVICE_ACCOUNT_EMAIL=asahijapantoursapp@coastal-bloom-454011-e2.iam.gserviceaccount.com
GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDrDSfaaPnwjO+M\nxg4myHME3j6FQy/RrB0Q6/2IC/Z4/4BrK8M/aVvCZaj/kQhErWYJKHqpoNlVDMnM\n7Th5RKOA2GeO7GLjaOkWFGIdeQiPpdsvpBcu7bj63sYEY+P6UaijvAZugbiqIn0p\nQjIJqmvA6UddbVTagcnoQ+Q4xwPrlsKomC1cM2rarXBtnwpJde00exKGGpv8cBPe\nmBf9t1qsMHd0f0whXLvChBXjOL/Y9ycnF9XC90PTQuykV6O5DpHTeYFmEAVO39vz\nkWTX7nwrYOoWtP4CFqC3zLtdZLzJ88GgS0Ld2bSL9WR2wJ4BDV35MY52uGwjWGnX\niR2gj/vJAgMBAAECggEACPWqyttkyJe0s2TiyfVq1fkLQMzpdBh3kKswMjkDg4P4\nvw0PX5nKZL/3h8tdWXHTIX78ov3lvuVShWhW9l9ojJsjImpuEA1SEjSDc2xnSEN6\nFggvFou6+PwYJ/dvS53Ee/5JL/nrojeXlgSnD+GCQzuZK+1klkIrgjohR01Fv9t/\n+diXyzN5auaOtvP429BEErTGCmVqCYjGOITQ8U8HjaQJ40PyADbefgXWcQF9tDuK\n1HitHpOA5VhlMZmUj2oUTYzsggrnEbzutyEWZtjx9F8Ap4MRbQDBQM1TR9rJCE1d\nj69nhhJN1ky+PfHhdnVzY7z9Dptd4UBpquVCovsWYQKBgQD7eEnU9WYmska5cIbK\n4tphxosoKwHwT5zw+gkwaZ57ZfAMZIFumP9W57OnElIvi9dQKXSw2kBSrNlcScjk\nsRI0O6fmV5+vVLRLwFcxMqxwOb3L5Q478m85a1xfzVdJ5bTbSkcMNbMKf1gXnfY4\ng33VQl3eiDblfv9sk/hAE9pE6QKBgQDvSSZNDDkmP1U+VXmEerf+XC+a6zwVS6ue\nPrIVb9lMpqj+MCXoEklQHT/awMR39zk414p2rCnvy3+UYF7mE07ZmjQoJRUh/oZ3\nDGvwMmJitZpag017QVLpJMxFW6eMEPl5DVNRKZJC8mkcDHBuZZPASdryFWDMewuJ\ns9YwDqcz4QKBgQDHmLhxkb5c5JACTHCQxPK1PNPjNA+74FUfaDa2+H5UT5rzGyso\nz8OMBSixaXdWSdbCx8TZQsJfXNbBy8bqzik20Er6J36VudPJdIdAg4ofIZWmKs7b\nghgKKU8Os3ufKfYdQJ2X8V+E64LObBCs1qGgDadYJCH+kojGc8RNh/RtUQKBgQCT\n2KGmp2/ENwuHaS6c8Wov6murj77e9ZNDQj+sSSB9YNg3vi4dtva/XmMu2T5LVWBw\nw5SVAIkk1ZqtZeIczD9C6ilhyI/HIkmY0v76OVda4BRP6qL8Df+ZeBgSnq/mNjK+\nXcJl+oaZgMf7AaCSRYbGH5v9ScI2daxKV+h2ZwdeYQKBgBTf2TLsInVBhguuPpQQ\nCjSlB+yLJ+C6RNGk63k789BPLspXD5VNelyIIzCfQjSKVQUw4NhslGZL4hgfazYe\nus6DKFKLwnbBQOcEVxAusn6QIGYByC+HrhbnvSTkYzA7lHLYFbx9UTCX2TGBKWhh\n76GkcYBWPLvfPPke3S4WmX0U\n-----END PRIVATE KEY-----\n"

GOOGLE_CLIENT_ID=407408718192.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=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
GOOGLE_REFRESH_TOKEN=1//04r6Ht9qUilVPCgYIARAAGAQSNwF-L9IrwLvEGxqYA7wHpRPN80wwP4vOkBQQI0KvgSNFuRFy6e67UuMYeeLeMnqtb-ph5u4EHSQ

PORT=5000
NODE_VERSION=20.5.1
```

**Lưu ý**: Đảm bảo rằng `GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY` có định dạng đúng với dấu xuống dòng `\n` giữ nguyên.

## Bước 4: Triển khai và kiểm tra

1. Nhấp vào "Create Web Service" để bắt đầu quá trình triển khai
2. Theo dõi quá trình build và deploy trong tab "Logs"
3. Kiểm tra ứng dụng đã triển khai tại URL do Render cung cấp

## Bước 5: Cấu hình domain tùy chỉnh (asahivietlife.tokyo)

1. Trong trang chi tiết dịch vụ web, chọn tab "Settings"
2. Cuộn xuống mục "Custom Domain"
3. Nhấp "Add Custom Domain" và nhập domain của bạn: `asahivietlife.tokyo`
4. Làm theo hướng dẫn để cấu hình DNS:
   - Thêm bản ghi CNAME trỏ đến Render URL
   - Hoặc cập nhật bản ghi A trỏ đến IP của Render

## Xử lý sự cố

### Không kết nối được Google Sheets

1. Kiểm tra giá trị của `GOOGLE_API_KEY` đã chính xác và đã được bật API cho Google Sheets
2. Đảm bảo các Spreadsheet URLs đã được cấu hình quyền truy cập "Bất kỳ ai có liên kết có thể xem"
3. Kiểm tra logs trên Render để tìm thông báo lỗi cụ thể

### Lỗi khi triển khai

1. Kiểm tra lỗi build trong tab "Logs" của Render
2. Đảm bảo các file thừa đã được xóa khỏi repository
3. Kiểm tra xem `package.json` có chứa script start đúng không

### Dịch vụ không hoạt động đúng sau khi triển khai

1. Kiểm tra logs ứng dụng trên Render để tìm lỗi
2. Đảm bảo tất cả các biến môi trường đã được cấu hình
3. Kiểm tra các file tĩnh đã được build đúng cách

## Tài liệu tham khảo

- [Render Node.js Documentation](https://render.com/docs/deploy-node-express-app)
- [Environment Variables in Render](https://render.com/docs/environment-variables)
- [Custom Domains in Render](https://render.com/docs/custom-domains)