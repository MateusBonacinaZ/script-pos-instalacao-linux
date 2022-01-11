#!/bin/bash

#Programa desenvolvido para uso pessoal do criador!!

## YUM/DNF ##

## Atualizando os repositórios e pacotes ##
echo "[YUM/DNF] ATUALIZANDO A LISTA DOS REPOSITÓRIOS..."
sudo dnf update -y
echo -e "[YUM/DNF] LISTA DOS REPOSITÓRIOS ATUALIZADA! \n"

echo "[YUM/DNF] ATUALIZANDO OS PACOTES..."
sudo dnf upgrade -y
echo -e "[YUM/DNF] PACOTES ATUALIZADOS! \n"

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
		echo -e "[YUM/DNF] PACOTE $NOME_PACOTE JÁ INSTALADO! \n"
	
	else
		echo -e "[YUM/DNF] PACOTE $NOME_PACOTE JÁ INSTALADO! \n"
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
	)

## Criando loop na lista de pacotes e verificando se estão instalados, caso não esteja eles serão instalados ##
for NOME_PACOTE in ${PACOTES_FLATPAK[@]}; do
	if ! flatpak list | grep -q $NOME_PACOTE; then
		echo "[FLATPAK] O PACOTE $NOME_PACOTE ESTÁ SENDO INSTALADO..."
		sudo flatpak install flathub $NOME_PACOTE -y
		echo -e "[FLATPAK] PACOTE $NOME_PACOTE JÁ INSTALADO! \n"
	
	else
		echo -e "[FLATPAK] PACOTE $NOME_PACOTE JÁ INSTALADO! \n"
	fi
done



## SOFTWARES PROPRIETÁRIOS ##

#Configurando WGET
DIRETORIO_DOWNLOAD="/home/bonacina/Downloads/Instaladores"

echo "[MKDIR] CRIANDO DIRETÓRIO DE SALVAMENTO DOS INSTALADORES..."
mkdir $DIRETORIO_DOWNLOAD
echo -e "[MKDIR] DIRETÓRIO OK! \n"


## Listando o link dos pacotes que serão baixados pelo wget e instalados pelo rpm ##
LINKS_PACOTES=(
	"https://az764295.vo.msecnd.net/stable/899d46d82c4c95423fb7e10e68eba52050e30ba3/code-1.63.2-1639562596.el7.x86_64.rpm"
	)

for LINK_PACOTE in ${LINKS_PACOTES[@]}; do
	echo "[WGET] FAZENDO O DOWNLOAD DE UM PACOTE..."
	wget $LINK_PACOTE -P $DIRETORIO_DOWNLOAD
	echo -e "[WGET] DOWNLOAD CONCLUÍDO! \n"
done

sudo rpm -i $DIRETORIO_DOWNLOAD/*.rpm

echo -e "\nPROGRAMA PÓS-INSTALAÇÃO EXECUTADO COM SUCESSO!\n\n"
