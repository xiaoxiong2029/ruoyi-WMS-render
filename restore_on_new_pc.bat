@echo off
chcp 65001 >nul
title 荣租仓管系统 - 一键还原工具
echo ========================================
echo   荣租仓管系统 - 一键还原工具
echo ========================================
echo.
echo 请确保新电脑已安装：JDK 17、MySQL 8.0、Git、Node.js、IntelliJ IDEA、VS Code
echo.
set /p NEW_MYSQL_PWD=请输入本机 MySQL root 密码:

echo [1/5] 创建数据库并还原...
mysql -u root -p%NEW_MYSQL_PWD% -e "CREATE DATABASE IF NOT EXISTS ry_wms CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
mysql -u root -p%NEW_MYSQL_PWD% ry_wms < "%~dp0ry_wms_full.sql"
if errorlevel 1 (
    echo 数据库还原失败！
    pause
    exit /b
)
echo 数据库还原成功！

echo [2/5] 复制后端项目到 D 盘...
xcopy "%~dp0wms-ruoyi" "D:\wms-ruoyi\" /E /I /Y >nul
echo 后端项目复制完成！

echo [3/5] 复制前端项目到 D 盘...
xcopy "%~dp0ruo-yi-wms-vue" "D:\ruo-yi-wms-vue\" /E /I /Y >nul
echo 前端项目复制完成！

echo [4/5] 自动修改后端数据库密码...
set CONFIG_FILE=D:\wms-ruoyi\ruoyi-admin-wms\src\main\resources\application-druid.yml
powershell -Command "(Get-Content %CONFIG_FILE%) -replace 'password: .*', 'password: %NEW_MYSQL_PWD%' ^| Set-Content %CONFIG_FILE%"
echo 数据库密码已更新。

echo [5/5] 还原完成！
echo ========================================
echo 请手动启动后端和前端：
echo   2. 打开 VS Code → 打开 D:\ruo-yi-wms-vue → 终端执行 npm install → npm run dev
echo   3. 浏览器访问 http://localhost → 用户名 admin 密码 admin123
echo ========================================
pause
