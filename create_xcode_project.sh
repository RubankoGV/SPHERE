#!/bin/bash

# Скрипт для создания Xcode проекта из существующих файлов
# Запускать на macOS с установленным Xcode

echo "🚀 Создание Xcode проекта для SPHERE..."

# Создаём структуру проекта
mkdir -p SPHERE.xcodeproj
cd SPHERE.xcodeproj

# Создаём project.pbxproj (упрощённая версия)
cat > project.pbxproj << 'EOF'
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 56;
	objects = {
	};
	rootObject = SPHERE_PROJECT;
}
EOF

cd ..

# Используем xcodegen если установлен, или создаём вручную
if command -v xcodegen &> /dev/null; then
    echo "📦 Используем xcodegen для создания проекта..."
    xcodegen generate
else
    echo "⚠️  xcodegen не установлен. Создайте проект вручную через Xcode."
    echo "Инструкции в build_ipa_manual.md"
fi

echo "✅ Готово! Откройте SPHERE.xcodeproj в Xcode"

