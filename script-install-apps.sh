#!/bin/bash

#Programa desenvolvido para uso pessoal do criador!!

## YUM/DNF ##

## Atualizando os repositórios e pacotes ##
echo "[YUM/DNF] ATUALIZANDO A LISTA DOS REPOSITÓRIOS..."
sudo dnf update -y
echo -e "[YUM/DNF] LISTA DOS REPOSITÓRIOS ATUALIZADA... \n"

echo "[YUM/DNF] ATUALIZANDO OS PACOTES..."
sudo dnf upgrade -y
echo -e "[YUM/DNF] PACOTES ATUALIZADOS... \n"

## Listando o nome dos pacotes que serão instalados via YUM/DNF ##
PACOTES_DNF=(
	"flatpak"
	"wget"
	"gnome-tweaks"
	)

## Criando loop na lista de pacotes e verificando se estão instalados, caso não esteja eles serão instalados ##
for NOME_PACOTE in ${PACOTES_DNF[@]}; do
	if ! dnf list --installed | grep -q $NOME_PACOTE; then
		echo "[YUM/DNF] O PACOTE $NOME_PACOTE ESTÁ SENDO INSTALADO..."
		sudo dnf install $NOME_PACOTE
		echo -e "[YUM/DNF] PACOTE $NOME_PACOTE JÁ INSTALADO... \n"
	
	else
		echo -e "[YUM/DNF] PACOTE $NOME_PACOTE JÁ INSTALADO... \n"
	fi
done



## FLATPAK ##

## Adicionando o flathub (maior repositório flatpak) ao flatpak ##
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


## Listando o nome dos pacotes que serão instalados via flatpak ##
PACOTES_FLATPAK=(
	"com.spotify.Client"
	"org.gimp.GIMP"
	"com.rafaelmardojai.Blanket"
	"com.obsproject.Studio"
	"org.videolan.VLC"
	"com.jetbrains.PyCharm-Community"
	"com.google.Chrome"
	)

## Criando loop na lista de pacotes e verificando se estão instalados, caso não esteja eles serão instalados ##
for NOME_PACOTE in ${PACOTES_FLATPAK[@]}; do
	if ! flatpak list | grep -q $NOME_PACOTE; then
		echo "[FLATPAK] O PACOTE $NOME_PACOTE ESTÁ SENDO INSTALADO..."
		sudo flatpak install flathub $NOME_PACOTE -y
		echo -e "[FLATPAK] PACOTE $NOME_PACOTE JÁ INSTALADO... \n"
	
	else
		echo -e "[FLATPAK] PACOTE $NOME_PACOTE JÁ INSTALADO... \n"
	fi
done



## SOFTWARES PROPRIETÁRIOS ##

#Configurando WGET
DIRETORIO_DOWNLOAD="/home/$(whoami)/Downloads/Instaladores"

echo "[MKDIR] CRIANDO DIRETÓRIO DE SALVAMENTO DOS INSTALADORES..."
mkdir $DIRETORIO_DOWNLOAD
echo -e "[MKDIR] DIRETÓRIO OK... \n"


## Listando o link dos pacotes que serão baixados pelo wget e instalados pelo rpm ##
LINKS_PACOTES=(
	"https://vscode.download.prss.microsoft.com/dbazure/download/stable/dc96b837cf6bb4af9cd736aa3af08cf8279f7685/code-1.89.1-1715060595.el8.x86_64.rpm"
	)

## Verificamos se um determinado pacote já está instalado, caso não esteja ele será instalado ##
for LINK_PACOTE in ${LINKS_PACOTES[@]}; do
	RPM_PACOTE="${LINK_PACOTE##*/}"
	RPM_PACOTE="${RPM_PACOTE%.*}"
	echo $RPM_PACOTE
	if ! rpm -qa | grep -q $RPM_PACOTE; then
		echo "[WGET] FAZENDO O DOWNLOAD DO PACOTE $LINK_PACOTE..."
		wget $LINK_PACOTE -P $DIRETORIO_DOWNLOAD
		echo -e "[WGET] DOWNLOAD CONCLUÍDO... \n"
		echo -e "[RPM] INSTALANDO PACOTE... \n"
		sudo rpm -i $DIRETORIO_DOWNLOAD/*.rpm
	else
		echo "[RPM] PACOTE $RPM_PACOTE JÁ INSTALADO..."
	fi
done


echo -e "\nPROGRAMA PÓS-INSTALAÇÃO EXECUTADO COM SUCESSO!\n\n"
