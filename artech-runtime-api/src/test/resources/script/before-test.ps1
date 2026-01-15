# Obtém o diretório onde o script está localizado
$diretorioScript = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define o caminho relativo para o diretório "images" a partir do diretório do script
$caminhoImagensRelativo = "..\..\storage\images"  # Caminho relativo do diretório "images" em relação ao diretório do script

# Resolve o caminho absoluto para o diretório "images"
$diretorioImagens = Resolve-Path (Join-Path $diretorioScript $caminhoImagensRelativo)

# Exibe o caminho absoluto do diretório "images"
Write-Host "O caminho absoluto do diretório de imagens é: $diretorioImagens"

# Definir os diretórios
$diretorio1 = $diretorioImagens

# Excluir as pastas, se existirem
if (Test-Path $diretorio1) {
    Remove-Item -Recurse -Force $diretorio1
}

# $diretorioImagensArticle = Resolve-Path (Join-Path $diretorioImagens "\articles")
# $diretorioImagensManagement = Resolve-Path (Join-Path $diretorioImagens "\management")
# Criar as pastas novamente
New-Item -ItemType Directory -Path $diretorio1

# Defina os nomes das novas pastas
$pastaArticles = "articles"
$pastaManagement = "management"

# Crie as pastas dentro do diretório base
New-Item -Path (Join-Path $diretorio1 $pastaArticles) -ItemType Directory -Force
New-Item -Path (Join-Path $diretorio1 $pastaManagement) -ItemType Directory -Force

# Definir os caminhos das imagens e destinos

$backupFolder = "..\..\storage\backup"
$backupFolderPath = Resolve-Path (Join-Path $diretorioScript $backupFolder)

$sourceImage1 = "$backupFolderPath\mock-article-image.png"
$sourceImage2 = "$backupFolderPath\mock-avatar.jpg"
$destFolderArticles = "$diretorioImagens\articles"
$destFolderManagement = "$diretorioImagens\management"

# Criar a pasta de backup caso não exista
if (-not (Test-Path -Path $backupFolder)) {
    New-Item -Path $backupFolderPath -ItemType Directory
}

# Copiar as imagens para a pasta de backup
Copy-Item -Path $sourceImage1 -Destination $backupFolder
Copy-Item -Path $sourceImage2 -Destination $backupFolder

# Certificar-se que as pastas de destino existem
if (-not (Test-Path -Path $destFolderArticles)) {
    New-Item -Path $destFolderArticles -ItemType Directory
}

# Copiar as imagens para as pastas de destino
Copy-Item -Path $sourceImage1 -Destination $destFolderArticles
Copy-Item -Path $sourceImage2 -Destination $destFolderManagement

Write-Host "Pastas recriadas com sucesso."
